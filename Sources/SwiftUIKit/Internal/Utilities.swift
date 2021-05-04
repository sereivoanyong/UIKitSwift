//
//  Utilities.swift
//
//  Created by Sereivoan Yong on 4/30/21.
//

#if os(iOS)

import ObjectiveC

@usableFromInline
func class_exchangeInstanceMethodImplementations(_ cls: AnyClass, _ originalSelector: Selector, _ swizzledSelector: Selector) {
  let originalMethod = class_getInstanceMethod(cls, originalSelector).unsafelyUnwrapped
  let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector).unsafelyUnwrapped
  let wasMethodAdded = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
  if wasMethodAdded {
    class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod)
  }
}

@usableFromInline
func setValueIfNotEqual<Root, Value>(_ value: Value, for keyPath: ReferenceWritableKeyPath<Root, Value>, on object: Root) where Value: Equatable {
  if object[keyPath: keyPath] != value {
    object[keyPath: keyPath] = value
  }
}

#endif
