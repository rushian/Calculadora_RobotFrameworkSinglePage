*** Settings ***
Documentation   Arquivo para importacao de bibliotecas comuns a todos os testes
...             Tambem foram inclusas palavras chaves que podem ser utilizadas em todos os testes

Library         AppiumLibrary
Library         BuiltIn
Library         Collections
Library         DateTime
Library         JSONLibrary
Library         OperatingSystem
Library         Screenshot
Library         String
                
*** Variables ***
${REMOTE_URL}               http://127.0.0.1:4723/wd/hub
${avdReadyTimeout}          5000
${avdLaunchTimeout}         5000
${platformName}             Android
${automationName}           uiautomator2
${deviceName}               emulator-5554
${appPackage}               com.google.android.calculator
${appActivity}              com.android.calculator2.Calculator                      
${deviceOrientation}        portrait
${ensureWebviewsHavePages}  true
${nativeWebScreenshot}      true
${newCommandTimeout}        1000
${connectHardwareKeyboard}  true

*** Keywords ***
Abrir o app [no dispositivo: ${avd}]  
    ${data_atual}=                  Get Current Date             result_format=%d-%m-%Y
    Set Suite Variable      ${titulo}          ${TEST NAME}
    Create Directory                evidencias\\${data_atual}
    Exibir no console Abrir o app Calculadora ${appPackage}
    #Abrir aplicacao com os parametros fornecidos nas variaveis
    Open Application    ${REMOTE_URL}   
    ...    platformName=${platformName}  
    ...    automationName=${automationName}  
    ...    deviceName=${deviceName}  
    ...    appPackage=${appPackage}  
    ...    appActivity=${appActivity}
    ...    avd=${avd}
    ...    deviceOrientation=${deviceOrientation}  
    ...    ensureWebviewsHavePages=${ensureWebviewsHavePages}  
    ...    nativeWebScreenshot=${nativeWebScreenshot}  
    ...    newCommandTimeout=${newCommandTimeout}  
    ...    connectHardwareKeyboard=${connectHardwareKeyboard}    
    ...    avdReadyTimeout=${avdReadyTimeout}    
    ...    avdLaunchTimeout=${avdLaunchTimeout}
    ...    noSign=true

Ler Arquivo Json [${LocalArquivoJson}]    
    ${ArquivoJson}     Load Json From File     ${LocalArquivoJson}
    Log To Console    \nArquivo utilizado: ${LocalArquivoJson}
    [Return]            ${ArquivoJson}     

Exibir no console ${mensagem}
    log to console  ${mensagem}

Clicar no elemento ${locator} 
    Click Element    ${locator}

Elemento deve estar visivel ${locator}
    Element Should Be Visible    ${locator}

Espere elemento estar visivel ${locator}
    Wait Until Element Is Visible    ${locator}

Pular testes
    Skip

Tirar print
    Set Suite Variable      ${titulo}          ${TEST NAME}
    ${data_atual}=                  Get Current Date             result_format=%d-%m-%Y
    ${nome_arquivo}                 Get Current Date             result_format=%H-%M-%S
    Create Directory                evidencias\\${data_atual}\\${titulo}
    Set Screenshot Directory        evidencias\\${data_atual}\\${titulo}
    Take Screenshot                 evidence-${nome_arquivo}.png

Espere por ${tempo} segundos ate que a palavra chave (${palavra-chave}) seja executada com sucesso, verifica a cada ${intervalo}s
    Wait Until Keyword Succeeds       ${tempo}      ${intervalo}      ${palavra-chave}

Pagina nao deve conter o elemento ${locator}
    Page Should Not Contain Element     ${locator}

Pagina deve conter o elemento ${locator}
    Page Should Contain Element     ${locator}

Arrastar pra cima
    Swipe    500    1450    500    150
    
Arrastar pra baixo
    Swipe    500    150    500    1450

Repetir palavra-chave ${qtd} vezes - ${palavra-chave}
    Repeat Keyword      ${qtd}      ${palavra-chave}

Mover Screenshots
    Set Suite Variable      ${titulo}          ${TEST NAME}
    ${DATA_ATUAL}=                         Get Current Date      result_format=%d-%m-%Y
    Move Files                             appium-screenshot-*.png    ${EXECDIR}\\evidencias\\${DATA_ATUAL}\\${titulo}

Sair do app
    Exibir no console \n== Sair do aplicativo ==
    Close Application
