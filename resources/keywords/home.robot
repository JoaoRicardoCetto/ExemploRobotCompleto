*** Settings ***
Resource    ../main.robot


*** Keywords ***

#KEYWORDS PREENCHIMENTO CORRETO
Acessar Organo    
    Open Browser    ${URL}    ${Browser}
    
Dado que eu preencha os campos do formulário
    Input Text       ${home.CAMPO_NOME}       ${dados_registro.NOME}
    Input Text       ${home.CAMPO_CARGO}      ${dados_registro.CARGO}
    Input Text       ${home.CAMPO_IMAGEM}     ${dados_registro.IMAGEM}
    Click Element    ${home.TIMES}[0]

E clique no botão criar card    
    Click Element    ${home.BOTAO_CRIAR_CARD}

Então identificar o card no time esperado
    Element Should Be Visible    class:colaborador

Então identificar 3 cards no time esperado
    FOR    ${i}    IN RANGE    1    3
       Dado que eu preencha os campos do formulário
       E clique no botão criar card     
    END

Então crirar e identificar um card em cada time disponível
    FOR    ${index}    ${time}    IN ENUMERATE    ${selecionar_times}[0]
        Dado que eu preencha os campos do formulário
        Click Element    ${time}
        E clique no botão criar card
    END


#KEYWORDS PREENCHIMENTO INCORRETO
Dado que eu clique no botão "Criar Card"
    Click Element    home.BOTAO_CRIAR_CARD

Então sistema deve apresentar mensagem de campo obrigatório
    Element Should Be Visible    id:form-nome-erro
    Element Should Be Visible    id:form-cargo-erro
    Element Should Be Visible    id:form-times-erro