package ops.school.api.wxutil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import ops.school.api.util.LoggerUtil;

public class WxGUtil {

    private static String tokenurl = "https://api.weixin.qq.com/cgi-bin/token"; // 获取token的api
    private static String token = "";
    private static long tokenTime = 0;
    private static final long tokenTimeRefreshTime = 7200 * 1000;
    private static String msurl = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=";
    private static String gz = "https://api.weixin.qq.com/cgi-bin/user/info";

    /**
     * 获取access_token
     *
     * @param appid
     * @return
     */
    public static String getAccessToken(String appid, String secert) {
        if (token.equals("") || ((System.currentTimeMillis() - tokenTime) >= tokenTimeRefreshTime)) {
            String rs = HttpRequest.sendGet(tokenurl, "grant_type=client_credential&appid=" + appid + "&secret=" + secert);
            JSONObject json = JSON.parseObject(rs, JSONObject.class);
            token = json.getString("access_token");
            tokenTime = System.currentTimeMillis();
            return token;
        } else {
            return token;
        }
    }

    /**
     * 发送小程序服务通知模板
     * touser 用户openid
     * template_id 模板id
     * form_id  表单id  或者支付id
     * keyword 关键字 1,2,3,4,5,6,7.。。。
     */
    public static void snedM(JSONObject output) {
        //发送模板消息
        String access_token = getAccessToken("wx5b97919ccae6d986", "21ffc5cd23e1efa82bb26ee79af691ac");
        String rs = PayUtil.httpRequest(msurl + access_token, "POST", output.toString());
        LoggerUtil.log(rs);
    }

    public static boolean checkGz(String openid) {
        String access_token = getAccessToken("wx5b97919ccae6d986", "21ffc5cd23e1efa82bb26ee79af691ac");
        String rs = HttpRequest.sendGet(gz, "lang=zh_CN&access_token=" + access_token + "&openid=oZUxM1LBsaU2R5cY9huIUaG8TGZM");
        JSONObject json = JSON.parseObject(rs, JSONObject.class);
        if (json.getInteger("subscribe") == 1) {
            return true;
        } else {
            return false;
        }
    }

}
