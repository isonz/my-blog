:: usage:
:: git commit: ./push.sh 'commit message'
:: set nacos group to DEFAULT_GROUP: ./push.sh set default
:: set nacos group to my name: ./push.sh set my

@echo off
setlocal enabledelayedexpansion


:: get which modules need to change group
SET modules=gigi-auth gigi-gateway gigi-visual\gigi-monitor
list the folds of gigi-modules
(for /f %%i in ('dir .\gigi-modules\ /ad /b') do (
  SET modules=!modules!;gigi-modules\%%i
))


:: set group config string
(for /f %%i in ('git config user.name') do (
  SET groupName=%%i
))
echo "my group name is %groupName%"
SET myGroupStr="group: %groupName%"
SET defaultGroupStr="group: DEFAULT_GROUP"


:: set git commit message
SET commit_msg=%1
IF "%commit_msg%"=="" (
  echo "Please input commit message"
  exit
) ELSE IF "%commit_msg%"=="set" (
  IF "%2"=="default" (
    CALL :loopModules default
  ) ELSE IF "%2"=="my" (
    CALL :loopModules my
  )
) ELSE (
  CALL :gitPush
)



EXIT /B %ERRORLEVEL%
:loopModules
(for %%m in (%modules%) do (
  :: echo %%m
  CALL :changeGroup %%m %1
))
EXIT /B 0


:changeGroup
SET filename=%1\src\main\resources\bootstrap.yml
IF "%2"=="default" (
  echo "------ %1 reset to %defaultGroupStr% ---------"
  powershell -Command "(gc %filename% -encoding utf8) -replace '%myGroupStr%', '%defaultGroupStr%' | Out-File -encoding utf8 %filename%"
) ELSE IF "%2"=="my" (
  echo "------ %1 set to %myGroupStr% ---------"
  powershell -Command "(gc %filename% -encoding utf8) -replace '%defaultGroupStr%', '%myGroupStr%' | Out-File -encoding utf8 %filename%"
)
EXIT /B 0


:gitPush
SET useBranch=dev
echo "------ git checkout %useBranch% ---------"
git checkout %useBranch%

CALL :loopModules default

echo "------ git add --all ---------"
git add --all
echo "------ git commit -m %commit_msg% ---------"
git commit -m "%commit_msg%"
echo "------ git pull origin %useBranch% ---------"
git pull origin %useBranch%
echo "------ git push origin %useBranch% ---------"
git push origin %useBranch%

CALL :loopModules my

EXIT /B 0
