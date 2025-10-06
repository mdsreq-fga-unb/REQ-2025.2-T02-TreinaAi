# Requisitos Não Funcionais

Requisitos não funcionais descrevem como o sistema deve operar, garantindo qualidade, usabilidade e desempenho adequados à experiência dos usuários e à administração eficiente da plataforma, classificados de acordo com o modelo **URPS+**.

## Usabilidade
| Índice | Requisito                                                                                              |
|--------|--------------------------------------------------------------------------------------------------------|
| 1      | Interface intuitiva, permitindo que profissionais entendam e naveguem facilmente entre as funcionalidades. |     
| 2      | Visualizações claras que facilitem a compreensão do progresso dos alunos para o profissional por meio de períodos anteriores. |     
| 3      | Feedback visual motivador para os alunos, mas gerenciado pelo profissional.                            |    
| 4      | A interface de período deve destacar as principais categorias de treino, podendo ser moldado pelo profissional |
| 5      | A interface deve exibir feedbacks utilizando popups ao realizar fechamentos de períodos |

## Confiabilidade
| Índice | Requisito                                                                                              | 
|--------|--------------------------------------------------------------------------------------------------------|
| 1      | Controle de acesso, permitindo que apenas o profissional responsável visualize ou edite os registros.  |     
| 2      | Em caso de perda de arquivos, o sistema deve possuir um backup a cada 3 semanas.                       |  

## Desempenho
| Índice | Requisito                                                                                              |
|--------|--------------------------------------------------------------------------------------------------------|
| 1      | O tempo de resposta para geração de PDF de períodos não deve exceder 10 segundos |       
| 2      | Relatórios e gráficos devem ser gerados rapidamente (<800 ms) a requisitos do usuário.                           |       
| 3      | Tempo médio de carregamento da página inferior a 1000 ms |

## Suportabilidade
| Índice | Requisito                                                                                              | 
|--------|--------------------------------------------------------------------------------------------------------|
| 1      | A plataforma deve estar acessível via mobile durante o horário de operação do profissional, com ou sem internet           |      
| 2      | Inicialmente funcionar somente via Mobile.                                                             |       
| 3      | Todas as mensagens de erro devem ser facilmente localizáveis.           |       
| 4      | O sistema deve ter documentação no repositório para continuidade do desenvolvimento, incluindo instruções de contribuição, instalação, endpoints da API e estrutura do projeto. |
| 5     | O sistema deve permitir futuras atualizações e inclusão de novas métricas ou tipos de treino sem impacto significativo nas funcionalidades existentes. |  


