*** Settings ***
Library           ../Library/utility.py
Resource          ../Public/public data.robot
Resource          ../Public/public_file_element.resource

*** Keywords ***
Trigger the open file dialog
    Sleep    1s
    Press 2 Keys    k1=ctrl    k2=o
    Sleep    1s

GoToDefaultPath
    Type Path    path=c:
    Sleep    2s
    ClickEnter

Choose File Type In Dialog
    # [Arguments]    ${translator}
    # Sleep    ${SLEEP_TIMER}
    Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\file_type.png  Optional=2
    # Sleep    3s
    Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\all_files.png  Optional=2
    # Sleep    2s
    Click Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\file_path2.png  Optional=2
    # Sleep    2s


Input File Path In Dialog
    [Arguments]    ${data_path}
    Sleep    1s
    Type Path    path=${data_path}
    Sleep    2s

Click Open Button From Dialog
    ClickEnter

MinimizeCurrentFile
    Click Img    img=${CURDIR}\\VerifyImg\\CommonAction\\SwitchToRoot\\MinimizeButton_CurrentFile.PNG  Optional=2
    # Sleep    2s
    Move To Center By Click
    # ClickEnter

MinimizeCurrentFileAsm
    Sleep    1s
    Click Img    img=${CURDIR}\\VerifyImg\\CommonAction\\SwitchToRoot\\MinimizeButton_CurrentFile_asm.PNG  Optional=2
    Move To Center By Click
    Sleep    2s

Press Enter Three Times
    Log    satu
    ClickEnter
    Sleep    3s
    Log    dua
    ClickEnter
    Sleep    3s
    Log    tiga
    ClickEnter
    Sleep    3s

SwitchToMainInventorWindow
    Press 3 Keys    k1=ctrl    k2=alt    k3=tab

ActiveWindows
    utility.Click
