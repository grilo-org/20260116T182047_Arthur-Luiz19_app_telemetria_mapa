# Search Telemetria Location

Aplicativo Flutter para exibição de telemetria em tempo real com integração de GPS, sensores de aceleração e bússola, exibindo os dados sobre um mapa interativo.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Google Maps](https://img.shields.io/badge/Google_Maps-%234285F4.svg?style=for-the-badge&logo=google-maps&logoColor=white)

## 🎯 Funcionalidades

- 📍 **Localização em tempo real** via GPS
- 🚗 **Velocidade** (km/h) com base no sinal do GPS
- 📏 **Aceleração linear** (m/s²) usando o sensor de aceleração (com remoção da gravidade)
- 🧭 **Direção aproximada** (N, NE, E, etc.) com base no *heading* do GPS
- 🗺️ **Mapa interativo** com marcador da posição atual
- 🔍 **Busca de locais** (ex: "Hotéis", "Postos", "Hospitais") com sugestões em tempo real
- 🔤 **Suporte total a acentuação e caracteres especiais** na busca (ex: "Hotéis em São Paulo")
- ⏯️ Botão para **iniciar/parar coleta de telemetria**
- 📱 Interface otimizada para **dispositivos móveis**

---

## 🧩 Tecnologias utilizadas

- **Flutter** + **Dart**
- **Provider** – gerenciamento de estado
- **geolocator** – localização, velocidade e heading
- **sensors_plus** – leitura do acelerômetro
- **google_maps_flutter** – exibição do mapa
- **http** + **Google Places API** – busca de locais
- **flutter_dotenv** – gerenciamento seguro de chaves de API

---

## ⚙️ Configuração do projeto

### 1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/mobs2-telemetria.git
cd mobs2-telemetria
```

### 2. **Crie o arquivo .env na raiz do projeto**
```bash
CHAVE_API_GOOGLE_MAPS=SUA_CHAVE_AQUI
```

## Importante: 

- Ative as seguintes APIs no Google Cloud Console :
- Maps SDK for Android
- Places API
- Geocoding API

### 3. Instale as dependências
```bash
flutter pub get
```

### 4. Execute o app
```bash
flutter run
```

---

## 📱 Permissões
- O app solicita automaticamente:
- Localização em tempo de execução
- Acesso ao sensor de aceleração
- As permissões já estão declaradas no AndroidManifest.xml.

