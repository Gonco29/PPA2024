# seeds.rb

# Categorías disponibles
categories = ['Motores', 'Controles', 'Accesorios', 'Placas']

# Array de productos de ejemplo
products = [
  {
    name: 'Motor eléctrico A',
    price: 199.99,
    category: categories.sample,
    details: 'Motor eléctrico de alta potencia para uso industrial.',
    stock: 10
  },
  {
    name: 'Control remoto universal',
    price: 49.99,
    category: categories.sample,
    details: 'Control remoto compatible con la mayoría de los equipos electrónicos.',
    stock: 20
  },
  {
    name: 'Placa de circuito C',
    price: 29.99,
    category: categories.sample,
    details: 'Placa de circuito impreso para proyectos electrónicos.',
    stock: 15
  },
  {
    name: 'Accesorio X',
    price: 9.99,
    category: categories.sample,
    details: 'Accesorio útil para mejorar el rendimiento de equipos.',
    stock: 30
  },
  {
    name: 'Motor industrial B',
    price: 299.99,
    category: categories.sample,
    details: 'Motor robusto para aplicaciones industriales pesadas.',
    stock: 5
  },
  {
    name: 'Controlador de temperatura',
    price: 89.99,
    category: categories.sample,
    details: 'Dispositivo para controlar y regular la temperatura en sistemas automatizados.',
    stock: 12
  },
  {
    name: 'Placa de expansión D',
    price: 39.99,
    category: categories.sample,
    details: 'Placa de expansión para agregar funcionalidades a dispositivos electrónicos.',
    stock: 18
  },
  {
    name: 'Accesorio Y',
    price: 14.99,
    category: categories.sample,
    details: 'Accesorio versátil para diversas aplicaciones.',
    stock: 25
  },
  {
    name: 'Motor de alta velocidad',
    price: 159.99,
    category: categories.sample,
    details: 'Motor compacto diseñado para alcanzar altas velocidades.',
    stock: 8
  },
  {
    name: 'Control de iluminación inteligente',
    price: 129.99,
    category: categories.sample,
    details: 'Sistema de control de iluminación avanzado con conectividad IoT.',
    stock: 15
  },
  {
    name: 'Placa base para proyectos',
    price: 49.99,
    category: categories.sample,
    details: 'Placa base diseñada para facilitar la creación de proyectos electrónicos.',
    stock: 22
  },
  {
    name: 'Accesorio Z',
    price: 19.99,
    category: categories.sample,
    details: 'Accesorio especializado para optimizar funciones específicas.',
    stock: 28
  },
  {
    name: 'Motor pequeño',
    price: 79.99,
    category: categories.sample,
    details: 'Motor compacto ideal para aplicaciones donde el espacio es limitado.',
    stock: 10
  },
  {
    name: 'Control de accesos biométrico',
    price: 199.99,
    category: categories.sample,
    details: 'Dispositivo avanzado para controlar accesos mediante identificación biométrica.',
    stock: 7
  },
  {
    name: 'Placa de desarrollo E',
    price: 59.99,
    category: categories.sample,
    details: 'Placa de desarrollo para explorar y prototipar nuevas ideas electrónicas.',
    stock: 20
  },
  {
    name: 'Accesorio de ajuste fino',
    price: 29.99,
    category: categories.sample,
    details: 'Accesorio que permite ajustes precisos en dispositivos mecánicos.',
    stock: 14
  },
  {
    name: 'Motor resistente al agua',
    price: 249.99,
    category: categories.sample,
    details: 'Motor diseñado para operar en ambientes húmedos y condiciones adversas.',
    stock: 6
  },
  {
    name: 'Controlador de potencia',
    price: 109.99,
    category: categories.sample,
    details: 'Dispositivo para controlar y gestionar el suministro de potencia eléctrica.',
    stock: 9
  },
  {
    name: 'Placa de interfaz F',
    price: 79.99,
    category: categories.sample,
    details: 'Placa de interfaz para conectar diferentes dispositivos y sistemas electrónicos.',
    stock: 17
  },
  {
    name: 'Accesorio universal',
    price: 12.99,
    category: categories.sample,
    details: 'Accesorio versátil compatible con una amplia gama de equipos.',
    stock: 24
  }
]

# Creación de los productos en la base de datos
products.each do |product_attrs|
  Product.create(product_attrs)
end

puts 'Se han creado los productos de ejemplo.'

