//
//  DataValidator.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

import Foundation

final class DataValidator: DataValidatorProtocol {

    public func isValidKeyword(word keyword: String) -> Bool {
        return keyword == Constants.General.KEYWORD
    }

    public func isValidName(name: String) -> Bool {
        /// Code reference - StackOverFlow
        let regEx = Constants.General.VALID_NAME_REGEX
        // `try!` will always succeed because the pattern is a valid regular expression
        let regexPatter = try! NSRegularExpression(pattern: regEx, options: .caseInsensitive)
        return regexPatter.firstMatch(in: name, options: [], range: NSRange(location: 0, length: name.count)) != nil
    }

    public func isSalaryAValidNumber(salaryInString salary: String) -> Bool {
        guard let _ = Double(salary) else {
            return false
        }
        return true
    }

    public func isValidMinimumSalary(salary: Double) -> Bool {
        return salary > 0
    }

    public func removeSpaces(string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "")
    }

    public func validateUserInput(input: String) -> [String]? {
        let resultAfterSplit = input.components(separatedBy: "\"")
        return resultAfterSplit.count == 3 &&
            !resultAfterSplit[0].isEmpty &&
            !resultAfterSplit[1].isEmpty &&
            !resultAfterSplit[2].isEmpty ? resultAfterSplit : nil
    }

    public func extractData(from result: [String]) -> (keyword: String, name: String, salary: String) {
        precondition(result.count == 3)
        return (keyword: removeSpaces(string: result[0]),
                name: result[1],
                salary: removeSpaces(string: result[2]))
    }

    public func roundToTwoDecimals(value: Double) -> Double {
        return round(value * 100)/100
    }
}
