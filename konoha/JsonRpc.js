var JsonRPCClient = (function() {
	function JsonRPCClient() {
		this.jQuery = jQuery;
		this.version = "2.0";
		this.createMessage = function(method, params) {
			var message = {
				jsonrpc : this.version,
				version : "0.0"
			};
			if (method !== undefined) {
				message.method = method;
			}
			if (params !== undefined) {
				message.params = [];
				var len = params.length;
				for (var i=0; i < len; i++) {
					message.params = params[i];
				}
			}
			return message;
		};
		this.request = function(URL, request_type, values) {
			this.jQuery.ajax({
				url: URL,
				type: request_type,
				data: values,
				success: function(){
					alert("success");
				},
				error:function(){
					alert("failure");
				}
			});
		}
		this.post = function(URL, values) {
			this.request(URL, "post", values);
		};
		this.get = function(URL, values) {
			this.request(URL, "get", values);
		};
		this.emitRequest = function(request) {
			var values = {};
			values.request = "" + request;
			this.post(values);
			var json = {}; /* FIXME */
			return json;
		}
	}
	return JsonRPCClient;
})($);

