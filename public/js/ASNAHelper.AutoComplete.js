(function (globals){

var ASNAHelper = globals.ASNAHelper = (globals.ASNAHelper || {});

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

var AutoComplete = function(args) {
    this.url = null;
    this.ownerId = null;
    this.valueTargetId = null;
    this.labelTargetId = null;
    this.showLabelOnScroll = null;
    this.onSelect = args.onSelect;
}

AutoComplete.prototype = {
    source: 
    function(req,add,ajaxArgs,configArgs) {
        var url = configArgs.url;
        this.ownerId = configArgs.ownerId;
        if (configArgs.hasOwnProperty("valueTargetId")) this.valueTargetId = configArgs.valueTargetId;
        if (configArgs.hasOwnProperty("labelTargetId")) this.labelTargetId = configArgs.labelTargetId;
        if (configArgs.hasOwnProperty("showLabelOnScroll")) this.showLabelOnScroll = configArgs.showLabelOnScroll;

        if (ajaxArgs.hasOwnProperty("qryval1")) ajaxArgs.qryval1 = getQueryFieldValue(ajaxArgs.qryval1);
        if (ajaxArgs.hasOwnProperty("qryval2")) ajaxArgs.qryval2 = getQueryFieldValue(ajaxArgs.qryval2);
        if (ajaxArgs.hasOwnProperty("qryval3")) ajaxArgs.qryval3 = getQueryFieldValue(ajaxArgs.qryval3);

        $(".my-ui-icon-alert").removeClass("my-ui-icon-alert");

        var queryString = $.param(ajaxArgs);
        var fullUrl = url + "?" + queryString;
        var promise = $.getJSON(fullUrl)
        .done(function (data) {
            if (data.list) {
                if (data.list.length > 0) {
                    add(data.list);
                } else {
                    $(".ui-autocomplete-loading").addClass("my-ui-icon-alert");
                }
            }
            else if (data.error) {
                var x = data;
            }
        })
        .fail(function (jqXHR,textStatus,errorThrown) {
            console.log("error");
            console.log("error " + textStatus);
            console.log("incoming Text " + jqXHR.responseText);
        })
        .always(function() {
            $(".ui-autocomplete-loading").removeClass("ui-autocomplete-loading");
        });
    },
    select: 
    function(e,ui) {
        var result = true;
        if (this.valueTargetId) {
            $("#" + this.valueTargetId).text(ui.item.value);
            $("#" + this.valueTargetId).val(ui.item.value);
        }
        if (this.labelTargetId) {
            $("#" + this.labelTargetId).val(ui.item.label);
            result = this.labelTargetId !== this.ownerId;
        }    

        if (typeof this.onSelect == "function") {
            this.onSelect();
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

ASNAHelper.RegisterAutoComplete = function() {
    function forField(args) {

        var autocompleteHelper = new AutoComplete({onSelect: args.onSelect});

        $("#" + args.labelTargetId).autocomplete({
             source: function (req, add) {
                var ajaxArgs = {
                    library: args.library,
                    file: args.file,
                    fieldsList: args.fieldsList,
                    rows: args.rows,
                    qryfld1: args.qryfld1,
                    qryval1: req.term,
                    qryval2: args.qryval2,
                    qryfld2: args.qryfld2,
                    qryval3: args.qryval3,
                    qryfld3: args.qryfld3,
                    query: args.query
                };
                var configArgs = {
                    url: args.url,
                    ownerId: this.element.context.id,
                    valueTargetId: args.valueTargetId,
                    labelTargetId: args.labelTargetId,
                    showLabelOnScroll: args.showLabelOnScroll,
                    onSelect: args.onSelect
                };
                autocompleteHelper.source(req,add,ajaxArgs,configArgs);
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
        forField: forField
    }
}();

})(this);