@extends('templates.admins.layout')
@section('content')
<div class="container-fluid coupon form_ql">
    <div class="card_1">
        <h3 class="card-title">THÊM THỂ LOẠI SẢN PHẨM</h3>
        <div class="action">
            <a href="{{ route('category.show')}}" class="btn_add primary">
                <i class="fa fa-sign-out" aria-hidden="true"></i>
                Quay lại
            </a>
        </div>
        {{-- @if (Session::has('errors_add'))
            <div class="alert alert-danger" style="font-size:24px"> {{ Session::get('errors_add') }}</div>
        @endif --}}
        <div class="form-submit">
            <form action="{{ route('categories.addhandle') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="row">
                    <div class="col-md-6 col-12">
                        <div class="form_group">
                            <label>Tên loại</label>
                            <input name="namecategory" autocomplete='off' class="form_control" />
                        </div>
                    </div>
                    <div class="col-md-6 col-12" style="margin-top: 22px;">
                        <div class="form-group">
                            <label style="font-weight: 700;">Hình ảnh</label>
                            <input type="file" name="categoriesIMG" id="categoriesIMG" class="form-control"
                                onchange="preview_image_add()">
                            @if ($errors->first('categoriesIMG'))
                                <div class="btn-danger">
                                    {{ $errors->first('categoriesIMG') }}
                                </div>
                            @endif
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form_group">
                            <label>Mô tả</label>
                            <textarea type="text" class="form_control" name="descriptioncategory" autocomplete="off"></textarea>
                        </div>
                        @if($errors->first('descriptioncategory'))
                            <span class="error text-danger">{{ $errors->first('descriptioncategory') }}</span>
                        @endif
                    </div>
                    <!-- <div class="form-group">
                            <label >Mô tả</label>
                            <input type="text" name="descriptioncategory" autocomplete='off' class="form_control" />
                    </div> -->
                   
                    
                    <!-- <div class="col-md-4 col-12">
                        <div class="img-preview">
                            <label for="categoriesIMG" class="preview">
                                <i class="fa fa-cloud-upload" aria-hidden="true"></i>
                                <span>Thêm hình ảnh</soan>
                            </label>
                            @if($errors->first('categoriesIMG'))
                            <span class="error text-danger">{{ $errors->first('categoriesIMG') }}</span>
                            @endif
                            <input id="categoriesIMG" type="file" name="categoriesIMG" hidden class="form_control" />
                        </div>
                    </div> -->
                    <div class="col-12 action aciton_bottom">
                        <button type="submit" class="btn btn-success">
                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                            Lưu thông tin
                        </button>
                    </div>
                </div>
                <!-- <button type="submit" class="btn btn-success">Lưu thông tin</button> -->
            </form>
        </div>
    @endsection
    </div>
</div>

