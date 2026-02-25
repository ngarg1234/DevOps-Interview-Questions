package com.helloworld;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.syndicate.deployment.annotations.lambda.LambdaHandler;
import com.syndicate.deployment.annotations.lambda.LambdaUrlConfig;
import com.syndicate.deployment.model.RetentionSetting;
import com.syndicate.deployment.model.lambda.url.AuthType;
import com.syndicate.deployment.model.lambda.url.InvokeMode;


import java.util.HashMap;
import java.util.Map;

@LambdaHandler(lambdaName = "hello_world",
	roleName = "hello_world-role",
	isPublishVersion = true,
	logsExpiration = RetentionSetting.SYNDICATE_ALIASES_SPECIFIED
)

@LambdaUrlConfig(invokeMode = InvokeMode.BUFFERED,authType = AuthType.NONE)
public class HelloWorld implements RequestHandler<Map<String, Object>, Map<String, Object>> {

    public Map<String, Object> handleRequest(Map<String, Object> input, Context context) {
        System.out.println("Handling Lambda request");
		
		// if (input == null || !input.containsKey("httpMethod") || !input.containsKey("path")) {
		// 	// Return an error response if input is null or missing required keys
		// 	return handleErrorResponse("Unknown", "Unknown");
		// }

        // Extract path and method from the input map
        String httpMethod = (String) input.get("httpMethod");
        String path = (String) input.get("path");

    //     // Check if the request is for the /hello endpoint
    //     if (httpMethod.equals("GET") && path.equals("/hello")) {
    //         return handleHelloRequest();
    //     } else {
    //         return handleErrorResponse(path, httpMethod);
    //     }
    // }
			// Check if the request is for the /hello endpoint
			if ("GET".equals(httpMethod) && "/hello".equals(path)) {
				return handleHelloRequest();
			} else {
				return handleErrorResponse(path, httpMethod);
			}
		}

    private Map<String, Object> handleHelloRequest() {
        // Construct the response for /hello endpoint
        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("statusCode", 200);
        responseBody.put("message", "Hello from Lambda");
		
        Map<String, Object> response = new HashMap<>();
        response.put("statusCode", 200);
        response.put("body", responseBody);

        return response;
    }

    private Map<String, Object> handleErrorResponse(String path, String httpMethod) {
        // Construct the error response for other endpoints
        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("statusCode", 400);
        responseBody.put("message", "Bad request syntax or unsupported method. Request path: " + path + ". HTTP method: " + httpMethod);

        Map<String, Object> response = new HashMap<>();
        response.put("statusCode", 400);
        response.put("body", responseBody);

        return response;
    }
}