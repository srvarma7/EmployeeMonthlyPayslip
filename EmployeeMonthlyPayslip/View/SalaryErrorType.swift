//
//  SalaryErrorType.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 11/5/21.
//
/**
 Enum - defines type of error related to salary
 */
enum SalaryErrorType: Error {
    case nonNumeric
    case nonPositive
}
