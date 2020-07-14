const PAYMENT_URL =
    "http://10.0.2.2:5000/connect-59a1f/us-central1/customFunctions/payment";

const ORDER_DATA = {
  "orderID": "ORDER_111",
  "custID": "Cust_111",
  "custEmail": "Cust_111@gmail.com",
  "custPhone": "1111111111"
};
const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";
