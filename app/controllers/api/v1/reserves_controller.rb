class Api::V1::ReservesController < ApplicationController
  def provisional_regist
    reserve = Reserve.new(provisional_reserve_params)
    unless reserve.valid?
      raise HotelExampleSiteApiExceptions::BadRequestError
        .new('Input value is invalid.', reserve.errors.full_messages)
    end

    if policy_scope(Plan.where(id: provisional_reserve_params[:plan_id])).empty?
      raise HotelExampleSiteApiExceptions::UnauthorizedError
        .new('Only users of the membership rank specified in the plan can access the system.')
    end

    reserve.save
    render json: {
      message: 'Create completed.',
      data: build_data(reserve)
    }, status: :created
  end

  def definitive_regist
    reserve = Reserve.find_by!(id: definitive_reserve_params[:reserve_id])

    if reserve.is_definitive_regist # すでに本登録済みならばエラー
      raise HotelExampleSiteApiExceptions::ConflictError
        .new('Already completed reservation registration.')
    end

    if DateTime.now > reserve.session_expires_at.to_datetime # 有効時間が過ぎていればエラー
      raise HotelExampleSiteApiExceptions::ConflictError.new('Session token expiration.')
    end

    unless definitive_reserve_params[:session_token] == reserve.session_token
      raise HotelExampleSiteApiExceptions::BadRequestError
        .new('Session token does not match.')
    end

    update_reserve(reserve)
    render json: { message: 'Update completed.' }
  end

  private

  def build_data(reserve)
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

  def provisional_reserve_params
    params
      .permit(:plan_id, :total_bill, :date, :term, :head_count, :breakfast, :early_check_in,
              :sightseeing, :username, :contact, :tel, :email, :comment)
      .merge(session_token: SecureRandom.base64,
             session_expires_at: DateTime.now + Rational(5, 24 * 60), # 5分後
             is_definitive_regist: false)
  end

  def definitive_reserve_params
    params.permit(:reserve_id, :session_token)
  end
end
