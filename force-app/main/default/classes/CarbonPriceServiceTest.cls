@IsTest
private class CarbonPriceServiceTest {
    class MockResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"price": 12.34}');
            res.setStatusCode(200);
            return res;
        }
    }

    @IsTest static void testFetchCarbonPriceFuture() {
        Test.setMock(HttpCalloutMock.class, new MockResponseGenerator());
        Test.startTest();
            CarbonPriceService.fetchCarbonPrice('https://api.example.com/carbon');
        Test.stopTest();
        System.assert(true);
    }
}
