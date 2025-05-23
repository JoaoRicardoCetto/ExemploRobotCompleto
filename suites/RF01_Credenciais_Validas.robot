*** Settings ***
Resource    ../resources/main.robot
Test Setup    Dado que eu acesse o Organo
Test Teardown    Fechar navegador

*** Test Cases ***
#RF01.01
Verificar se ao preencher corretamente o formulário os dados são inseridos corretamente na lista e se um novo card é criado no time esperado
    Dado que eu preencha os campos do formulário
    E clique no botão criar card
    Então identificar o card no time esperado
    Sleep  5

#RF01.02
Verificar se é possivel criar mais de um card se preenchermos os campos corretamente
    Dado que eu preencha os campos do formulário
    E clique no botão criar card
    Então identificar 3 cards no time esperado
    Sleep  5


Verificar se é possível criar um card para cada time disponível se preenchermos os campos corretamente
    Dado que eu preencha os campos do formulário
    Então crirar e identificar um card em cada time disponível
    Sleep  5


