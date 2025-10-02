# Requisitos Funcionais

Requisitos funcionais são especificações que descrevem o que o sistema deve fazer. Eles definem as funções, comportamentos e processos que o software precisa executar para atender às necessidades do usuário ou do negócio.

Com base na definição acima, montamos uma lista de requisitos inicias que conseguimos montar com base nos objetivos específicos.

- **Valor**: impacto do requisito para sucesso do projeto.
- **CT**: custo de produção do requisito, calculado com a soma de tempo ( 0 a 5) e esforço (0 a 5).

### Personal e Administração de Alunos

| Índice | Requisito | Valor | CT |
|--------|-----------|-------|----|
| REQ01  | O usuário deve ser capaz de realizar o registro de usuário ao entrar no aplicativo pela primeira vez. | 4 | 7 |
| REQ02  | O usuário deve ser capaz de cadastrar um novo aluno. | 9 | 7 |
| REQ03  | O usuário deve ser capaz de abrir o perfil do aluno. | 9 | 3 |
| REQ08  | O usuário deve ser capaz de editar cada perfil do aluno, período ativo (Título/Objetivo do período, Plano de Treino e Treino). | 8 | 6 |
| REQ12  | O usuário deve ser capaz de realizar uma busca por nome na lista de alunos cadastrados. | 6 | 4 |
| REQ13  | O usuário deve ser capaz de ocultar alunos. (Função "aluno inativo" pedida pelo cliente). | 3 | 5 |
| REQ14  | O usuário deve ser capaz de deletar um aluno cadastrado. | 3 | 2 |
| REQ15  | O usuário deve ser capaz de adicionar observações em diferentes locais do aplicativo. | 4 | 1 |


### Administração de Períodos

| Índice | Requisito | Valor | CT |
|--------|-----------|-------|----|
| REQ04  | No perfil de cada aluno, deve ser possível abrir períodos anteriores e/ou ativos. | 8 | 5 |
| REQ05  | O usuário deve ser capaz de cadastrar o período de um aluno, com Título/Objetivo do Período e Plano de Treino. | 10 | 8 |
| REQ06  | O usuário deve ser capaz de registrar treinos durante o período ativo de cada aluno. | 6 | 5 |
| REQ07  | Ao registrar treinos o usuário poderá registrar exercícios realizados durante o treino, com suas respectivas informações (carga, duração, etc). | 7 | 7 |
| REQ09  | O usuário deve ser capaz de fechar um período. | 5 | 2 |
| REQ10  | O sistema deve criar um pdf baixável toda vez que o usuário fechar um período. | 9 | 8 |
| REQ11  | O pdf criado pelo sistema ao fechar um período deve ter: título (objetivo), plano de treino, datas, gráficos de evolução e outras variáveis. | 7 | 8 |

