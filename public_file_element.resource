*** Settings ***
Library           ../Library/utility.py
Resource            ../Public/public data.robot


*** Keywords ***

Restore Data
    [Arguments]    ${action}
    utility.Restore Data    ${action}

ExitWithoutSave
    utility.Presskey    k1=down
    Sleep    2s
    utility.Presskey    k1=enter
    Sleep    2s

ClickEnter
    Sleep    2s
    utility.Presskey    k1=enter
    Sleep    2s

MoveToCenterAndClick
    utility.Move To Center By Click

KeyboardForSaveAs
    utility.presskeys    Ctrl    Shift    S

ChooseOpen
    utility.Press Key    down    2
    ClickEnter

ChooseOption
    utility.Press Key    down    1
    ClickEnter

ChooseSketch
    utility.Press Key    down    7
    ClickEnter

ChooseAssemble
    utility.Press Key    down    27
    ClickEnter

ChooseImportCAD
    utility.Press Key    down    5
    ClickEnter

ChooseImportDWG
    utility.Press Key    down    4
    ClickEnter

CloseFile
    Sleep    2s
    Press 2 Keys    k1=alt    k2=w
    Sleep    3s
    # utility.Presskey    k1=esc
    # Press 2 Keys    k1=ctrl    k2=w
    utility.Presskey    k1=enter
    Sleep    1s

CloseFile2
    Press 2 Keys    k1=alt    k2=w
    Sleep    3s

EraseFile
    utility.Presskey    k1=f8
    Sleep    1s
    utility.Presskey    k1=enter
    Sleep    4s
    
ClickFile
    Click Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\file.png  Optional=2
    # Sleep    ${SLEEP_TIMER}

InputFilePath
    [Arguments]    ${test_data}
    Type Path    path=${test_data}
    ClickEnter

FileName
    Click Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\file_path2.png   Optional=2
    # Sleep    ${SLEEP_TIMER}

FileType
    Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\file_type.png   Optional=2
    # Sleep    ${SLEEP_TIMER}

ClosewindowsForDenyMessage
    [Arguments]    ${expected_result}
    IF  "${expected_result}" == "deny"
        ClickEnter
    END
    Sleep    2s

SaveFile
    [Arguments]    ${save_type}
    Sleep    ${SLEEP_TIMER}
    Log    save_type = ${save_type}
    SaveTypeCondition    ${save_type}

InputOutputPath
    Click Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\file_path.png   Optional=2
    Clear Path
    Type Path    path=${OUTPUT_FOLDER}

ChooseFileType
    [Arguments]    ${translator}    ${different_action}
    IF    '${different_action}' == 'FileOpenImportCAD' or '${different_action}' == '3DModelImport' or '${different_action}' == 'ManageInsertImport'
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\file_type.png  Optional=2
        # Sleep    ${SLEEP_TIMER}
        TranslatorCondition    ${translator}
        ChooseOption
    ELSE IF    '${different_action}' == 'SketchInsert'
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\file_type.png  Optional=2
        # Sleep    ${SLEEP_TIMER}
        ChooseSketch
    ELSE IF    '${different_action}' == 'AssembleComponentPlace'
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\file_type.png  Optional=2
        # Sleep    ${SLEEP_TIMER}
        TranslatorCondition    ${translator}
        ChooseAssemble
    END

ChooseFile
    [Arguments]    ${test_data}    ${open_type}
    Click Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\file_path2.png  Optional=2
    Type Path    path=${test_data}
    ClickEnter
    Log    open_type = ${open_type}
    OpenTypeCondition    ${open_type}
    Sleep    8s

OpenTypeCondition
    [Arguments]    ${open_type}
    Log    open_type = ${open_type}
    IF    '${open_type}' == '2'
        Sleep    1s
        ClickEnter
    ELSE IF    '${open_type}' == '3'
        Sleep    3s
        Click Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\FileOpen\\finish_button.png  Optional=2
    ELSE IF    '${open_type}' == '4'
        MoveToCenterAndClick
    ELSE IF    '${open_type}' == '5'
        MoveToCenterAndClick
        # Sleep    ${SLEEP_TIMER}
        Click Img   img=${SCREEN_IMAGES_PATH}\\CommonAction\\3DModelTab\\point.png  Optional=2
    ELSE IF    '${open_type}' == '6'
        InputOutputPath
        # Sleep    ${SLEEP_TIMER}
        ClickEnter
    END

SaveTypeCondition
    [Arguments]    ${save_type}
    IF    '${save_type}' == ''
        utility.Presskeys    ctrl    s
    ELSE IF    '${save_type}' == '2'
        utility.Presskeys    ctrl    s    enter
        Sleep    ${SLEEP_TIMER}
    ELSE IF    '${save_type}' == '3'
        utility.Presskeys    alt    y
        Sleep    ${SLEEP_TIMER}
        Type Path    path=${OUTPUT_FOLDER}
        ClickEnter
        Type Path    path=output
        Sleep    2s
        ClickEnter
        # Sleep    2s
        # ClickEnter
    END

ExpectedResultCondition
    [Arguments]    ${expected_result}    ${extra_step}
    Log    ${extra_step}
    IF    '${expected_result}' == 'deny'
        Log    "Stopping process for deny case after choosing file"
        RETURN    ${None}
    ELSE IF    '${extra_step}' == ''
        InputOutputPath
        Sleep    1s
        ClickEnter
    END

OpenIPT
    Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\3DModelTab\\arrow_new_file.png   Optional=2
    # Sleep    ${SLEEP_TIMER}
    Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\3DModelTab\\ipt_file.png  Optional=2
    # Sleep    10s

OpenIAM
    Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\3DModelTab\\arrow_new_file.png   Optional=2
    Sleep    ${SLEEP_TIMER}
    Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\AssembleTab\\open_iam.png   Optional=2
    Sleep    10s

ClickImport
    [Arguments]    ${different_action}
    Log    different_action = ${different_action}
    IF    '${different_action}' == '3DModelImport'
        Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\3DModelTab\\3DModel_Import.png   Optional=2
        # Sleep    ${SLEEP_TIMER}
    ELSE IF    '${different_action}' == 'SketchInsert'
        Sleep    1s
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\sketch_tab.png  Optional=2
        # Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\start_sketch.png  Optional=2
        # Sleep    2s
        MoveToCenterAndClick
        Sleep    ${SLEEP_TIMER}
    ELSE IF    '${different_action}' == 'ManageInsertImport'
        Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\ManageTab\\manage_tab.png   Optional=2
        # Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\3DModelTab\\3DModel_Import.png   Optional=2
        # Sleep    ${SLEEP_TIMER}
    ELSE IF    '${different_action}' == 'ManagePointCloudAttach'
        Sleep    6s
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\ManageTab\\manage_tab.png  Optional=2
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\ManageTab\\point_import.png  Optional=2
        # Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\ManageTab\\attach_import.png  Optional=2
        # Sleep    ${SLEEP_TIMER}
    ELSE IF    '${different_action}' == 'AssembleComponentPlace'
        Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\AssembleTab\\place_component.png   Optional=2
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\AssembleTab\\place_component2.png   Optional=2
        Sleep    ${SLEEP_TIMER}
    END

ActionTypeSketchInsert
    [Arguments]    ${test_data}    ${action_type}
    Log    action_type = ${action_type}
    IF    '${action_type}' == 'ACAD'
        Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\acad_import.png   Optional=2

        # condition for ${action_type} == ACAD
        IF    'dwg' in '${test_data}'
            Log    File type is DWG
            Sleep    ${SLEEP_TIMER}
        ELSE IF    'dxf' in '${test_data}'
            Log    File type is DXF
            Sleep    ${SLEEP_TIMER}
            FileType
            ChooseOption
            Sleep    ${SLEEP_TIMER}
            FileName
        END

    ELSE IF    '${action_type}' == 'Points'
        Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\points_import.png   Optional=2
        Sleep    ${SLEEP_TIMER}

    ELSE IF    '${action_type}' == 'Image'
        Sleep    ${SLEEP_TIMER}
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\SketchTab\\image_import.png   Optional=2
        Sleep    ${SLEEP_TIMER}
        FileType
        ChooseSketch
        Sleep    ${SLEEP_TIMER}
        FileName
    END

ExtraStep
    [Arguments]    ${test_data}
    IF    'rcp' in '${test_data}'
        Log    File type is RCP
        Sleep    ${SLEEP_TIMER}
    ELSE IF    'rcs' in '${test_data}'
        Log    File type is RCS
        Sleep    ${SLEEP_TIMER}
        FileType
        ChooseOption
        Sleep    ${SLEEP_TIMER}
        FileName
    END

TranslatorCondition
    [Arguments]    ${translator}
    Sleep    ${SLEEP_TIMER}
    Log    ${translator}
    IF    '${translator}' == 'no'
        Sleep    2s
    ELSE IF    '${translator}' == 'yes'
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\AssembleTab\\cancel_button.png  Optional=2
        # Sleep    1s
        Click Img    img=${SCREEN_IMAGES_PATH}\\CommonAction\\AssembleTab\\cancel_button.png  Optional=2
        # Sleep    2s
        utility.Click
        Sleep    2s
    END

Close All File
    # Check if the 'testpart' image is detected
    ${testpart}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\testpart.png
    Sleep    2s

    IF    '${testpart}' != 'None'
        Log    testpart window detected - close window
        Sleep    2s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\close testpart.PNG   Optional=2
        # Sleep    3s
    ELSE
        Log    testpart window not detected - continue
    END

    # Repeat for other windows
    ${iam_window}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\iam.png
    Sleep    2s

    IF    '${iam_window}' != 'None'
        Log    iam window detected - close window
        Sleep    2s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\close testpart.PNG   Optional=2
        # Sleep    3s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\no button.PNG   Optional=2
    ELSE
        Log    iam window not detected - continue
    END

    # Continue this pattern for other windows
    ${iam_window}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\assembly iam.png
    Sleep    2s

    IF    '${iam_window}' != 'None'
        Log    iam window detected - close window
        Sleep    2s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\close assembly iam.PNG   Optional=2
        # Sleep    1s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\no button.PNG   Optional=2
    ELSE
        Log    iam window not detected - continue
    END

    ${idw_window}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\idw.png
    Sleep    2s

    IF    '${idw_window}' != 'None'
        Log    idw window detected - close window
        # Sleep    2s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\close idw.PNG   Optional=2
        # Sleep    2s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\no button.PNG   Optional=2
    ELSE
        Log    idw window not detected - continue
    END

    ${dwg_window}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\dwg.png
    Sleep    2s

    IF    '${dwg_window}' != 'None'
        Log    dwg window detected - close window
        Sleep    1s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\close dwg.PNG   Optional=2
        # Sleep    2s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\no button.PNG   Optional=2
    ELSE
        Log    dwg window not detected - continue
    END

    ${ipn_window}=    Verify Img    img=${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\ipn.png
    Sleep    2s

    IF    '${ipn_window}' != 'None'
        Log    ipn window detected - close window
        Sleep    1s
        Click Img    ${CURDIR}\\VerifyImg\\CommonAction\\CloseAllFile\\close ipn.PNG   Optional=2
        # Sleep    2s
    ELSE
        Log    ipn window not detected - continue
    END
