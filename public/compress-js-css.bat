ajaxmin vendor/jquery/dist/jquery.min.js ^
        vendor/jquery-ui/jquery-ui.min.js ^
        vendor/underscore/underscore.js ^
        vendor/bootstrap/dist/js/bootstrap.min.js ^
        vendor/bootstrap-growl/jquery.bootstrap-growl.min.js ^
        vendor/datatables/media/js/jquery.dataTables.js ^
        vendor/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.js ^
        js/ASNAHelpers.QueryInputArgs.js -o site.compressed.js

ajaxmin js/jQueryAutoComplete.aspx.js   -o js/jQueryAutoComplete.aspx.min.js
ajaxmin js/DataServicesGridView.aspx.js -o js/DataServicesGridView.aspx.min.js
ajaxmin js/ExportToExcel.aspx.js        -o js/ExportToExcel.aspx.min.js
ajaxmin js/JsonDataTable.aspx.js        -o js/JsonDataTable.aspx.min.js

ajaxmin css/DataServicesGridView.aspx.css -o css/DataServicesGridView.aspx.min.css 

ajaxmin vendor/bootstrap/dist/css/bootstrap.min.css ^
        vendor/font-awesome/css/font-awesome.min.css ^
        vendor/jquery-ui/themes/smoothness/jquery-ui.min.css ^
        css/home.master.css ^
        vendor/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css ^
        -o css/site-compressed.css





