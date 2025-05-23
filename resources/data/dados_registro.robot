#VARIÁVEIS COM DADOS QUE SERÃO USADOS PARA PREENCHER CAMPOS NO SISTEMA
*** Settings ***
Resource    ../main.robot

*** Variables ***
${TESTE}    FakerLibrary.First Name

&{dados_registro}
...    NOME=FakerLibrary.First Name
...    CARGO=FakerLibrary.Job
...    IMAGEM=FakerLibrary.Image Url 
...    INDICE_TIME=1
