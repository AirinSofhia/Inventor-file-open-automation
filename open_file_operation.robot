*** Settings ***
Resource          open_file_element.resource
Library           ../Library/utility.py

*** Keywords ***
Load Test Data
    [Documentation]    Open file
    [Arguments]    ${data_path}    ${extra_step} 
    # ActiveWindows
    Sleep    2s
    Trigger the open file dialog
    # Input File Type In Dialog    fileName=${data_path}
    Choose File Type In Dialog
    Input File Path In Dialog    ${data_path}
    Click Open Button From Dialog
    Sleep    ${SLEEP_TIMER}
    # SendCommand    command=xref
    # IF    '${extra_step}' == 'yes'    Press Enter Three Times

Go Back To asm
    [Documentation]    go back to asm.
    MinimizeCurrentfile
    # ActiveWindows

Minimize Asm Window
    [Documentation]    go back to drw.
    MinimizeCurrentFileAsm
    Sleep    2s

Minimize Windows After Edit
    # Minimize test part window first (go back to asm)
    Go Back To asm
    # Move To Center By Click
    Sleep    1s

    # Detect IDW window still presence
    ${idw_visible}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\minimize\\idw_window_indicator.png
    Sleep    2s

    IF    '${idw_visible}' != 'None'
        Log    IDW window detected - minimizing ASM window
        Go Back To asm
        # Move To Center By Click
        Sleep    2s
    ELSE
        Log    IDW window not detected - keeping ASM window open
    END

    # Detect DWG window still presence
    ${dwg_visible}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\minimize\\dwg_window_indicator.png
    Sleep    3s

    IF    '${dwg_visible}' != 'None'
        Log    DWG window detected - minimizing window
        Go Back To asm
        # Move To Center By Click
        Sleep    2s
    ELSE
        Log    DWG window not detected - keeping window open
    END

    # Detect IPN window still presence
    ${ipn_visible}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\minimize\\ipn window indicator.png
    Sleep    2s
    IF    '${ipn_visible}' != 'None'
        Log    ipn window detected - minimizing window
        Go Back To asm
        Sleep    2s
    ELSE
        Log    ipn window not detected - keeping window open
    END

    # # Detect IPN window presence
    # ${ipn_visible}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\minimize\\ipn window indicator.png
    # Sleep    2s
    # IF    '${ipn_visible}' != 'None'
    #     Log    ipn window detected - minimizing window
    #     Sleep    1s
    #     Minimize Asm Window
    #     Sleep    2s
    # ELSE
    #     Log    ipn window not detected - keeping window open
    # END

    # Detect updated state for idw
    ${updated_visible}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\minimize\\updated state.png
    Sleep    2s
    IF    '${updated_visible}' != 'None'
        Log    updated state detected
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\minimize\\okay button.PNG  Optional=2
        # Sleep    2s
    ELSE
        Log    updated state not detected
    END

Open TestPrtInNewWindows
    [Documentation]    for iam, idw, dwg and ipn, we need to open the test.prt in new windows to do edit action
    # Check if IAM VIEW window is present
    Sleep    1s
    ${view_iam}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\view_iam.png
    IF    '${view_iam}' != 'None'
        Log    IAM view image found - proceeding with IDW/DWG open steps
        Rightclick Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\view_iam.png  Optional=2
        # Sleep    1s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\open_file.PNG  Optional=2
        Sleep    2s

        ${testpart}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\TestPrt.png
        Sleep    1s
        IF    '${testpart}' == 'None'
            Fail    Test part image not found!
        ELSE
            Rightclick Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\TestPrt.png  Optional=2
            # Sleep    2s
            Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\open button.PNG  Optional=2
            # Sleep    3s
        END
    
    ELSE
        Sleep    1s
        Log    IAM view image not found - assuming IAM file, proceeding IAM step
        Sleep    1s
        Rightclick Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\TestPrt.png  Optional=2
        # Sleep    1s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\open button.PNG  Optional=2
        # Sleep    3s
        # ActiveWindows
    END

    # Check if IPN window is present
    ${view_ipn}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\view_ipn.png
    IF    '${view_ipn}' != 'None'
        Log    IPN view image found
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\open dwg.png  Optional=2
        # Sleep    1s
        Doubleclick Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\standard dwg.png  Optional=2
        # Sleep    1s
        Choose Ok Button
        Sleep    3s
    ELSE
        Log    IPN view not detected
    END
    
Open SubAsmWindows
    # Check if IAM VIEW image is present
    ${view_iam}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\view_iam.png
    IF    '${view_iam}' != 'None'
        Log    IAM view image found - proceeding with IDW open steps
        Rightclick Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\view_iam.png  Optional=2
        # Sleep    1s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\open_file.PNG  Optional=2
        # Sleep    3s

        ${subasm}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\SubAsm.png
        IF    '${subasm}' == 'None'
            Fail    SubAsm image not found!
        ELSE
            Rightclick Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\SubAsm.png  Optional=2
            # Sleep    2s
            Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\open button.PNG  Optional=2
            # Sleep    3s
        END
    
    ELSE
        Log    IAM view image not found - assuming IAM file, proceeding IAM step
        Rightclick Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\TestPrt.png  Optional=2
        # Sleep    2s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\openTestPrtInNewWindows\\open button.PNG  Optional=2
        # Sleep    3s
        # ActiveWindows
    END

Handle Resolve Link Dialog
    # Detect resolve link dialog
    ${dialog_present}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\ResolveLink\\resolve link dialog.png
    Sleep    1s

    IF    '${dialog_present}' != 'None'
        Log    dialog window detected
        Sleep    1s

        # Check if ipn word image appears in the dialog
        ${ipn_found}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\ResolveLink\\ipn word.png
        Sleep    2s

        IF    '${ipn_found}' != 'None'
            Log    IPN word detected in dialog - clicking cancel button
            Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\ResolveLink\\cancel button.png  Optional=2
            # Sleep    1s

        ELSE
            Log    IPN word not detected - clicking open button
            # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\ResolveLink\\open button.png  Optional=2
            Click Enter
            # Sleep    2s
        END
    ELSE
        Log    Resolve Link dialog not detected
    END

Open Dialog Link
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\ResolveLink\\open button.png  Optional=2
    # Sleep    3s
