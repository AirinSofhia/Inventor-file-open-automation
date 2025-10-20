import os
import pydirectinput as pdi
import pyautogui
import shutil
from pyscreeze import locateOnScreen
import time
import re

pdi.FAILSAFE = False


screenWidth, screenHeight = pyautogui.size()
currentMouseX, currentMouseY = pyautogui.position()
confidence, grayscale = 0.8, True

pyautogui.FAILSAFE = False

def presskeys(*keys):
    pyautogui.hotkey(*keys)

# def presskey(k1):
#     pdi.keyDown(k1)
#     pdi.keyUp(k1)
    
def presskey(k1, count=1):
    for _ in range(count):
        pdi.keyDown(k1)
        pdi.keyUp(k1)

def manual_print():
    time.sleep(1)
    pyautogui.hotkey('ctrl', 'p')  # Open print dialog
    time.sleep(2)
    # pyautogui.press('enter')       # Confirm print
    # time.sleep(2)

def press2keys(k1, k2):
    pdi.keyDown(k1)
    pdi.keyDown(k2)
    pdi.keyUp(k2)
    pdi.keyUp(k1)

def press3keys(k1, k2, k3):
    pdi.keyDown(k1)
    pdi.keyDown(k2)
    pdi.keyDown(k3)
    pdi.keyUp(k3)
    pdi.keyUp(k2)
    pdi.keyUp(k1)
    
def presskey_down():
    pdi.press('down')  # Move to "New"
    time.sleep(0.5)
    pdi.press('down')  # Move to "Open"
    time.sleep(0.5)
    pdi.press('down')  # Move to "Save"
    time.sleep(0.5)
    
def presskey_down_print():
    pdi.press('down')  # Move to "New"
    time.sleep(0.5)
    pdi.press('down')  # Move to "Open"
    time.sleep(0.5)
    pdi.press('down')  # Move to "Save"
    time.sleep(0.5)
    pdi.press('down')  # Move to "SaveAs"
    time.sleep(0.5)
    pdi.press('down')  # Move to "Export"
    time.sleep(0.5)
    pdi.press('down')  # Move to "Share"
    time.sleep(0.5)
    pdi.press('down')  # Move to "Manage"
    time.sleep(0.5)
    
def presskey_down_print2():
    # Navigate down the left menu until "Print"
    pdi.press('down')  # "New"
    time.sleep(0.5)
    pdi.press('down')  # "Open"
    time.sleep(0.5)
    pdi.press('down')  # "Save"
    time.sleep(0.5)
    pdi.press('down')  # "SaveAs"
    time.sleep(0.5)
    pdi.press('down')  # "Export"
    time.sleep(0.5)
    pdi.press('down')  # "Share"
    time.sleep(0.5)
    pdi.press('down')  # ✅ Now on "Print"
    time.sleep(0.5)

    # Now move to the right submenu
    pdi.press('right')  # Open the Print submenu
    time.sleep(0.5)

    # Move down to "Send to 3D Print Service"
    pdi.press('down')  # 1: Print
    time.sleep(0.3)
    pdi.press('down')  # 2: Print Preview
    time.sleep(0.3)
    pdi.press('down')  # 3: Print Setup
    time.sleep(0.3)
    pdi.press('down')  # 4: ✅ Send to 3D Print Service
    time.sleep(0.3)

    # Confirm selection
    pdi.press('enter')
    
def press_to_save():
    pdi.press('up')  # iProperties
    time.sleep(0.5)
    pdi.press('up')  # Manage
    time.sleep(0.5)
    pdi.press('up')  # Share
    time.sleep(0.5)
    pdi.press('up')  # Export
    time.sleep(0.5)
    pdi.press('up')  # Save As
    time.sleep(0.5)
    pdi.press('up')  # Save
    time.sleep(0.5)

def Click():
    pyautogui.click()
    
def ActiveWindowsByClick():
    pyautogui.moveTo(screenWidth/4, screenHeight/4)
    pyautogui.click()
    # pdi.click()

def MoveToCenterByClick():
    pyautogui.moveTo(screenWidth/2, screenHeight/2)
    pyautogui.click()

def type_path(path):
    pyautogui.typewrite(path)
    
def type_import():
    pyautogui.write('import')

def restore_data(action):
    source_path = "C:\\InventorUsageControl\\bak\\" + action + "\\Data"
    destination_path =  "C:\\InventorUsageControl\\" + action + "\\Data"
    empty_folder(destination_path)
    copy_demo(source_path, destination_path)

def empty_folder(folder_path):
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        if os.path.isfile(file_path):
            os.remove(file_path)
        elif os.path.isdir(file_path):
            empty_folder(file_path)
            os.rmdir(file_path)
            
def copy_demo(src_dir, dst_dir):
    if not os.path.exists(dst_dir):
        os.makedirs(dst_dir)
    if os.path.exists(src_dir):
        for file in os.listdir(src_dir):
            file_path = os.path.join(src_dir, file)
            dst_path = os.path.join(dst_dir, file)
            if os.path.isfile(os.path.join(src_dir, file)):
                shutil.copy2(file_path, dst_path)
            else:
                copy_demo(file_path, dst_path)
                # print("存在多级文件夹，正在复制。")

def getfileinfo(files):
    files = list(files.split("\n"))
    fileinfo_dict = {}
    # file_file_list = []
    for file in files:
        # os.path.getsize(file)
        # os.path.getmtime(file)
        fileinfo_dict[file] = [os.path.getsize(file), os.path.getmtime(file)]
    return fileinfo_dict

def rightclick_img(img, Optional = 1):
    # location = verify_img(img)
    # if location != None:
    #     pyautogui.rightClick(location)
    start_time = time.time()
    elapse_time = 0
    while elapse_time < Optional:
        location = verify_img(img)
        time.sleep(0.1)
        elapse_time = time.time()-start_time
        if location != None:
            pyautogui.rightClick(location)
            elapse_time = 6

def click_img(img, Optional = 1):
    start_time = time.time()
    elapse_time = 0
    while elapse_time < Optional:
        location = verify_img(img)
        time.sleep(0.1)
        elapse_time = time.time()-start_time
        if location != None:
            pyautogui.click(location)
            elapse_time = 6
        
def doubleclick_img(img, Optional = 1):
    # location = verify_img(img)
    # if location != None:
    #     pyautogui.doubleClick(location)
    start_time = time.time()
    elapse_time = 0
    while elapse_time < Optional:
        location = verify_img(img)
        time.sleep(0.1)
        elapse_time = time.time()-start_time
        if location != None:
            pyautogui.doubleClick(location)
            elapse_time = 6
            
def MoveTo_img(img,Optional = 1):
    # location = verify_img(img)
    # if location != None:
    #     pyautogui.moveTo(location)
    start_time = time.time()
    elapse_time = 0
    while elapse_time < Optional:
        location = verify_img(img)
        time.sleep(0.1)
        elapse_time = time.time()-start_time
        if location != None:
            pyautogui.moveTo(location)
            elapse_time = 6

def verify_img(img, confidence=0.77, grayscale=False):
    try:
        location = pyautogui.locateOnScreen(img, confidence=confidence, grayscale=grayscale)
        return location
    except pyautogui.ImageNotFoundException:
        return None
    
def clear_path():
    pyautogui.hotkey('ctrl', 'a')
    pyautogui.press('backspace')
    
def choose_ok_button():
    pyautogui.press('right', presses=1)
    pyautogui.press('enter')
    
def choose_no_button():
    time.sleep(1.0) 
    pyautogui.press('right', presses=1)
    pyautogui.press('enter')
    
def ClickNoButton2():
    """
    Presses the keyboard shortcut to select 'No' in a dialog (usually Right Arrow + Enter).
    Adjust as needed for your dialog behavior.
    """
    print("[INFO] Pressing 'Right Arrow' + 'Enter' to choose 'No'")
    pyautogui.press('right')   # Move focus to 'No' button
    time.sleep(0.5)
    pyautogui.press('enter')   # Confirm selection
    time.sleep(1)

def click_no_with_tab():
    print("[INFO] Navigating to 'No' with Tab...")
    pyautogui.press('tab')  # Once to go from "Yes" to "No"
    time.sleep(0.2)
    pyautogui.press('enter')  # Select "No"
    print("[INFO] Pressed Enter on 'No'.")
        
def ClickYesButton():
    """
    Presses 'Enter' to choose 'Yes' if it is the default selected option.
    """
    print("[INFO] Pressing 'Enter' to choose 'Yes'")
    pyautogui.press('enter')
    time.sleep(1)
    
def check_file_protection(file_path):
    try:
        
        print(f"Checking file path: {file_path}")
        
        if not os.path.isfile(file_path):
            return False, f"File '{file_path}' does not exist."
        
        with open(file_path, 'r', errors='ignore') as file_object:
            all_text = file_object.read()
            is_protected = "NXLFMT" in all_text

        if is_protected:
            return True, "File is protected"
        else:
            return False, "File is not protected"
    except Exception as e:
        return False, f"ERROR: {str(e)}"

def verify_result_for_Inventor_import(default_file=None, output_folder=None, image_path=None):
    try:
        # Ensure arguments are provided
        if not default_file and not output_folder and not image_path:
            return False, "Invalid arguments: Provide either `default_file`, `output_folder`, or `image_path`."

        # Case 1: File and folder size comparison
        if default_file and output_folder:
            # Validate default_file
            if not os.path.isfile(default_file):
                return False, f"Default file '{default_file}' does not exist or is not a file."

            # Validate output_folder
            if not os.path.isdir(output_folder):
                return False, f"Output folder '{output_folder}' does not exist or is not a directory."

            # Get the size of the default file
            default_file_size = os.path.getsize(default_file)

            # Calculate the total size of the output folder
            def get_folder_size(folder):
                total_size = 0
                for root, _, files in os.walk(folder):
                    for file in files:
                        file_path = os.path.join(root, file)
                        if os.path.isfile(file_path):
                            total_size += os.path.getsize(file_path)
                return total_size

            output_folder_size = get_folder_size(output_folder)

            # Compare sizes
            if output_folder_size != 0 and output_folder_size != default_file_size:
                return True, (
                    f"The size of the default file ({default_file_size} bytes) "
                    f"is not equal to the size of the output file ({output_folder_size} bytes)."
                )
            else:
                return False, (
                    f"The size of output file ({output_folder_size} byte) "
                    f"is equal to default file ({default_file_size} bytes) or is 0 byte."
                )

        # Case 2: Image verification
        if image_path:
            # Verify if the image file exists
            if not os.path.isfile(image_path):
                return False, f"Image file '{image_path}' does not exist or is not a file."

            # Perform the image verification logic
            location = verify_img(image_path)
            if location is not None:
                return True, "Deny image verified successfully."
            else:
                return False, "Image not matched."

    except Exception as e:
        return False, f"ERROR: {str(e)}"
    
def Verify_Result_For_Inventor_Save(expected_result, img_deny, verify_files, OldFileInfo):
    try:
        isPass = False
        # expect result is allow, then verify the new protected file's file size is biger and modified time is newer than the old file.
        if expected_result == "allow":
            files = list(verify_files.split("\n"))
            filesize_new = []
            for f in files:
                # file is not exit, return failed
                if not os.path.exists(f):
                    isPass = False
                    msg = "file is not exit, check verify_files in excel"                  
                else:
                # file is exist. check file is protect or not, new file size > old file size and new file modified time > old one.
                    file_object2 = open(f, 'r', errors='ignore')
                    all_the_text = file_object2.read()  # 结果为str类型
                    is_nxlfmt = re.findall("NXLFMT", all_the_text)[0]
                    if is_nxlfmt =="NXLFMT" and os.path.getsize(f) > int(OldFileInfo[f][0]) and os.path.getmtime(f) > float(OldFileInfo[f][1]):
                        isPass = True
                        msg = "expect result is allow, file is edited and update."
                    else:
                        isPass = False
                        msg = "expect result is allow, but file is not protected or not update"
                        # msg = str(OldFileInfo[f][0]) +'/n'+ str(os.path.getsize(f)) +'/n'+ str(OldFileInfo[f][1]) +'/n'+ str(os.path.getmtime(f))
                        break
        # expect result is deny, verify deny message
        elif expected_result == "deny":
            if not os.path.exists(img_deny):
                isPass = False
                msg = "file is not exit, check img_deny in excel"
            else:
                location = verify_img(img_deny)
                print(location)
                if location != None:
                    isPass = True
                    msg = "expect result is deny, and find the deny img"
                else:
                    msg = "expect result is deny, but the deny img is not match"
                    isPass = False
        return isPass, msg
    except Exception as msg:
        print(msg)
        
def Verify_Result_for_Inventor_Print(expected_result, img_deny, verify_files):
    try:
        isPass = False
        # expect result is allow, then verify the new protected file's file size is biger and modified time is newer than the old file.
        if expected_result == "allow":
            files = list(verify_files.split("\n"))
            for f in files:
                # file is not exit, return failed
                if not os.path.exists(f):
                    isPass = False
                    msg = "file is not exit, check verify_print_files in excel"
                else:
                    isPass = True
                    msg = "find the printed file"
        # expect result is deny, verify deny message
        elif expected_result == "deny":
            if not os.path.exists(img_deny):
                isPass = False
                msg = "file is not exit, check img_deny in excel"
            else:
                location = verify_img(img_deny)
                print(location)
                if location != None:
                    isPass = True
                    msg = "expect result is deny, and find the deny img"
                else:
                    msg = "expect result is deny, but the deny img is not match"
                    isPass = False
        return isPass, msg
    except Exception as msg:
        print(msg)
        
def draw_circle():
    # Focus Inventor window first
    pyautogui.getWindowsWithTitle("Inventor")[0].activate()
    time.sleep(1)

    # Example steps:
    # 1. Start 2D Sketch - send Alt+N then K (adjust as needed)
    pyautogui.hotkey('alt', 'n')
    time.sleep(0.5)
    pyautogui.press('k')
    time.sleep(1)

    # 2. Click XY plane in browser/tree - replace with your screen coords
    pyautogui.click(150, 300)
    time.sleep(1)

    # 3. Select Circle tool - press 'c'
    pyautogui.press('c')
    time.sleep(0.5)

    # 4. Click center point of circle - screen coords (adjust!)
    pyautogui.click(400, 400)
    time.sleep(0.5)

    # 5. Move mouse down to define radius and click
    pyautogui.moveTo(400, 450, duration=0.3)
    pyautogui.click()
    time.sleep(1)
    
def save_file_manually():
    # Focus Inventor window
    pyautogui.getWindowsWithTitle("Inventor")[0].activate()
    time.sleep(1)
    
    # Press Ctrl+S to save
    pyautogui.hotkey('ctrl', 's')
    time.sleep(2)

def manual_edit():

    # Step 1: Select the profile for extrusion
    profile_pos = (800, 450)  # Adjust to where your profile is located
    pyautogui.moveTo(profile_pos)
    pyautogui.click()
    time.sleep(1)

    # Step 2: Click the Extrude button
    extrude_button_pos = (400, 500)  # Adjust to Extrude button location
    pyautogui.moveTo(extrude_button_pos)
    pyautogui.click()
    time.sleep(1)

    # Step 3: Enter extrusion distance
    extrusion_distance_pos = (600, 550)  # Position of input box for distance
    pyautogui.click(extrusion_distance_pos)
    pyautogui.typewrite('10')  # Example: extrude by 10 units
    time.sleep(1)

    # Step 4: Confirm the extrusion (e.g., click OK or press Enter)
    confirm_button_pos = (650, 600)  # Adjust to OK/Confirm button location
    pyautogui.moveTo(confirm_button_pos)
    pyautogui.click()
    time.sleep(2)

    print("Extrude automation completed.")
    