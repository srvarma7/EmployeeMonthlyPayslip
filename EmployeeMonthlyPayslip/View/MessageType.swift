//
//  MessageType.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

/**
 Enum - defines type of message to distinguish between different types of messages and to show appropriate symbol
 */
enum MessageType: String, Error {
    case normal
    case success = "✅"
    case warning = "⚠️"
    case error   = "🛑"
}
