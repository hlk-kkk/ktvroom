package com.hlk.ktvroom.config;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */
public class AlipayConfig {

//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "2016092300576185";

    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC8r6aXJNqDBYNr4eFepkDD1FBwfidTJT3dHLQQty8CS0mP1mQTMQmUnNiFyIFzzJ6O4LR7GVA2xFTJVsIXGQXZFDduEiVhl/HbEH31QXWGpdTGyUiqVqMbPccUE2o3Vq5UR9qjx3iH5oOsWxfbBc4u/H8kJyQyEUQcT9mnqzIb9FCrnN7VUlR40bua+6N4LtO70lOfM5e9/mzDei9QDk+Kp+ubt+K/oekjnPDe1SSGO/zZaO6QTrGo06pDPXHPQPox/qMCrmm+peQ6zQjrcCsXc/ISSMalZgqDLWweogaYKJJiHeHNNEP5zJfMKyQWC13/xX+HS07lmoyFr1TayLd7AgMBAAECggEAQm0UGOHAi5/FRJWg4dFlu4tjRjcjYQIbZVxViAz1X7lhjGHNmXQKC2esUmzkJgBDUcmJwEyJEL7NmpQQgFEu3d1gJj/9KP51BsonjdAdr+lxnwn9qvoVMeHt1AOBwTmi5cjmEAKJTE66zFLFczX4AFKj7/ZXp8isUctKtNxwJ6afrLR8R/4T+PwsvkQ4jatCQASasw2UlwIdJEfrvXN+qa3VHtO9ErDqrim80F7fD0vE29QQm7TMFyg1vI3bkJKP3FX596dzgd1GHsh87rYxRQl3DM2dCk50zhEzXDDPEF2kTNLlrIzgVPJlEvvQDx1vAlpDSvu4Ex8w5KQ+adqcAQKBgQDzsyISZUEIdqKUDac7yE3YGe6/kMaOTCxaEq8HrMvhjV8N3Z9rlpuqaJ7j/QvMg3V3LlV+qw7q3OFfZ6Y7IsZZp9SoNymHIWVSDeo6bamsUSwrttEEqj1FWG/5kwLRePEj0ka1medwZVlYQhLf0Vbsjjo5vvuP4Qap0wwCau6o6wKBgQDGNa6JuaDJcdmFWahNNsKgQZdMbSK+ebwwzMmOi9V39mZZhNUMkfe3dj0hL5fRo9qJfVn03nFmFkjI2iFrmHBTU2trMtOV0UKc3vcXu1gSLal13blVxtZn0vkVA/EaH8kiG3pLzpySlU6+PK5sn85iLZ/NtpHA+8xLwPYEhZaHsQKBgDnpedFRSpEOUDhKvlEQmp8eGoRfjS/HnkqRYhK614B0LgCHiBjzI27ticS4H5OsMb/uvNZrJBJgBxa69N/ctbIclgabhTzdjMxhDiZwZP/UEmEZArbPFdxi1clDTEonKXbPw4noVv14uDCnEwEpKDTy35dVcUaRvRmiU5pHewudAoGAU/5TpFFhbXwtbXD8/RuDhl3FO8HTw1va/+MIVruzDk8AOFct4VHJ45jbdsCwWUpSRYk1IatR6qzu0w58sxe6IdVr49V6DDbNP6TMmOXvAGURNr1q2IqWORESNHGjLiriFO4H+S/o8cULxVn5oFZoIvqqiYYgZeNOQ5vVpTzm+UECgYBHKLOSb4GhqAD9O0EzdE6+fERIh/5cgJpgCfKy0mmh8jlc/hdLwF8cKsw8GgWXtQkxIhcFjmvIFsdvECNxuSsfuNWe3eBgN4JT/6DnlyapISNsQsYh6k6OzXr+0e+WqRs9oVbTgB5x3FJxoG/CNTUnxDgwhpR/pCebrT0ABN8t6Q==";
    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvK+mlyTagwWDa+HhXqZAw9RQcH4nUyU93Ry0ELcvAktJj9ZkEzEJlJzYhciBc8yejuC0exlQNsRUyVbCFxkF2RQ3bhIlYZfx2xB99UF1hqXUxslIqlajGz3HFBNqN1auVEfao8d4h+aDrFsX2wXOLvx/JCckMhFEHE/Zp6syG/RQq5ze1VJUeNG7mvujeC7Tu9JTnzOXvf5sw3ovUA5Piqfrm7fiv6HpI5zw3tUkhjv82WjukE6xqNOqQz1xz0D6Mf6jAq5pvqXkOs0I63ArF3PyEkjGpWYKgy1sHqIGmCiSYh3hzTRD+cyXzCskFgtd/8V/h0tO5ZqMha9U2si3ewIDAQAB";
    // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String notify_url = "http://localhost:8888/ktvroom/pay/alipay.trade.page.pay-JAVA-UTF-8/notify_url.jsp";

    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String return_url = "http://localhost:8888/ktvroom/roomorder/orderok";

    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

    // 支付宝网关
    public static String log_path = "D:\\Steam";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /**
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     *
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            System.out.println(sWord);
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis() + ".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
