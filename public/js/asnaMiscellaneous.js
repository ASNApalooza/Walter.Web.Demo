(function(globals) {
    if (!String.prototype.format) {
      String.prototype.format = function() {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function(match, number) { 
          return typeof args[number] != 'undefined'
            ? args[number]
            : match
          ;
        });
      };
    }

    globals.populateSelectTag = function(query) {
        query.url = "../services/jsonservice.ashx";
        query.cacheList = query.cacheList || true;
        query.raiseChangeEvent = query.raiseChangeEvent || false;

        var options = $("#" + query.targetSelectId);
        var cacheKey = query.targetSelectId + "_cache";

        var doneCallBack = function(json) {
            if (_.isUndefined(json.error)) {
                _.each(json.list, function(element,index,list) {
                    options.append($("<option />").val(element.value).text(element.text));
                });

                if (query.cacheList) {
                    sessionStorage.setItem(cacheKey,JSON.stringify(json));    
                }

                if (! _.isUndefined(query.selectedValue)) {
                    options.val(query.selectedValue);
                }
                else {
                    options.val(json.list[0].value);
                }

                if (query.raiseChangeEvent) {
                    options.change();
                }
            }
            else {
                showGrowlError(json.error.message);       
            }
        };

        var alwaysCallBack = function() {
            $("#json-loading").hide();    
        };
        
        if (query.cacheList && sessionStorage.getItem(cacheKey)) {
            var json = JSON.parse(sessionStorage.getItem(cacheKey));        
            doneCallBack(json);
            alwaysCallBack();
        }
        else {
            ASNAHelpers.ajax.postJson(query.url,query.getJson(),doneCallBack,alwaysCallBack);    
        }
    };

    globals.showGrowlError = function(msg) {
        $.bootstrapGrowl(msg, {
            offset: { from: 'top', amount: 70 },
            type: "danger",
            delay: 30000
        });
    }

})(this);