//
//  ServiceLocator.swift
//  otus_hw2
//
//  Created by Владимир Воротников on 30.12.2025.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    
    private var services: [String: Any] = [:]
    
    func register<T>(service: T) {
        let key = String(describing: T.self)
        services[key] = service
    }
    
    func resolve<T>() -> T? {
        let key = String(describing: T.self)
        return services[key] as? T
    }
}
