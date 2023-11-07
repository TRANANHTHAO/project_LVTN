@extends('templates.admins.layout')
@section('content')


<div class="container-fluid form_ql">
  <div class="card_1">
    <h3 class="card-title">LOẠI SẢN PHẨM</h3>

    <div class="action" style="padding-bottom: 15px;">
        <a href="{{ route('categories.addview') }}" id="addModalMMU" class="btn btn-primary">
            <i class="fa fa-plus-circle" aria-hidden="true"></i>
                Thêm loại sản phẩm mới
        </a>
    </div>
    <div class="content-show">
        <table class="table table-dark table-striped">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên Loại</th>
                    <th>Mô tả</th>
                    <th style="width: 20%;">Hình ảnh</th>
                    <th style="width: 20%;">Trạng thái</th>
                    <th>Thao Tác</th>
                </tr>
            </thead>
            <tbody id="show-manager-material-use "style="font-size:16px;font-weight:bold">
                <?php $i = 1; ?>
                    @foreach ($getCat as $m)
                    <tr>
                        <td>{{ $i++ }}</td>
                        <td>{{ $m->tenloai }}
                        </td>
                        <td>{{ $m->mota }}</td>
                        <td> <img style="width: 50px; height: 80px ; border-radius: 10px;"
                                src="{{ asset('uploads/categories/' . $m->hinhanh) }}"></td>
                        <td> 
                            <div class=" badge badge-warning">
                                {{$m->trangthai==1?"Hoạt động" : "Không hoạt động"}}
                            </div>
        
                        </td>

                        <td>
                            <a href="{{ route('categories.editview', $m->slug) }}" class="btn btn-info mgr-5">
                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                            </a>

                            <a href="{{ route('categories.del', $m->id) }}" class="btn btn-danger mgr-5">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </a>
                        </td>

                    </tr>
               
                @endforeach
                
            </tbody>
        </table>
    </div>
  </div>  
</div>
@endsection
