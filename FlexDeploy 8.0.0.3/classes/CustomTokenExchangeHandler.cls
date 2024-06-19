public class CustomTokenExchangeHandler {

    // Class to represent an OAuth2 Token
    public class OAuth2Token {
        public String accessToken { get; set; }
        public String refreshToken { get; set; }

        public OAuth2Token(String accessToken, String refreshToken) {
            this.accessToken = accessToken;
            this.refreshToken = refreshToken;
        }
    }

    // Method to exchange the refresh token for a new access token
    public OAuth2Token exchangeToken(String oldRefreshToken, String clientId, String clientSecret, String tokenEndpoint) {
        // Prepare the request body with the necessary parameters for token exchange
        String requestBody = 'grant_type=refresh_token'
                           + '&client_id=' + EncodingUtil.urlEncode(clientId, 'UTF-8')
                           + '&client_secret=' + EncodingUtil.urlEncode(clientSecret, 'UTF-8')
                           + '&refresh_token=' + EncodingUtil.urlEncode(oldRefreshToken, 'UTF-8');
        
        // Make the HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenEndpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody(requestBody);

        Http http = new Http();
        HttpResponse res;
        try {
            res = http.send(req);
        } catch (Exception e) {
            throw new CustomTokenExchangeException('Failed to make HTTP request: ' + e.getMessage());
        }

        // Parse the response
        if (res.getStatusCode() == 200) {
            Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            
            // Extract the new access and refresh tokens
            String newAccessToken = (String) responseBody.get('access_token');
            String newRefreshToken = (String) responseBody.get('refresh_token');

            if (newAccessToken == null || newRefreshToken == null) {
                throw new CustomTokenExchangeException('Failed to extract tokens from response');
            }

            // Return the new token
            return new OAuth2Token(newAccessToken, newRefreshToken);
        } else {
            throw new CustomTokenExchangeException('Token exchange failed with status code: ' + res.getStatusCode() + ' and body: ' + res.getBody());
        }
    }

    // Custom exception class
    public class CustomTokenExchangeException extends Exception {}
}