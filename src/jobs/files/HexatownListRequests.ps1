function HexatownListRequests {

return @'
{
    "description":  "Used by the www.hexatown.com framework for requesting a batch process to run ",        
    "displayName":  "Hexatown Requests",
    "list":  {
                 "contentTypesEnabled":  false,
                 "hidden":  false,
                 "template":  "genericList"
             },
    "columns":  [
                    {
                        "columnGroup":  "Custom Columns",
                        "description":  "ID which you can use in your code to relate this request to something",
                        "displayName":  "Your Reference ID",
                        "enforceUniqueValues":  false,
                        "hidden":  false,
                        "indexed":  true,
                        "name":  "YourReferenceID",
                        "readOnly":  true,
                        "required":  false,
                        "text":  {
                                     "allowMultipleLines":  false,
                                     "appendChangesToExistingText":  false,
                                     "linesForEditing":  0,
                                     "maxLength":  255
                                 }
                    },
                    {
                        "columnGroup":  "Custom Columns",
                        "description":  "Here you put a value corresponding with your PowerBricks router logic",
                        "displayName":  "Path",
                        "enforceUniqueValues":  false,
                        "hidden":  false,
                        "indexed":  false,
                        "name":  "Path",
                        "readOnly":  false,
                        "required":  false,
                        "text":  {
                                     "allowMultipleLines":  false,
                                     "appendChangesToExistingText":  false,
                                     "linesForEditing":  0,
                                     "maxLength":  255
                                 }
                    },
                    {
                        "columnGroup":  "Custom Columns",
                        "description":  "Here you put a method, PUT, GET, PATCY, POST, DELETE corresponding to what you like your PowerBricks to do",
                        "displayName":  "Method",
                        "enforceUniqueValues":  false,
                        "hidden":  false,
                        "indexed":  false,
                        "name":  "Method",
                        "readOnly":  false,
                        "required":  false,
                        "text":  {
                                     "allowMultipleLines":  false,
                                     "appendChangesToExistingText":  false,
                                     "linesForEditing":  0,
                                     "maxLength":  255
                                 }
                    },
                    {
                        "columnGroup":  "Custom Columns",
                        "description":  "This is the 'Payload' for the request, it is the logic in the PowerBrick which dictate the format, but it is  typically in a JSON format",
                        "displayName":  "Request",
                        "enforceUniqueValues":  false,
                        "hidden":  false,
                        "indexed":  false,
                        "name":  "Request",
                        "readOnly":  false,
                        "required":  false,
                        "text":  {
                                     "allowMultipleLines":  true,
                                     "appendChangesToExistingText":  false,
                                     "textType": "plain"
                                 }
                    },
                    {
                        "columnGroup":  "Custom Columns",
                        "description":  "This is the a code indicating the process result, following internet REST API standards, so 200 is the value to look for if noting went wrong",
                        "displayName":  "Response Code",
                        "enforceUniqueValues":  false,
                        "hidden":  false,
                        "indexed":  false,
                        "name":  "ResponseCode",
                        "readOnly":  false,
                        "required":  false,
                        "number":  {
                                   "decimalPlaces": "none",
  "displayAs": "number",
  "maximum": 999,
  "minimum": 0
                                 }
                    },
                    {
                        "columnGroup":  "Custom Columns",
                        "description":  "This is the result for of the request, it is the logic in the PowerBrick which dictate the format, but it is  typically in a CSV format for easy consumption in PowerApps",
                        "displayName":  "Response",
                        "enforceUniqueValues":  false,
                        "hidden":  false,
                        "indexed":  false,
                        "name":  "Response",
                        "readOnly":  false,
                        "required":  false,
                        "text":  {
                                     "allowMultipleLines":  true,
                                     "appendChangesToExistingText":  false,
                                                                          "textType": "plain"
                                 }
                    },
                    {
                        "columnGroup":  "Custom Columns",
                        "description":  "Has this been procesed",
                        "displayName":  "Processed",
                        "enforceUniqueValues":  false,
                        "hidden":  false,
                        "indexed":  false,
                        "name":  "Processed",
                        "readOnly":  false,
                        "required":  false,
                        "boolean":  {
                                     
                                 }
                    }

                ]
}

'@

}
