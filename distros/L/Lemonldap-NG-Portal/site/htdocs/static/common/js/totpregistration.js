// Generated by CoffeeScript 1.12.7

/*
LemonLDAP::NG TOTP registration script
 */

(function() {
  var displayError, getKey, setMsg, token, verify;

  setMsg = function(msg, level) {
    $('#msg').html(window.translate(msg));
    $('#color').removeClass('message-positive message-warning message-danger alert-success alert-warning alert-danger');
    $('#color').addClass("message-" + level);
    if (level === 'positive') {
      level = 'success';
    }
    return $('#color').addClass("alert-" + level);
  };

  displayError = function(j, status, err) {
    var res;
    console.log('Error', err);
    res = JSON.parse(j.responseText);
    if (res && res.error) {
      res = res.error.replace(/.* /, '');
      console.log('Returned error', res);
      return setMsg(res, 'warning');
    }
  };

  token = '';

  getKey = function(reset) {
    setMsg('yourTotpKey', 'warning');
    return $.ajax({
      type: "POST",
      url: portal + "/2fregisters/totp/getkey",
      dataType: 'json',
      data: {
        newkey: reset
      },
      error: displayError,
      success: function(data) {
        var qr, s;
        if (data.error) {
          if (data.error.match(/totpExistingKey/)) {
            $("#divToHide").hide();
          }
          return setMsg(data.error, 'warning');
        }
        if (!(data.portal && data.user && data.secret)) {
          return setMsg('PE24', 'danger');
        }
        $("#divToHide").show();
        s = "otpauth://totp/" + (escape(data.portal)) + ":" + (escape(data.user)) + "?secret=" + data.secret + "&issuer=" + (escape(data.portal));
        if (data.digits !== 6) {
          s += "&digits=" + data.digits;
        }
        if (data.interval !== 30) {
          s += "&period=" + data.interval;
        }
        qr = new QRious({
          element: document.getElementById('qr'),
          value: s,
          size: 150
        });
        $('#serialized').text(s);
        if (data.newkey) {
          setMsg('yourNewTotpKey', 'warning');
        } else {
          setMsg('yourTotpKey', 'success');
        }
        return token = data.token;
      }
    });
  };

  verify = function() {
    var val;
    val = $('#code').val();
    if (!val) {
      return setMsg('fillTheForm', 'warning');
    } else {
      return $.ajax({
        type: "POST",
        url: portal + "/2fregisters/totp/verify",
        dataType: 'json',
        data: {
          token: token,
          code: val,
          TOTPName: $('#TOTPName').val()
        },
        error: displayError,
        success: function(data) {
          if (data.error) {
            if (data.error.match(/bad(Code|Name)/)) {
              return setMsg(data.error, 'warning');
            } else {
              return setMsg(data.error, 'danger');
            }
          } else {
            return setMsg('yourKeyIsRegistered', 'success');
          }
        }
      });
    }
  };

  $(document).ready(function() {
    getKey(0);
    $('#changekey').on('click', function() {
      return getKey(1);
    });
    return $('#verify').on('click', function() {
      return verify();
    });
  });

}).call(this);
