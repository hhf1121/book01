/*带时间*/
function formatDateBoxFull(value) {
    if (value == null || value == '') {
        return '';
    }
    var dt = parseToDate(value);
    return dt.toLocaleString();
}

function parseToDate(value) {
    if (value == null || value == '') {
        return undefined;
    }
    var dt;
    if (value instanceof Date) {
        dt = value;
    }
    else {
        if (!isNaN(value)) {
            dt = new Date(value);
        }
        else if (value.indexOf('/Date') > -1) {
            value = value.replace(/\/Date\//, '$1');
            dt = new Date();
            dt.setTime(value);
        } else if (value.indexOf('/') > -1) {
            dt = new Date(Date.parse(value.replace(/-/g, '/')));
        } else {
            dt = new Date(value);
        }
    }
    return dt;
}