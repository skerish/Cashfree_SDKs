const paymentSessionId = "session_n26a2ENWV6adcVTHRAZumodHaodEGlycyJRuz5tdz_oKOBoSYLKohTrfI0V3xZqTjWeV9z8vVFdkVF74K9_PZ2bcxIrIFtlFwICqG_zf9GGq"; 
const cashfree = new Cashfree(paymentSessionId);
const paymentDom = document.getElementById("payment-form");
const success = function(data) {
    if (data.order && data.order.status == "PAID") {
        $.ajax({
            url: "checkstatus.php?order_id=" + data.order.orderId,
            success: function(result) {
                if (result.order_status == "PAID") {
                    alert("Order PAID");
                }
            },
        });
    } else {
        //order is still active
        alert("Order is ACTIVE")
    }
}
let failure = function(data) {
    alert(data.order.errorText)
}
document.getElementById("pay-btn").addEventListener("click", () => {
    const dropConfig = {
        "components": [
            "order-details",
            "card",
            "netbanking",
            "app",
            "upi"
        ],
        "onSuccess": success,
        "onFailure": failure,
        "style": {
            "backgroundColor": "#ffffff",
            "color": "#11385b",
            "fontFamily": "Lato",
            "fontSize": "14px",
            "errorColor": "#ff0000",
            "theme": "light", //(or dark)
        }
    }
    cashfree.drop(paymentDom, dropConfig);
    // cf.redirect();
})