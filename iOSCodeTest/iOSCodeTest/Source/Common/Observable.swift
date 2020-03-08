//  Observable.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 08/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// We use Generics to accept any type of data, each time that an object of this class is instanced,
// the type of data T will be inferred according to the type of data received

class Observable<T> {
    
    // to use a name more suited to the context, such as Listener
    typealias Listener = (T?) -> Void
    
    private var listener: Listener?
    private let thread : DispatchQueue
    
    // receives a parameter of any type of data and assigns it to the property that is of the same type
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    // the code inside the didSet will run immediately after the value is stored,
    // so the listener property will be initialized
    var value : T? {
        didSet {
            // Although it is not strictly necessary, it is done asynchronously
            thread.async {
                self.listener?(self.value)
            }
        }
    }
    
    // the initialization is done in the main thread
    init(_ value : T? = nil, thread dispatcherThread : DispatchQueue = DispatchQueue.main) {
        self.thread = dispatcherThread
        self.value = value
    }
}
