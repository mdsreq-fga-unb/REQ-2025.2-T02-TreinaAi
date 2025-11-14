# Requisitos Não Funcionais

Requisitos não funcionais descrevem como o sistema deve operar, garantindo qualidade, usabilidade e desempenho adequados à experiência dos usuários e à administração eficiente da plataforma, classificados de acordo com o modelo **URPS+**.

## Usabilidade
| Índice | Requisito                                                                                              |
|--------|--------------------------------------------------------------------------------------------------------|
| RNF01      | Interface intuitiva, onde o usuário deve conseguir acessar qualquer funcionalidade com no máximo 3 cliques |     
| RNF02      | Visualizações de gráfico de progresso dos alunos para o profissional com até 2 cliques. |     
| RNF03      | Feedback visual gerado por professor com métricas selecionadas em tags não intrusivas (20-25% da tela)|                          
| RNF04     | As categorias de treino devem aparecer no topo da tela do período em formato de cartões, cada um ocupando no máximo 200px de altura |
| RNF05      | Popup de confirmação de formulários em popup pequeno (150px) no centro da tela do usuário, contendo: *resumo do período, botão Confirmar e botão Cancelar.*” |

## Confiabilidade
| Índice | Requisito                                                                                              | 
|--------|--------------------------------------------------------------------------------------------------------|
| RNF06    | Controle de acesso, permitindo que apenas o profissional responsável visualize ou edite os registros.  |     
| RNF07    | O sistema deve possuir um backup automático salvo no armazenamento interno a cada 3 semanas.                       |  

## Desempenho
| Índice | Requisito                                                                                              |
|--------|--------------------------------------------------------------------------------------------------------|
| RNF08     | O tempo de resposta para geração de PDF de períodos não deve exceder 10 segundos |       
| RNF09    | Relatórios e gráficos devem ser gerados rapidamente (<8 seg) requisitos do usuário.                           |       
| RNF10    | Tempo médio de carregamento da página inferior a 1 segundo |

## Suportabilidade
| Índice | Requisito                                                                                              | 
|--------|--------------------------------------------------------------------------------------------------------|
| RNF11 | A plataforma deve ser acessivel com ou sem uso de internet, mantendo a velocidade inferior a 1 segundo.   |      
| RNF12    | Inicialmente funcionar somente via Mobile.                                                             |       
| RNF13    | Todas as mensagens de erro devem estar centralizadas na tela e possuir aproximadamente 150px.          |       
| RNF14  | O sistema deve ter documentação no repositório para continuidade do desenvolvimento, incluindo instruções de contribuição, instalação, endpoints da API e estrutura do projeto. |
| RNF15    | O sistema deve possuir arquitetura modular que permita adicionar novas métricas ou tipos de treino sem necessidade de alterar mais do que 10% dos módulos existentes e sem causar falhas nas funcionalidades já implementadas. |  

## Histórico de Versão

| Data     | Versão | Descrição             | Autor              |
| -------- | ------ | --------------------- | ------------------ |
| 14/09/2025 | 1.0    | Criação do Documento  | Gabriel Fae    |
| 14/11/2025 | 1.1 | Ajuste de requisitos não funcionais | Gabriel Fae |