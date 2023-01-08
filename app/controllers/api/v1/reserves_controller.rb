class Api::V1::ReservesController < ApplicationController
  def provisional_regist
    render status: 401 and return if policy_scope(Plan.where(id: params[:plan_id])).empty?

    reserve = Reserve.new(reserve_provisional_params)

    reserve.valid?
    reserve.save

    render json: generate_response_body(reserve)
  end

  def definitive_regist
    # TODO:permitみたいなの必要かも

    begin
      reserve = Reserve.find_by!(id: params[:reserve_id])
    rescue ActiveRecord::RecordNotFound
      render status: 404 and return
    end

    render status: 400 and return unless reserve.session_token == params[:session_token]
    render status: 409 and return if reserve.is_definitive_regist # すでに本登録済みならばエラーとする

    update_reserve(reserve)
    render :json
  end

  private

  def generate_response_body(reserve)
    res = reserve.as_json(except: ['plan_id', 'session_expires_at', 'is_definitive_regist'])
    res['plan_name'] = reserve.plan.as_json(only: 'name')['name']
    res['reserve_id'] = res.delete('id')
    res['start_date'] = res.delete('date').gsub(/-/, '/')
    res['end_date'] = reserve.end_date.strftime('%Y/%m/%d')
    res
  end

  def update_reserve(reserve)
    reserve.is_definitive_regist = true
    reserve.session_token = nil
    reserve.session_expires_at = nil

    reserve.save
  end

  private

  def reserve_provisional_params
    params
      .permit(:plan_id, :total_bill, :term, :head_count, :breakfast, :early_check_in,
              :sightseeing, :username, :contact, :tel, :email, :comment)
      .merge(date: params[:date].to_date,
             session_token: SecureRandom.base64,
             session_expires_at: DateTime.now + Rational(5, 24 * 60), # FIXME:これいつまで許可？
             is_definitive_regist: false)
  end
end
