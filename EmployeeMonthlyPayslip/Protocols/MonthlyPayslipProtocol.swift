//
//  MonthlyPayslipProtocol.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

/**
 Monthly Payslip Protocol
 */
protocol MonthlyPayslipProtocol {
    // Protocol methods for generating payslip
    func generateMonthlyPaySlip(employee: Employee) -> Income
    func calculateGrossMonthlyIncome(for annualSalary: Double) -> Double
    func calculateMonthlyIncomeTax(for annualSalary: Double) -> Double
    func calculateNetMonthlyIncome(grossMonthlyIncome gMI : Double, monthlyIncomeTax mIT: Double) -> Double
}
