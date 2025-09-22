# Cronograma e entregas

A partir da estratégia de desenvolvimento de software estabelecida, tem-se a seguinte proposta de cronograma, suas fases e resultados esperados:

| Sprint  | Início      | Fim        | Objetivo Principal                                | Atividades (Scrum + XP)                                                                 | Critério de Aceitação                           |
|---------|-------------|-----------|--------------------------------------------------|------------------------------------------------------------------------------------------|------------------------------------------------|
| Sprint 1 | 15/09/2025 | 21/09/2025 | Preparar ambiente + primeiro incremento funcional | - Definir backlog inicial (Product Backlog)- Configurar ambiente e CI/CD- Configurar base do BD- Pair programming em funcionalidades essenciais | Backlog aprovado pelo cliente |
| Sprint 2 | 22/09/2025 | 28/09/2025 | Incrementar cadastro de alunos                   | - Refinar backlog<br>- Criar cadastro simples de usuários em BD<br>- Refatorar código do Sprint 1 | Cadastro no BD e aprovado pelo cliente |
| Sprint 3 | 29/09/2025 | 05/10/2025 | Interfaces iniciais + validação de dados         | - Criar interface inicial do cadastro<br>- Implementar validações de campos<br>- Testes automatizados de integração | Interface funcional de cadastro validada com feedback |
| Sprint 4 | 06/10/2025 | 12/10/2025 | Integração cadastro + fluxo básico do sistema    | - Integrar cadastro + interface<br>- Implementação das primeiras rotas<br>- Feedback em Review | Sistema com fluxo básico navegável e testado |
| Sprint 5 | 13/10/2025 | 19/10/2025 | Páginas de planejamento mensal e inserção de dados | - Implementar pág. Planejamento<br>- Testes de aceitação automatizados<br>- Adição das primeiras variáveis calculáveis | Interfaces funcionando e aprovadas no Review |
| Sprint 6 | 20/10/2025 | 26/10/2025 | Integração páginas + cadastro de alunos          | - Integração backend (rotas) + frontend<br>- Testes de integração<br>- Feedback de páginas | Páginas integradas com dados reais funcionando |
| Sprint 7 | 27/10/2025 | 02/11/2025 | Relatórios visuais (UI inicial)                  | - Criar interface de relatórios<br>- Configurar base de dados para gráficos<br>- PP aplicado à lógica de relatórios | Interface de relatórios revisada e aprovada |
| Sprint 8 | 03/11/2025 | 09/11/2025 | Relatórios dinâmicos (dados reais)               | - Implementar geração de gráficos dinâmicos<br>- Testes automatizados de consultas<br>- Revisão de backlog | Gráficos exibindo dados reais corretamente |
| Sprint 9 | 10/11/2025 | 16/11/2025 | Automação de QA e testes finais                  | - Implementar testes de sistema<br>- Testes gerando builds | Testes automatizados executando sem falhas |
| Sprint 10 | 17/11/2025 | 23/11/2025 | Ajustes + refinamentos finais                    | - Correção de bugs<br>- Refino da interface<br>- Otimização de performance<br>- Testes de aceitação com cliente | Feedback positivo em Review e Retrospectiva |
| Sprint 11 | 24/11/2025 | 01/12/2025 | Entrega final do MVP                             | - Revisão final backlog + documentação<br>- Demonstração do sistema completo<br>- Preparação para deploy | MVP aceito formalmente pelo cliente |


---

## Considerações:
- **Datas de Início e Fim**: Sprints quinzenais, começando em 15/09/2025 e finalizando em 01/12/2025, distribuindo as entregas parciais ao longo do tempo.
- **Validações quinzenais de Cada Sprint :** A cada 2 sprints, haverá uma reunião de revisão com o cliente para validar as funcionalidades entregues, coletar feedback e ajustar o backlog para os próximos sprints.
- **Entregas de validação** As funcionalidades principais, como cadastro de alunos, alimentação de métricas e geração de gráficos, serão entregues e testadas ao longo do desenvolvimento, garantindo validação contínua até o lançamento final.

## Histórico de Versão

| Data     | Versão | Descrição             | Autor              |
| -------- | ------ | --------------------- | ------------------ |
| 14/09/2025 | 1.0    | Criação do Documento  | Gabriel Fae    |
| 22/09/2025 | 1.1 | Refinamento | Gabriel Fae | 
