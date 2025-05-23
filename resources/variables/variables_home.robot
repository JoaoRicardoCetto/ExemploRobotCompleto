*** Settings ***
Resource    ../main.robot

*** Variables *** 
@{selecionar_times}
...       //option[contains(.,'Programação')]
...       //option[contains(.,'Front-End')]
...       //option[contains(.,'Data Science')]
...       //option[contains(.,'Devops')]
...       //option[contains(.,'UX e Design')]
...       //option[contains(.,'Mobile')]
...       //option[contains(.,'Inovação')]

&{home} 
...    BOTAO_CRIAR_CARD=//button[@id="form-botao"]
...    //div[@class="flex flex-col gap-6"]
...    CAMPO_NOME=//input[@id="form-nome"]
...    CAMPO_CARGO=//input[@id="form-cargo"]
...    CAMPO_IMAGEM=//input[@id="form-imagem"]
...    TIMES=@{selecionar_times}




