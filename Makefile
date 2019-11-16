i.PHONY: clean


## Delete all compiled python (or other) files
clean:
	find . -type f -name "*.py[co]" -delete || 1
	find . -type d -name "__pycache__" -exec rm -rf {} ';' || 1
	find . -type d -name "*.egg-info" -exec rm -rf {} ';' || 1
	find . -type f -name "*.tmp" -delete || 1

## Build cloudmesh in docker
build: clean
	docker build -t cloudmesh -f project/cloudmesh/images/cloudmesh/Dockerfile project/.
	
## Run cloudmesh as daemon	
run: clean
	docker run \
	--mount type=bind,src="$(shell pwd)/project",dst=/home/cloudmesh-cluster \
	--mount type=bind,src=$(shell echo $$HOME)/.cloudmesh/,dst=/root/.cloudmesh \
	--mount type=bind,src=$(shell echo $$HOME)/.ssh/,dst=/root/.ssh \
	-it cloudmesh:latest
	
## Run cloudmesh and attach in it mode (windows)
inter:
	docker attach $(shell make -s run)

## Build, run interactive cloudmesh
up: build inter
HOT=false
COMMAND = "python -m pytest -r /root/cloudmesh-cluster/test"
test-hot:
	docker exec -i $(shell docker ps -lq -f ancestor=cloudmesh) $(COMMAND)
test-cold:
	docker exec -i $(shell make -s run) $(COMMAND)

#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')