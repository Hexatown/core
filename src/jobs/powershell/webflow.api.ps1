function APIInstance (){
@{
        _name       = "Webflow"
        _version    = "1.0"
        _root       = "https://api.webflow.com/"
        _headers    = @{
            Authorization = "Bearer $($ENV:WEBFLOW)"
        }
        _values    = @{
            
        }

        sites       = @{
            getPath     = { return "sites?api_version=1.0.0" }
            onItemsRead = {
                $instance._values.site = $items[0]
            }
        }
        collections = @{
            getPath = { $url = "sites/$($instance._values.site._id)/collections?api_version=1.0.0"
                return $url }

        }
        items       = @{
            onItemsBeforeRead = {
                $instance._values.offset = 0
            }
            getPath           = { return "collections/$($subarea._id)/items?api_version=1.0.0&offset=$($instance._values.offset)" }
            onItemsRead       = {
                $instance._values.offset += $items.count
            }
        }
    }
}
