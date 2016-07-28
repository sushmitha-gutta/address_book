class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index


    _index
  end
  

  def _index
    @contacts = current_user.contacts.sort_alphabetically(params[:direction])
      @contacts = @contacts.search_by_name(params[:name]) if (params[:name].present?)
      @contacts = @contacts.paginate(page: (params[:page].presence || 1), per_page: 5)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])
  end

  # GET /contacts/new
  def new
    @contact = current_user.contacts.build
  end

  # GET /contacts/1/edit
  def edit

  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = current_user.contacts.build(contact_params)
    
    respond_to do |format|
      if @contact.save
        Resque.enqueue(Sleeper, 30)
        
        @create_list=true
        _index
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
        format.js { render :create}
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        format.js { render :new}
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        @update_list=true
        _index

        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
        format.js {render :show }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
   @contact = current_user.contacts.find(params[:id])
    @contact.destroy
    @contacts = current_user.contacts
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
      format.js 
    end
  end

  def import
    
  Resque.enqueue(ImportJob, File.new(params[:file].tempfile.path).read, current_user)
  #Contact.import(params[:file], current_user)

  redirect_to root_url, notice: "Contacts imported."
  end
  def export
    @contacts = Contact.order(:name)
    respond_to do |format|
      format.csv { send_data @contacts.to_csv }
      format.xls { send_data @contacts.to_csv(col_sep: "\t") }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = current_user.contacts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :active, :birthday, :address, :city, :state, :zipcode, :image)
    end

end
