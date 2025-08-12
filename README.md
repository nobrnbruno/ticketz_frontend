# Ticketz (Flutter)

Um Aplicativo Flutter para seleção e reserva de assentos em cinema.

---

## Funcionalidades

* Listagem de filmes em cartaz com informações básicas.
* Seleção de horários de exibição.
* Visualização de preço total dos assentos selecionados.
* Confirmação visual da reserva (modal).

---

## Requisitos

* Flutter SDK instalado (recomenda-se a versão estável mais recente).
* Emulador ou dispositivo físico configurado para rodar apps Flutter.
* Backend API rodando e acessível (ex: Spring Boot na porta 8080).

---

## Setup

### 1. Clonar o projeto

```bash
git clone <url-do-repositório>
cd ticketz
```

### 2. Instalar dependências

```bash
flutter pub get
```

### 3. Configurar URL da API (se aplicável)

No arquivo onde as chamadas HTTP são feitas (exemplo: `api_service.dart`), configure a base URL para apontar para o backend:

* Para emulador Android: `http://10.0.2.2:8080`
* Para dispositivo físico ou iOS: `http://<IP_do_servidor>:8080`

---

## Como rodar

```bash
flutter run
```

Ou use seu editor (VS Code, Android Studio) para executar no dispositivo/emulador.

---

## Estrutura

* `main.dart` — Entry point, configura tema e home page.
* `models/` — Modelos de dados (`Movie`, `Seat`, enums).
* `pages/` — Telas da aplicação (`HomePage`, `SeatSelectionPage`).
* `widgets/` — Componentes reutilizáveis (cards, legendas, botões).
* `services/` — (Opcional) Serviços para comunicação com backend.
