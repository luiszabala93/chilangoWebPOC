def obtain_xpath_gender_selector(gender):
    return "//select[@name='gender']/option[text()='" + gender + "']"

def obtain_xpath_image(image):
    return "//img[@alt = '" + image + "']"