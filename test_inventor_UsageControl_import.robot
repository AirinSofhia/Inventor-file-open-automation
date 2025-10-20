*** Settings ***
Suite Setup       Open App
Suite Teardown    Close App
Test Template     UsageControlForImport
Resource          Public/public data.robot
Resource          Public/public operation.robot
Library           DataDriver    file=testcase.xlsx    sheet_name=Import    include=2    exclude=0

*** Test Cases ***
Run AutoCAd Usage Control for Import
    default    default    default    default    default    default    default    default    default    default    default

*** Keywords ***
UsageControlForImport
    [Arguments]    ${test_data}    ${verify_file}    ${verify_img}    ${expected_result}    ${save_type}    ${open_type}    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action}
    [Tags]    default

    # Define the list of words to check in the file path
    @{protected_keywords}    Set Variable    ipn    idw    Inventor_dwg    iam    ipt
    # Check if any keyword exists in the file path
    ${is_protected}    Evaluate    any(word in r"${test_data}\ " for word in ${protected_keywords})

    # Step 1: Open model
    Log    Testing action: ${different_action}    console=True
    # Step 2: Run process based on ${different_action}
    Run Keyword    ${different_action}    ${test_data}    ${expected_result}    ${open_type}    
    ...    ${extra_step}    ${translator}    ${sleep_time}    ${action_type}    ${different_action}
    Sleep    10s

    # Step 3: Run process based on ${expected_result}
    IF    '${expected_result}' == 'allow'
        ${result}    ${msg}    Run Allow Case    ${test_data}    ${verify_file}    ${save_type}    ${different_action}    ${is_protected}
    ELSE IF    '${expected_result}' == 'deny'
        ${result}    ${msg}    Run Deny Case    ${test_data}    ${verify_img}    ${different_action}    ${is_protected}
    END

    # Verify result
    IF    not ${result}    Fail    "Case Failed: ${msg}"
    Log To Console    "Case Passed: ${msg}"

## Keyword for allow test cases
Run Allow Case
    [Arguments]    ${test_data}    ${verify_file}    ${save_type}    ${different_action}    ${is_protected}
    Log    ${different_action}
    # Step 4: Run process based on ${different_action}
    IF    not ${is_protected}
        # Case 1 != 'FileOpen'
        SaveFile    ${save_type}
        Sleep    ${SLEEP_TIMER}
        # Verify result for allow case
        ${result}    ${msg}    Verify Result For Inventor Import    ${verify_file}    ${OUTPUT_FOLDER}
        Sleep    ${SLEEP_TIMER}
    ELSE
        # Case 2 == 'FileOpen'
        Log    satu
        ${result}    ${msg}    Check File Protection    ${test_data}
        Sleep    ${SLEEP_TIMER}
    END
    # Step 5: Close All File
    CloseFileWithoutSave
    Sleep    ${SLEEP_TIMER}
    # Step 6: Clear 'output' folder
    ${results}    Empty Folder    ${OUTPUT_FOLDER}
    Log    ${results}
    RETURN    ${result}    ${msg}

# Keyword for deny test cases
Run Deny Case
    [Arguments]    ${test_data}    ${verify_img}    ${different_action}    ${is_protected}
    Log    ${different_action}
    # Step 4: Additional steps for 'FileOpen'
    IF    ${is_protected}
        Open Explorer
        Sleep    ${SLEEP_TIMER}
        Click Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\file_path3.png   Optional=2
        # Sleep    ${SLEEP_TIMER}
        InputFilePath    ${test_data}
        Sleep    ${SLEEP_TIMER}
        Rightclick Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\super.png
        # Sleep    ${SLEEP_TIMER}
        Rightclick Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\skydrm.png
        Sleep    ${SLEEP_TIMER}
        utility.Presskey    down    2
        ClickEnter
    END

    # Step 5: Verify deny image
    ${result}    ${msg}    Verify Result For Inventor Import    image_path=${CURDIR}\\${verify_img}
    Log    ${CURDIR}\\${verify_img}
    Sleep    ${SLEEP_TIMER}

    IF    not ${is_protected}
        # Step 5: Close deny message
        ClickEnter
        Sleep    ${SLEEP_TIMER}
        # Step 6: Close File
        CloseFileWithoutSave
    ELSE
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\close_skydrm.png
        Sleep    ${SLEEP_TIMER}
        Close Explorer
    END

    RETURN    ${result}    ${msg}
