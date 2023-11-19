function fn() {
    var env = karate.env; // get system property 'karate.env'
    karate.log('karate.env system property was:', env);

    var config = {
        env: env,
        apiEnvPath: 'dev',
        baseUrl: 'https://ravikarate.agilecrm.com',
        username: 'ravikarate@yopmail.com',
        password: 'Ravi@123',
        apiPassKey: 'qbamrbmr0578ju22h21loqbv77'
    }
    return config;
}