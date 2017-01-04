class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  helper_method :day_of_week

  $ghOrders = {}

  $ghInstitution = {}
  $ghSupplier_order = {}
  $ghOrder = {}
  $ghReceipt = {}
  $ghSavon = { wsdl: "http://192.168.1.2:8080/gos1/ws/createsd.1cws?wsdl",  namespaces: { "xmlns:ins0" => 'http://www.reality.sh' } }
  #$ghSavon = { wsdl: "http://77.123.138.82:999/edu/ws/createsd.1cws?wsdl",  namespaces: { "xmlns:ins0" => 'http://www.reality.sh' } }

  def day_of_week(pdDate)
    days = {0 => "Неділя",
            1 => "Понеділок",
            2 => "Вівторок",
            3 => "Середа",
            4 => "Четвер",
            5 => "П'ятниця",
            6 => "Субота"}
    return days[pdDate.wday]
  end

  def get_ghInstitution(code)
    institution = Institution.select(:id, :code, :name).where(code: code).first
    $ghInstitution = { id: institution.id, code: institution.code, name: institution.name } unless institution.nil?
  end

  def get_supplier_id(code)
    base = Supplier.select(:id).where(code: code).first
    return base.nil? ? { id: 0, error: "Не знайдений код постачальника [#{code}]".encode!("utf-8") } : { id: base.id }
  end

  def get_branch_id(code)
    base = Branch.select(:id).where(code: code).first
    return base.nil? ? { id: 0, error: "Не знайдений код організації [#{code}]".encode!("utf-8") } : { id: base.id }
  end

  def get_institution_id(code)
    base = Institution.select(:id).where(code: code).first
    return base.nil? ? { id: 0, error: "Не знайдений код підрозділу [#{code}]".encode!("utf-8") } : { id: base.id }
  end

  def get_product_id(code)
    base = Product.select(:id).where(code: code).first
    return base.nil? ? { id: 0, error: "Не знайдений код продукту [#{code}]".encode!("utf-8") } : { id: base.id }
  end

  def get_contract_id(number)
    base = Contract.select(:id).where(number: number).first
    return base.nil? ? { id: 0, error: "Не знайдений номер договору [#{number}]".encode!("utf-8") } : { id: base.id }
  end



end
