//
//  Display.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

class Display {

    /// Singleton of the Display
    static let shared = Display()

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

    private func printWithSuccess(message: String) {
        print(" \(MessageType.success.rawValue) \(message)")
    }
    private func printWithWarning(message: String) {
        print(" \(MessageType.warning.rawValue) \(message)")
    }
    private func printWithWarningAndWhitespace(message: String) {
        print("\n\n\n\n\n\n\n\n\n\n \(MessageType.warning.rawValue) \(message)")
    }
    private func printWithError(message: String) {
        print(" \(MessageType.error.rawValue) \(message)")
    }

    // MARK:- Utility Functions
    public func welcomeMessage() {
        print("**************************************************")
        print("* Welcome to Employee Monthly Pay Slip generator *")
        print("**************************************************")
    }

    public func programInstructions() {
        print("\nPlease enter GenerateMonthlyPayslip along with Name and Annual salary of the Employee:")
        print("Example input:- GenerateMonthlyPayslip \"Mary Song\" 60000")
        print("~~~~~~~ ~~~~~")
    }

    public func monthlyPaySlip(income: Income) {
        print("\n********* Generated Monthly Payslip *********")
        print("-> Monthly Payslip for: \"\(income.employeeName)\"")
        print("-> Gross Monthly Income: $\(income.grossMonthlyIncome)")
        print("-> Monthly Income Tax: $\(income.monthlyIncomeTax)")
        print("-> Net Monthly Income: $\(income.netMonthlyIncome)")
        print("*********************************************\n")
    }

    public func emptyInputProvided() {
        printWith(type: .warning, message: "Input cannot be empty. Please try again...")
    }

    public func invalidUserInput() {
        printWith(type: .warning, message: "Invalid input. Ensure all three attributes are provided correctly...")
    }

    public func invalidKeywordFound() {
        printWith(type: .error, message: "Invalid keyword found. Please try again...")
    }

    public func invalidNameFound() {
        printWith(type: .error, message: "Invalid name found. Please try again...")
    }

    public func invalidSalaryFound(type: SalaryErrorType) {
        switch type {
        case .nonNumeric:
            salaryNonNumericFound()
        case .nonPositive:
            salaryNonPositiveNumberFound()
        }
    }

    private func salaryNonNumericFound() {
        printWith(type: .error, message: "Invalid salary found. Enter salary in numeric. Please try again...")
    }

    private func salaryNonPositiveNumberFound() {
        printWith(type: .error, message: "Invalid salary found. Salary cannot be negative. Please try again...")
    }
}
