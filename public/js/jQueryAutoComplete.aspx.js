$(function () {
    $("#textboxCustomerName").autocomplete({
        source: function (req, add) {
            var ajaxArgs = {
                library: "examples",
                file: "cmastnewl2",
                fieldsList: "cmname:label,cmcustno:value",
                rows: 12,
                qryfld1: "cmname",
                qryval1: req.term,
                query: "CMNAME >= '{CMNAME}'",
            };
            var configArgs = {
                url: "/services/JsonAutoComplete.ashx",
                ownerId: this.element.context.id,
                valueTargetId: "textboxCustomerNumber",
                labelTargetId: "textboxCustomerName",
                showLabelOnScroll: true
            };
            ASNAHelper.AutoComplete.source(req,add,ajaxArgs,configArgs);
        },
        select: function (e, ui) {
            //    $("#textboxCounty").focus();
            return ASNAHelper.AutoComplete.select(e, ui);
        },
        focus: function (e, ui) {
            return ASNAHelper.AutoComplete.focus(e, ui);
        }
    });
});
