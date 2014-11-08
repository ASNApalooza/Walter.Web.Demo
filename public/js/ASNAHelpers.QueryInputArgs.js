(function (globals) {
    var ASNAHelpers = globals.ASNAHelpers = (globals.ASNAHelpers || {});

    // QueryInputArgs is a JavaScript object that corresponds to the 
    // ASNA.Helpers.DataServices.QueryFileInstanceArgs.InputArgs class.
    // After populating its properties, the Json its getJson() method
    // returns can be deserialized into an anstance of 
    // ASNA.Helpers.DataServices.QueryFileInstanceArgs.InputArgs on the 
    // server side. 
    ASNAHelpers.QueryInputArgs = function() {
        this.Library = null;
        this.File = null;
        this.Rows = 0;
        this.Query = null;
        this.QueryParms = [];
        this.Options = {};
        this.OrderBy = [];
        this.FieldsList = null;
    }

    ASNAHelpers.QueryInputArgs.prototype = {
        addQueryParm: 
            function(field,value) {
                if (_.isUndefined(value) ) {
                    value = "";
                }
                this.QueryParms.push({"FieldName": field, "FieldValue": value});
            },
        addOrderBy:
            function(field,sortOrder) {
                this.OrderBy.push({"FieldName": field, "SortOrder": sortOrder});
            },
        addOption: 
            function(key,value) {            
                if ((key == "labelTargetId") || (key == "labelValueId")) {
                    if ($("#" + value).length == 0) {
                        console.log("Couldn't find element " + value + " for Options collection.");
                    }                    
                }
                this.Options[key] = value;
            },
        getJson: 
            function() {
                return JSON.stringify(this);
            }
    };

    ASNAHelpers.ajax = function() {
        function failCallBack(jqXHR,originObject) {
                var HttpStatus = jqXHR.status;
                var HttpStatusText = jqXHR.statusText;
                var url = originObject.url;
                console.log("Ajax POST failed.");
                console.log("HTTP status: " + HttpStatus + "  Message text: " + HttpStatusText);
                console.log("URL requested: " + url);
                console.log(JSON.stringify(originObject));
        }

        function postJson(url, jsonToPost, successCallBack, alwaysCallBack, failCallBack) {
            var jqXHR = $.post(url, jsonToPost,"json")
            .done(function(json) {
                  successCallBack(json);       
            })            
            .fail(function (jqXHR,textStatus,errorThrown) {
                if ( typeof(failCallBack) == "undefined") {
                    var originObject = this;
                    ASNAHelpers.ajax.failCallBack(jqXHR,originObject);
                }
                else {
                    var originObject = this;
                    failCallBack(jqXHR,originObject);                
                }
            })                    
            .always(function() {
                if ( typeof(alwaysCallBack) != "undefined") {
                    alwaysCallBack();
                }
            });
        }
    
        return {
            postJson: postJson,
            failCallBack: failCallBack
        };
    }();

    function getQueryFieldValue(valueSpecified){
        // If the value of a query field starts with a # is assumed 
        // to be a selector and the value of that select should be used. 
        // This code looks first to the val() property of form elements
        // first, and then to the text() property. If an element isn't 
        // found with either search, the original value specified
        // is returned. 
        if (typeof valueSpecified == 'undefined') return 'undefined';
        if (valueSpecified.substring(0,1) === "#") {
            var selector = $(valueSpecified);
            if (selector.length > 0) {
                var value = selector.val();
                if (value) return value;
                if (!value) {
                    value = selector.text();
                    if (value) return value;
                }
            }
            return valueSpecified;
        }
        else {
            return valueSpecified;
        }
    }

    function restoreReplaceableQueryParmValues(inputs) {
        // Restore replaceable token for next time. This puts the replaceable 
        // token back into the FieldValue property.
        if (_.isUndefined(inputs.QueryParmsSaved)) {
            return;
        }            
        _.each(inputs.QueryParmsSaved, function(saved_element, saved_index, saved_list) {
            _.each(inputs.QueryParms, function(element, index, list) {
                if(element.FieldName === saved_element.FieldName) {
                    element.FieldValue = saved_element.FieldValue;               
                }
            });
        }); 
    }

    function saveReplaceableQueryParmValues(inputs) {
        // Push any QueryParm value into QueryParmSaved where its FieldValue 
        // starts with '#' (ie, its value should be replaced at runtime). 
        _.each(inputs.QueryParms,function(element,index,list) {                
            if (element.FieldValue.substring(0,1) === "#") {
                if (_.isUndefined(inputs.QueryParmsSaved)) {
                    inputs.QueryParmsSaved = [];
                }
                inputs.QueryParmsSaved.push({"FieldName": element.FieldName, "FieldValue":element.FieldValue});
            }
        });
    }

    function resolveReplaceableQueryParmValues(inputs) {
        // The runtime field value for this parm should be 
        // available in an element with id specified by its FieldValue. 
        
        // This causes a problem because the next time the QueryParms collection 
        // is used, the replaceable FieldValue no longer exists! That's why the 
        // QueryParmsSaved array is necessary. 
        if (_.isUndefined(inputs.QueryParmsSaved)) {
            return;
        }            
        _.each(inputs.QueryParms,function(element,index,list) {                
            if (element.FieldValue.substring(0,1) === "#") {
                var value = $(element.FieldValue).val();
                element.FieldValue = value;
            }
        });
    }

    var AutoComplete = function() {
        this.url = null;
        this.ownerId = null;
        this.valueTargetId = null;
        this.labelTargetId = null;
        this.showLabelOnScroll = null;
    }

    var prepareListElement = function(fn, list) {
        if (typeof(fn) !== "undefined" && (_.isFunction(fn))) {
            _.each(list,function(element,index,list) {
                fn(element);
            });
        }
    };

    AutoComplete.prototype = {
        source: 
        function(req,add,inputs) {
            var url = inputs.url;
            this.ownerId = inputs.ownerId;

            resolveReplaceableQueryParmValues(inputs);

            $(".my-ui-icon-alert").removeClass("my-ui-icon-alert");            
            this.labelTargetId = inputs.Options["labelTargetId"] || null;
            this.valueTargetId = inputs.Options["labelValueId"] || null;
            this.showLabelOnScroll = inputs.Options["showLabelOnScroll"] || false;   
            this.onSelect = inputs.onSelect || null;

            var successCallBack = function(json) {
                if (json.list) {
                    if (json.list.length > 0) {
                        prepareListElement(inputs.onPrepareListElement,json.list);
                        add(json.list);
                    } else {
                        $(".ui-autocomplete-loading").addClass("my-ui-icon-alert");
                    }
                }    
                else if (json.error) {
                    console.log(json.error.message);
                    if (! _.isUndefined(json.error.note)) console.log(json.error.note); 
                    console.log(json.error.source);
                }
            };

            var alwaysCallBack = function() {
                $(".ui-autocomplete-loading").removeClass("ui-autocomplete-loading");
            };

            var json = inputs.getJson();
            ASNAHelpers.ajax.postJson(url,json,successCallBack,alwaysCallBack);

            restoreReplaceableQueryParmValues(inputs);
        },
        select: 
        function(e,ui) {
            // If this function returns true then the AutoComplete insists 
            // on putting the value selected in the owning input element. 
            // Return false to put the text selected in the owning input element. 
            // This function returns false if a valueTargetId was specified. 

            // The this.ownerId value is the id of the ownning textbox. That value 
            // can't ever not be the labelTargetId can it? this.ownerId isn't 
            // good for anything! I think. 
            var result = true;
            var ENTER_KEY = 13;

            if (this.valueTargetId) {
                $("#" + this.valueTargetId).text(ui.item.value);
                $("#" + this.valueTargetId).val(ui.item.value);
                result = false;
            }
            else {
                $("#" + this.labelTargetId).text(ui.item.value);            
            }

            if (typeof(this.onSelect) === "function") {
                this.onSelect(e,ui);
            }

            if (e.keyCode == ENTER_KEY) {
                // Eat the enter if used to select an entry 
                // in the AutoComplete's list. This is especially 
                // important for Wings apps.
                e.stopPropagation();
            }

            return result;
        },
        focus: 
        function(e,ui) {
            var result = true;
            if (this.showLabelOnScroll) {
                $("#" + this.labelTargetId).val(ui.item.label);            
                result = false;
            }
            return result;
        }
    };

    ASNAHelpers.autoComplete = function() {
        function registerQuery(inputs) {

            saveReplaceableQueryParmValues(inputs);
            var autocompleteHelper = new AutoComplete();

            $("#" + inputs.Options["labelTargetId"]).autocomplete({
                source: function(req,add) {                    
                    inputs.ownerId = this.element.context.id; 
                    inputs.QueryParms[0]["FieldValue"] = req.term;
                    autocompleteHelper.source(req,add,inputs);

                },
                select: function (e, ui) {
                    return autocompleteHelper.select(e, ui);
                },
                focus: function (e, ui) {
                    return autocompleteHelper.focus(e, ui);
                }
            });
        };

        return {
            registerQuery: registerQuery
        }
    }();

})(this);