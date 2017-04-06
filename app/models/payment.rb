class Payment < ApplicationRecord
  belongs_to :orders, optional: true

  STATUS = {
    'IN_ANALYSIS' => 'Em análise',
    'AUTHORIZED' => 'Autorizado',
    'CANCELLED' => 'Cancelado',
    'PRE_AUTHORIZED' => 'Pré Autorizado',
    'WAITING' => 'Aguardando'
  }
end
