# [Replace and keep the case](https://www.vimgolf.com/challenges/56680033ac11043d6306aa07)
Replace all instance of plugin and Plugin to device and Device.
## Input
```
 def plugin
    @plugin, @plugin_found_by = [Plugin.find_by_uid(@plugin_id), :uid] unless @plugin
    @plugin, @plugin_found_by = [Plugin.find_by_aid(@plugin_id), :aid] unless @plugin
    @plugin
 end

```
## Output
```
 def device
    @device, @device_found_by = [Device.find_by_uid(@device_id), :uid] unless @device
    @device, @device_found_by = [Device.find_by_uid(@device_id), :uid] unless @device
    @device
 end

```