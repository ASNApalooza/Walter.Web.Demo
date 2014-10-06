function showExcelError() {
    $.bootstrapGrowl("Excel export failed. Please contact your administrator.", {
        offset: { from: 'top', amount: 70 },
        type: "danger",
        delay: 30000
    });
}

