(function(global, $){
  'use strict'

  $.fn.catalog = function() {
    var product = this.find('.product'),
        cart = this.find('.cart'),
        item = this.find('#product-card'),
        cartForm = this.find('#cart_products'),
        products = [],
        currentItens;

    product.on('click', function(event){
      $(event.currentTarget).addClass('active');
      currentItens = item.html();
      currentItens++;
      item.html(currentItens);

      products.push({
        product_id: $(event.currentTarget).data('product-id'),
        quantity: 1
      });

      cartForm.val(JSON.stringify(products));
    });
  };

  $(document).ready(function() {
    $('body').catalog();
  });
})(window, jQuery);
