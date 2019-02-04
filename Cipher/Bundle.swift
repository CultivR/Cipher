//
//  Bundle.swift
//  Cipher
//
//  Created by Jordan Kay on 2/4/19.
//  Copyright © 2019 Cultivr. All rights reserved.
//

private var templates: [String: [Data]] = [:]
private var sizeTemplates: [String: [CGSize]] = [:]

public extension Bundle {
    var isInterfaceBuilder: Bool {
        return bundleIdentifier?.range(of: "com.apple") != nil
    }
    
    static func loadNibNamed(nibName: String, variantID: Int) -> UIView {
        if main.isInterfaceBuilder {
            let nib: UINib = .init(nibName: nibName)
            return nib.contents[variantID]
        } else {
            let template = findTemplate(withName: nibName, variantID: variantID)
            let view = NSKeyedUnarchiver.unarchiveObject(with: template) as! UIView
            view.awakeFromNib()
            return view
        }
    }
    
    static func sizeOfNibNamed(nibName: String, variantID: Int) -> CGSize {
        findTemplate(withName: nibName, variantID: variantID)
        return sizeTemplates[nibName]![min(variantID, sizeTemplates[nibName]!.count - 1)]
    }
    
    @discardableResult static func findTemplate(withName nibName: String, variantID: Int) -> Data {
        let nib: UINib = .init(nibName: nibName)
        let variants = templates[nibName] ?? {
            let contents = nib.contents
            let data = contents.map { NSKeyedArchiver.archivedData(withRootObject: $0) }
            templates[nibName] = data
            return data
        }()
        return variants[min(variantID, variants.count - 1)]
    }
}
