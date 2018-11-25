NODE_BIN=./node_modules/.bin

.PHONY: clean clean_static static migrate quality test requirements serve network

help:
	@echo "Please use \`make <target>\` where <target> is one of"
	@echo "  clean                      delete generated byte code and coverage reports"
	@echo "  help                       display this help message"
	@echo "  migrate                    apply database migrations"
	@echo "  requirements               install requirements for vue-network app environment"
	@echo "  serve                      serve Vue Network App at 0.0.0.0:8811"
	@echo "  static                     build and compress static assets"
	@echo "  clean_static               delete compiled/compressed static assets"
	@echo "  network                    Parse and save data from network log files in the 'network_data' directory"
	@echo ""

clean:
	find . -name '*.pyc' -delete

clean_static:
	rm -rf vue-network/static/build/

requirements:
	pip install -qr requirements.txt --exists-action w

static:
	python manage.py collectstatic --noinput

serve:
	python manage.py runserver 0.0.0.0:8811

migrate:
	python manage.py migrate --noinput

network:
	python manage.py process_network_logs
