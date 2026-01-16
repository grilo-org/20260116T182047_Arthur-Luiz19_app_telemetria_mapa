import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onPlaceSelected;

  const SearchBarWidget({super.key, required this.onPlaceSelected});

  @override
  State<SearchBarWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<dynamic> _suggestions = [];
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _fetchSuggestions(_searchController.text);
    });
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _suggestions = []);
      return;
    }
    final apiKey = dotenv.env['CHAVE_API_GOOGLE_MAPS'];
    if (apiKey == null || apiKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chave da API não configurada.')),
      );
      return;
    }
    final uri =
        Uri.https('maps.googleapis.com', '/maps/api/place/autocomplete/json', {
          'input': query.trim(),
          'key': apiKey,
          'language': 'pt-BR',
          'types': 'establishment|geocode',
        });
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() => _suggestions = data['predictions'] ?? []);
      }
    } catch (e) {
      print('Erro na busca de sugestões: $e');

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Não foi possível carregar sugestões.'),
          backgroundColor: Colors.orange,
        ),
      );

      setState(() => _suggestions = []);
    }
  }

  void _clearSuggestions() {
    setState(() {
      _suggestions = [];
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Buscar local...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearSuggestions,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onChanged: (_) => _onSearchChanged(),
          ),
        ),
        if (_suggestions.isNotEmpty && _focusNode.hasFocus)
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final item = _suggestions[index] as Map<String, dynamic>;
                return ListTile(
                  title: Text(item['description']),
                  dense: true,
                  onTap: () {
                    _clearSuggestions();
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.onPlaceSelected(item);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
