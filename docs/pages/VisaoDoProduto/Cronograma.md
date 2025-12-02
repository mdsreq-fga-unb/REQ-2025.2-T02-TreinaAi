# Cronograma e entregas

A partir da estratégia de desenvolvimento de software estabelecida, tem-se a seguinte proposta de cronograma, suas fases e resultados esperados:

| Sprint   | Data            | Entregas | Objetivo Principal                                   | Atividades (Scrum + XP)                                                                 | Critério de Aceitação                                  |
|:----------:|:------------------:|:----------:|:--------|-------:|---------------------------------------------------------|
| Sprint 1 | 15/09 - 21/09    |     --     | Preparar ambiente + primeiro incremento funcional     | - Definir backlog inicial (Product Backlog)<br>- Configurar ambiente e CI/CD<br>- Configurar base do BD<br>- Pair programming em funcionalidades de entrega | Backlog aprovado pelo cliente                           |
| Sprint 2 | 22/09 - 28/09    |     US02, 01 <br> REQ02, 01   | Incrementar cadastro de alunos                        | - Refinar backlog<br>- Criar cadastro simples de usuários em BD<br>- Refatorar código do Sprint 1 | Cadastro no BD e aprovado pelo cliente                  |
| Sprint 3 | 29/09 - 05/10    |    US03 <br>  REQ03,04      | Interfaces iniciais + perfil do aluno preenchível       | - Criar interface inicial do cadastro<br>- Implementar validações de campos<br> -Acesso ao perfil do aluno | Interface funcional de cadastro validada com feedback   |
| Sprint 4 | 06/10 - 12/10    |    US05, US15 <br> REQ12, REQ10   | Integração cadastro + fluxo básico do sistema         | - Integrar cadastro + interface<br>- Implementação das primeiras rotas<br> -Páginas de período para cadastro | Sistema com fluxo básico navegável e testado            |
| Sprint 5 | 13/10 - 19/10    |     US07, US06 <BR> REQ13    | Páginas de período com inserção de dados    | - Implementar pág. Planejamento<br>- Exercícios preenchíveis<br>- Adição das primeiras variáveis calculáveis | Interfaces funcionando e aprovadas no Review            |
| Sprint 6 | 20/10 - 26/10    |  US14,04 <br> REQ07, REQ11  | Correlacionar períodos com alunos     | - Acesso dinâmico de período diferentes alunos <br> - Capacidade de deletar alunos + período | Páginas integradas com dados reais funcionando          |
| Sprint 7 | 27/10 - 02/11    |      US08, 09, 10 <br> REQ14, 05    | Relatórios visuais (UI inicial)                       | - Criar interface de relatórios<br>- Configurar base de dados para gráficos<br> - Editar período ativo| Interface de relatórios revisada e aprovada            |
| Sprint 8 | 03/11 - 09/11    |     US10, 09, 11 <br> REQ14, 05, 15 | Relatórios dinâmicos (dados reais)                    | - Implementar geração de gráficos dinâmicos<br>- Testes automatizados de consultas<br>- Revisão de backlog | Gráficos exibindo dados reais corretamente              |
| Sprint 9 | 10/11 - 16/11    |      -    | Testes de build de apk com flutter                | - Implementar testes de sistema<br>- Testes gerando builds de diferentes versões do app | Apk gerando sem falhas              |
| Sprint 10| 17/11 - 23/11    |    US07, 12, 13 <br> REQ06, 08, 09     | Ajustes + refinamentos finais                         | - Correção de bugs<br>- Refino da interface<br>- Otimização de performance<br>- Testes de aceitação com cliente | Feedback positivo em Review e Retrospectiva             |
| Sprint 11| 24/11 - 01/12    |     -     | Entrega final do MVP                                  | - Revisão final backlog + documentação<br>- Demonstração do sistema completo<br>- Preparação para deploy | MVP aceito formalmente pelo cliente                    |

---

## Considerações:
- **Datas de Início e Fim**: Sprints quinzenais, começando em 15/09/2025 e finalizando em 01/12/2025, distribuindo as entregas parciais ao longo do tempo.
- **Validações quinzenais de Cada Sprint :** A cada 2 sprints, haverá uma reunião de revisão com o cliente para validar as funcionalidades entregues, coletar feedback e ajustar o backlog para os próximos sprints.
- **Entregas e códigos**: para facilitar visualização e objetividade, os códigos das histórias e requisitos entregues foi adicionado na categoria "entregas" da tabela.

## Histórico de Versão

| Data     | Versão | Descrição             | Autor              |
| -------- | ------ | --------------------- | ------------------ |
| 14/09/2025 | 1.0    | Criação do Documento  | Gabriel Fae    |
| 22/09/2025 | 1.1 | Refinamento | Gabriel Fae | 
| 29/11/2925 | 1.2 | Ajuste final | Gabriel Fae |
