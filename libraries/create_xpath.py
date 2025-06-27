def obtain_xpath_gender_selector(gender):
    return "//select[@name='gender']/option[text()='" + gender + "']"

def obtain_xpath_title_from_chilango(title):
    return "//a/strong[contains(., '" + title + "')]"
