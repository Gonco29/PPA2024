puts "Eliminando items del carrito..."
CartItem.destroy_all

puts "Eliminando carritos..."
Cart.destroy_all

puts "Eliminando pedidos..."
OrderItem.destroy_all
Order.destroy_all

puts "Eliminando productos existentes..."
Product.destroy_all

puts "Cargando productos nuevos..."

# Placeholder para las imágenes
placeholder_image = Rails.root.join("app/assets/images/product.png")

# Productos
products_data = [
  { name: "Eurus 20", category: "Automatismos", subcategory: "Corredizos", price: 15000, installation_included: true, details: "", power: "1/3 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 4, warranty: "1 Año*" },
  { name: "Eurus 20", category: "Automatismos", subcategory: "Corredizos", price: 9900, installation_included: false, details: "Cubre defectos de fábrica. Repuestos y Servicio Técnico.", power: "1/3 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 4, warranty: "1 Año*" },
  { name: "Custom", category: "Automatismos", subcategory: "Corredizos", price: 12000, installation_included: true, details: "", power: "1/4 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 3, warranty: "1 Año*" },
  { name: "Custom", category: "Automatismos", subcategory: "Corredizos", price: 6600, installation_included: false, details: "", power: "1/4 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 3, warranty: "1 Año*" },
  { name: "Speed", category: "Automatismos", subcategory: "Corredizos Rápidos", price: 15000, installation_included: true, details: "", power: "1/4 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 3.5, warranty: "1 Año*" },
  { name: "Speed", category: "Automatismos", subcategory: "Corredizos Rápidos", price: 8800, installation_included: false, details: "", power: "1/4 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 3.5, warranty: "1 Año*" },
  { name: "Steel", category: "Automatismos", subcategory: "Corredizos", price: 17000, installation_included: true, details: "", power: "1/2 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 5, warranty: "1 Año*" },
  { name: "Steel", category: "Automatismos", subcategory: "Corredizos", price: 13000, installation_included: false, details: "", power: "1/2 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 5, warranty: "1 Año*" },
  { name: "Steel Jet", category: "Automatismos", subcategory: "Corredizos Rápidos", price: 22000, installation_included: true, details: "", power: "1/2 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 5, warranty: "1 Año*" },
  { name: "Steel Jet", category: "Automatismos", subcategory: "Corredizos Rápidos", price: 16000, installation_included: false, details: "", power: "1/2 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 5, warranty: "1 Año*" },
  { name: "Powerful", category: "Automatismos", subcategory: "Corredizos Industrial", price: 32000, installation_included: true, details: "", power: "1 HP", controls_included: 2, rack_meters: 3, usage_type: "Industrial", gate_max_length: 12, warranty: "1 Año*" },
  { name: "Powerful", category: "Automatismos", subcategory: "Corredizos Industrial", price: 24000, installation_included: false, details: "", power: "1 HP", controls_included: 2, rack_meters: 3, usage_type: "Industrial", gate_max_length: 12, warranty: "1 Año*" },
  { name: "Potenza", category: "Automatismos", subcategory: "Basculante", price: 20000, installation_included: true, details: "", power: "1/4 HP", controls_included: 2, accionamiento: 1, usage_type: "Residencial", indication: "Revestimiento liviano", warranty: "1 Año*" },
  { name: "Potenza", category: "Automatismos", subcategory: "Basculante", price: 14000, installation_included: false, details: "", power: "1/4 HP", controls_included: 2, accionamiento: 1, usage_type: "Residencial", indication: "Revestimiento liviano", warranty: "1 Año*" },
  { name: "Penta", category: "Automatismos", subcategory: "Basculante", price: 22000, installation_included: true, details: "", power: "1/2 HP", controls_included: 2, accionamiento: 1, usage_type: "Residencial", indication: "Revestimiento pesado", warranty: "1 Año*" },
  { name: "Penta", category: "Automatismos", subcategory: "Basculante", price: 16000, installation_included: false, details: "", power: "1/2 HP", controls_included: 2, accionamiento: 1, usage_type: "Residencial", indication: "Revestimiento pesado", warranty: "1 Año*" },
  { name: "Penta Jet", category: "Automatismos", subcategory: "Basculante Rápido", price: 30000, installation_included: true, details: "", power: "1/2 HP", controls_included: 2, accionamiento: 1, usage_type: "Residencial", indication: "Revestimiento pesado", warranty: "1 Año*" },
  { name: "Penta Jet", category: "Automatismos", subcategory: "Basculante Rápido", price: 22000, installation_included: false, details: "", power: "1/2 HP", controls_included: 2, accionamiento: 1, usage_type: "Residencial", indication: "Revestimiento pesado", warranty: "1 Año*" },
  { name: "Torsión 2", category: "Automatismos", subcategory: "Basculante", price: 23000, installation_included: true, details: "", power: "1/2 HP", controls_included: 2, accionamiento: 1, usage_type: "Residencial", indication: "Cuando no hay espacio en costados", warranty: "1 Año*" },
  { name: "Torsión 2", category: "Automatismos", subcategory: "Basculante", price: 18500, installation_included: false, details: "", power: "1/2 HP", controls_included: 2, accionamiento: 1, usage_type: "Residencial", indication: "Cuando no hay espacio en costados", warranty: "1 Año*" },
  { name: "Unique Doble", category: "Automatismos", subcategory: "Pivotante", price: 27000, installation_included: true, details: "", power: "1/4 HP", controls_included: 2, arms: 2, usage_type: "Residencial", gate_max_length: 3, warranty: "1 Año*" },
  { name: "Unique Doble", category: "Automatismos", subcategory: "Pivotante", price: 19000, installation_included: false, details: "", power: "1/4 HP", controls_included: 2, arms: 2, usage_type: "Residencial", gate_max_length: 3, warranty: "1 Año*" },
  { name: "Premium Doble", category: "Automatismos", subcategory: "Pivotante", price: 32000, installation_included: true, details: "", power: "1/2 HP", controls_included: 2, arms: 2, usage_type: "Residencial", gate_max_length: 6, warranty: "1 Año*" },
  { name: "Premium Doble", category: "Automatismos", subcategory: "Pivotante", price: 24000, installation_included: false, details: "", power: "1/2 HP", controls_included: 2, arms: 2, usage_type: "Residencial", gate_max_length: 6, warranty: "1 Año*" },
  { name: "Unique Simple", category: "Automatismos", subcategory: "Pivotante", price: 15000, installation_included: true, details: "", power: "1/4 HP", controls_included: 2, arms: 1, usage_type: "Residencial", gate_max_length: 3, warranty: "1 Año*" },
  { name: "Unique Simple", category: "Automatismos", subcategory: "Pivotante", price: 11000, installation_included: false, details: "", power: "1/4 HP", controls_included: 2, arms: 1, usage_type: "Residencial", gate_max_length: 3, warranty: "1 Año*" },
  { name: "Premium Simple", category: "Automatismos", subcategory: "Pivotante", price: 17000, installation_included: true, details: "", power: "1/2 HP", controls_included: 2, arms: 1, usage_type: "Residencial", gate_max_length: 6, warranty: "1 Año*" },
  { name: "Premium Simple", category: "Automatismos", subcategory: "Pivotante", price: 14000, installation_included: false, details: "", power: "1/2 HP", controls_included: 2, arms: 1, usage_type: "Residencial", gate_max_length: 6, warranty: "1 Año*" },
  { name: "Industrial Doble", category: "Automatismos", subcategory: "Pivotante Industrial", price: 40000, installation_included: false, details: "", power: "1 HP", controls_included: 2, arms: 2, usage_type: "Industrial", gate_max_length: 7, warranty: "1 Año*" },
  { name: "Hub", category: "Automatismos", subcategory: "Corredizos", price: 4400, installation_included: false, details: "", power: "1/4 HP", controls_included: 2, rack_meters: 3, usage_type: "Residencial", gate_max_length: 3, warranty: "1 Año*" }
]

products_data.each do |product_data|
  puts "Cargando producto: #{product_data[:name]}"

  product = Product.new(
    name: product_data[:name],
    category: product_data[:category],
    subcategory: product_data[:subcategory],
    price: product_data[:price],
    installation_included: product_data[:installation_included],
    details: product_data[:details],
    power: product_data[:power],
    controls_included: product_data[:controls_included],
    rack_meters: product_data[:rack_meters],
    usage_type: product_data[:usage_type],
    gate_max_length: product_data[:gate_max_length],
    warranty: product_data[:warranty]
  )

  if File.exist?(placeholder_image)
    product.photos.attach(io: File.open(placeholder_image), filename: "product.png")
  end

  product.save!
  puts "Producto cargado: #{product.name}"
end

puts "Productos cargados correctamente."
puts "Se han creado #{Product.count} productos."

puts "Creando usuario administrador..."

User.create!(
  email: "admin1@example.com",
  password: "password123",
  password_confirmation: "password123",
  first_name: "Admin",
  last_name: "One",
  address: "Dirección de administrador",
  admin: true
)

puts "Usuario administrador creado con éxito."
