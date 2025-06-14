﻿# ExemploRobotCompleto

# leds-conectafapes-validation-tests

---

Padrão de repositório de automação de testes com Robot Framework.

## Estrutura do repositório

---

```
leds-conectafapes-validation-tests/
├── robot/
│   ├── .env
│   ├── .gitignore
│   ├── env_vars.py
│   │
│   ├── resources/
│   │   ├── data/
│   │   │   └── registro.robot
│   │   ├── keywords/
│   │   │   └── home.robot
│   │   ├── shared/
│   │   │   └── setup_teardown.robot
│   │   ├── variables/
│   │   │   └── variables_home.robot
│   │   └── main.robot
│   │
│   ├── suites/
│   │   └── requisitos_funcionais/
│   │       └── RF02_projetosCoordenador.robot
│   │
│   └── results/
│       ├── log.html
│       ├── output.xml
│       └── report.html
│
└── README.md
```

---

## Descrição das pastas e arquivos

### Raiz do Projeto

- **`.env`**
    
    Arquivo de variáveis de ambiente (não comitado no repositório) usado para armazenar credenciais sensíveis, URLs, token de acesso e outras configurações específicas de ambiente.
    
- **`env_vars.py`**
    
    Script Python responsável por carregar e propagar as variáveis definidas em `.env` para os testes do robot(ex.: via biblioteca `dotenv`).
    

---

### resources/

Contém todos os recursos utilizados pelos testes.

- **`main.robot`**
    
    Resource principal que pode incluir imports comuns (bibliotecas e outros resource files).
    
- **`data/`**
    
    Arquivos que possuem variáveis que guardam dados utilizados nos testes:
    
    - `registro.robot` — dados específicos de fluxos de registro.
- **`keywords/`**
    
    Definições de palavras-chave para ações de alto nível:
    
    - `home.robot` — keywords relacionadas à página inicial do sistema.
- **`shared/`**
    
    Recursos compartilhados por múltiplas suítes:
    
    - `setup_teardown.robot` — configurações de setup e teardown globais (inicialização de browser, limpeza de base, etc).
- **`variables/`**
    
    Variáveis globais definidas em arquivos separados:
    
    - `variables_home.robot` — variáveis usadas nos testes da área “home”.

---

### suites/

Local onde residem as suites de testes agrupadas por funcionalidade.

- **requisitos_funcionais/**: Suítes que validam requisitos funcionais do sistema.
    - `RF02_projetosCoordenador.robot`: Caso de teste específico para os requisitos funcionais RF02 (Projetos Coordenador). Os requisitos “filhos” de RF02, são inseridos nesse arquivo, nos test cases (`RF02_01`, `RF02_02`…),. Eles poderão ser chamados separadamente por meio de tags
- casos_de_uso/: Suítes que validam os casos de uso.

> Dica de organização: para cada nova funcionalidade ou perfil, crie uma subpasta em suites/ e adicione ali os casos .robot.
> 

---

### results/

Diretório onde o Robot Framework gera os artefatos de execução:

- **`output.xml`**
    
    Arquivo XML bruto com todos os detalhes da execução (usado por outras ferramentas p/ relatórios).
    
- **`log.html`**
    
    Relatório detalhado passo a passo, com screenshots (se configurado).
    
- **`report.html`**
    
    Visão geral do status de cada caso (pass/fail, tempo, estatísticas).
    

---

# Makefile e Execução dos testes 

## Variáveis do Makefile

As variáveis abaixo podem ser sobrescritas na chamada do `make` usando `make VAR=valor`. Se não forem especificadas, assumem o valor padrão indicado.

| Variável    | Descrição                                                        | Valor Padrão                     |
|-------------|------------------------------------------------------------------|----------------------------------|
| `BROWSER`   | Navegador a ser usado nos testes (`Chrome`, `Firefox`, etc.)     | `Chrome`                         |
| `OUTPUT_DIR`| Diretório onde são gravados relatórios, logs e saída dos testes  | `results`                        |
| `URL`       | URL base passada à variável `${GERAL_URL}` nos testes            | `http://localhost:5173/`         |
| `TAG`       | Filtra apenas casos marcados com `@<TAG>` (expande para `-i TAG`)| (nenhum filtro; roda todos)      |
| `TEST_PATH` | Caminho (arquivo ou diretório) das suítes ou casos de teste      | `suites`                         |

### Exemplo de sobrescrita

make test \
  BROWSER=firefox \
  OUTPUT_DIR=meus_relatorios \
  URL=https://qa.exemplo.com/ \
  TAG=RF02_06 \
  TEST_PATH=custom_tests/login_tests.robot

## Exemplos de chamadas dos testes

### Rodar testes com as variáveis padrão
make test

### Rodar RF01 tests num URL específica com o Chrome
make test TAG=RF01 URL=http://localhost:5173/dashboard BROWSER=Chrome

### Rodar suíte específica e customizar diretório de saída
make test TEST_PATH=suites/login_tests.robot OUTPUT_DIR=login_reports

### Limpar e rodar regressão
make clean
make test TAG=RF02_06 TEST_PATH=suites/requisitos_funcionais


## 🛠 Instalação do Ambiente

### 1. Instale o Python

Baixe em: [python.org/downloads](https://www.python.org/downloads/windows/)

---

### 2. Instale as dependências

Execute no terminal:

```bash
pip install robotframework                            # Framework principal de automação
pip install setuptools                                # Suporte à instalação de pacotes Python
pip install --upgrade robotframework-seleniumlibrary  # Integração com navegadores (Selenium)
pip install robotframework-faker                      # Geração de dados falsos para testes
pip install python-dotenv                             # Leitura de variáveis de ambiente (.env)
```

---

### 3. ChromeDriver

    1. Atualiza e instala pré-requisitos
        sudo apt update && sudo apt install -y wget unzip

    2. Baixa e instala o Google Chrome
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo apt install -y ./google-chrome-stable_current_amd64.deb || sudo apt --fix-broken install -y

    3. Extrai a versão “major” do Chrome
        CHROME_VER=$(google-chrome --version | sed -E 's/.* ([0-9]+)\..*/\1/')
        echo "Chrome major version = $CHROME_VER"

    4. Consulta o ChromeDriver correspondente
        DRIVER_VER=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VER)

    5. Se não encontrar um release específico, usa o LATEST_RELEASE geral
        if [ -z "$DRIVER_VER" ]; then
        echo "Nenhum LATEST_RELEASE_$CHROME_VER — caindo para LATEST_RELEASE"
        DRIVER_VER=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
        fi
        echo "ChromeDriver version = $DRIVER_VER"

    6. Baixa, extrai e dá permissão
        wget https://chromedriver.storage.googleapis.com/${DRIVER_VER}/chromedriver_linux64.zip
        unzip chromedriver_linux64.zip
        chmod +x chromedriver

    7. Move para um diretório do PATH
        sudo mv chromedriver /usr/local/bin/

    8. Verifica instalação
        chromedriver --version
---

### 4. Visual Studio Code

- Baixe o VS Code: [code.visualstudio.com](https://code.visualstudio.com/)
- Instale a extensão: **Robot Framework Language Server**
