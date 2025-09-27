public with sharing class CarbonPriceService {
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
                System.debug('Carbon price response: ' + res.getBody());
            } else {
                System.debug('Carbon price error: ' + res.getStatus());
            }
        } catch (CalloutException ce) {
            System.debug('Callout failed: ' + ce.getMessage());
        }
    }
}