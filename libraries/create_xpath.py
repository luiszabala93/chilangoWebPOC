def obtain_xpath_gender_selector(gender):
    return "//select[@name='gender']/option[text()='" + gender + "']"

def obtain_xpath_title_from_chilango(title):
    return "//a/strong[contains(., '" + title + "')]"


def obtain_xpath_image(image):
    return "//img[@alt = '" + image + "']"

def obtain_xpath_button(button):
    return "//button[contains(., '" + button + "')]"

def obtain_xpath_span(span):
    return "//span[@class = '" + span + "']"

def obtain_xpath_p(p):
    return "//p[contains(.,'" + p + "')]"