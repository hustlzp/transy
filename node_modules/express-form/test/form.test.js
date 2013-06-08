var assert = require("assert"),
    form = require("../index"),
    validate = form.validate,
    utils = require('../lib/utils');

module.exports = {
  'form : isValid': function() {
    // Failure.
    var request = { body: { field: "fail" }};
    form(validate("field").isEmail())(request, {});
    assert.strictEqual(request.form.isValid, false);

    // Success
    var request = { body: { field: "me@dandean.com" }};
    form(validate("field").isEmail())(request, {});
    assert.strictEqual(request.form.isValid, true);
    
    // form.isValid is a getter only
    request.form.isValid = false;
    assert.strictEqual(request.form.isValid, true);
  },
  
  'form : getErrors': function() {
    var request = {
      body: {
        field0: "win",
        field1: "fail",
        field2: "fail",
        field3: "fail"
      }
    };
    
    form(
      validate("field0").equals("win"),
      validate("field1").isEmail(),
      validate("field2").isEmail().isUrl(),
      validate("field3").isEmail().isUrl().isIP()
    )(request, {});
    
    assert.equal(request.form.isValid, false);
    assert.equal(request.form.errors.length, 6);

    assert.equal(request.form.getErrors("field0").length, 0);
    assert.equal(request.form.getErrors("field1").length, 1);
    assert.equal(request.form.getErrors("field2").length, 2);
    assert.equal(request.form.getErrors("field3").length, 3);
  },
  
  'form : configure : dataSources': function() {
    form.configure({ dataSources: 'other' });

    var request = { other: { field: "me@dandean.com" }};
    form(validate("field").isEmail())(request, {});
    assert.strictEqual(request.form.isValid, true);
    assert.equal(request.form.field, "me@dandean.com");

    form.configure({ dataSources: ['body', "query", "params"] });
  },
  
  'form : configure : autoTrim': function() {
    // request with username field containing a trailing space
    var request = {
      body: {
        username: 'myuser1 '
      }
    };
    
    var request2 = utils.clone(request);
    
    // alphanumeric
    var regex = /^[0-9A-Z]+$/i
    
    // autoTrim defaults to false, test results with it off
    assert.strictEqual(form._options.autoTrim, false);
    form(validate('username').is(regex))(request, {});
    assert.strictEqual(request.form.isValid, false);
    
    // test results with autoTrim turned on 
    form.configure({ autoTrim: true });
    assert.strictEqual(form._options.autoTrim, true);
    form(validate('username').is(regex))(request2, {});
    assert.strictEqual(request2.form.isValid, true);
    assert.strictEqual(request2.form.username, 'myuser1');
    
    // turn autoTrim back off
    form.configure({ autoTrim: false });
    assert.strictEqual(form._options.autoTrim, false);
  }
  
};
