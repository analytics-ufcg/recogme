RecogMe - Sistema de autenticação por Keystroke Dynamics (Dinâmica de Digitação)

Para rodar a aplicação em outro servidor são necessários os seguintes requisitos: 
- python 3.4 
- backports-abc==0.4
- decorator==4.0.4
- Django==1.8.6
- Jinja2==2.8
- jsonschema==2.5.1
- MarkupSafe==0.23
- mistune==0.7.1
- nbconvert==4.1.0
- nbformat==4.0.1
- notebook==4.0.6
- numpy==1.10.1
- pandas==0.17.1
- path.py==8.1.2
- pexpect==4.0.1
- pickleshare==0.5
- ptyprocess==0.5
- Pygments==2.0.2
- python-dateutil==2.4.2
- pytz==2015.7
- pyzmq==15.0.0
- qtconsole==4.1.0
- rpy2==2.5.0
- scipy==0.16.1
- simplegeneric==0.8.1
- six==1.10.0
- terminado==0.5
- tornado==4.3
- traitlets==4.0.0

step 1) Instalar Python 3.4

step 2) Criar um ambiente virtual (virtualenv). Usar a sequencia de comandos a seguir:
pyvenv <nome_da_pasta> 

step 3) Ativar ambiente virtual
source <nome_da_pasta>/bin/activate

step 4) Instalar dependências
após entrar na raiz do projeto:
pip install -r pip-packages

step 5) Iniciar a aplicação. 
python RecogMeApp/manage.py runserver (~/recogme$ python RecogMeApp/manage.py runserver)
