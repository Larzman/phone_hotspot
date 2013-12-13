

class NetController < ApplicationController
  def index
    show
    # render :text => 'ok'
  end

  def am_alive
    
  end
  
  def register
    # render :text => "register " + params[:ip].inspect
    ip = params[:ip]
    ph = Phone.find_by_ip(ip)
    unless ph
      ph = Phone.new(:ip => ip)
      ph.save
    end
    render :text => 'ok'
  end
  
  def show
    phones = Phone.all
    render :text => phones.map{|ph| ph.ip}.join("; ")
  end
  
  def clear
    Phone.all.each{|ph| ph.destroy}
    render :text => 'ok'
  end
  
end
