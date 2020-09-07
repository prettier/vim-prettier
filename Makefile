NAME=vim-prettier

VERSION=1.0.0-beta

build: 
	docker build -t mitermayer/vim-test-bed .

test:
	echo "Running tests..."
	docker run \
		-t \
		--rm \
		-v ${PWD}:/testplugin \
		-v ${PWD}/tests:/home \
		"mitermayer/vim-test-bed" \
		yarn --cwd testplugin test

test-update-snapshot:
	echo "Running tests..."
	docker run \
		-t \
		--rm \
		-v ${PWD}:/testplugin \
		-v ${PWD}/tests:/home \
		"mitermayer/vim-test-bed" \
		yarn --cwd testplugin test -u

lint:
	echo "Running linter..."
	docker run \
		-t \
		--rm \
		-v ${PWD}:/testplugin \
		-v ${PWD}/tests:/home \
		"mitermayer/vim-test-bed" \
		yarn --cwd testplugin lint

tag:
	git tag $(VERSION)

chroot:
	docker run \
		-it \
		-v ${PWD}:/testplugin \
		-v ${PWD}/tests:/home \
		"mitermayer/vim-test-bed" \
		bash

run:
	docker run \
		-it \
		-v ${PWD}:/testplugin \
		-v ${PWD}/tests:/home \
		"mitermayer/vim-test-bed" \
		${VIM_VERSION} -u /home/vimrc

changelog:
	docker run -it --rm -v "${PWD}":/usr/local/src/your-app ferrarimarco/github-changelog-generator -u prettier -p vim-prettier -t ${GITHUB_REPO_READ_TOKEN}

release:
	git push --tags

.PHONY: build test lint tag chroot run changelog release
