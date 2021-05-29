//
//  Utilities.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

infix operator ====

extension Hashable {

  @inlinable
  static func ==== (lhs: Self, rhs: Self) -> Bool {
    lhs.hashValue == rhs.hashValue && lhs == rhs
  }
}

#endif
