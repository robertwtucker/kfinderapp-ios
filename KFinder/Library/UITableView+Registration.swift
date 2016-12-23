/**
 * Copyright (c) 2016 Robert Tucker
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import UIKit

// Eliminating strings for reusable cell identifiers
// See: http://techblog.thescore.com/2016/04/04/typed-uitableview-uicollectionview-dequeuing-in-swift/

extension UITableViewCell {
    public class func defaultIdentifier() -> String {
        return "\(self)"
    }
}

// MARK: - Cell Registration

extension UITableView {
    public func register<T: UITableViewCell>(cellClass `class`: T.Type) {
        register(`class`, forCellReuseIdentifier: `class`.defaultIdentifier())
    }
    
    public func register<T: UITableViewCell>(nib: UINib, forClass `class`: T.Type) {
        register(nib, forCellReuseIdentifier: `class`.defaultIdentifier())
    }
    
    /**
     Dequeue a Reusable Cell in a way that provides type information.
     
     If you are going to use this dequeue method it is recomended that you use
     `register<T: UITableViewCell>(cellClass: T.Type)` or
     `register<T: UITableViewCell>(nib: UINib, forClass: T.Type)`
     for registration.
     
     - parameter `class`: The class whose type you are dequeing.
     
     - returns: Returns a view of the type requested if it was registered, `nil` otherwise.
     */
    public func dequeueReusableCell<T: UITableViewCell>(withClass `class`: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: `class`.defaultIdentifier()) as? T
    }
    
    /**
     Dequeue a Reusable Cell in a way that provides type information.
     
     This call will raise a fatal error if the cell was not registered with `defaultIdentifier()`
     this behaviour is not particularily different from the method which it is covering,
     `dequeueReusableCell(withIdentifier)` which will raise an NSInternalInconsistency Exception
     because the cell was not registered with the corrrect identifier or at all. If you are going
     to use this dequeue method it is recomended that you use
     `register<T: UITableViewCell>(cellClass: T.Type)` or
     `register<T: UITableViewCell>(nib: UINib, forClass: T.Type)` 
     for registration.
     
     - parameter `class`:   The class whose type you are dequeing.
     - parameter indexPath: The index path of the cell you want to dequeue.
     
     - returns: Returns a cell of the type requested.
     */
    public func dequeueReusableCell<T: UITableViewCell>(withClass `class`: T.Type, forIndexPath indexPath: NSIndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: `class`.defaultIdentifier(), for: indexPath as IndexPath) as? T else {
            fatalError("Error: cell with identifier: \(`class`.defaultIdentifier()) for index path: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}

