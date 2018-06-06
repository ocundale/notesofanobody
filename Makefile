DEPLOY_DIRECTORY=public
DEPLOY_BRANCH=gh-pages

all: submodules deploy clean

submodules:
	@ git submodule init
	@ git submodule update

build:
	@ hugo

worktree:
	@ git worktree add $(DEPLOY_DIRECTORY) $(DEPLOY_BRANCH)

deploy: worktree build
	@ cd $(DEPLOY_DIRECTORY) && git add . && git commit -m "Build output as of $(shell git log '--format=format:%H' master -1)"
	@ git push origin $(DEPLOY_BRANCH)

clean:
	@ rm -rf $(DEPLOY_DIRECTORY)
	@ git worktree prune