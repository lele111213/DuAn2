package com.example.app_menh_ly

import android.app.AlertDialog
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import vn.zalopay.sdk.Environment
import vn.zalopay.sdk.ZaloPayError
import vn.zalopay.sdk.ZaloPaySDK
import vn.zalopay.sdk.listeners.PayOrderListener
import vn.momo.momo_partner.AppMoMoLib
import vn.momo.momo_partner.MoMoParameterNameMap

// momo config
private val fee = "0"
private val environment = 0 //developer default
private val merchantName = "MOMO payment test"
private val merchantCode = "MOMONCUJ20210804"
private val merchantNameLabel = "Nhà cung cấp"
private val description = "Thanh toán dịch vụ ABC"

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ZaloPaySDK.init(2554, Environment.SANDBOX) // Merchant AppID
        AppMoMoLib.getInstance().setEnvironment(AppMoMoLib.ENVIRONMENT.DEVELOPMENT) // AppMoMoLib.ENVIRONMENT.PRODUCTION
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        ZaloPaySDK.getInstance().onResult(intent)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?){
        super.onActivityResult(requestCode, resultCode, intent)
        var hashMap: MutableMap<String, Any> = HashMap()
        hashMap.put("status", -1)
        hashMap.put("message", "Failed")
        if(requestCode == AppMoMoLib.getInstance().REQUEST_CODE_MOMO && resultCode == -1) {
            if(intent != null) {
                Log.d("newIntent", intent.toString())
                Log.d("onActivityResult", intent.getStringExtra("message").toString())
                hashMap.put("status", intent.getIntExtra("status", -1))
                hashMap.put("message", intent.getStringExtra("message").toString())
                hashMap.put("phonenumber", intent.getStringExtra("phonenumber").toString())
                hashMap.put("token", intent.getStringExtra("data").toString())
                AppMoMoLib.getInstance().setOrderResponse(hashMap)
            } else{
                AppMoMoLib.getInstance().setOrderResponse(hashMap)
            }
        }
        else{
            AppMoMoLib.getInstance().setOrderResponse(hashMap)
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channelPayOrder = "flutter.native/channelPayOrder"
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelPayOrder)
            .setMethodCallHandler { call, result ->
                if (call.method == "payOrder"){
                    val tagSuccess = "[OnPaymentSucceeded]"
                    val tagError = "[onPaymentError]"
                    val tagCanel = "[onPaymentCancel]"
                    val token = call.argument<String>("zptoken")
                    ZaloPaySDK.getInstance().payOrder(this@MainActivity, token !!, "menhly://app",object: PayOrderListener {
                        override fun onPaymentCanceled(zpTransToken: String?, appTransID: String?) {
                            Log.d(tagCanel, String.format("[TransactionId]: %s, [appTransID]: %s", zpTransToken, appTransID))
                            result.success("""{"result":"User Canceled","appTransID":"$appTransID"}""")
                        }

                        override fun onPaymentError(zaloPayErrorCode: ZaloPayError?, zpTransToken: String?, appTransID: String?) {
                            Log.d(tagError, String.format("[zaloPayErrorCode]: %s, [zpTransToken]: %s, [appTransID]: %s", zaloPayErrorCode.toString(), zpTransToken, appTransID))
                            result.success("""{"result":"Payment Failed","appTransID":"$appTransID"}""")
                        }

                        override fun onPaymentSucceeded(transactionId: String, transToken: String, appTransID: String?) {
                            Log.d(tagSuccess, String.format("[TransactionId]: %s, [TransToken]: %s, [appTransID]: %s", transactionId, transToken, appTransID))
                            result.success("""{"result":"Payment Success","appTransID":"$appTransID"}""")
                        }
                    })
                } else {
                    Log.d("[METHOD CALLER] ", "Method Not Implemented")
                    result.success("Payment failed")
                }
            }
        val channelRequestPayment = "flutter.native/channelRequestPayment"
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelRequestPayment)
            .setMethodCallHandler { call, result ->
                if (call.method == "requestPayment"){
                    AppMoMoLib.getInstance().setAction(AppMoMoLib.ACTION.PAYMENT)
                    AppMoMoLib.getInstance().setActionType(AppMoMoLib.ACTION_TYPE.GET_TOKEN)
                    val amount = call.argument<Int>("amount")
                    val currentTime: Long = System.currentTimeMillis();
                    var hashMap: MutableMap<String, Any?> = HashMap()
                    hashMap.put("merchantname", merchantName) //Tên đối tác. được đăng ký tại https://business.momo.vn. VD: Google, Apple, Tiki , CGV Cinemas
                    hashMap.put("merchantcode", merchantCode) //Mã đối tác, được cung cấp bởi MoMo tại https://business.momo.vn 
                    hashMap.put("amount", amount) //Kiểu integer 
                    hashMap.put("orderId", "orderId_"+currentTime) //uniqueue id cho Bill order, giá trị duy nhất cho mỗi đơn hàng  
                    hashMap.put("orderLabel", "Mã đơn hàng") //gán nhãn 
                
                    //client Optional - bill info
                    hashMap.put("merchantnamelabel", "Dịch vụ") //gán nhãn 
                    hashMap.put("fee", fee) //Kiểu integer
                    hashMap.put("description", description) //mô tả đơn hàng - short description 

                    //client extra data 
                    hashMap.put("requestId",  merchantCode+"merchant_billId_"+currentTime)
                    hashMap.put("partnerCode", merchantCode)
                    //Example extra data 
                    // var objExtraData = ""
                        // objExtraData.put("site_code", "008")
                        // objExtraData.put("site_name", "CGV Cresent Mall")
                        // objExtraData.put("screen_code", 0)
                        // objExtraData.put("screen_name", "Special")
                        // objExtraData.put("movie_name", "Kẻ Trộm Mặt Trăng 3")
                        // objExtraData.put("movie_format", "2D")
                   
                    // hashMap.put("extraData", objExtraData)
                    // hashMap.put("extra", "")
                    
                    AppMoMoLib.getInstance().requestMoMoCallBack(this@MainActivity, hashMap)
                    result.success("pay loading")
                } else if(call.method == "getResult"){
                    val orderResponse = AppMoMoLib.getInstance().getOrderResponse()
                    if (orderResponse != null){
                        val status = orderResponse["status"]
                        val message = orderResponse["message"]
                        val token = orderResponse["token"] // token thanh toán của momo
                        val phonenumber = orderResponse["phonenumber"]
                        AppMoMoLib.getInstance().clearOrderResponse()
                        if(status == 0){
                            val dataRequest = AppMoMoLib.getInstance().dataRequest
                            val orderId = dataRequest["orderId"]
                            val amount = dataRequest["amount"]
                            val requestId = dataRequest["requestId"]
                            // thanh cong
                            result.success("""{"status":$status,"message":"$message","phonenumber":"$phonenumber","orderId":"$orderId","requestId":"$requestId","amount":$amount,"token":"$token"}""")
                        }else if (status == 5){
                            result.success("""{"status":$status,"message":"Hết thời gian thực hiện giao dịch (Timeout transaction)"}""")
                        }else if (status == 6){
                            result.success("""{"status":$status,"message":"User huỷ giao dịch"}""")
                        }else{
                            result.success("""{"status":$status,"message":"Lỗi"}""")
                        }
                    }else{
                        Log.d("[GET ORDER RESPONSE] ", "Need order before")
                        result.success("null")
                    }
                } else
                {
                    Log.d("[METHOD CALLER] ", "Method Not Implemented")
                    result.success("Payment failed")
                }
            }
    }
}
