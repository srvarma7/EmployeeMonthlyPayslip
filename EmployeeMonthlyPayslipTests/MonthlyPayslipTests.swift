//
//  MonthlyPayslipTests.swift
//  EmployeeMonthlyPayslipTests
//
//  Created by Sai Raghu Varma Kallepalli on 11/5/21.
//

import XCTest
@testable import EmployeeMonthlyPayslip

class MonthlyPayslipTests: XCTestCase {
    
    // System under test variable of type MonthlyPayslip
    var sut: MonthlyPayslip!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Arrange system under test with MonthlyPayslip instance
        sut = MonthlyPayslip()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    //MARK:- Tests for Generating Monthly Payslip
    func test_generateMonthlyPaySlip_WhenPassedValidEmployeeData_ShouldReturnValidIncome() {
        // Arrange
        let employee = Employee(name: "Sam Smith", annualSalary: 138000)
        // Act
        let result = sut.generateMonthlyPaySlip(employee: employee)
        // Assert
        XCTAssertEqual(result.employeeName, "Sam Smith",
                       "The generateMonthlyPaySlip() should have returned valid name but returned invalid data")
        XCTAssertEqual(result.grossMonthlyIncome, 11500,
                       "The generateMonthlyPaySlip() should have returned valid gross monthly income but returned invalid data")
        XCTAssertEqual(result.monthlyIncomeTax, 2283.33,
                       "The generateMonthlyPaySlip() should have returned valid monthly income tax but returned invalid data")
        XCTAssertEqual(result.netMonthlyIncome, 9216.67,
                       "The generateMonthlyPaySlip() should have returned valid net monthly income but returned invalid data")
    }

    func test_generateMonthlyPaySlip_WhenPassedInValidEmployeeData_ShouldReturnInValidIncome() {
        // Arrange
        let employee = Employee(name: "Sam Smith", annualSalary: 90000)
        // Act
        let result = sut.generateMonthlyPaySlip(employee: employee)
        // Assert
        XCTAssertNotEqual(result.employeeName, "Smith Sam",
                          "The generateMonthlyPaySlip() should have returned invalid name but returned valid data")
        XCTAssertNotEqual(result.grossMonthlyIncome, 6000.33,
                          "The generateMonthlyPaySlip() should have returned invalid gross monthly income but returned valid data")
        XCTAssertNotEqual(result.monthlyIncomeTax, 1283.33,
                          "The generateMonthlyPaySlip() should have returned invalid monthly income tax but returned valid data")
        XCTAssertNotEqual(result.netMonthlyIncome, 4616.00,
                          "The generateMonthlyPaySlip() should have returned invalid net monthly income but returned valid data")
    }

    //MARK:- Tests for Calculating Gross Monthly Income
    func test_calculateGrossMonthlyIncome_WhenPassedValidSalary_ShouldReturnValidValue() {
        // Arrange
        let salary: Double = 60000
        // Act
        let result = sut.calculateGrossMonthlyIncome(for: salary)
        // Assert
        XCTAssertEqual(result, 5000,
                       "The calculateGrossMonthlyIncome() should have returned valid gross monthly income but returned invalid gross monthly income")
    }

    func test_calculateGrossMonthlyIncome_WhenPassedValidSalaryWithDecimal_ShouldReturnValidValue() {
        // Arrange
        let salary: Double = 910500.49
        // Act
        let result = sut.calculateGrossMonthlyIncome(for: salary)
        // Assert
        XCTAssertEqual(result, 75875.04,
                       "The calculateGrossMonthlyIncome() should have returned valid gross monthly income with correct decimals but returned invalid gross monthly income")
    }

    //MARK:- Tests for Calculating Monthly Income Tax
    func test_calculateMonthlyIncomeTax_WhenPassedValidData_ShouldReturnValidValue() {
        // Arrange
        let salary: Double = 100000
        // Act
        let result = sut.calculateMonthlyIncomeTax(for: salary)
        // Assert
        XCTAssertEqual(result, 1333.33,
                       "The calculateMonthlyIncomeTax() should have returned valid monthly income tax but returned invalid data")
    }

    func test_calculateMonthlyIncomeTax_WhenPassedValidDataWithDecimals_ShouldReturnValidValue() {
        // Arrange
        let salary: Double = 789789.789
        // Act
        let result = sut.calculateMonthlyIncomeTax(for: salary)
        // Assert
        XCTAssertEqual(result, 23659.66,
                       "The calculateMonthlyIncomeTax() should have returned valid monthly income tax with correct decimals but returned invalid monthly income tax")
    }

    //MARK:- Tests for Calculating Net Monthly Income
    func test_calculateNetMonthlyIncome_WhenPassedValidData_ShouldReturnValidValue() {
        // Arrange
        let grossMonthlyIncome: Double = 100
        let monthlyIncomeTax: Double = 10
        // Act
        let result = sut.calculateNetMonthlyIncome(grossMonthlyIncome: grossMonthlyIncome, monthlyIncomeTax: monthlyIncomeTax)
        // Assert
        XCTAssertEqual(result, 90,
                       "The calculateNetMonthlyIncome() should have returned valid net monthly income tax but returned invalid data")
    }

    func test_calculateNetMonthlyIncome_WhenPassedValidDataWithDecials_ShouldReturnValidValue() {
        // Arrange
        let grossMonthlyIncome: Double = 100.70
        let monthlyIncomeTax: Double = 10.30
        // Act
        let result = sut.calculateNetMonthlyIncome(grossMonthlyIncome: grossMonthlyIncome, monthlyIncomeTax: monthlyIncomeTax)
        // Assert
        XCTAssertEqual(result, 90.40,
                       "The calculateNetMonthlyIncome() should have returned valid net monthly income tax with correct decimals but returned invalid net monthly income tax")
    }

    #warning("Note:- The negative test cases for calculateGrossMonthlyIncome(), calculateMonthlyIncomeTax(), calculateNetMonthlyIncome() were not written as the functions itself stop executing when precondition is failed")
//    func test_calculateGrossMonthlyIncome_WhenPassedNegativeSalary_ShouldReturnValidValue() {
//        // Arrange
//        let salary: Double = -123900
//        // Act
//        let result = sut.calculateGrossMonthlyIncome(for: salary)
//        // Assert
//        XCTAssertEqual(result, 10325)
//    }
}
