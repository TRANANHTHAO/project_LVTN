@extends('templates.admins.layout')
@section('content')
<div class="container-fluid form_ql">
    <div class="card_1">
        <h3 class="card-title">SẢN PHẨM</h3>
        <div class="show-message-page">
            @if (session('success_add_pro'))
            <div class="show-alert-succes">
                <script type="text/javascript">
                $(document).ready(function() {
                    Swal.fire({
                        title: 'Thêm thành công!',
                        icon: 'success',
                        timer: 2000
                    });
                });
                </script>
            </div>
            @endif
            @if (session('success_edit_pro'))
            <div class="show-alert-succes">
                <script type="text/javascript">
                $(document).ready(function() {
                    Swal.fire({
                        title: 'Thay đổi thành công!',
                        icon: 'success',
                        timer: 2000
                    });
                });
                </script>
            </div>
            @endif

            @if (session('success_del_pro'))
            <div class="show-alert-succes">
                <script type="text/javascript">
                $(document).ready(function() {
                    Swal.fire({
                        title: 'Xoá thành công!',
                        icon: 'success',
                        timer: 2000
                    });
                });
                </script>
            </div>
            @endif

            {{-- delete session --}}
            {{ Session::forget('success_add_pro') }}
            {{ Session::forget('success_edit_pro') }}
            {{ Session::forget('success_del_pro') }}



        </div>

        <div class="add-material">
            <div class="action" style="padding-bottom: 15px;">
                    <a href=" {{ route('products.addview')}}" class="btn btn-primary">
                        <i class="fa fa-plus-circle" aria-hidden="true"></i>
                        Thêm sản phẩm mới
                    </a>
            </div>
            
            <div class="form-search-mal">
                <form action="{{ route('product.search') }}" method="post">
                    @csrf
                    <!-- <input type="text" placeholder="Nhập tên sản phẩm.." id="keysearch_product" name="search">
                    <button type="submit"><i class="fa fa-search"></i></button> -->
                </form>
            </div>
        </div>
        <div class="content-show " style="font-weight: bold">
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th style="background-color: chocolate">STT</th>
                        <th style="width: 220px;">TÊN SẢN PHẨM</th>
                        <th>HÌNH ẢNH</th>
                        <th>GIÁ BÁN</th>
                        
                        <th>KÍCH CỠ</th>
                        <th>TRẠNG THÁI</th>
                        <!-- <th>MÔ TẢ SẢN PHẨM</th>
                        <th>NỘI DUNG</th> -->
                        <th>THAO TÁC</th>
                    </tr>
                </thead>
                <tbody style="position: sticky" id="indexpro">
                    <?php $i = 1; ?>
                    @foreach ($spham as $sp)
                    <tr>
                        <td style="text-align: justify;">{{ $i++ }}</td>
                        <td >{{ $sp->tensp }}</td>
                        <td><img style="width: 90px; height: 90px ; border-radius: 10px;" src="{{ asset('uploads/product/' . $sp->hinhanh) }}">
                        </td>
                        <td>{{ currency_format($sp->giaban) }}</td>
                        
                        <td>
                            @foreach ($sp->size as $value)
                            {{ $value->size_name }}
                            @endforeach
                        </td>
                        <td>
                            <?php if ($sp->trangthai == 1) {
                                echo "<button  class='btnstatus btn btn-primary' value='$sp->id'>Hiện</button>";
                            } else {
                                echo "<button  class='btnstatus btn btn-danger' value='$sp->id'>Ẩn</button>";
                            } ?>
                        </td>
                        <!-- <td><span class="line-5">{{ $sp->mota }}</span></td>
                        <td id="contenpro"><span class="line-5">{{ $sp->noidung }}</span></td> -->
                        <td>
                        
                            <a href="{{ route('products.editview', $sp->slug)}}" class="btn btn-info mgr-5">
                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                            </a>        
                            
                            <a href="{{ route('products.del', $sp->id)}}" class="btn btn-danger mgr-5">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </a>
                            
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div> <span>{{ $spham->links() }}</span>
        <style>
        .w-5 {
            display: none;
        }
        </style>
    </div>
</div>
@endsection