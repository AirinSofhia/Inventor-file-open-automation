*** Settings ***
Suite Setup       Open App and prepare Data    Open
Suite Teardown    Close App
Test Template     UsageControlForOpen
Resource          Public/public data.robot
Resource          Public/public operation.robot
Resource          Open_File/open_file_operation.robot
Library           String
Library           DataDriver    file=testcase.xlsx    sheet_name=Open    include=2    exclude=0

*** Test Cases ***
Run Inventor Usage Control for Open
    default    default    default    default

*** Keywords ***
UsageControlForOpen
    [Arguments]    ${test_data}    ${verify_img}    ${extra_step}    ${sleep_time}
    [Tags]    default

    # Initialize variable to track if the image is detected
    ${image_found}    Set Variable   False

    Sleep    5s
    Load Test Data    ${test_data}    ${extra_step}
    Sleep    ${sleep_time}

    # Handle additional condition for ${extra_step}
    IF    '${extra_step}' == 'yes'

        ${folder_path}    Evaluate    os.path.dirname(r'''${test_data}''')    modules=os
        Sleep    ${SLEEP_TIMER}
        Type Path    ${folder_path}
        ClickEnter

        FOR    ${i}    IN RANGE    4
            ${full_path}    Evaluate    os.path.join(r"${CURDIR}", r"${verify_img.strip()}")    modules=os
            ${result}    Verify Img    ${full_path}
            Sleep    ${sleep_time}

            # Update status to True upon successful image detection
            IF    "${result}" != "None" and "${result}" != "False"
                ${image_found}    Set Variable    True
            END
            ClickEnter
        END
    ELSE
        # Skip extra steps and directly verify the image once
        ${result}    Verify Img    ${CURDIR}\\${verify_img}
        Sleep    ${SLEEP_TIMER}
        # Update status to True upon successful image detection
        IF    "${result}" != "None" and "${result}" != "False"
            ${image_found}    Set Variable    True
        END
        ClickEnter
    END

    CloseFileWithoutSave

    # verify and log
    IF    "${image_found}" == "False"
        Fail    "Case Failed: Image not found or incorrect path"
    ELSE
        Log To Console    "Case Passed"
    END
