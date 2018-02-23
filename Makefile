all:
ifndef VIRTUAL_ENV
	@echo "You need make and activate a virtualenv first:"
	@echo "make venv"
	@echo "source venv/bin/activate"
	@exit
else
	@$(MAKE) build
endif

venv:
	@virtualenv --python=python3.6 venv

build: pip npm assets ssl
	@python manage.py collectstatic --no-input --clear
	@$(MAKE) migrate
	@$(MAKE) init-db

start: migrate
	@DJANGO_SETTINGS_MODULE=config.settings.local gunicorn config.wsgi:application --config config/gunicorn/local.py

test:
	@mypy --strict-optional --ignore-missing-imports tracks/tracks
	@pytest tracks

shell:
	@python manage.py shell

init-db:
	@python manage.py loaddata tracks/trakcs/fixtures/initial_data.json

migrate:
	@python manage.py migrate

migrations:
	@python manage.py makemigrations

pip:
	@pip install -r requirements/local.txt

npm:
	@npm install

assets:
	@npm run webpack

ssl:
	@bin/ssl_keygen

clean-assets:
	@rm -rf tracks/assets/public/js/*.js*
	@rm -rf tracks/assets/public/css/*.css*

clean:
	@rm -rf venv
	@rm -rf node_modules
	@rm -rf static
	@find . -name \*.pyc -delete
	@find . -name __pycache__ -delete

.PHONY: all venv build start test shell init-db migrate migrations pip npm assets ssl clean-assets clean
