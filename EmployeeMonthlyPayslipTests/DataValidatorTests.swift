//
//  EmployeeMonthlyPayslipTests.swift
//  EmployeeMonthlyPayslipTests
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

import XCTest
@testable import EmployeeMonthlyPayslip

class DataValidatorTests: XCTestCase {

    var sut: DataValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Arrange
        sut = DataValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    //MARK:- Tests for Keyword
    func test_WhenPassedValidKeyword_ShouldReturnTrue() {
        // Arrange
        let validKeyWord: String = Constants.General.KEYWORD
        // Act
        let keywordStatus = sut.isValidKeyword(word: validKeyWord)
        // Assert
        XCTAssertTrue(keywordStatus, "The isValidKeyword() should return TRUE but returned FALSE when valid keyword is passed")
    }

    func test_WhenPassedInvalidKeyword_ShouldReturnFalse() {
        // Arrange
        let invalidKeyWord: String = "GenPayslip"
        // Act
        let keywordStatus = sut.isValidKeyword(word: invalidKeyWord)
        // Assert
        XCTAssertFalse(keywordStatus, "The isValidKeyword() should return FALSE but returned TRUE when invalid keyword is passed")
    }

    func test_WhenPassedEmptyKeyWord_ShouldReturnFalse() {
        // Arrange
        let invalidKeyWord: String = ""
        // Act
        let keywordStatus = sut.isValidKeyword(word: invalidKeyWord)
        // Assert
        XCTAssertFalse(keywordStatus, "The isValidKeyword() should return FALSE but returned TRUE when empty keyword is passed")
    }

    //MARK:- Tests for Name
    func test_WhenPassedValidNameWithTwoCharactersLength_ShouldReturnTrue() {
        // Arrange
        let validName: String = "Iron Man"
        // Act
        let nameStatus = sut.isValidName(name: validName)
        // Assert
        XCTAssertTrue(nameStatus, "The isValidName() should return TRUE but returned FALSE when valid name of length greater than or equals to \(Constants.General.MIN_VALID_NAME_LENGTH) is passed")
    }

    func test_WhenPassedInvalidNameWithOneCharacterLength_ShouldReturnFalse() {
        // Arrange
        let invalidName: String = "K"
        // Act
        let nameStatus = sut.isValidName(name: invalidName)
        // Assert
        XCTAssertFalse(nameStatus, "The isValidName() should return FALSE but returned TRUE when invalid name of length \(invalidName.count) less than \(Constants.General.MIN_VALID_NAME_LENGTH) is passed")
    }

    func test_WhenPassedEmptyName_ShouldReturnFalse() {
        // Arrange
        let invalidName: String = ""
        // Act
        let nameStatus = sut.isValidName(name: invalidName)
        // Assert
        XCTAssertFalse(nameStatus, "The isValidName() should return FALSE but returned TRUE when empty name of length which is less than \(Constants.General.MIN_VALID_NAME_LENGTH) is passed")
    }

    func test_WhenPassedValidNameOfSize37Length_ShouldReturnTrue() {
        // Arrange
        let validName: String = "Chola Naga Sai Raghu Varma Kallepalli"
        // Act
        let nameStatus = sut.isValidName(name: validName)
        // Assert
        XCTAssertTrue(nameStatus, "The isValidName() should return TRUE but returned FALSE when valid name of length \(validName.count) than is equals to \(Constants.General.MAX_VALID_NAME_LENGTH) is passed")
    }

    func test_WhenPassedInvalidNameOfSize38Length_ShouldReturnFalse() {
        // Arrange
        let invalidName: String = "Chola Naga Sai Raghu Varma Kallepalli Kallepalli"
        // Act
        let nameStatus = sut.isValidName(name: invalidName)
        // Assert
        XCTAssertFalse(nameStatus, "The isValidName() should return FALSE but returned TRUE when invalid name of length \(invalidName.count) which is greater than \(Constants.General.MIN_VALID_NAME_LENGTH) is passed")
    }

    func test_WhenPassedInvalidNameWithSpecialCharacters_ShouldReturnFalse() {
        // Arrange
        let invalidName: String = "Sai_Raghu@Varma"
        // Act
        let nameStatus = sut.isValidName(name: invalidName)
        // Assert
        XCTAssertFalse(nameStatus, "The isValidName() should return FALSE but returned TRUE when invalid name name contains special characters like !@#$%^&*()_+ etc is present. Hint:- Name can only contain A-Z, a-z, \" \" and no special characters.")
    }

    //MARK:- Tests for Salary
    func test_WhenPassedValidSalary_ShouldReturnTrue() {
        // Arrange
        let validSalary: String = "1234"
        // Act
        let numericStatus = sut.isSalaryAValidNumber(salaryInString: validSalary)
        // Assert
        XCTAssertTrue(numericStatus, "The isSalaryAValidNumber() should return TRUE but returned FALSE when valid salary is passed")
    }

    func test_WhenPassedValidSalaryWithDecimals_ShouldReturnTrue() {
        // Arrange
        let validSalary: String = "1234.20"
        // Act
        let numericStatus = sut.isSalaryAValidNumber(salaryInString: validSalary)
        // Assert
        XCTAssertTrue(numericStatus, "The isSalaryAValidNumber() should return TRUE but returned FALSE when valid salary is passed")
    }

    func test_WhenPassedInvalidSalary_ShouldReturnFalse() {
        // Arrange
        let invalidSalary: String = "Abc"
        // Act
        let numericStatus = sut.isSalaryAValidNumber(salaryInString: invalidSalary)
        // Assert
        XCTAssertFalse(numericStatus, "The isSalaryAValidNumber() should return FALSE but returned TRUE when invalid salary is passed")
    }

    func test_WhenPassedEmptySalary_ShouldReturnFalse() {
        // Arrange
        let invalidSalary: String = ""
        // Act
        let numericStatus = sut.isSalaryAValidNumber(salaryInString: invalidSalary)
        // Assert
        XCTAssertFalse(numericStatus, "The isSalaryAValidNumber() should return FALSE but returned TRUE when empty salary is passed")
    }

    //MARK:- Tests of Valid Salary

    func test_WhenPassedValidSalaryAmount_ShouldReturnTrue() {
        // Arrange
        let invalidSalary: Double = 100000
        // Act
        let numericStatus = sut.isValidMinimumSalary(salary: invalidSalary)
        // Assert
        XCTAssertTrue(numericStatus, "The isValidSalary() should return TRUE but returned FALSE when valid value of salary is passed")
    }

    func test_WhenPassedNegativeSalaryAmount_ShouldReturnFalse() {
        // Arrange
        let invalidSalary: Double = -10000
        // Act
        let numericStatus = sut.isValidMinimumSalary(salary: invalidSalary)
        // Assert
        XCTAssertFalse(numericStatus, "The isValidSalary() should return FALSE but returned TRUE when negative value of salary is passed")
    }

    func test_WhenPassedInvalidSalaryAmount_ShouldReturnFalse() {
        // Arrange
        let invalidSalary: Double = 0
        // Act
        let numericStatus = sut.isValidMinimumSalary(salary: invalidSalary)
        // Assert
        XCTAssertFalse(numericStatus, "The isValidSalary() should return FALSE but returned TRUE when invalid value of salary is passed")
    }

    //MARK:- Tests for Remove Spaces

    func test_WhenPassedStringWithSpace_ShouldReturnStringWithNoSpaces() {
        // Arrange
        let valueWithSpaces = "Mc Donalds"
        // Act
        let result = sut.removeSpaces(string: valueWithSpaces)
        // Assert
        XCTAssertEqual(result, "McDonalds", "The removeSpaces() should return string with no spaces but returned invalid result")
    }

    func test_WhenPassedStringWithNoSpace_ShouldReturnStringWithNoSpaces() {
        // Arrange
        let valueWithSpaces = "McDonalds"
        // Act
        let result = sut.removeSpaces(string: valueWithSpaces)
        // Assert
        XCTAssertEqual(result, "McDonalds", "The removeSpaces() should return string with no spaces but returned invalid result")
    }

    func test_WhenPassedStringWithOnlySpace_ShouldReturnStringWithNoSpaces() {
        // Arrange
        let valueWithSpaces = "                                                         "
        // Act
        let result = sut.removeSpaces(string: valueWithSpaces)
        // Assert
        XCTAssertEqual(result, "", "The removeSpaces() should return string with no spaces but returned invalid result")
    }

    func test_WhenPassedStringWithNoSpaces_ShouldReturnStringWithNoSpaces() {
        // Arrange
        let valueWithSpaces = "ILoveVictoria"
        // Act
        let result = sut.removeSpaces(string: valueWithSpaces)
        // Assert
        XCTAssertNotEqual(result, "I Love Victoria", "The removeSpaces() should return string with no spaces but returned invalid result")
    }
}
