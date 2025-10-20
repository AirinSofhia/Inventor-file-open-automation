*** Settings ***
Suite Setup       Open App and prepare Data    Save
Suite Teardown    Close App
Test Template     UsageControlForSave
Resource          Public/public data.robot
Resource          Public/public operation.robot
Resource          Open_File/open_file_operation.robot
Resource          Run_Macros/run_macros_operation.robot
Library           DataDriver    file=testcase.xlsx    sheet_name=Save2    include=2    exclude=0

*** Test Cases ***
Run Inventor Usage Control for Save
    default    default    default    default    default    default    default    default

*** Keywords ***
UsageControlForSave
    [Arguments]    ${test_data}
    ...            ${sleepTime}
    ...            ${OpenInNewWindows}
    ...            ${SaveAction}
    ...            ${is_edit}
    ...            ${expected_result}
    ...            ${verify_deny_img}
    ...            ${verify_allow_files}
    [Tags]        default
    Sleep    2s

    # Get old file info
    ${OldFileInfo}    Evaluate    collections.OrderedDict()    modules=collections
    IF    '${expected_result}' == 'allow'
        ${OldFileInfo}    Getfileinfo    ${verify_allow_files}
    END

    # Open file in Inventor
    Load Test Data    ${test_data}    save
    Handle Resolve Link Dialog
    Sleep    3s
    IF    '${OpenInNewWindows}' == 'yes'
        Open TestPrtInNewWindows
    END

    # # Perform Edit Macro
    # Load Macro    ${macro_edit}
    # Sleep    2s

    # Perform Manual Edit
    # Open Sketch
    # Manual Edit
    # Sleep    3s
    IF    '${is_edit}' == 'yes'
        Sleep    2s
        Open sketch
        Manual Edit
        Sleep    1s
    END

    # If OpenInNewWindows is 'yes', perform the steps
    IF    '${OpenInNewWindows}' == 'yes'
        Minimize Windows After Edit
        Sleep    3s
        # CloseNoEditPermissionDialog
        # ActiveWindows
    END

    # # Perform save macro
    # Load Macro    ${macro_save}

    # Perform Save All Action
    Run Keyword    ${SaveAction}
    Sleep    2s

    # Verify result after save operation
    ${result}    ${msg}    Verify Result For Inventor Save    ${expected_result}    ${CURDIR}\\${verify_deny_img}    ${verify_allow_files}    ${OldFileInfo}
    Sleep    1s

    # Close any deny message windows if they appeared
    ClosewindowsForDenyMessage    ${expected_result}

    # Try to close opened files
    CloseFileHandling    ${expected_result}
    CloseFile2
    # CloseFile
    CloseFileWithoutSave
    # CloseFileWithoutSave
    # ExitWithoutSave

    IF    ${result} == ${False} or ${result} == ${None}
        Fail    "Case Failed"
        Log To Console   ${msg}
    END
