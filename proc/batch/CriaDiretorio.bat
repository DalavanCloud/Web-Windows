rem CriaDiretorio
rem Parametro 1: diretorio

call batch\VerifPresencaParametro.bat %0 @%1 diretorio a ser criado

call batch\InformaLog.bat %0 x Cria diretorio: %1
mkdir %1
