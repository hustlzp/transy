from fabric.api import run, env, cd

env.host_string = "root@173.208.227.86"

def start():
	with cd('/var/www/transy'):
		run('')

def restart():
	with cd('/var/www/transy'):
		run('')

def deploy():
	with cd('/var/www/transy'):
		run('git pull')
		run('')

def ldeploy():
	with cd('/var/www/transy'):
		run('git pull')

# back up database files
def backup():
	pass

# show apache error log
def log():
	pass
