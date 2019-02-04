//
//  Nib.swift
//  Cipher
//
//  Created by Jordan Kay on 2/4/19.
//  Copyright © 2019 Cultivr. All rights reserved.
//

public extension UINib {
    convenience init!(nibName: String) {
        var bundle: Bundle? = .main
        for framework in Bundle.allFrameworks {
            if framework.path(forResource: nibName, ofType: "nib") != nil {
                bundle = framework
                break
            }
        }
        
        if let bundle = bundle, bundle.path(forResource: nibName, ofType: "nib") != nil {
            self.init(nibName: nibName, bundle: bundle)
        } else {
            return nil
        }
    }
}

extension UINib {
    var contents: [UIView] {
        return instantiate(withOwner: nil, options: nil).compactMap { $0 as? UIView }
    }
}
