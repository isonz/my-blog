@echo off

set PYTHON=
set GIT=
set VENV_DIR=
set COMMANDLINE_ARGS=--precision full --no-half --medvram --xformers --disable-safe-unpickle --api --listen --enable-insecure-extension-access 
call webui.bat
