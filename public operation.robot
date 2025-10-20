*** Settings ***
Library           ../Library/utility.py
Library           FlaUILibrary
Resource          ../Public/public data.robot
Resource          ../Public/public_file_element.resource
Resource          ../Open_File/open_file_element.resource

*** Keywords ***
Open App
    Launch Application    ${PROGRAM_PATH}
    Sleep    12s
    Attach Application By Name    ${PROGRAM_NAME}
    Sleep    12s

Open App and prepare Data
     [Arguments]    ${action}
     Restore Data    ${action}
     Open App
     
Close App
    Sleep    3s
    Close Application By Name    ${PROGRAM_NAME}
    Sleep    10s

Close File and Erase
    CloseFile
    EraseFile
    
Open Explorer
    Sleep    12s
    Launch Application    explorer.exe
    Sleep    12s

Close Explorer
    Sleep    3s
    Close Application By Name    explorer.exe
    Sleep    10s

Close SkyDRM
    Sleep    3s
    Close Application By Name    skydrmdesktop.exe
    Sleep    10s

CloseFileWithoutSave
    CloseFile
    # Sleep    3s
    Choose Ok Button
    # Sleep    2s
    # MoveToCenterAndClick
    # Choose No Button
    # ExitWithoutSave
    # Sleep    2s

    # CloseFile
    # MoveToCenterAndClick
    # ExitWithoutSave
    # Choose No Button

    # CloseFile
    # # Sleep    1s
    # # MoveToCenterAndClick
    # Sleep    2s
    # ExitWithoutSave
    # Sleep    3s
    # ClickNoButton
    # Sleep    1s

CloseFileHandling
    [Arguments]    ${expected_result}
    Sleep    1s
    CloseFile2

    # Handle save prompt based on expected result
    IF    '${expected_result}' == 'deny'
        Log    Deny case detected — clicking No on save prompt
        ClickNoButton
    ELSE IF    '${expected_result}' == 'allow'
        Log    Allow case detected — clicking Yes on save prompt
        ClickYesButton
    ELSE
        Log    Unknown expected result — no action taken
    END
    Sleep    2s

ClickNoButton
    # Detect save dialog presence if the file still not close properl
    ${save_dialog}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\save dialog.png
    Sleep    1s

    # First check for the dialog
    IF    '${save_dialog}' != 'None'
        Log    save dialog detected (Attempt 1)
        # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\choose no button.png
        Choose No Button
        Sleep    1s
    ELSE
        Log    save dialog not detected (Attempt 1)
    END

    # Second check for the dialog
    IF    '${save_dialog}' != 'None'
        Log    save dialog detected (Attempt 2)
        # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\choose no button.png
        Choose No Button
        Sleep    1s
    ELSE
        Log    save dialog not detected (Attempt 2)
    END

    # Third check for the dialog
    IF    '${save_dialog}' != 'None'
        Log    save dialog detected (Attempt 3)
        # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\choose no button.png
        Choose No Button
    ELSE
        Log    save dialog not detected (Attempt 3)
    END

CloseNoEditPermissionDialog
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseNoEditPermissionWindows\\XbuttonForNextLabs.PNG

# ${diferent_action}
FileOpenImportCAD
    [Arguments]    ${test_data}    ${expected_result}    ${open_type}    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action}
    ClickFile
    ChooseOpen
    ChooseImportCAD
    Sleep    5s
    ChooseFileType    ${translator}    ${different_action}
    ChooseFile    ${test_data}    ${open_type}
    Sleep    1s
    ExpectedResultCondition    ${expected_result}    ${extra_step}
    Sleep    ${sleep_time}

FileOpenImportDWG
    [Arguments]    ${test_data}    ${expected_result}    ${open_type}    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action}
    ClickFile
    ChooseOpen
    ChooseImportDWG
    Sleep    1s
    Type Path    path=${test_data}
    ClickEnter
    OpenTypeCondition    ${open_type}
    Sleep    1s
    ExpectedResultCondition    ${expected_result}    ${extra_step}

3DModelImport
    [Arguments]    ${test_data}    ${expected_result}    ${open_type}    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action}
    OpenIPT
    ClickImport    ${different_action}
    ChooseFileType    ${translator}    ${different_action}
    FileName
    InputFilePath    ${test_data}
    IF    '${expected_result}' == 'deny'    RETURN
    OpenTypeCondition    ${open_type}
    Sleep    ${sleep_time}

SketchInsert
    [Arguments]    ${test_data}    ${expected_result}    ${open_type}    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action} 
    OpenIPT
    ClickImport    ${different_action}
    ActionTypeSketchInsert    ${test_data}    ${action_type}
    InputFilePath    ${test_data}
    IF    '${expected_result}' == 'deny'    RETURN
    Sleep    10s
    OpenTypeCondition    ${open_type}
    Sleep    ${sleep_time}

ManageInsertImport
    [Arguments]    ${test_data}    ${expected_result}    ${open_type}    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action}
    OpenIPT
    ClickImport    ${different_action}
    ChooseFileType    ${translator}    ${different_action}
    FileName
    InputFilePath    ${test_data}
    IF    '${expected_result}' == 'deny'    RETURN
    OpenTypeCondition    ${open_type}
    Sleep    ${sleep_time}

ManagePointCloudAttach
    [Arguments]    ${test_data}    ${expected_result}    ${open_type}    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action} 
    OpenIPT
    ClickImport    ${different_action}
    ExtraStep    ${test_data}
    InputFilePath    ${test_data}
    IF    '${expected_result}' == 'deny'    RETURN
    OpenTypeCondition    ${open_type}
    Sleep    ${sleep_time}
    MoveToCenterAndClick
    Sleep    ${SLEEP_TIMER}
    ClickEnter

AssembleComponentPlace
    [Arguments]    ${test_data}    ${expected_result}    ${open_type}    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action}
    OpenIAM
    ClickImport    ${different_action}
    ChooseFileType    ${translator}    ${different_action}
    FileName
    InputFilePath    ${test_data}
    IF    '${expected_result}' == 'deny'    RETURN
    Sleep    ${SLEEP_TIMER}
    OpenTypeCondition    ${open_type}
    Sleep    ${sleep_time}
    MoveToCenterAndClick
    Sleep    ${SLEEP_TIMER}

Check Macro Success
    ${error_present}    Run Keyword And Return Status    Verify Img    img=${CURDIR}\\VerifyImg\\ErrorDialog.PNG
    Run Keyword If    ${error_present}    Return From Keyword    False
    # Or check for success indication image or condition here
    Return From Keyword    True

Run Edit Macro
    [Arguments]    ${macro_name}
    Load Macro    ${macro_name}
    Sleep    2s

Create New IPT File
    # Example 1: Use Inventor menu keyboard shortcut Alt+N (File > New)
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\test\\newfile.PNG   Optional=2
    # Sleep    1s
    # Example 2: Select Part template from dialog by image click or keyboard navigation
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\test\\ipt.PNG   Optional=2
    # Sleep    3s
    # Or run macro that creates new part document

Sketch
# Step1: open sketch window
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\first click sketch window.PNG  Optional=2
    # Sleep    1s
# Step2: open sketch button
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\second select sketch.PNG  Optional=2
    # Sleep    1s
# Step3: choose 3D sketch
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\third choose 3D.PNG  Optional=2
    # Sleep    1s
# Step4: choose sketch plus
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\fourth click sketch plus.PNG  Optional=2
    # Sleep    1s
# Step5: click start
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\five click start.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\six click draw.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerfyImg\\CommonAction\\Sketch\\seven choose arc.PNG  Optional=2
    # Sleep    1s
    Move To Center By Click
    
Open sketch

    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\first click sketch window.PNG  Optional=2
    # Sleep    2s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\second select sketch.PNG  Optional=2
    # Sleep    2s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\third choose 3D.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\fourth click sketch plus.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\fifth click start.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\sixth click draw.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Sketch\\seventh choose arc.PNG  Optional=2
    # Sleep    1s

Click OK Button
    Click Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseFile\\ok button.png  Optional=2
    # Sleep    1s
    Click Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseFile\\second ok button.png  Optional=2

Save All File
    # Sleep     ${SLEEP_TIMER}
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file.PNG  Optional=2
    # Sleep    1s
    # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\save file.PNG
    # Sleep    1s
    Presskey Down
    Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\save option.PNG  Optional=2
    # Sleep    2s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\save all file.PNG  Optional=2
    # Sleep    3s

    # Detect the first appearance of the Assembly IPN dialog after save file
    ${dialog_present}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseFile\\assembly_ipn.png
    Sleep    2s

    # If Assembly IPN dialog is present, handle it
    IF    '${dialog_present}' != 'None'
        Log    Assembly IPN dialog detected
        Click Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseFile\\ok button.png  Optional=2
        # Sleep    1s
    ELSE
        Log    Assembly IPN dialog not detected
    END

    # Detect the second appearance of the Assembly IPN dialog after save file
    ${dialog_present}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseFile\\assembly_ipn.png
    Sleep    2s

    # If Assembly IPN dialog is present again, handle it
    IF    '${dialog_present}' != 'None'
        Log    Assembly IPN dialog detected
        Click Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseFile\\second ok button.png  Optional=2
        # Sleep    1s
    ELSE
        Log    Assembly IPN dialog not detected
    END
    # Sleep    1s

SaveCmd
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file.PNG  Optional=2
    # Sleep    1s
    Presskey Down
    Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\save option.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\save.PNG  Optional=2
    # Sleep    1s

    # If save button disable click save all to see the deny notification appear
    ${save button_present}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\disable save button.png
    Sleep    2s
    IF    '${save button_present}' != 'None'
        Log    save button disable
        Click Img    img=${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\save all file.png  Optional=2
        # Sleep    1s
    ELSE
        Log    save button function
    END
    Sleep    1s

SaveFiles
    # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file.PNG
    Press To Save
    Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\save option.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\save all file.PNG  Optional=2
    # Sleep    1s

Click Print Button
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file2.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\print_button.PNG  Optional=2
    # Sleep    1s
    # Manual Print
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\file print.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\file print2.PNG  Optional=2
    # Sleep    1s

PrintToPDF
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file.PNG  Optional=2
    # Sleep    1s
    # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file2.PNG
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\print_button.PNG  Optional=2
    # Sleep    1s
    # Manual Print
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\file print.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\file print2.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\PDF file.PNG  Optional=2
    # Sleep    1s
    ClickEnter
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\print dialog.png  Optional=2
    ${verify_print_files} =    Set Variable    C:\\InventorUsageControl\\Print\\PrintFiles\\Part1.pdf
    Type Path    path=${verify_print_files}
    # Sleep    1s
    ClickEnter
    Sleep    2s

    # If print button disable click save all to see the deny notification appear
    ${print_button_disable}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\Print\\print_button_disable.png
    Sleep    2s
    IF    '${print_button_disable}' != 'None'
        Log    print button disable
        SaveFiles
        Sleep    1s
    ELSE
        Log    print button function
    END
    Sleep    1s

PrintToXPS
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file.PNG  Optional=2
    # Sleep    1s
    # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file2.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\print_button.PNG  Optional=2
    # Sleep    1s
    # Manual Print
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\file print.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\file print2.PNG  Optional=2
    # Sleep    1s
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\XPS file.PNG  Optional=2
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\XPS file2.PNG  Optional=2
    ClickEnter
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\print dialog.png  Optional=2
    ${verify_print_files} =    Set Variable    C:\\InventorUsageControl\\Print\\PrintFiles\\Part1.oxps
    Type Path    path=${verify_print_files}
    ClickEnter
    Sleep    2s

    # If print button disable click save all to see the deny notification appear
    ${print_button_disable}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\Print\\print_button_disable.png
    Sleep    2s
    IF    '${print_button_disable}' != 'None'
        Log    print button disable
        SaveFiles
        Sleep    1s
    ELSE
        Log    print button function
    END
    Sleep    1s

PrintTo3DService
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file.PNG  Optional=2
    # Sleep    1s
    # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file2.PNG  Optional=2
    # Sleep    1s
    Presskey Down Print2
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\3D print.PNG  Optional=2
    ClickEnter
    ${verify_print_files} =    Set Variable    C:\\InventorUsageControl\\Print\\PrintFiles\\Part1.stl
    Type Path    path=${verify_print_files}
    ClickEnter
    Sleep    2s

PrintDisable
    Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\SaveFile\\file.PNG  Optional=2
    # Sleep    1s
    # Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\Print\\print disable.png  Optional=2
    