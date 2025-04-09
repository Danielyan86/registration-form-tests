from tests.config.locators import (
    FIRST_NAME,
    LAST_NAME,
    PHONE,
    COUNTRY,
    EMAIL,
    PASSWORD,
    TERMS,
    REGISTER_BUTTON,
)


class RegistrationPage:

    def __init__(self, driver):
        self.selib = driver

    def fill_first_name(self, name):
        self.selib.input_text(FIRST_NAME, name)

    def fill_last_name(self, name):
        self.selib.input_text(LAST_NAME, name)

    def fill_phone(self, phone):
        self.selib.input_text(PHONE, phone)

    def select_country(self, country):
        self.selib.select_from_list_by_label(COUNTRY, country)

    def fill_email(self, email):
        self.selib.input_text(EMAIL, email)

    def fill_password(self, password):
        self.selib.input_text(PASSWORD, password)

    def accept_terms(self):
        self.selib.wait_until_element_is_visible(TERMS)
        self.selib.wait_until_element_is_enabled(TERMS)
        if not self.selib.checkbox_should_be_selected(TERMS):
            self.selib.select_checkbox(TERMS)

    def click_register(self):
        self.selib.click_element(REGISTER_BUTTON)
