import UIKit

enum GlobalConstants {
    
    enum NotificationsIdentifiers: String {
        case updateProgress = "UpdateHabitsProgress"
        case addHabit = "AddNewHabit"
    }
    
    static let navBarTopInset: CGFloat = 21
    static let groupTopInset: CGFloat = 15
    static let groupItemTopInset: CGFloat = 7
    static let subViewsBorderInset: CGFloat = 15
//    static let cellLeadingTrailingInset: CGFloat = 16
    static let cellTopBottomInset: CGFloat = 6
    static let habitsStore = HabitsStore.shared
}
