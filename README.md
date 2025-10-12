# REQ-2025.2-T02-TreinaAi

Repositório de projeto da disciplina de REQ-T2 - 2025.2.

## Tecnologias utilizadas

- Flutter
- Dart
- Node.js
- PostgreSQL

## Pré-requisitos

# Nome do Projeto

Descrição breve do projeto. Por exemplo:  
> Este é um aplicativo desenvolvido em Flutter para a disciplina X da faculdade, com o objetivo de [descrever objetivo principal do app].

---

## Tecnologias Utilizadas

- [Flutter](https://flutter.dev/)  
- Dart  
- [Outras tecnologias/libraries usadas, se houver]

---

## Pré-requisitos

Antes de rodar o projeto, você precisa ter instalado:  

- [Flutter SDK](https://docs.flutter.dev/get-started/install)  
- [Node.js](https://nodejs.org/en/download)  
- [PostgreSQL](https://www.postgresql.org/download/)  
- [Git](https://git-scm.com/)  
- Um editor de código (recomendado: **VS Code** ou **Android Studio**)  
- Emulador ou dispositivo físico para testar o app

---

## Instalação

1. Clone o repositório:

```bash
git clone https://github.com/mdsreq-fga-unb/REQ-2025.2-T02-TreinaAi.git
```
2. Entre na pasta do projeto

```bash
cd REQ-2025.2-T02-TreinaAi
```
3. Instale as dependências

```bash
flutter pub get
```

## Executando o app

Para rodar o aplicativo em emulador ou microsoft edge, use o comando:

```bash
flutter run 
```
ou utilize as ferramentas do seu editor de código (VScode ou Android Studio).

## Testes

Para rodar os testes, utilize o comando:

```bash
flutter test
```
Vai rodar todos os testes automatizados definidos no projeto.

_Testes com appium serão adicionados futuramente._

### Estrutura do projeto

- ```app/frontend```: Código fonte do aplicativo Flutter.
- ```app/backend```: Código fonte do backend.
- ```docs```: Documentação do projeto, incluindo requisitos, diagramas, etc.
- ```tests```: Testes automatizados (unitários, integração, etc.).

### Fluxo do projeto

Flutter → HTTP Request → Node.js (localhost:3000) → PostgreSQL

### Licença

Este projeto está licenciado sob a licença...


### Equipe

Projeto desenvolvido pelo grupo T02 - TreinaAi da disciplina de Requisitos de Software (2025.2) - Faculdade do Gama / Universidade de Brasília (FGA/UnB).