public with sharing class CarbonPriceService {
    /**
     * Future method to perform an HTTP GET callout to a carbon price API.
     * Ensure a Remote Site Setting or Named Credential exists for the endpoint.
     */
    @future(callout=true)
    public static void fetchCarbonPrice(String endpoint) {
        if (String.isBlank(endpoint)) return;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                // Minimal handling: log response. Extend to parse JSON and persist to an External/Custom object.
                System.debug('CarbonPriceService response: ' + res.getBody());
            } else {
                System.debug('CarbonPriceService non-200 status: ' + res.getStatus());
            }
        } catch (CalloutException ce) {
            System.debug('CarbonPriceService callout failed: ' + ce.getMessage());
        }
    }
}
