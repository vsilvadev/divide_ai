# Documentação da Tab Bar

## Visão Geral

A tab bar do aplicativo Divide AI é implementada usando o Flutter com `go_router` para navegação. Ela utiliza um `ShellRoute` que envolve todas as rotas principais do aplicativo, permitindo que a tab bar seja exibida em todas as telas principais.

## Estrutura Atual

### Arquivos Principais

- **`lib/app_routes.dart`**: Define as rotas e configura o `ShellRoute`
- **`lib/core/tab_bar/tab_bar_widget.dart`**: Implementa o widget da tab bar

### Tabs Atuais

1. **Conta** (`/`) - Ícone: `Icons.home`
2. **Novo Item** (`/add-item`) - Ícone: `Icons.add`
3. **Perfil** (`/profile`) - Ícone: `Icons.person`

## Como Funciona

### 1. Configuração das Rotas

O `ShellRoute` no arquivo `app_routes.dart` envolve todas as rotas principais:

```dart
ShellRoute(
  builder: (context, state, child) => TabBarWidget(
    child: child,
  ),
  routes: [
    // Rotas individuais aqui
  ],
)
```

#### 1.1. Como Funciona o ShellRoute

O `ShellRoute` é um tipo especial de rota que funciona como um **"invólucro"** ou **"casca"** que envolve outras rotas. Ele permite manter um layout compartilhado (como a tab bar) sempre visível enquanto o conteúdo interno muda.

**Estrutura:**
- **Layout fixo**: O `TabBarWidget` é renderizado uma vez e permanece visível
- **Conteúdo dinâmico**: O parâmetro `child` contém o conteúdo da rota atual
- **Navegação**: Quando você navega entre rotas, apenas o `child` muda, mas o `TabBarWidget` continua visível

**Fluxo de renderização:**
```
┌─────────────────────────────────────┐
│           TabBarWidget              │ ← Layout fixo (sempre visível)
├─────────────────────────────────────┤
│                                     │
│        child (conteúdo)             │ ← Muda conforme a rota
│                                     │
│  - HomeScreen (/)                   │
│  - AddItemScreen (/add-item)        │
│  - ProfileScreen (/profile)         │
│                                     │
└─────────────────────────────────────┘
```

**Parâmetros do builder:**
- **`context`**: Contexto do Flutter
- **`state`**: Estado da rota atual (URL, parâmetros, etc.)
- **`child`**: Widget da rota filha que será renderizado dentro do shell

**Importante**: Se você não usar o parâmetro `child` no builder, o conteúdo das rotas filhas não será exibido, resultando em uma tab bar vazia sem conteúdo.

### 2. Widget da Tab Bar

O `TabBarWidget` é responsável por:
- Gerenciar o estado da tab selecionada
- Navegar entre as rotas usando `go_router`
- Renderizar a `NavigationBar` do Flutter

### 3. Navegação

Quando uma tab é selecionada:
1. O estado `_selectedIndex` é atualizado
2. A navegação é executada usando `context.goNamed(_routes[index])`
3. O `go_router` carrega a tela correspondente

## Como Adicionar uma Nova Tab

### Passo 1: Criar a Tela

Primeiro, crie a tela que será exibida na nova tab. Por exemplo:

```dart
class NovaTela extends StatelessWidget {
  const NovaTela({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Nova Tela'),
      ),
    );
  }
}
```

### Passo 2: Adicionar a Rota

No arquivo `lib/app_routes.dart`, adicione uma nova `GoRoute` dentro do `ShellRoute`:

```dart
GoRoute(
  path: '/nova-tela',
  name: 'nova-tela',
  builder: (context, state) => const NovaTela(),
),
```

### Passo 3: Atualizar a Tab Bar

No arquivo `lib/core/tab_bar/tab_bar_widget.dart`:

1. **Adicionar a rota na lista `_routes`**:
```dart
final List<String> _routes = [
  'home',
  'add-item',
  'profile',
  'nova-tela', // Nova rota
];
```

2. **Adicionar o destino na `NavigationBar`**:
```dart
destinations: [
  NavigationDestination(
    icon: Icon(Icons.home),
    label: 'Conta',
  ),
  NavigationDestination(
    icon: Icon(Icons.add),
    label: 'Novo Item',
  ),
  NavigationDestination(
    icon: Icon(Icons.person),
    label: 'Perfil',
  ),
  NavigationDestination(
    icon: Icon(Icons.nova_icon), // Escolha um ícone apropriado
    label: 'Nova Tela',
  ),
],
```

### Passo 4: Importar a Nova Tela

No arquivo `lib/app_routes.dart`, adicione o import da nova tela:

```dart
import 'package:divide_ai/features/nova_feature/nova_tela.dart';
```

## Boas Práticas

1. **Nomenclatura**: Use nomes descritivos para as rotas e labels
2. **Ícones**: Escolha ícones que representem bem a funcionalidade da tela
3. **Organização**: Mantenha as telas organizadas em pastas por feature
4. **Consistência**: Mantenha o padrão de nomenclatura existente

## Estrutura de Pastas Recomendada

```
lib/
├── features/
│   ├── home/
│   │   └── home_screen.dart
│   ├── nova_feature/
│   │   └── nova_tela.dart
│   └── profile/
│       └── profile_screen.dart
├── core/
│   └── tab_bar/
│       └── tab_bar_widget.dart
└── app_routes.dart
```

## Observações Importantes

- A tab bar é persistente em todas as telas principais
- O estado da tab selecionada é mantido localmente no widget
- A navegação usa `go_router` para roteamento declarativo
- Todas as rotas principais devem estar dentro do `ShellRoute`
