.config/hypr/hyprctl.config

```hyprctl reload``` - reload configurations changes 

Change windows size at run time
bind = SUPER, H, resizeactive, -20 0
bind = SUPER, L, resizeactive, 20 0
bind = SUPER, K, resizeactive, 0 -20
bind = SUPER, J, resizeactive, 0 20

   ```
Moves Windows at runtime
```bash
bind = SUPER, left, movewindow, -20 0
bind = SUPER, right, movewindow, 20 0
bind = SUPER, up, movewindow, 0 -20
bind = SUPER, down, movewindow, 0 20
```

Switch Workspaces
```bash
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6
bind = SUPER, 7, workspace, 7
bind = SUPER, 8, workspace, 8
bind = SUPER, 9, workspace, 9
bind = SUPER, 0, workspace, 10
```
