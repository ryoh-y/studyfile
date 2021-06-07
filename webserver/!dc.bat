@echo off

::************************************************************
::File Name	: !dc.bat
::Date		: 2021/06/04
::作者		: yamafuji
::
::function	:tmpファイルをコピーします
::************************************************************
::変数:
set CONTAINER=projCon
set IMAGE_NAME=projimg
::************************************************************
echo.

if "%1" =="" (
	goto RARAM_ERROR
) else if "%1" =="buildc" (
	docker-compose build
	goto CORRECT
) else if "%1" =="up" (
	docker-compose up -d
	goto CORRECT
) else if "%1" =="runc" (
	docker-compose run
	goto CORRECT
) else if "%1" =="down" (
	docker-compose down
	goto CORRECT
) else if "%1" =="ps" (
	docker-compose ps %2
	goto CORRECT
) else if "%1" =="pull" (
	docker pull %2
	goto CORRECT
)
if not "%2" =="" (set CONTAINER="%2" )

if "%1" =="build" (
	docker build -t %IMAGE_NAME% .
	goto CORRECT
) else if "%1" =="exec" (
	docker exec -it %CONTAINER% /bin/bash
	goto CORRECT
) else if "%1" =="execa" (
	docker exec -it %CONTAINER% /etc/myinit
	goto CORRECT
) else if "%1" =="start" (
	docker start %CONTAINER%
	goto CORRECT
) else if "%1" =="stop" (
	docker stop %CONTAINER%
	goto CORRECT
) else if "%1" =="run" (
set FILE_FULLDIR=%~dp0
set FILE_DIR=%FILE_FULLDIR:\=/%
set FILE_NAME=%FILE_DIR:~0,-1%

	docker run -d -it -p 80:80 -p 8000:8000 -p 3306:3306 --privileged ^
	--sysctl net.ipv6.conf.all.disable_ipv6=1 --cap-add=NET_ADMIN ^
	 -v %FILE_NAME%/data:/root/data ^
	 -v %FILE_NAME%/install:/root/install ^
	 --name %CONTAINER% %IMAGE_NAME% /sbin/init 
	goto CORRECT
)

::----------------------------------------------------------
:CORRECT
exit /B

:PARAM_ERROR
echo パラメータエラー：ファイル名が必要です。
exit /B

:NOT_FOUND_ERROR
echo ファイル、フォルダが見つかりません。
exit /B

