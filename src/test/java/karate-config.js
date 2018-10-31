function() {
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev'; // a custom 'intelligent' default
  }

  var config = { // base config JSON
    baseUrl: 'http://localhost:5000'
  };

  if (env == 'stage') {
    // over-ride only those that need to be
    config.baseUrl = 'https://stage-host/v1/auth';
  } else if (env == 'e2e') {
    config.baseUrl = 'https://e2e-host/v1/auth';
  }

  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 60000);
  karate.configure('readTimeout', 60000);
  return config;
}