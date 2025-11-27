# 1. Nome do Caso de Uso
Criar perfil profissional

## 1.1 Breve Descrição
O caso de uso "Criar Perfil Profissional" tem como objetivo permitir que o usuário registre suas informações pessoais, experiências e habilidades em um perfil organizado dentro da plataforma.

O ator deseja criar e registrar seu perfil profissional, enquanto o sistema oferece os meios para coletar, salvar e disponibilizar essas informações de forma estruturada.

## 1.2 Atores
- **Ator Principal:** Profissional da Saúde - responsável por iniciar a ação de criar o perfil profissional
- **Atores Secundários:**  
  - Sistema de autentificção - responsável por validar a identidade do profissional antes da criação do perfil.
# 2. Fluxo de Eventos

## 2.1 Fluxo Principal


| Passo    | Ação                                                                 |
|----------|----------------------------------------------------------------------|
| **2.1.1** | O **Profissional da Saúde** acessa a opção *Criar Perfil Profissional*. |
| **2.1.2** | O **Sistema** exibe o formulário de criação de perfil.               |
| **2.1.3** | O **Profissional da Saúde** preenche suas informações profissionais.                  |
| **2.1.4** | O **Sistema** valida os dados informados (RN).                       |
| **2.1.5** | O **Sistema** registra o novo perfil no banco de dados.              |
| **2.1.6** | O **Sistema** confirma a criação do perfil exibindo uma mensagem de sucesso. |


## 2.2 Fluxos Alternativos


### [FA01] – Edição opcional de informações adicionais
**Origem:** Passo 2.1.3  
1. O **Ator** opta por adicionar informações complementares ao perfil (ex.: certificações, idiomas).  
2. O **Sistema** exibe os campos opcionais correspondentes.  
3. O **Ator** preenche os campos desejados.  
**Retorno:** O fluxo volta ao passo 2.1.4.

---

### [FA02] – Indicação de experiência profissional prévia
**Origem:** Passo 2.1.3  
1. O **Ator** decide incluir experiências profissionais anteriores.  
2. O **Sistema** exibe os campos para cargo, instituição, período e descrição da atividade.  
3. O **Ator** adiciona uma ou mais experiências.  
**Retorno:** O fluxo volta ao passo 2.1.4.

---

### [FA03] – Inserção de links externos
**Origem:** Passo 2.1.3  
1. O **Ator** opta por inserir links relevantes (ex.: LinkedIn, portfólio, site profissional).  
2. O **Sistema** apresenta os campos para adicionar URLs .  
3. O **Ator** insere um ou mais links.  
4. O **Sistema** verifica se os links possuem formato válido.  
**Retorno:** O fluxo volta ao passo 2.1.4.

## 2.3 Fluxos de Exceção

### [FE01] – Dados obrigatórios ausentes
**Origem:** Passo 2.1.4  
1. O **Sistema** identifica que campos obrigatórios não foram preenchidos.  
2. O **Sistema** exibe mensagem informando os campos faltantes e solicita correção.  
**Retorno:** O fluxo retorna ao passo 2.1.3.

---

### [FE02] – Formato de dados inválido
**Origem:** Passo 2.1.4  
1. O **Sistema** detecta dados em formato inválido (ex.: e-mail incorreto, telefone incompleto).  
2. O **Sistema** destaca os campos inválidos e orienta o ator a corrigir.  
**Retorno:** O fluxo retorna ao passo 2.1.3.

---

### [FE03] – Falha ao registrar o perfil no banco de dados
**Origem:** Passo 2.1.5  
1. O **Sistema** não consegue salvar o perfil devido a uma falha na operação de banco de dados.  
2. O **Sistema** informa o erro e solicita que o ator tente novamente mais tarde.  
**Retorno:** O fluxo é encerrado sem criar o perfil.

---

### [FE04] – Tamanho de arquivo excedido (caso exista upload)
**Origem:** Passo 2.1.3  
1. O **Sistema** detecta que um arquivo enviado (ex.: foto) excede o tamanho permitido.  
2. O **Sistema** exibe mensagem de erro e rejeita o upload.  
**Retorno:** O fluxo retorna ao passo 2.1.3.



# 3. Requisitos Especiais

- **Compatibilidade com dispositivos móveis:**  
  O sistema deve permitir a criação do perfil profissional em smartphones e tablets, mantendo layout responsivo e usabilidade adequada.

- **Requisitos de performance:**  
  O formulário de criação do perfil e a validação dos dados devem ser executados rapidamente pelo sistema.

# 4. Regras de Negócio

**[RN01]** Todos os campos obrigatórios do perfil devem estar preenchidos para permitir a criação do perfil profissional.

**[RN02]** O número de registro profissional (ex.: CRM, COREN, CRP) deve seguir o formato definido pelo respectivo conselho e ser validado antes do registro do perfil.

**[RN03]** Cada profissional pode possuir apenas um perfil ativo por CPF cadastrado.

**[RN04]** Em caso de integração externa, o sistema deve verificar o registro profissional em até 5 segundos; após esse tempo, a verificação deve ser considerada indisponível.

# 5. Pré-condições

- O **Profissional da Saúde** deve estar autenticado no sistema.  
- O ator deve ter sido previamente validado como um **profissional da saúde legítimo** (ex.: registro em conselho profissional confirmado).  
- O sistema deve estar conectado ao banco de dados.  
- O ator deve possuir um cadastro básico ativo (ex.: CPF e e-mail verificados). 

# 6. Pós-condições

- Um novo perfil profissional é criado e armazenado no banco de dados.  
- O ator passa a ter acesso às funcionalidades que dependem de um perfil profissional ativo.  
