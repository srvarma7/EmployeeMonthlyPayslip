//
//  Constants.swift
//  EmployeeMonthlyPayslip
//
//  Created by Sai Raghu Varma Kallepalli on 10/5/21.
//

struct Constants {
    struct General {
        static let MONTHS_IN_A_Year: Int        = 12
        static let KEYWORD: String              = "GenerateMonthlyPayslip"
        static let MIN_VALID_NAME_LENGTH: Int   = 2
        static let MAX_VALID_NAME_LENGTH: Int   = 37
        static let VALID_NAME_REGEX: String     = "^[a-zA-Z ]{\(MIN_VALID_NAME_LENGTH),\(MAX_VALID_NAME_LENGTH)}$"
    }
    struct Tax {
        static let RATES: [Double]       = [0, 0.1, 0.2, 0.3, 0.4]
        static let BASE_VALUES: [Double] = [0, 20000, 40000, 80000, 180000]
    }
}
