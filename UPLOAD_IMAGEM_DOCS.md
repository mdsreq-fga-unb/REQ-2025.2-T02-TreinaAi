# Funcionalidade de Upload de Imagem do Aluno - TreinaAí

## Resumo
Implementação completa da funcionalidade de upload de imagem de perfil para alunos no aplicativo TreinaAí. O usuário pode capturar uma foto via câmera ou selecioná-la da galeria, e a imagem é armazenada localmente no dispositivo.

## Arquivos Modificados/Criados

### 1. **pubspec.yaml**
Adicionadas as seguintes dependências:
```yaml
image_picker: ^1.0.4          # Para seleção de imagens
path_provider: ^2.1.0         # Para acesso ao diretório de documentos
permission_handler: ^12.0.1   # Para gerenciar permissões
```

### 2. **lib/repositories/image_repository.dart** (NOVO)
Repositório responsável por gerenciar operações com imagens:

**Métodos principais:**
- `pickImageFromGallery()`: Abre a galeria de fotos
- `pickImageFromCamera()`: Abre a câmera para capturar fotos
- `saveImageLocally(File imageFile, int codClient)`: Salva imagem localmente com nome único
- `deleteImageLocally(String imagePath)`: Remove imagem do armazenamento local
- `imageExists(String imagePath)`: Verifica se a imagem existe

**Localização de armazenamento:**
- As imagens são salvas em: `{app_documents_directory}/client_images/`
- Nome do arquivo: `client_{codClient}_{timestamp}.jpg`

### 3. **lib/ui/edit_student_page.dart**
Implementação da UI e lógica de upload:

**Novos métodos:**
- `_showImageSourceDialog()`: Diálogo para escolher câmera ou galeria
- `_pickImageFromCamera()`: Captura foto da câmera e salva
- `_pickImageFromGallery()`: Seleciona foto da galeria e salva
- `_removePhoto()`: Remove a foto atual com confirmação

**Modificações na UI:**
- Botão "Alterar foto" → Abre diálogo de seleção
- Botão "Remover foto" → Remove foto com confirmação
- Exibição atualizada da foto usando `FileImage` (local)

**Persistência:**
- O `photoPath` é agora salvo no banco de dados quando o usuário clica em "Salvar Edições"
- A foto é exibida em tempo real após seleção

### 4. **lib/ui/student_page.dart**
Atualizado para exibir a foto corretamente:
- Mudança de `NetworkImage` para `FileImage` para imagens locais
- Adicionado import de `dart:io`

## Fluxo de Uso

### Alterar Foto:
1. Usuário clica em "Alterar foto"
2. Diálogo pergunta: "Câmera" ou "Galeria"
3. Sistema abre câmera/galeria
4. Foto é capturada/selecionada e salva localmente
5. Foto aparece imediatamente no previsualizador
6. Usuário clica "Salvar Edições" para persistir no banco

### Remover Foto:
1. Usuário clica em "Remover foto"
2. Diálogo de confirmação aparece
3. Se confirmado, foto é removida do armazenamento
4. Campo `photoPath` é limpo
5. Usuário clica "Salvar Edições" para atualizar banco

## Estrutura de Dados

### Cliente (Client Model)
```dart
class Client {
  final String? photoPath;  // Caminho local da imagem
  // ... outros campos
}
```

### Banco de Dados
O campo `photoPath` já existia na tabela `clients`:
```sql
CREATE TABLE clients (
  ...
  photoPath TEXT,
  ...
);
```

## Permissões Necessárias

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

### iOS (ios/Runner/Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>Precisamos acessar a câmera para capturar sua foto</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Precisamos acessar sua galeria para selecionar uma foto</string>
```

## Tratamento de Erros

- **Sem permissão**: Sistema exibe mensagem "Permissão negada"
- **Arquivo não encontrado**: Valida existência antes de usar
- **Erro ao salvar**: Exibe mensagem informativa
- **Erro ao remover**: Confirma e informa ao usuário

## Validações

1. ✅ Nome do aluno não pode ser vazio (validação existente)
2. ✅ Imagem deve existir antes de ser removida
3. ✅ Apenas um arquivo por aluno (sobrescreve anterior)
4. ✅ Qualidade de imagem limitada a 80% para otimizar armazenamento

## Testes Recomendados

1. **Upload via câmera**: Capturar foto e verificar exibição
2. **Upload via galeria**: Selecionar foto existente
3. **Remoção**: Remover foto e verificar ícone padrão
4. **Persistência**: Editar aluno, sair e voltar para verificar se foto persiste
5. **Sincronização**: Verificar se foto aparece em StudentPage após edição

## Próximas Melhorias (Sugestões)

1. Adicionar crop/edição de imagem antes de salvar
2. Implementar sincronização com backend (se aplicável)
3. Adicionar suporte a múltiplas fotos por aluno
4. Implementar cache de imagens para melhor performance
5. Adicionar compressão automática de imagens

## Changelog

- **v1.0** (2025-11-27): Implementação inicial da funcionalidade de upload de imagem
