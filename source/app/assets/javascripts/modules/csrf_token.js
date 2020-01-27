(function($, Cookie) {
  $(document).ready(function() {
    var token = $('form meta[name="csrf-token"]').attr('content');
    console.info(token);

    Cookies.set('HTTP_X_CSRF_TOKEN', token);
  });
})(window.jQuery, window.Cookie)
