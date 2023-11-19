function fn() {
    var env = karate.env; // get system property 'karate.env'
    var config = {
        env: env,
        myVarName: 'hello karate',
        baseUrl: 'https://www.google.com',
        // ------------  SOME PATHS TO BE USED in Project
        REQUEST_PAYLOAD_PATH : 'classpath:test-data/request_payloads',
        RESPONSE_PAYLOAD_PATH : 'classpath:test-data/response_payloads',
        COMMONS_PATH : 'classpath:scripts/commons',
        COMMONS_CLEANUP_PATH : 'classpath:scripts/commons/cleanup',
        CONFIGS_PATH : 'classpath:configs'
    }

    return config;
}