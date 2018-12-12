(function() {

    if (window.CRJSBridge) {
      return;
    }
  
    window.CRJSBridge = {
      callNative: callNative,
      callBack: callBack,
    };
  
    var responseCallbackList = {};
    var uniqueId = 0;
    
    function callNative(methodName, content, callBack){
        if (arguments.length == 2 && typeof content == 'function') {
            callBack = content;
            content = null;
          }
        _callNative({
            methodName: methodName,
            content: content
        }, callBack);
    }

    function _callNative(messageData, callBack){
        if (callBack) {
            var callbackId = 'callback_' + (uniqueId++) + '_' + new Date().getTime();
            responseCallbackList[callbackId] = callBack;
            messageData['identifier'] = callbackId;
        }
        window.webkit.messageHandlers.NativeMethodMessage.postMessage(messageData);
    }

    function callBack(messageData){
        var callback = responseCallbackList[messageData.identifier];
        if (callback) {
            callback(messageData.content);
            responseCallbackList[messageData.identifier] = null;
            delete responseCallbackList[messageData.identifier];
          }
    }
    
  })();
  
