//
//  MessageType.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

enum MessageType: String, Error {
    case normal
    case success = "✅"
    case warning = "⚠️"
    case error   = "🛑"
}
