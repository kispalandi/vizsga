# Blue Water Pool Website Test Automation
This is a Robot Framework test automation project for the Sauce Demo website (https://bwpool.azurewebsites.net/).
The project includes one case covering various functionalities of the website, such as 
- opening of customer, location and tool menu
- recording data from API calls into customer, location and tool menu
- exporting excel file from tool menu including the recorded data
- filtering the recorded customer data in location menu

## Prerequisites
- Python 3.x (Robot Framework is Python-based)
- Robot Framework (Installation: ```pip install robotframework```)
- Robot Framework SeleniumLibrary (Installation: ```pip install --upgrade robotframework-seleniumlibrary```)

## Installation
1. Clone the repository:
```
git clone https://github.com/kispalandi/vizsga.git
```

2. Navigate to the project directory:
```
cd bwp_tool_project
```

3. Install the required Python libraries:
```
pip install -r requirements.txt
```

## Running Tests
To run the entire test suite, use the following command:

```
robot -d ./results ./tests
```

This will execute all the test cases and generate a report and log files in the results directory.

You can also run specific test cases or suites by providing their respective paths. For example:
```
robot -d ./results ./tests/bwp_test.robot
```

This will run only the test cases in the bwp_test.robot file.

## Test Case
The project includes the following test case:

- bwp_test.robot