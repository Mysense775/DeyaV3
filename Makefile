# Deya v3.0 Makefile
# Quick commands for development and deployment

.PHONY: help install dev start stop test lint backup health update clean

help: ## Show this help
	@echo "🌺 Deya v3.0 Commands"
	@echo "===================="
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## One-line install
	curl -fsSL https://raw.githubusercontent.com/Mysense775/DeyaV3/main/install.sh | bash

setup: ## Run setup script
	node scripts/setup.js

dev: ## Start in development mode
	npm run dev

start: ## Start production server
	npm start

stop: ## Stop server (PM2)
	pm2 stop deya || true

docker-up: ## Start with Docker
	docker-compose up -d

docker-down: ## Stop Docker containers
	docker-compose down

docker-logs: ## View Docker logs
	docker-compose logs -f deya

test: ## Run tests
	npm test

lint: ## Run linter
	npm run lint

backup: ## Create backup
	node scripts/backup.js

health: ## Run health check
	node scripts/healthcheck.js

update: ## Update to latest version
	git pull origin main
	npm install
	pip3 install -r requirements.txt
	pm2 restart deya || npm start

clean: ## Clean temporary files
	rm -rf tmp/*
	rm -rf logs/*.log
	docker system prune -f || true

status: ## Check status
	@echo "🌺 Deya Status"
	@echo "============="
	@curl -s http://localhost:3000/health || echo "❌ Not running"
	@pm2 status deya 2>/dev/null || true
