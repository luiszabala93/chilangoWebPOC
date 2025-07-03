def obtain_xpath_gender_selector(gender):
    return "//select[@name='gender']/option[text()='" + gender + "']"

def obtain_xpath_title_from_chilango(title):
    return "//a/strong[contains(., '" + title + "')]"


def obtain_xpath_image(image):
    return "//img[@alt = '" + image + "']"

def obtain_xpath_button(button):
    return "//button[contains(., '" + button + "')]"

def obtain_xpath_span_class(span):
    return "//span[@class = '" + span + "']"

def obtain_xpath_p(p):
    return "//p[contains(.,'" + p + "')]"

def obtain_xpath_span_name(span_name):
    return "//span[contains(.,'" + span_name + "')]"

def obtain_xpath_button_class(button_class):
    return "//button[@class = '" + button_class + "']"

def obtain_xpath_div_class(div_class):
    return 0

def obtain_xpath_span_button_name(span):
    return "//button/span[contains(., '" + span + "')]"

def obtain_xpath_a_name(a):
    return "//a[contains(., '" + a + "')]"