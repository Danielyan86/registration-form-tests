from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.common.exceptions import (
    TimeoutException,
    ElementClickInterceptedException,
)
from tests.config.config import EnvironmentConfig
from tests.pages.registration_page import RegistrationPage
from robot.libraries.BuiltIn import BuiltIn
import os


class RegistrationLibrary:

    def __init__(self):
        self.selenium_lib = None
        self.registration_page = None

    def start_browser(self):
        self.selenium_lib = BuiltIn().get_library_instance("SeleniumLibrary")

        if os.environ.get("HEADLESS") == "true":
            firefox_options = FirefoxOptions()
            firefox_options.add_argument("--headless")
            firefox_options.add_argument("--disable-dev-shm-usage")

            self.selenium_lib.open_browser(
                url=EnvironmentConfig.BUGS_FORM_URL,
                browser="firefox",
                options=firefox_options,
            )
        else:
            self.selenium_lib.open_browser(
                url=EnvironmentConfig.BUGS_FORM_URL, browser="chrome"
            )

        self.selenium_lib.maximize_browser_window()
        self.registration_page = RegistrationPage(self.selenium_lib)

    def register_user(self, firstname, lastname, phone, country, email, password):
        try:
            self.registration_page.fill_first_name(firstname)
            self.registration_page.fill_last_name(lastname)
            self.registration_page.fill_phone(phone)
            self.registration_page.select_country(country)
            self.registration_page.fill_email(email)
            self.registration_page.fill_password(password)
            self.registration_page.accept_terms()
            self.registration_page.click_register()
        except TimeoutException:
            raise Exception("Timeout while filling registration form")
        except ElementClickInterceptedException:
            raise Exception("Element click was intercepted during registration")

    def end_browser(self):
        if self.selenium_lib:
            self.selenium_lib.close_all_browsers()
