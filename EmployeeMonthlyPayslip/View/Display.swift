//
//  Display.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

/**
 This class is helpful for displaying feedback or messages to the User
 It contains a few predefined display methods
 This class can also be used to display custom messages with different message types
 Ex:- Message with error type, warning type, success type....
 */
class Display {

    /// Singleton of the Display
    static let shared = Display()

    /// Prints custom message with type symbol. Ex:- success, waring, failure and normal
    func printWith(type: MessageType, message: String) {
        switch type {
        case .normal:
            print(message)
        case .success:
            printWithSuccess(message: message)
        case .warning:
            printWithWarning(message: message)
        case .error:
            printWithError(message: message)
        }
    }

    /// prints custom message with success symbol
    private func printWithSuccess(message: String) {
        print(" \(MessageType.success.rawValue) \(message)")
    }

    /// prints custom message with warning symbol
    private func printWithWarning(message: String) {
        print(" \(MessageType.warning.rawValue) \(message)")
    }

    /// prints custom message with success symbol and whitespace to get user attention
    private func printWithWarningAndWhitespace(message: String) {
        print("\n\n\n\n\n\n\n\n\n\n \(MessageType.warning.rawValue) \(message)")
    }

    /// prints custom message with error symbol
    private func printWithError(message: String) {
        print(" \(MessageType.error.rawValue) \(message)")
    }

    // MARK:- Utility Functions
    /// prints welcome message
    public func welcomeMessage() {
        print("**************************************************")
        print("* Welcome to Employee Monthly Pay Slip generator *")
        print("**************************************************")
    }

    /// Prints program instructions with example
    public func programInstructions() {
        print("\nPlease enter GenerateMonthlyPayslip along with Name and Annual salary of the Employee:")
        print("Example input:- GenerateMonthlyPayslip \"Mary Song\" 60000")
        print("~~~~~~~ ~~~~~")
    }

    /// Prints monthly payslip
    /// - Parameter income: Income type to populate the method
    public func monthlyPaySlip(income: Income) {
        print("\n********* Generated Monthly Payslip *********")
        print("-> Monthly Payslip for: \"\(income.employeeName)\"")
        print("-> Gross Monthly Income: $\(income.grossMonthlyIncome)")
        print("-> Monthly Income Tax: $\(income.monthlyIncomeTax)")
        print("-> Net Monthly Income: $\(income.netMonthlyIncome)")
        print("*********************************************\n")
    }

    /// Prints empty error with warning symbol
    public func emptyInputProvided() {
        printWith(type: .warning, message: "Input cannot be empty. Please try again...")
    }

    /// Prints invalid user input error with error symbol
    public func invalidUserInput() {
        printWith(type: .error, message: "Invalid input. Ensure all three attributes are provided correctly...")
    }

    /// Prints invalid keyword found error with error symbol
    public func invalidKeywordFound() {
        printWith(type: .error, message: "Invalid keyword found. Please try again...")
    }

    /// Prints invalid name found error with error symbol
    public func invalidNameFound() {
        printWith(type: .error, message: "Invalid name found. Please try again...")
    }


    /// Prints invalid salary found message with specific description depending on the error type provided
    /// - Parameter type: SalaryErrorType can be nonPositive or nonNumeric
    public func invalidSalaryFound(type: SalaryErrorType) {
        switch type {
        case .nonNumeric:
            salaryNonNumericFound()
        case .nonPositive:
            salaryNonPositiveNumberFound()
        }
    }

    /// Prints invalid salary found error with error symbol
    private func salaryNonNumericFound() {
        printWith(type: .error, message: "Invalid salary found. Enter salary in numeric. Please try again...")
    }

    /// Prints invalid salary found error with error symbol
    private func salaryNonPositiveNumberFound() {
        printWith(type: .error, message: "Invalid salary found. Salary cannot be negative. Please try again...")
    }

    /// Prints successful generating monthly invoice with success symbol
    public func successGeneratingInvoice() {
        print("\n")
        printWith(type: .success, message: "Successfully generated monthly payslip")
    }
}
