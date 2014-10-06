$(function () {
    ASNAHelper.RegisterAutoComplete.forField({
        labelTargetId: "textboxCustomerName",
        valueTargetId: "textboxCustomerNumber",
        library: "examples",
        file: "cmastnewL2",
        fieldsList: "cmname:label,cmcustno:value",
        rows: 12,
        qryfld1: "cmname",
        query: "CMNAME >= '{CMNAME}'",
        url: "/services/JsonAutoComplete.ashx",
        showLabelOnScroll: true
    });
});