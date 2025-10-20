*** Settings ***
Suite Setup       Open App and prepare Data    Print
Suite Teardown    Close App
Test Template     UsageControlForPrint
Resource          Public/public data.robot
Resource          Public/public operation.robot
Resource          Open_File/open_file_operation.robot
Resource          Run_Macros/run_macros_operation.robot
Library           DataDriver    file=testcase.xlsx    sheet_name=Print    include=2    exclude=0

*** Test Cases ***
Run Inventor Usage Control for Print
    default    default    default    default    default    default    default    default

*** Keywords ***
UsageControlForPrint
    [Arguments]    ${test_data}
    ...            ${sleepTime}
    ...            ${OpenInNewWindows}
    ...            ${is_edit}
    ...            ${PrintAction}
    ...            ${expected_result}
    ...            ${verify_deny_img}
    ...            ${verify_print_files}
    [Tags]        default
    Sleep    2s

    # Open File
    Load Test Data    ${test_data}    print
    Handle Resolve Link Dialog
    Sleep    3s
    IF    '${OpenInNewWindows}' =='yes'
        Open TestPrtInNewWindows
    END

    # Edit Action
    IF    '${is_edit}' == 'yes'
        Sleep    2s
        Open sketch
        Manual Edit
        Sleep    1s
    END
    
    # Minimize Windows
    IF    '${OpenInNewWindows}' == 'yes'
        Minimize Windows After Edit
        Sleep    2s
    END

    # Print the file
    # Click Print Button
    Run Keyword    ${PrintAction}
    Sleep    1s

    # Get the result
    ${result}    ${msg}    Verify Result For Inventor Print    ${expected_result}    ${CURDIR}\\${verify_deny_img}    ${verify_print_files}
    ClosewindowsForDenyMessage    ${expected_result}
    Moveto Center And Click
    CloseFileHandling    ${expected_result}
    IF    '${OpenInNewWindows}' == 'yes'
        Sleep    1s
        CloseFileHandling    ${expected_result}
    END

    # Verify and set case pass or fail
    IF    ${result} == ${False} or ${result} == ${None}
        Fail    "Case Failed"
        Log    ${msg}
    END
    Sleep    1s
    Empty Folder    folder_path=C:\\InventorUsageControl\\Print\\PrintFiles
    