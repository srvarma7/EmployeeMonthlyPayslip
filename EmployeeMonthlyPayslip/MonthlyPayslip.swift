//
//  MonthlyPayslip.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

import Foundation

/**
 MonthlyPayslip class -
    Implements the CRUD operations for the program.
    Conforms to MonthlyPayslipProtocol for calculating and generating the employee monthly payslip.
    This class is the entry point for the program to run.
 */
final class MonthlyPayslip {

    // Private instance variable of type DataValidator for validating data entered by user
    private var dataValidator: DataValidator

    init() {
        // When the class gets created, the dataValidator variable is instantiated
        dataValidator = DataValidator()
    }

    // MARK:- Starting Function
    /// This method is responsible for displaying welcome message to user and begin the program flow
    public func start() {
        Display.shared.welcomeMessage()
        beginProgram()
    }

    /**
     This methods is responsible for showing program instructions to the user and get input.
     Do data validation for input.....
     if not valid, it calls it own method recursively until the condition is met to give user an other go.
     if valid data is passed, then continuous to generate monthly payslip.
     Displays the generated monthly payslip on console.
     */
    private func beginProgram() {
        var inputFromConsole = ""
        Display.shared.programInstructions()
        // Read the input from the console entered by User and assign the value to inputFormConsole.
        inputFromConsole = readInputFromConsole()
        // Checking if the value is empty for inputFromConsole variable.
        while inputFromConsole.isEmpty {
            /// Empty data is found. Display error message.
            Display.shared.emptyInputProvided()
            /// Allow user to re-enter the data.
            inputFromConsole = readInputFromConsole()
        }
        // Condition met. The value of inputFromConsole variable is not empty.
        // Proceed further
        guard let employee = dataValidationAndExtraction(inputFromConsole: inputFromConsole) else {
            /// Error:- The data provided my the user in console is not correct.
            /// Display the particular error that caused the issue in dataValidationAndExtraction() method.
            /// Calling its own function as required condition not met to allow user to try again.
            beginProgram()
            return
        }
        // Created employee variable successfully.
        // Generating the income by passing employee variable that contains name and salary.
        let income = generateMonthlyPaySlip(employee: employee)
        Display.shared.successGeneratingInvoice()
        // Now, passing the generated income to Display class to display the Employee monthly payslip details on console.
        Display.shared.monthlyPaySlip(income: income)
        // Reached end of the program logic. So, program ends.
    }

    private func dataValidationAndExtraction(inputFromConsole: String) -> Employee? {
        guard let validResult = dataValidator.validateUserInput(input: inputFromConsole) else {
            /// Found nil in validResult.
            /// Displaying error message to User and restarting the program.
            Display.shared.invalidUserInput()
            return nil
        }
        // Valid data is found in validResult variable.
        // Now extracting the data to keyword, name and salary
        let (keyword, name, salary) = dataValidator.extractData(from: validResult)
        guard dataValidator.isValidKeyword(word: keyword) else {
            /// Keyword is not matched as required
            /// Displays the error to User
            Display.shared.invalidKeywordFound()
            return nil
        }
        guard dataValidator.isValidName(name: name) else {
            /// Name has not met the required condition.
            /// Displays the error to User
            Display.shared.invalidNameFound()
            return nil
        }
        guard dataValidator.isSalaryAValidNumber(salaryInString: salary) else {
            /// Salary is not a numeric value as required
            /// Displays the error to User
            Display.shared.invalidSalaryFound(type: .nonNumeric)
            return nil
        }
        // Force casting the variable to double as we already found the value is numeric
        let salaryInDouble = Double(salary)!
        guard dataValidator.isValidMinimumSalary(salary: salaryInDouble) else {
            /// Salary is not greater than 0 as required
            /// Displays the error to User
            Display.shared.invalidSalaryFound(type: .nonPositive)
            return nil
        }
        // The data in all the three variables are valid
        // Then creates the employee type variable and returns the value
        return Employee(name: name, annualSalary: salaryInDouble)
    }

    // MARK:- Utility Functions
    /// This method reads input from the console provided by the User.
    /// - Returns: The value entered by user as String or if nothing is provided empty String is returned.
    private func readInputFromConsole() -> String {
        return readLine() ?? ""
    }
}

extension MonthlyPayslip: TaxCalculationProtocol {

    /// This method calculates gross monthly income, monthly income tax and net monthly income. Then returns the calculated values as Income variable.
    /// - Parameter employee: The object of employee which contains name and annual salary.
    /// - Returns: Income - The calculated values are wrapped and returned as Income
    func generateMonthlyPaySlip(employee: Employee) -> Income {
        let grossMonthlyIncome = calculateGrossMonthlyIncome(for: employee.annualSalary)
        let monthlyIncomeTax   = calculateMonthlyIncomeTax(for: employee.annualSalary)
        let netMonthlyIncome   = calculateNetMonthlyIncome(grossMonthlyIncome: grossMonthlyIncome,
                                                           monthlyIncomeTax: monthlyIncomeTax)
        return Income(employeeName: employee.name,
                      grossMonthlyIncome: grossMonthlyIncome,
                      monthlyIncomeTax: monthlyIncomeTax,
                      netMonthlyIncome: netMonthlyIncome)
    }

    //MARK:- Helper functions to generate monthly pay slip
    /// This function calculates the monthly salary by dividing the annual salary by number of months in a year. Then rounds the value to precision two and returns the obtained value as type Double.
    /// - Parameter annualSalary: The annual salary of the employee.
    /// - Returns: A monthly salary value rounded to two decimals.
    func calculateGrossMonthlyIncome(for annualSalary: Double) -> Double {
        // Forcing the app to crash when the condition is not met. As it should have met the condition to come to this stage.
        precondition(annualSalary > 0)
        let monthlySalary = annualSalary/Double(Constants.Tax.MONTHS_IN_A_Year)
        return dataValidator.roundToTwoDecimals(value: monthlySalary)
    }

    /// This function calculates the monthly income tax by making some computation based on the pay rate with pre-defined tax rates. Then rounds the value to precision two and returns the obtained value as type Double.
    /// - Parameter annualSalary: The annual salary of the employee.
    /// - Returns: A monthly income tax value rounded to two decimals.
    func calculateMonthlyIncomeTax(for annualSalary: Double) -> Double {
        // Forcing the app to crash when the condition is not met. As it should have met the condition to come to this stage.
        precondition(annualSalary > 0)
        // First assigning the salary to remaining salary.
        var remainingSalary: Double = annualSalary
        // At first the yearly income tax is always 0.
        var yearlyIncomeTax: Double = 0
        // Setting the value of index to number of tax categories
        /// Ex:- 1-20k, 20k - 40k, ....
        // But array starts from index 0. So, total count - 1
        var index = Constants.Tax.RATE_PERCENTAGE.count - 1
        // Run the loop until all of the tax for salary is calculated
        while remainingSalary > 0 &&
                /// Checking one more extra condition for eradicating the chance of array index out of bounds run time error. Also eliminates infinite looping.
                index > -1 &&
                index < Constants.Tax.RATE_PERCENTAGE.count {
            /// Condition passed. Salary is greater than 0 and index within the range.
            let currentTaxRateBaseValue = Constants.Tax.BASE_VALUES_SLAB[index]
            // Check if remaining salary is greater that current tax base slab
            if remainingSalary > currentTaxRateBaseValue {
                /// Condition passed. So, there is amount to calculate tax with current tax percentage.
                // Get the remaining amount that belongs to current tax slab
                let taxableAmount = remainingSalary - currentTaxRateBaseValue
                // Calculate the tax amount for the amount with tax percentage
                let taxForCurrentAmount = taxableAmount * Constants.Tax.RATE_PERCENTAGE[index]
                // Add the tax obtained to the total yearly income tax local variable
                yearlyIncomeTax  = yearlyIncomeTax + taxForCurrentAmount
                // Remove the already taxed amount from the salary
                remainingSalary = remainingSalary - taxableAmount
            }
            // Regardless of above if condition decrease the index value by 1 to loop through for calculating rest of the tax amount
            index -= 1
        }
        // Now, dividing the yearly income tax by number of months in a year to get tax per month
        let monthlyIncomeTax = yearlyIncomeTax/Double(Constants.Tax.MONTHS_IN_A_Year)
        // return the obtained value after rounding the value to two decimals
        return dataValidator.roundToTwoDecimals(value: monthlyIncomeTax)
    }

    /// This method calculates the net monthly income by subtracting the gross monthly income with monthly income tax and returns the obtained value as type Double
    /// - Parameters:
    ///   - grossMonthlyIncome: Gross monthly income of Employee
    ///   - monthlyIncomeTax: Monthly income tax of Employee
    /// - Returns: Net monthly income as type Double
    func calculateNetMonthlyIncome(grossMonthlyIncome: Double, monthlyIncomeTax: Double) -> Double {
        // Forcing the app to crash when the condition is not met. As it should have met the condition to come to this stage.
        precondition(grossMonthlyIncome > 0 &&
                        monthlyIncomeTax > 0 &&
                        grossMonthlyIncome > monthlyIncomeTax)
        return grossMonthlyIncome - monthlyIncomeTax
    }
}
