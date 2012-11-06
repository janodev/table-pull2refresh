![pull2refresh](https://raw.github.com/j4n0/table-pull2refresh/master/pages/pull2refresh.gif)

**To add "pull to refresh"** to a table controller, set its superclass to PullToRefreshVC or PullToRefreshFoldVC. 

This is the class hierarchy:
<pre>UIScrollView               - Apple scroll view.
  UITableViewController    - Apple table view controller.
    PullToRefreshVC        - Adds the "pull to refresh" feature.
      PullToRefreshFoldVC  - Adds a folding animation for the "pull to refresh".
        TableVC            - Your table view controller.
</pre>

Behaviour:
  1. There is a "pull to refresh" (aka pull view) on top of the table.
  2. As the user drags the table down, the pull view becomes visible.
  3. If the user lifts the finger while the pull view is fully visible, an update operation is executed.

Triggers:
  - Step 1 is done adding a normal view with a negative y origin.
  - Step 2 is detected with UIScrollView's scrollViewDidScroll: method.
  - Step 3 is detected with UIScrollView's scrollViewDidEndDragging:willDecelerate: method.

Animations:
  - Step 2 triggers an icon, text, and 3D transform animation.
  - Step 3 triggers a looping arrow icon animation, and the adding and removal of a table inset to keep the view visible.
