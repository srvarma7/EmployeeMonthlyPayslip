//
//  MonthlyPayslip.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

import Foundation

final class MonthlyPayslip {

    private var dataValidator: DataValidator

    init() {
        dataValidator = DataValidator()
    }

    public func start() {
        Display.shared.welcomeMessage()
        beginProgram()
    }

    private func beginProgram() {
        var inputFromConsole = ""
        Display.shared.programInstructions()
        // Read the input from the console entered by User and assign the value to inputFormConsole.
        inputFromConsole = readInputFromConsole()
        // Checking if the value is empty for inputFromConsole variable.
        while inputFromConsole.isEmpty {
            // Empty data is found. Display error message.
            Display.shared.emptyInputProvided()
            // Allow user to re-enter the data
            inputFromConsole = readInputFromConsole()
        }
        // Condition met. The value of inputFromConsole variable is not empty.
        // Proceed further
        guard let employee = dataValidationAndExtraction(inputFromConsole: inputFromConsole) else {
            beginProgram()
            return
        }
        let income = generateMonthlyPaySlip(employee: employee)
        Display.shared.monthlyPaySlip(income: income)
    }

    private func dataValidationAndExtraction(inputFromConsole: String) -> Employee? {
        guard let validResult = dataValidator.validateUserInput(input: inputFromConsole) else {
            // Found nil in validResult.
            /// Displaying error message to User and restarting the program.
            Display.shared.invalidUserInput()
            return nil
        }
        // Valid data is found in validResult variable.
        // Now extracting the data to keyword, name and salary
        let (keyword, name, salary) = dataValidator.extractData(from: validResult)
        guard dataValidator.isValidKeyword(word: keyword) else {
            Display.shared.invalidKeywordFound()
            return nil
        }
        guard dataValidator.isValidName(name: name) else {
            Display.shared.invalidNameFound()
            return nil
        }
        guard dataValidator.isSalaryAValidNumber(salaryInString: salary) else {
            Display.shared.invalidSalaryFound(type: .nonNumeric)
            return nil
        }
        // Force casting the variable to double as we already found the value is a numeric
        let salaryInDouble = Double(salary)!
        guard dataValidator.isValidMinimumSalary(salary: salaryInDouble) else {
            Display.shared.invalidSalaryFound(type: .nonPositive)
            return nil
        }
        // The data in all the three variables are valid
        return Employee(name: name, annualSalary: salaryInDouble)
    }

    // MARK:- Utility Functions

    private func readInputFromConsole() -> String {
        return readLine() ?? ""
    }
}

extension MonthlyPayslip: MonthlyPayslipProtocol {
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
    func calculateGrossMonthlyIncome(for annualSalary: Double) -> Double {
        let monthlySalary = annualSalary/Double(Constants.General.MONTHS_IN_A_Year)
        return dataValidator.roundToTwoDecimals(value: monthlySalary)
    }

    func calculateMonthlyIncomeTax(for annualSalary: Double) -> Double {
        var remainingSalary: Double = annualSalary
        var yearlyIncomeTax: Double = 0
        var index = 4
        while remainingSalary > 0 {
            let currentTaxComp = Constants.Tax.BASE_VALUES[index]
            if remainingSalary > currentTaxComp {
                let taxableAmount = remainingSalary - currentTaxComp
                let currentTaxFor = taxableAmount * Constants.Tax.RATES[index]
                yearlyIncomeTax  = yearlyIncomeTax + currentTaxFor
                remainingSalary = remainingSalary - taxableAmount
            }
            index -= 1
        }
        let monthlyIncomeTax = yearlyIncomeTax/Double(Constants.General.MONTHS_IN_A_Year)
        return dataValidator.roundToTwoDecimals(value: monthlyIncomeTax)
    }

    func calculateNetMonthlyIncome(grossMonthlyIncome: Double, monthlyIncomeTax: Double) -> Double {
        return grossMonthlyIncome - monthlyIncomeTax
    }
}
