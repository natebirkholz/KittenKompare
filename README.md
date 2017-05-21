# KittenKompare

1. Changed `Data` to `ModelData` to not shadow Foudation's `Data` (i.e. `NSData` renamed in Swift 3), just as a best practice.
2. Changed `Cat` to a Class to allow self mutation in a closure. Would in pratice discuss this with tech director/lead/architect to determine if the data needed to be value type, but wanted the images working at least.
3. UITableView disappears when reloadData() is called in it, not sure why, ran out of time to research it, but if you "touch" the tableView, it appears. Puzzling. (Later solved. Adding a branch named `BugFix` with the change.)
4. The outlet for the tableview has a typo in it, `tableVIew`, but I know that changing that with interface builder can be troublesome so I left it for "later".
