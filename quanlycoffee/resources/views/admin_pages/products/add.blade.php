@extends('templates.admins.layout')
@section('content')
<div class="container-fluid coupon form_ql">
    <div class="card_1">
        <h3 class="card-title">THÊM SẢN PHẨM</h3>   
        <div class="action">
            <a href="{{ route('products.show')}}" class="btn_add primary">
                <i class="fa fa-sign-out" aria-hidden="true"></i>
                Quay lại
            </a>
        </div>
        <!-- {{ Breadcrumbs::render('Thêm sản phẩm') }} -->
        <div class="form-submit">
            <div class="content-add showind">
                <form action="{{ route('products.addhandle') }}" method="post" id="form-add-material" enctype="multipart/form-data">
                    @csrf
                    <div class="form-add-material-l row">
                        <div class="col-md-6 col-12"> 
                            <div class="form-group">
                                <label>Tên sản phẩm</label>
                                <input name="ProductName" id="ProductName" class="form-control" />
                                @if($errors->first('ProductName'))
                                    <span class="error text-danger">{{ $errors->first('ProductName') }}</span>
                                @endif
                            </div>
                           

                            <div class="form-group">
                                <label for="">Giá sản phẩm</label>
                                <div class="input-group input-group-lg"> 
                                    <input name="SellPrice" id="SellPrice" class="form-control">
                                    <span class="input-group-text">0.000</span>
                                    <span class="input-group-text">VND</span>

                                </div>
                                @if($errors->first('SellPrice'))
                                    <span class="error text-danger">{{ $errors->first('SellPrice') }}</span>
                                @endif
                            </div>

                            <div class="form-group">
                                <label>Size sản phẩm</label>
                                {{-- @foreach ($size as $s) --}}

                                <div class="size-choose row">
                                    <div class="col-md-4 col-12 ">
                                        <input class="form-check-input" type="radio" name="radioNoLabel" id="radioNoLabel1" checked>
                                        <label for="radioNoLabel1">
                                            Size nhỏ S (mặc định)
                                        </label>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <input name="sizePro" class="form-check-input" type="checkbox" id="sizeChoose" value="3">
                                        <label for="sizeChoose">
                                            Size lớn (M)    
                                        </label>
                                    </div>
                                    {{-- @endforeach --}}
                                    @if ($errors->first('sizeChoose'))
                                        <span class="error text-danger">{{ $errors->first('sizeChoose') }}</span>
                                    @endif

                                    <!-- <label for="">Kích thước mặc định là : nhỏ</label><br>
                                    <label for="">Bạn có muốn chọn thêm kích cỡ :</label>
                                    <input type="checkbox" name="sizePro" id="sizeChoose" value="3">Lớn -->
                                </div>  

                            </div>

                            <div class="form-group">
                                <label for="">Loại sản phẩm</label>
                                <div class="input-group mb-3 input-group-lg">
                                    <label class="input-group-text" for="inputGroupSelect01">Chọn loại</label>
                                    <select name="select_cat" class="form-select" id="inputGroupSelect01">
                                        @foreach ($categories as $cat)
                                        <option name="" id="" value="{{ $cat->id }}">
                                            {{ $cat->tenloai }}</option>
                                        @endforeach
                                    </select>   
                                </div>
                                @if($errors->first('select_cat'))
                                    <span class="error text-danger">{{ $errors->first('select_cat') }}</span>
                                @endif
                            </div>

                            <div class="form-group">
                                <label for="">Hình ảnh</label>
                                <div class="input-group mb-3 input-group-lg">
                                    <input type="file" name="ProductImage" class="form-control" id="ProductImage">
                                    <label class="input-group-text" for="ProductImage">Upload</label>
                                </div>
                                @if($errors->first('ProductImage'))
                                    <span class="error text-danger">{{ $errors->first('ProductImage') }}</span>
                                @endif
                            </div>

                            
                        </div>

                        <div class="col-md-6 col-12">
                            

                            <div class="form-group">
                                <label>Mô tả sản phẩm</label>
                                <textarea type="text" class="form-control" name="Description" id="Description" style="width:100%" cols="30" rows="7" autocomplete="off"></textarea>
                                @if($errors->first('Description'))
                                    <span class="error text-danger">{{ $errors->first('Description') }}</span>
                                @endif
                            </div>

                            <div class="form-group">
                                <label for="">Nội dung</label><br>
                                <textarea type="text" class="form-control" name="contenproduct" id="contenproduct" style="width:100%" cols="30" rows="7" autocomplete="off"></textarea>
                            </div>
                            @if ($errors->first('contenproduct'))
                                <div class="btn-danger">
                                    {{ $errors->first('contenproduct') }}
                                </div>
                            @endif
                            @if ($errors->any())
                                <script type="text/javascript">
                                    $(document).ready(function() {
                                        toastr.error("Kiểm tra lại giá trị nhập vào");
                                    });
                                </script>
                            @endif 
 
                        </div>
                        

                        @if (session('error_nameexists'))
                            <div class="show-alert-error">
                                <script type="text/javascript">
                                    $(document).ready(function() {
                                        Swal.fire({
                                            title: 'Tên sản phẩm đã tồn tại',
                                            icon: 'warning',
                                            timer: 2000
                                        });
                                    });
                                </script>
                            </div>
                        @endif

                        {{ Session::forget('error_nameexists') }}
                    </div>
                    <button type="submit" class="btn btn-success" id="btn-add-material">Lưu lại</button>
                </form>
            </div>
        </div>
        @endsection
    </div>
</div>
  

