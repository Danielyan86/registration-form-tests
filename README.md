# QA Registration Form Automation

This project automates testing of the registration form at https://qa-practice.netlify.app/registration-form using Robot Framework with Python and Selenium.

## Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Run Tests

### Local

```bash
robot tests/robot_test_cases
```

### Docker

```bash
docker build -t qa-registration .
docker run -v ${PWD}/results:/app/results qa-registration
```

## Reports

Test reports are generated in the `results` directory.
