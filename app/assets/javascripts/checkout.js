(function(global, $){
  'use strict'

  $.fn.products = function() {
    var coupon = this.find('#coupon'),
        form = this.find('form');
    coupon.on('change', function(){
      form.attr('action', '/checkout/customer?coupon=' + coupon.val());

      if(coupon.val() == '') {
        form.attr('action', '/checkout/customer');
      }
    });
  };

  $(document).ready(function() {
    $('.products').products();
  });
})(window, jQuery);
