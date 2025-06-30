from fpdf import FPDF
import os
from datetime import datetime
import csv
import fitz
import shutil

report_title = "Chilango Testing with Robot Framework"
pdf_path = "path"

test_class_dictionary = {
    "AGN": "agenda_test.robot",
    "CHI": "chilango_test.robot",
}

global global_test_name
global_test_name = ""
global global_browser_name
global_browser_name = ""
global global_test_no
global_test_no = ""
global global_page_and_pos
global_page_and_pos = ""
global global_environment
global_environment = ""


def set_test_name(test_name):
    global global_test_name
    global_test_name = test_name


def set_global_environment(environment):
    global global_environment
    global_environment = environment


def set_browser_name(browser_name):
    global global_browser_name
    global_browser_name = browser_name.replace(" ", "")


def get_global_environment():
    return global_environment


def get_current_date_and_hour(day_format='%m%d%Y', time_format='%H%M%S'):
    return datetime.today().strftime('%m%d%Y') + \
           datetime.now().strftime('%H%M%S')


def get_current_month(format='%m'):
    return datetime.today().strftime(format)


def get_current_year(format='%Y'):
    return datetime.today().strftime(format)


def get_customer_portal_img_path():
    return get_current_path(1) + "/resources/reportimagespdf/chilango.png"


def get_selenium_logo_path():
    return get_current_path(1) + "/resources/reportimagespdf/selenium_logo.png"


def get_test_name():
    return global_test_name


def pdf_configuration_setup(sub_folders, test_name):
    global global_test_name
    global_test_name = test_name


def create_report(sub_folders, test_name, environment, browser=None):
    global global_test_name
    global_test_name = global_test_name
    global global_test_no
    global_test_no = 1
    global global_page_and_pos
    global_page_and_pos = [1, 1]
    create_pdf_file(sub_folders, test_name, environment, browser)
    images_no = int(get_current_image_name().replace("temp_evidence_", "")) - 1

    for i in range(images_no):
        add_image_to_report()

def add_text_to_pdf_file(text, current=True):
    pdf_path = read_path_from_file()
    pdf_path = pdf_path.pop()
    document = fitz.open(pdf_path)

    current_values = get_current_page_and_position()
    if not current:
        if current_values[1] == "1":
            current_values[0] = str(int(current_values[0]) - int(1))
            current_values[1] = str(int(current_values[1]) + int(1))
        else:
            if current_values[1] == "2":
                current_values[1] = str(int(current_values[1]) - int(1))

    txt_rect = ""
    if int(current_values[1]) == 1:
        txt_rect = fitz.Rect(30, 395, 570, 500)
    else:
        if int(current_values[1]) == 2:
            txt_rect = fitz.Rect(30, 765, 570, 880)

    page = document[0]
    try:
        page = document[int(current_values[0])]
    except (ValueError, IndexError):
        document.new_page()
        page = document[int(current_values[0])]

    page.insert_textbox(txt_rect, "Validation: \n\n" +
                        str(text), fontsize=6,  # choose fontsize (float)
                        fontname="Helvetica",  # a PDF standard font
                        fontfile=None,  # could be a file on your system
                        align=0)
    document.can_save_incrementally()
    document.save(pdf_path, incremental=1, encryption=0)
    document.close()


def get_current_path(folders_up=0):
    current_path = os.getcwd()
    if folders_up == 0:
        return current_path
    if folders_up == 1:
        return current_path.replace("\\custom_libs", "")
    return current_path


def get_results_directory_path():
    return get_current_path(1) + "\\results\\"


def get_reports_directory_path():
    return get_current_path(1) + "\\results\\test_cases_evidence\\"

def get_failed_reports_directory_path():
    return get_current_path(1) + "\\results\\test_cases_evidence\\failed"


def get_resources_directory_path():
    return get_current_path(1) + "\\resources\\"


def get_tests_path():
    return get_current_path(1) + "\\tests\\"


def get_screenshots_path():
    code = get_test_code()
    return get_results_directory_path() + "\\" + code + "_" + global_browser_name


def remove_step_no_file():
    try:
        remove_file(get_results_directory_path() + "step_no.csv")
    except FileNotFoundError:
        pass


def remove_temp_status_file():
    try:
        remove_file(get_results_directory_path() + "temp_status.csv")
    except FileNotFoundError:
        pass


def remove_temp_evidence_file():
    try:
        remove_file(get_results_directory_path() + "temp_evidence.png")
    except FileNotFoundError:
        pass


def remove_test_information_file():
    try:
        remove_file(get_results_directory_path() + "test_info.csv")
    except FileNotFoundError:
        pass


def remove_path_file():
    try:
        remove_file(get_results_directory_path() + "path.csv")
    except FileNotFoundError:
        pass


def remove_tc_directory_temporary_files():
    code = get_test_code()
    path = get_results_directory_path() + "\\" + code + "_" + global_browser_name
    try:
        shutil.rmtree(path)
        return True
    except FileNotFoundError:
        return False


def create_report_directory_on_results_folder(path, sub_folders):
    # REPORTS MAIN

    validate = check_if_directory_exists(get_reports_directory_path())
    if validate:
        pass
    else:
        print("path we are going to create is :" + str(path))
        os.mkdir(path)

    # Other folders
    if isinstance(sub_folders, list):
        sub_folders = [get_global_environment()] + sub_folders
        for i in range(len(sub_folders)):
            prev_folder = ""
            try:
                for j in (range(i)):
                    if j != i:
                        prev_folder = prev_folder + "\\" + sub_folders[j]
                    print("prev folder: " + str(prev_folder))
            except IndexError:
                pass
            create_report_directory_on_results_folder(path + prev_folder, sub_folders[i])
    else:
        if not isinstance(sub_folders, list):
            path = path + "\\" + sub_folders
            path = path.replace("\\\\", "\\")
            validate = check_if_directory_exists(path)
            print("Path that we are validating is : " + str(path))
            print("Folder: " + str(sub_folders) + "  creation status is " + str(validate))
            if validate:
                return True
            else:
                print("path we are going to create is :" + str(path))
                os.mkdir(path)
                return "created"


def save_evidence_if_test_failed():
    if not check_if_directory_exists(get_failed_reports_directory_path()):
        create_report_directory_on_results_folder(get_failed_reports_directory_path(), '')
    if not check_if_directory_exists(get_failed_reports_directory_path() + get_test_code()):
        os.mkdir(get_failed_reports_directory_path() + "\\" + get_test_code())

def get_failed_evidence_path():
    return get_failed_reports_directory_path() + "\\" + get_test_code()

def get_data_directory_path():
    return get_current_path(1) + "\\data\\"


def create_report_directory_on_data_folder(sub_folders, path=None):
    if path is None:
        path = get_data_directory_path()
    if isinstance(sub_folders, list):
        for i in range(len(sub_folders)):
            create_report_directory_on_data_folder(sub_folders[i], path)
    else:
        if not isinstance(sub_folders, list):
            validate = check_if_directory_exists(path + "\\" + sub_folders)
            if validate:
                return True
            else:
                os.mkdir(path + "\\" + sub_folders)


def create_pdf_file(directory_path, test_name, environment, browser=None):
    test_description = read_line_from_test_info(0, test_name)

    code = get_test_code()

    pdf = FPDF(orientation='P', unit='mm', format='Letter')
    pdf.add_page()
    pdf.set_font('Arial', 'B', 24)
    pdf.cell(w=200, h=90, align='C', txt=report_title)

    pdf.image(get_selenium_logo_path(), 20, 49, 10, 10)
    pdf.image(get_customer_portal_img_path(), 50, 70, 120, 80)
    write_title(pdf, test_name, test_description, environment, browser)
    if browser:
        path = get_reports_directory_path() + environment + "\\" + directory_path + "\\" + browser + "_" + code + "_" + \
               datetime.today().strftime('%m%d%Y') + \
               datetime.now().strftime('%H%M%S') + ".pdf"
    else:
        path = get_reports_directory_path() + "\\" + environment + directory_path + "\\" + code + "_" + \
               datetime.today().strftime('%m%d%Y') + \
               datetime.now().strftime('%H%M%S') + ".pdf"
    pdf.output(path)
    add_path_string_to_file(path)


def write_title(pdf, test_name, test_description, environment, browser):
    test_description = test_description.split("Expected Result: ")
    expected_result = test_description[1]
    test_description = test_description[0]
    pdf.set_font('Arial', 'B', 14)
    pdf.set_text_color(0, 0, 0)
    pdf.ln(150)
    pdf.write(5, "Test Name: " + test_name)
    pdf.ln(8)
    pdf.set_font('Arial', 'B', 12)
    pdf.write(5, "\nTest Description: ")
    pdf.set_font('Arial', '', 12)
    pdf.write(5, test_description)
    pdf.set_font('Arial', 'B', 12)
    pdf.write(5, "\nExpected Result: ")
    pdf.set_font('Arial', '', 12)
    pdf.write(5, expected_result)
    pdf.set_font('Arial', '', 11)
    pdf.ln(8)
    if browser:
        pdf.set_font('Arial', 'B', 11)
        pdf.write(10, "Browser: ")
        pdf.set_font('Arial', '', 11)
        pdf.write(10, "             " + browser)
    pdf.set_font('Arial', 'B', 11)
    pdf.ln(8)
    pdf.write(5, "Environment: ")
    pdf.set_font('Arial', '', 11)
    pdf.write(5, "      " + environment)
    pdf.write(10, "\nDate: " + datetime.today().strftime('%m / %d / %Y'))
    pdf.set_font('Arial', 'B', 11)
    pdf.write(6, "\nRun Time: " + datetime.now().strftime('%H:%M:%S') + " CST")
    pdf.ln()


def texts(pdf, name):
    with open(name, 'w') as xy:
        txt = xy.read().decode('latin-1')
    pdf.set_xy(10.0, 80.0)
    pdf.set_text_color(169, 169, 169)
    pdf.set_font('Arial', '', 12)
    pdf.multi_cell(0, 10, txt)


def add_path_string_to_file(path_to_write):
    code = get_test_code()
    read_file_path = get_results_directory_path() + "\\" + code + "_" + global_browser_name + "\\path.csv"

    validate = check_if_file_exists(read_file_path)
    if validate:
        os.remove(read_file_path)
        filename = open(read_file_path, "w")
        filename.close()
    else:
        filename = open(read_file_path, "x")
        filename.close()

    with open(read_file_path, 'a') as filename:
        filename.write(path_to_write)
        filename.close()


def remove_file(filepath):
    try:
        os.remove(filepath)
        return True
    except FileNotFoundError:
        return False


def check_if_file_exists(filepath):
    return os.path.isfile(filepath)


def check_if_directory_exists(path):
    return os.path.isdir(path)


def read_path_from_file():
    code = get_test_code()
    read_file_path = get_results_directory_path() + code + "_" + global_browser_name + "\\" + "path.csv"

    path = ""
    with open(read_file_path, 'rt') as csv_file:
        reader = csv.reader(csv_file)
        for row in reader:
            path = row
    return path


def get_test_code():
    global_test_name = get_test_name()
    global_test_name = global_test_name.split(" ")
    test_code = global_test_name[0]
    return test_code


def get_current_image_name():
    test_code = get_test_code()

    create_report_directory_on_results_folder(get_results_directory_path(), test_code + "_" + global_browser_name)

    number = 1

    while True:
        file_name = get_results_directory_path() + test_code + "_" + global_browser_name + "\\temp_evidence_{number}.png"
        file_name = file_name.replace("{number}", str(number))
        validate = check_if_file_exists(file_name)
        if validate:
            number += 1
            file_name = get_results_directory_path() + test_code + "_" + global_browser_name + "\\temp_evidence_{number}.png"
            file_name = file_name.replace("{number}", str(number))
            validate = check_if_file_exists(file_name)
            if not validate:
                return "temp_evidence_" + str(number)
        else:
            if number == 1:
                break
    return "temp_evidence_" + str(number)


def add_image_to_report():
    code = get_test_code()
    current_values = get_current_page_and_position()

    if int(current_values[1]) == 1:
        img_rect = fitz.Rect(20, 80, 570, 450)
    else:
        if int(current_values[1]) == 2:
            img_rect = fitz.Rect(20, 480, 570, 800)
    pdf_path = read_path_from_file()
    pdf_path = pdf_path.pop()
    document = fitz.open(pdf_path)
    
    image_path = get_results_directory_path() + code + "_" + global_browser_name + "\\" + "temp_evidence_" + str(get_current_step()) + ".png"
    print(image_path)
    page = document[0]
    try:
        page = document[int(current_values[0])]
    except (ValueError, IndexError):
        document.new_page()
        page = document[int(current_values[0])]
        
    add_txt_step_to_report(document, page, current_values)
    page.insert_image(img_rect, filename=image_path)
    
    document.can_save_incrementally()
    document.save(pdf_path, incremental=1, encryption=0)
    document.close()
    increase_value_on_file(current_values)
    increase_step()

def add_txt_step_to_report(document, page, current_values):
    txt_rect = ""
    if int(current_values[1]) == 1:
        txt_rect = fitz.Rect(30, 50, 570, 500)
    else:
        if int(current_values[1]) == 2:
            txt_rect = fitz.Rect(30, 450, 570, 880)

    step = int(get_current_step())
    print("Step number:  " + str(step))
    txt = read_line_from_test_info(step, global_test_name)

    page.insert_textbox(txt_rect, txt, fontsize=14,  # choose fontsize (float)
                        fontname="helvetica",  # a PDF standard font
                        fontfile=None,  # could be a file on your system
                        align=0)


def get_current_page_and_position():
    return global_page_and_pos


def increase_step():
    global global_test_no
    global_test_no += 1
    return global_test_no


def get_current_step():
    return global_test_no


def increase_value_on_file(values):
    if int(values[1]) == 2:
        global_page_and_pos[0] = values[0] + 1
        global_page_and_pos[1] = 1
    else:
        global_page_and_pos[0] = global_page_and_pos[0]
        global_page_and_pos[1] = int(values[1]) + 1


def get_robot_class_path(directory_path, code):
    print(directory_path)
    print(str(test_class_dictionary.get(code)))
    return get_tests_path() + directory_path + "\\" + str(test_class_dictionary.get(code))


def get_real_path(robot_class_path, sub_folders):
    sub_folders = sub_folders.split("\\")
    auxiliar = ""
    path = ""
    for i in range(len(sub_folders) - 1, -1, -1):
        path = robot_class_path.replace(auxiliar, "")
        validate = \
            check_if_file_exists(path)
        if validate:
            return path
        else:
            auxiliar = sub_folders[i] + "\\" + auxiliar
    return path


def get_test_information(sub_folders, test_name):
    test_info = []
    code = test_name.split(" ")
    code = code[0]
    code = code.split("_")
    code = code[0]
    robot_class_path = get_robot_class_path(sub_folders, code)
    print(robot_class_path)

    filename = get_real_path(robot_class_path, sub_folders)
        
    with open(filename) as f:
        my_list = [line.rstrip('\n') for line in f]
        
    next_index = 0
    actual_index = 0
    flag_found_tc = False
    
    for i in range(len(my_list)):
        if my_list[i] == test_name and flag_found_tc is False:
            actual_index = i
            flag_found_tc = True

        else:
            code = get_test_code()
            tc_no = code.split("_")
            tc_no = tc_no[1]
            tc_no = int(tc_no) + 1
            if my_list[i].__contains__(code[:3]) and my_list[i].__contains__(str(tc_no)) and flag_found_tc is True:
                next_index = i - 1
                break
            if i == (len(my_list)) - 1 and next_index == 0:
                next_index = len(my_list)
    counter = 0

    for i in range(actual_index, int(next_index)):
        if my_list[i].__contains__("Documentation"):
            temp = my_list[i]
            temp = temp.split("]    ")
            description = temp[1]
            for j in range(i, next_index):
                if my_list[j].__contains__("...    "):
                    temp = my_list[j]
                    temp = temp.split("...    ")
                    description = description + " " + temp[1]
                if j == (next_index - 1):
                    test_info.append(description)
        if my_list[i].lower().__contains__("get evidence"):
            if my_list[i - 1].lower().__contains__("sleep") or \
                    my_list[i - 1].lower().__contains__("validate") or \
                    my_list[i - 1].lower().__contains__("verify"):
                j = 2
                while True:
                    if my_list[i - j].lower().__contains__("validate") or \
                            my_list[i - j].lower().__contains__("verify"):
                        j += 1
                    else:
                        temp = my_list[i - j]
                        break
            else:
                temp = my_list[i - 1]
            counter += 1
            temp = temp.split("    ")
            my_list[i - 1] = "Step " + str(counter) + ": " + temp[1]
            try:
                my_list[i - 1] = my_list[i - 1] + ":    " + temp[2]
            except IndexError:
                pass
            test_info.append(my_list[i - 1])
        else:
            pass
    return test_info


def write_test_documentation(test_info, test_info_path, test_name):
    documentation = ""
    code = get_test_code()
    validate = check_if_file_exists(test_info_path + "\\" + code + "_" + global_browser_name + "\\" + "test_info.csv")

    if validate:
        remove_file(test_info_path + "\\" + code + "_" + global_browser_name + "\\test_info.csv")
        write_test_documentation(test_info, test_info_path, test_name)
    else:
        for i in range(len(test_info)):
            documentation = documentation + test_info[i] + "\n"
        filename = open(test_info_path + code + "_" + global_browser_name + "\\" + "test_info.csv", "a")
        filename.write(documentation)
        filename.close()


def read_line_from_test_info(row, test_name):
    code = get_test_code()
    path = get_results_directory_path() + code + "_" + global_browser_name + "\\" + "test_info.csv"

    with open(path) as f:
        my_list = [line.rstrip('\n') for line in f]

    info = [my_list[row]]

    return info[0]


# Use this method just to populate matrixes from CAB
def get_test_information_for_matrix(code, sub_folders):

    filename = test_class_dictionary.get(code)

    robot_class_path = get_real_path(get_tests_path() + sub_folders +  "\\" + filename, sub_folders)

    test_info = []

    with open(robot_class_path) as f:
        my_list = [line.rstrip('\n') for line in f]

    test_cases = []

    for i in range(len(my_list)):
        if my_list[i].__contains__(code + "_0") and "Tag" not in my_list[i]:
            test_cases.append(my_list[i])
            flag_found_tc = True

    codes = []

    for i in range(len(test_cases)):
        codes.append(test_cases[i].split(" ")[0])
        next_index = 0
        actual_index = 0
        flag_found_tc = False
        for j in range(len(my_list)):
            if my_list[j] == test_cases[i] and flag_found_tc is False:
                actual_index = j
                flag_found_tc = True

            else:
                if my_list[j].__contains__(code + "_0") and ('Tags' not in my_list[j]) and flag_found_tc is True:
                    next_index = j
                    break
                if j == (len(my_list)) - 1 and next_index == 0:
                    next_index = len(my_list)
        counter = 0


        for j in range(actual_index, int(next_index)):
            if my_list[j].__contains__("Documentation"):
                temp = my_list[j]
                temp = temp.split("]    ")
                description = temp[1]
                for k in range(j, next_index):
                    if my_list[k].__contains__("...    "):
                        temp = my_list[k]
                        temp = temp.split("...    ")
                        description = description + " " + temp[1]
                    if k == (next_index - 1):
                        test_info.append(description)

    expected_result = []

    for i in range(len(test_info)):
        temp = test_info[i].split("Expected Result:")
        test_info[i] = temp[0]
        expected_result.append(temp[1])
    matrix = codes, test_cases, test_info, expected_result
    for i in range(len(matrix[0])):
        print(str(matrix[0][i] + "\t" + matrix[1][i] + "\t" + matrix[2][i] + "\t" + matrix[3][i]))
    return codes, test_cases, test_info, expected_result

