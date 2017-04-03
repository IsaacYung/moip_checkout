(function(global, $){
  'use strict'

  $.fn.catalog = function() {
    var card = this.find('.card'),
        cart = this.find('.cart'),
        item = this.find('#product-card'),
        cartForm = this.find('#cart_products'),
        products = [],
        currentItens;



    card.on('click', function(event){
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
