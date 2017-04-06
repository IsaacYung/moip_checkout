class Payment < ApplicationRecord
  belongs_to :orders, optional: true

  STATUS = {
    'IN_ANALYSIS' => 'Em análise',
    'AUTHORIZED' => 'Autorizado',
    'CANCELLED' => 'Cancelado',
    'PRE_AUTHORIZED' => 'Pré Autorizado',
    'WAITING' => 'Aguardando'
  }

  INSTALMENTS = {
    '1x Sem juros' => 1,
    '2x'  => 2,
    '3x'  => 3,
    '4x'  => 4,
    '5x'  => 5,
    '6x'  => 6,
    '7x'  => 7,
    '8x'  => 8,
    '9x'  => 9,
    '10x' => 10,
    '11x' => 11,
    '12x' => 12
  }
end
