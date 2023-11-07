@extends('templates.admins.layout')
@section('content')
<div class="container-fluid coupon form_ql">
    <div class="card_1">
        <h3 class="card-title">SỬA LOẠI SẢN PHẨM</h3>
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
            <form action="{{ route('categories.edithandle',$editCat->id) }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="row">
                    <div class="col-md-6 col-12">
                        <div>
                            <input type="text" name="id_cat" value="{{$editCat->id}}" hidden>
                            <div class="form-group">
                                <label style="font-weight: 700;">Tên loại</label>
                                <input  name="categoryname_edit" value="{{$editCat->tenloai}}" class="form-control"/>
                            </div>
                            @if($errors->first('tenloai'))
                                <span class="error text-danger">{{ $errors->first('tenloai') }}</span>
                            @endif
                        </div>
                        <div style="margin-top: 30px;">
                            <div class="form_group" >
                                    <label>Mô tả</label>
                                    <textarea class="form_control" name="des_edit" rows="6">{{$editCat->mota}}</textarea>
                            </div>
                            @if($errors->first('des_edit'))
                                <span class="error text-danger">{{ $errors->first('des_edit') }}</span>
                            @endif
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <input type="text" name="oldename" id="" hidden value="{{$editCat->hinhanh}}">
                        <div class="d-flex justify-content-center" style="margin-top: 20px;">
                            <div class="show-img-mal item_category" >
                                <img claas="img_category" src="{{ asset('uploads/categories/' . $editCat->hinhanh) }}" alt="{{ $editCat->tenloai }}"
                                    id="preview_images" name="preview_images" style="width: 130px; height:170px; border-radius: 10px;">
                            </div>
                        </div>
                        <div class="form-group" style="margin-top: 30px;">
                            <input type="file" name="categoryImage" id="categoryImage" onchange="preview_image(this)" class="form-control">
                        </div>
                    </div>
                    <div class="col-12 action aciton_bottom">
                        <button type="submit" class="btn btn-success">
                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                            Lưu thông tin
                        </button>
                    </div>
                </div>
            </form>
        </div>
        @endsection
    </div>
</div>




