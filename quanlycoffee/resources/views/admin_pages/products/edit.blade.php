@extends('templates.admins.layout')
@section('content')
<div class="container-fluid coupon form_ql"> 
    <div class="card_1">
        <h3 class="card-title">CẬP NHẬT SẢN PHẨM</h3>  
        <div class="action">
            <a href="{{ route('products.show')}}" class="btn_add primary">
                <i class="fa fa-sign-out" aria-hidden="true"></i>
                Quay lại
            </a>
        </div>

        <div class="form-submit">
            <!-- {{ Breadcrumbs::render('Sửa sản phẩm', $spham->slug) }} -->
            <div class="content-edit-show">
                <form action="{{ route('products.edithandle', $spham->id) }}" method="post" enctype="multipart/form-data">
                    @csrf
                    <div class="row">
                        <div class="col-md-6 col-12">
                            <input type="text" name="id_spham" id="id_spham" value="{{ $spham->id }}" hidden>
                            <div class="form-group">
                                <label>Tên sản phẩm</label>
                                <input name="ten_spham" id="ten_spham" value="{{ $spham->tensp }}" class="form-control">
                                @if($errors->first('ten_spham'))
                                    <span class="error text-danger">{{ $errors->first('ten_spham') }}</span>
                                @endif
                            </div>
                            <div class="form-group">
                                <label>Giá sản phẩm</label>
                                <div class="input-group input-group-lg"> 
                                    <input name="giaban" id="giaban" value="{{ $spham->giaban }}" class="form-control">
                                    <span class="input-group-text">0.000</span>
                                    <span class="input-group-text">VND</span>

                                </div>
                                @if($errors->first('giaban'))
                                    <span class="error text-danger">{{ $errors->first('giaban') }}</span>
                                @endif
                                <!-- <input type="text" name="giaban" id="giaban" value="{{ $spham->giaban }}" class="form-control">
                                @if ($errors->first('giaban'))
                                <div class="btn-danger">
                                    {{ $errors->first('giaban') }}
                                </div>
                                @endif -->
                            </div>
                            <div class="form-group">
                                <label for="">Loại sản phẩm</label>
                                <div class="input-group mb-3 input-group-lg">
                                    <label class="input-group-text" for="inputGroupSelect01">Chọn loại</label>
                                    <select name="select_cat" class="form-select" id="inputGroupSelect01">
                                        @foreach ($catetype as $dvnl)
                                            @if ($dvnl->id == $spham->id_loaisanpham)
                                                <option name="" id="" selected="selected" value="{{ $dvnl->id }}">
                                                    {{ $dvnl->tenloai }}</option>

                                            @else{
                                                <option name="" id="" value="{{ $dvnl->id }}">
                                                    {{ $dvnl->tenloai }}</option>
                                                }
                                            @endif
                                        @endforeach
                                    </select>   
                                </div>
                                @if($errors->first('select_cat'))
                                    <span class="error text-danger">{{ $errors->first('select_cat') }}</span>
                                @endif
                                <!-- <select name="select_cat">
                                    @foreach ($catetype as $dvnl)
                                        @if ($dvnl->id == $spham->id_loaisanpham)
                                            <option name="" id="" selected="selected" value="{{ $dvnl->id }}">
                                                {{ $dvnl->tenloai }}</option>

                                        @else{
                                            <option name="" id="" value="{{ $dvnl->id }}">
                                                {{ $dvnl->tenloai }}</option>
                                            }
                                        @endif
                                    @endforeach
                                </select> -->
                            </div>

                            <div class="form-edit-right">
                                <div class="form-group">
                                    <input type="text" hidden value="{{ $spham->hinhanh }}" name="imageOld" class="form_control">
                                </div>
                                <div class="show-img-mal">
                                    <img src="{{ asset('uploads/product/' . $spham->hinhanh) }}" alt="{{ $spham->ten_spham }}"
                                        id="preview_images" name="preview_images" style="width: 600px;height:300px">
                                </div>
                                <div class="form-group" style="margin-top: 10px;">
                                    <!-- <input type="file" name="ProductImage" id="ProductImage" onchange="preview_image(this)"
                                        class="form-control"> -->
                                    <div class="input-group mb-3 input-group-lg">
                                        <input type="file" name="ProductImage" id="ProductImage" onchange="preview_image(this)"
                                            class="form-control">
                                        <label class="input-group-text" for="ProductImage">Upload</label>
                                    </div>
                                </div>
                                
                            </div>               
                                <p>Trạng thái</p>
                                @if ($spham->trangthai == 1)
                                    <input type="radio" id="showstatus" name="status_product" value="1" checked>
                                    <label for="css">Hiện</label><br>
                                    <input type="radio" id="hidestatus" name="status_product" value="0">
                                    <label for="html">Ẩn</label><br>
                                @else
                                    <input type="radio" id="showstatus" name="status_product" value="1">
                                    <label for="html">Hiện</label><br>
                                    <input type="radio" id="hidestatus" name="status_product" value="0" checked>
                                    <label for="html">Ẩn</label><br>
                                @endif
                            <br>

                        </div>

                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                        <label>Nội dung</label><br>
                                        <textarea class="form_control" name="conten_edit" id="conten_edit" cols="90" rows="15" >{{$spham->noidung}}</textarea>
                                        @if ($errors->first('conten_edit'))
                                        <div class="btn-danger">
                                            {{ $errors->first('conten_edit') }}
                                        </div>
                                    @endif
                            </div>

                            <div class="form-group">
                                        <label>Mô tả</label><br>
                                        <textarea class="form_control" name="description_edit" id="" cols="90" rows="15" >{{$spham->mota}}</textarea>
                                        @if ($errors->first('description_edit'))
                                        <div class="btn-danger">
                                            {{ $errors->first('description_edit') }}
                                        </div>
                                    @endif
                            </div>
                        </div>
                        
                    </div>
                    <button type="submit" class="btn btn-success" style="margin-left: 200px">Lưu thay đổi</button>
                </form>
            </div>
        </div>
        @endsection
    </div>

</div>



