@echo off

rem ===== Aumentar o espaco de variaveis de ambiente
rem CONFIG.SYS
rem set SHELL=C:\COMMAND.COM /P /E:1024

rem GeraSciELO
rem Parametro 1: path da producao da SciELO
rem Parametro 2: path do site da Scielo
rem Parametro 3: arquivo de log
rem Parametro 4: cria / adiciona

rem Inicializa variaveis
set SHELL=C:\COMMAND.COM /P /E:1024
set INFORMALOG=log\GeraScielo.log
set CISIS_DIR=cisis

rem Verifica parametros
call batch\VerifPresencaParametro.bat %0 @%1 path producao SciELO
call batch\VerifPresencaParametro.bat %0 @%2 path site SciELO
call batch\VerifPresencaParametro.bat %0 @%3 arquivo de LOG
call batch\VerifPresencaParametro.bat %0 @%4 opcao do LOG: cria/adiciona

if "%4"=="cria" call batch\DeletaArquivo.bat %3
set INFORMALOG=%3

call batch\InformaLog.bat %0 dh ===Inicio===

call batch\VerifExisteArquivo.bat %1\serial\scilista.lst
call batch\CopiaArquivo.bat %1\serial\scilista.lst scilista.lst
call batch\VerifExistemBases.bat %1

call batch\CriaDiretorio.bat ..\bases-work\title
call batch\GeraNovasDatas.bat %2\bases\title\title scilista.lst temp\NovasDatas
call batch\GeraMaster.bat %1\serial\title\title ..\bases-work\title\title prc\FilterAndGeraDatas.prc

rem call batch\CopiaDiretorio.bat %1\code %1\serial\code

call batch\OrdenaMaster.bat ..\bases-work\title\title 150 pft\OrdTitle.pft
call batch\GeraNewcodeAux.bat %1\serial temp\
call batch\GeraInvertido.bat ..\bases-work\title\title fst\title.fst ..\bases-work\title\title
rem call batch\GeraInvertido.bat ..\bases-work\title\title fst\serarea.fst ..\bases-work\title\serarea

rem call geraSubjectList.bat

call batch\GeraInvertido.bat ..\bases-work\title\title fst\titsrc.fst ..\bases-work\title\titsrc
call batch\GeraInvertido.bat ..\bases-work\title\title fst\titsrcp.fst ..\bases-work\title\titsrcp

call batch\GeraMaster.bat ..\bases-work\title\title ..\bases-work\title\logo prc\geraLogo.prc
call batch\GeraInvertido.bat ..\bases-work\title\logo fst\logo.fst ..\bases-work\title\logo

call batch\CriaDiretorio.bat ..\bases-work\newissue
call batch\GeraMaster.bat %1\serial\issue\issue ..\bases-work\newissue\newissue prc/nada.prc
call batch\GeraInvertido.bat ..\bases-work\newissue\newissue fst\newissue.fst ..\bases-work\newissue\newissue

call batch\CriaRevistasNovas.bat %1
call batch\GeraIssues.bat %1
call batch\GeraArtigo.bat %1

call batch\GeraFacCount.bat %1
call batch\GeraIssueIAH.bat %1

call batch\Seq2Master.bat scilista.lst space temp\scilista
call batch\TabulaMaster.bat temp\scilista temp\listatb 10 pft\TabLista.pft
call batch\GeraInvIAH.bat %1 temp\listatb

rem REPOSITORIO INICIO
if exist repo\repo.seq call repo\RepoGenerateIndex.bat %1
rem REPOSITORIO FIM

call batch\ManutencaoOn.bat ..\bases
call batch\CopiaWork2Teste.bat ..\bases-work ..\bases
call batch\ManutencaoOff.bat ..\bases

call batch\InformaLog.bat %0 dh ===Fim=== LOG gravado em: %INFORMALOG%
