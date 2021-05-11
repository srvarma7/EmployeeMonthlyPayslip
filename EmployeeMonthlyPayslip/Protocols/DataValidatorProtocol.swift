//
//  DataValidatorProtocol.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

/**
 Data Validation Protocol
 */
protocol DataValidatorProtocol {
    // Protocol methods for validation
    func isValidKeyword(word keyword: String) -> Bool
    func isValidName(name: String) -> Bool
    func isSalaryAValidNumber(salaryInString salary: String) -> Bool
    func isValidMinimumSalary(salary: Double) -> Bool
    func validateUserInput(input: String) -> [String]?
}
