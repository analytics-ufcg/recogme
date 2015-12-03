# recogme
RecogMe - Sistema de autenticação por Keystroke Dynamics (Dinâmica de Digitação)

Para rodar a aplicação em outro servidor são necessários os seguintes requisitos:
python 3.4
backports-abc==0.4
decorator==4.0.4
Django==1.8.6
Jinja2==2.8
jsonschema==2.5.1
MarkupSafe==0.23
mistune==0.7.1
nbconvert==4.1.0
nbformat==4.0.1
notebook==4.0.6
numpy==1.10.1
pandas==0.17.1
path.py==8.1.2
pexpect==4.0.1
pickleshare==0.5
ptyprocess==0.5
Pygments==2.0.2
python-dateutil==2.4.2
pytz==2015.7
pyzmq==15.0.0
qtconsole==4.1.0
rpy2==2.5.0
scipy==0.16.1
simplegeneric==0.8.1
six==1.10.0
terminado==0.5
tornado==4.3
traitlets==4.0.0

step 1) Instalar Python e Django (requisitos acima)
step 2) Criar um ambiente virtual (virtualenv). Como fazer: http://docs.python-guide.org/en/latest/dev/virtualenvs/
step 3) Rodar a aplicação:
		3.1) Entrar na pasta "recogme" (cd recogme)
		3.2) iniciar o virtualenv. Use o seguinte comando "source Django/bin/activate". (~/recogme$ source Django/bin/activate)
		3.3) iniciar a aplicação. Use o comando "python RecogMeApp/manage.py runserver" (~/recogme$ python RecogMeApp/manage.py runserver)
