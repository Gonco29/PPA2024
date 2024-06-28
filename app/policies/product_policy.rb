# app/policies/product_policy.rb
class ProductPolicy < ApplicationPolicy
  def index?
    true # Permitir a todos ver la lista de productos
  end

  def show?
    true # Permitir a todos ver un producto individual
  end

  def create?
    user.admin? # Solo permitir a administradores crear productos
  end

  def update?
    user.admin? # Solo permitir a administradores actualizar productos
  end

  def destroy?
    user.admin? # Solo permitir a administradores eliminar productos
  end
end
