#Messenger Bot API 實測

參考 [官方文件](https://developers.facebook.com/docs/messenger-platform/quickstart) 以Rails改寫

並實作 [Send API](https://developers.facebook.com/docs/messenger-platform/send-api-reference) 中的

1. Image Attachment 
2. Video Attachment （因為反應太慢所以在專案中已移除）
3. Button Template
4. Quick Replies

還有用到 [Persistent Menu](https://developers.facebook.com/docs/messenger-platform/thread-settings/persistent-menu) 

實測下確實很實用，可以拿來做很多創意的應用 [Her/Him](https://www.facebook.com/getHerHim/?fref=ts) 就是不錯的例子


如果有朋友也想用Rails實作的話，比較需要注意的地方是 `Route 及 CSRF token Verify ` 其餘問題不大，單看如何應用

`直接使用的話，替換setting.yml.sample檔中的token為粉絲頁的token轉存setting.yml應該就可以動了`
