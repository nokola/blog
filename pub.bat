@echo off
echo Pushing orig...
git add .
git commit -m %1
git push
echo.
echo Rebuild
hugo
echo.
echo Pushing generated...
cd public
git add .
git commit -m %1
git push
cd ..
