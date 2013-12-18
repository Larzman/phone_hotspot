

class NetController < ApplicationController
  def index
    show
    # render :text => 'ok'
  end

  def register_form
    @phones = Phone.all
    @networks = Network.all
    render :register_form
  end

  def send_message
    net_name = params[:network]
    net_name = 'none' if net_name.to_s.strip.empty?
    net = Network.where(:name => net_name).first
    name = params[:name]
    if net
      if name.to_s.strip.empty?
        ph = net.phones.where(:ip => params[:ip]).first
      else
        ph = net.phones.where(:name => name).first                
      end
    end  
    status = 'not found'
    if ph
      status = 'success'
      msg = Message.new(:body => params[:message])
      ph.messages << msg
    end  
    render json: {:status => status}
  end

  def am_alive    
    ph = Phone.where(:ip => params[:ip]).first
    status = 'success'
    status = 'not found' unless ph
    content = {:status => status}
    if ph.messages.count > 0
      msg = ph.messages.first
      content[:message] = msg.body.dup
      msg.destroy
    end
    render json: content
  end
  
  def register
    # render :text => "register " + params[:ip].inspect
    ip = params[:ip]
    ph = Phone.find_by_ip(ip)
    net_name = params[:network]
    net_name = nil if net_name.strip.empty?
    net_name ||= 'none'
    net = Network.find_or_create_by_name(net_name)
    ph = net.phones.where(:ip => ip, :name => params[:name]).first
    unless ph
      ph = Phone.create(:ip => ip, :name => params[:name])
      net.phones << ph      
    end
    render :text => 'success'
  end
  
  def show
    net = Network.where(:name => params[:network]).first
    status = 'not found'
    result = {}
    if net    
      phones = net.phones
      result[:phones] = phones.map{|ph| {:name => ph.name, :ip => ph.ip}}
      status = "success"
    end
    result[:status] = status  
    render :json => result
  end
  
  def clear
    Phone.all.each{|ph| ph.destroy}
    render :text => 'ok'
  end
  
end
