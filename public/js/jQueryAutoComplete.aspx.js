$(function () {
    var ACCustomerName = new ASNAHelpers.QueryInputArgs();
    ACCustomerName.url = "../services/jsonservice.ashx";
    ACCustomerName.Library = "examples";
    ACCustomerName.File = "cmastnewl2";
    ACCustomerName.FieldsList = "cmname:label,cmcustno:value";
    ACCustomerName.Rows = 12;
    ACCustomerName.Query = "CMNAME >= '{CMNAME}'";
    ACCustomerName.addQueryParm("CMNAME");
    ACCustomerName.addOption("labelTargetId", "textboxCustomerName");
    ACCustomerName.addOption("labelValueId", "textboxCustomerNumber");
    ACCustomerName.addOption("showLabelOnScroll", false);
    ASNAHelpers.autoComplete.registerQuery(ACCustomerName);
});