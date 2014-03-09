### Release Steps

update version in FlatButtons.podspec  
update the git tag to match the new version  
update README.md  

    pod lib lint

    git add -A && git commit -m "Release 0.0.1."
    git tag '0.0.1'
    git push --tags

