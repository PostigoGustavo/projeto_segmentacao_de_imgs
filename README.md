# Projeto de Segmentação de Plantas utilizando Processing

Este repositório contém um projeto de segmentação de plantas utilizando o framework Processing. O objetivo é segmentar cada objeto presente em imagens de plantas, empregando uma sequência de filtros que foram discutidos em sala de aula ou outros filtros relevantes para o contexto.

## Objetivo

O objetivo principal deste projeto é demonstrar a capacidade de segmentação de objetos em imagens, com foco específico em plantas. A segmentação é uma etapa crucial em muitas aplicações de visão computacional, incluindo agricultura de precisão, reconhecimento de objetos e análise de imagens médicas.

## Descrição do Projeto

O projeto consiste em segmentar cada planta presente em um conjunto de imagens utilizando sequências de filtros. Os filtros são implementados exclusivamente com as funções disponíveis no framework Processing. Cada imagem pode requerer uma sequência de filtros diferente, dependendo das características específicas da imagem e dos objetivos de segmentação.

## Estrutura do Repositório

- **/img1, /img2, /img3, /img4, /img5**: Cada diretório contém os arquivos relacionados a uma imagem específica de planta.
  - **Imagem original (`imgX.png`)**:
    ![Imagem original](/img1/img1.png)
  
  - **Segmentação inicial (`imgX_ground.png`)**:
    ![Segmentação inicial](/img1/img1_ground.png)
  
  - **Segmentação após aplicação dos filtros (`imgX_ground_new.png`)**:
    ![Segmentação nova](/img1/img1_ground_new.png)
  
  - **Segmentação após segunda aplicação de filtros (`imgX_ground_new_2.png`)**:
    ![Segmentação nova 2](/img1/img1_ground_new_2.png)
  
  - **Código fonte do sketch do Processing (`codigo_img01.pde`)**: Implementação dos filtros para esta imagem.
  - **`sketch.properties`**: Arquivo de propriedades do sketch do Processing.

- **/img2, /img3, /img4, /img5**: Semelhante a `/img1`, mas para as outras imagens do projeto.

## Instruções de Uso

1. Clone este repositório para sua máquina local.
2. Abra o sketch principal do Processing localizado no diretório `/src`.
3. Execute o sketch, que irá carregar uma das imagens de plantas.
4. Utilize os filtros implementados para segmentar a imagem conforme desejado.
5. Analise os resultados obtidos e ajuste os parâmetros dos filtros conforme necessário.

## Referências

- Documentação oficial do Processing, incluindo referências às funções de processamento de imagens.
- Material de aula relacionado a processamento de imagens e segmentação de objetos.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues relatando problemas, sugestões ou melhorias. Pull requests também são incentivados.

---

Este projeto foi desenvolvido como parte de um curso de processamento de imagens e visa aplicar os conceitos aprendidos na segmentação de plantas utilizando o framework Processing. Se tiver alguma dúvida ou sugestão, não hesite em entrar em contato.

