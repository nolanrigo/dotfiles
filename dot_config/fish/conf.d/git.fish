abbr --add gl   git lg
abbr --add gs   git status -sb
abbr --add gco  git checkout
abbr --add gm git merge
abbr --add gmb git merge-base

# Add
abbr --add ga   git add
abbr --add gap  git add -p
abbr --add gan  git add -N

# Commit
abbr --add gcm  git commit
abbr --add gcmf git commit --fixup
abbr --add gcma git commit --amend

# Rebase
abbr --add grb  git rebase
abbr --add grbi git rebase -i
abbr --add grbc git rebase --continue
abbr --add grba git rebase --abort

# Push
abbr --add gpu git push
abbr --add gpuu git push -u origin
abbr --add gpuf git push --force
abbr --add gpufl git push --force-with-lease

# Pull
abbr --add gpl git pull

# Stash
abbr --add gss git stash save -u
abbr --add gsp git stash pop --index
abbr --add gsl git stash list
abbr --add gsc git stash clear

# Diff
abbr --add gdf git diff
abbr --add gdfs git diff --staged

# Branch
abbr --add gbr git branch -avv
abbr --add gbrd git branch -d

# Reset
abbr --add grs git reset
abbr --add grsh git reset --hard
abbr --add grss git reset --soft
