//
//  DataValidator.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

import Foundation

/**
 This class helps to validate the data
 */
final class DataValidator: DataValidatorProtocol {

    /// The method takes an input as String then checks if it matches the value provided in the constant. If matches returns true else false
    /// - Parameter keyword: The actual keyword provided
    /// - Returns: A boolean - true when matches, false if not
    public func isValidKeyword(word keyword: String) -> Bool {
        return keyword == Constants.Validation.KEYWORD
    }

    /// The method takes an input as String then checks if it matches the Regular expression provided in the Constants. If matches returns true else false
    /// - Parameter name: The actual name provided
    /// - Returns: A boolean - true when matches, false if not
    public func isValidName(name: String) -> Bool {
        let regEx = Constants.Validation.VALID_NAME_REGEX
        // `try!` will always succeed because the pattern is a valid regular expression
        /// Code reference - StackOverFlow
        let regexPatter = try! NSRegularExpression(pattern: regEx, options: .caseInsensitive)
        return regexPatter.firstMatch(in: name, options: [], range: NSRange(location: 0, length: name.count)) != nil
    }

    /// The method takes an input as String then checks if the value in the string is actually a number. If its a number then returns true else false
    /// - Parameter salary: The actual salary provided
    /// - Returns: A boolean - true when value is numeric, false if not
    public func isSalaryAValidNumber(salaryInString salary: String) -> Bool {
        guard let _ = Double(salary) else {
            return false
        }
        return true
    }

    /// The method takes an input as Double then checks if the value is greater than 0. If its greater then returns true else false
    /// - Parameter salary: The actual salary provided
    /// - Returns: A boolean - true when value is greater that 0, false if not
    public func isValidMinimumSalary(salary: Double) -> Bool {
        return salary > 0
    }

    /// This methods takes an input as String then removes all the spaces in the values. Then return the value as String.
    /// - Parameter string: The value of String type
    /// - Returns: String - with no spaces
    public func removeSpaces(string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "")
    }

    /// This methods takes an input as String then separate values with `"`. Then checks if the value obtained as 3 values init. If 3 elements are present then it will make use the elements are not empty. If not empty then its a valid data returns the string array else returns nil.
    /// - Parameter input: A input of type String provided
    /// - Returns: String or nil -  If data is valid returns String array else returns nil.
    public func validateUserInput(input: String) -> [String]? {
        let resultAfterSplit = input.components(separatedBy: "\"")
        return resultAfterSplit.count == 3 &&
            !resultAfterSplit[0].isEmpty &&
            !resultAfterSplit[1].isEmpty &&
            !resultAfterSplit[2].isEmpty ? resultAfterSplit : nil
    }

    /// This method takes an input of type String array then checks the precondition. Then returns extracted values as Tuple.
    /// Notice:- There is a precondition at the beginning of the function. That means, in-order if perform its task the precondition must be met else the program is will force a crash on purpose.
    /// - Parameter result: An input od type String array
    /// - Returns: Tuple with keyword, name and salary as String
    public func extractData(from result: [String]) -> (keyword: String, name: String, salary: String) {
        precondition(result.count == 3)
        // Precondition is passed. Returns value.
        return (keyword: removeSpaces(string: result[0]),
                name: result[1],
                salary: removeSpaces(string: result[2]))
    }

    /// This method is helpful to round the decimal with precision two.
    /// - Parameter value: An input of type Double
    /// - Returns: Double - a value with precision 2
    public func roundToTwoDecimals(value: Double) -> Double {
        return round(value * 100)/100
    }
}
