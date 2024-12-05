class ProductPolicy < ApplicationPolicy
  def index?
    true # Todos los usuarios (visitantes y logueados) pueden ver el índice de productos
  end

  def show?
    true # Todos los usuarios (visitantes y logueados) pueden ver detalles de los productos
  end

  def create?
    user&.admin? # Solo permitir a administradores crear productos; `user&` evita llamar a `admin?` si `user` es nil
  end

  def update?
    user&.admin? # Solo permitir a administradores editar productos
  end

  def destroy?
    user&.admin? # Solo permitir a administradores eliminar productos
  end
end
