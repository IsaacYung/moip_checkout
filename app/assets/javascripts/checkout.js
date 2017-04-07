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

(function(global, $){
  'use strict'

  $.fn.payment = function() {
    var total = this.find('#total'),
        addition = this.find('#addition'),
        instalment = this.find('#payment_instalment_count'),
        ADDITION_TAX = 2.5;

    instalment.on('change', function(){
      var totalNumber = (total.data('initial')/100),
          additionNumber;

      if(instalment.val() > 1){
        additionNumber = totalNumber * (ADDITION_TAX/100);
        totalNumber = totalNumber + additionNumber;

        addition.text(additionNumber.toFixed(2).toString().replace(".", ","));
        total.text(totalNumber.toFixed(2).toString().replace(".", ","));
      } else {
        addition.text(0);
        total.text(totalNumber.toString().replace(".", ","));
      }
    });
  };

  $(document).ready(function() {
    $('.payment').payment();
  });
})(window, jQuery);
