@extends('templates.admins.layout')
@section('content')
@if(session()->has('message'))
<script>
window.addEventListener('load', (e) => {
    toastr.warning("{{session()->get('message')}}");
})
</script>
@endif
<div class="container-fluid coupon form_ql">
    <form method="post" class="form-submit" action="" enctype="multipart/form-data">
        @csrf
        <div class="card_1">
            <h3 class="card-title">Tin tức</h3>
            <div class="action" style="padding-bottom: 15px;">
                <a href=" {{ route('create.post')}}" class="btn btn-primary">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>
                    Thêm tin tức mới
                </a>
            </div>

            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th style="width: 25%;">Tiêu đề</th>
                        <th>Hình ảnh</th>
                        
                        <th>Loại tin tức</th>
                        <th>HOT</th>
                        <th>Trạng thái</th>
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    @if(isset($post) && count($post))
                    @foreach($post as $key => $value)
                    <tr>
                        <td style=" text-align: center;" scope="row">{{$key + 1}}</td>
                        <td >
                            {{$value->tieude}}
                        </td>
                        <td style=" text-align: center;">
                            @if($value->hinhanh)
                            <img style="width: 150px; height: 80px; border-radius: 4px; object-fit: cover;"
                                src="{{ asset('uploads/post/'.$value->hinhanh) }}" alt="{{$value->tieude}}" />
                            @else
                            <img style="width: 100px; height: 100px; border-radius: 4px; object-fit: cover;"
                                src="{{ asset('img/no-img.png') }}" alt="no-img" />
                            @endif
                        </td>

                        <td style=" text-align: center;">
                            <div class=" badge badge-info">
                                {{$value->danhmuc->tendanhmuc}}
                            </div>
                        </td>
                        <td style=" text-align: center;">

                            @if(+$value->hot === 1 )
                            <a href="{{route('hot.post', $value->id)}}">
                                <div class=" badge badge-success">
                                    Đang Hot
                                </div>
                            </a>
                            @else
                            <a href="{{ route('hot.post', $value->id)}}">
                                <div class="badge badge-danger">
                                    Không Hot
                                </div>
                            </a>
                            @endif

                        </td>
                        <td style=" text-align: center;">
                            @if(+$value->trangthai === 1 )
                            <a href="{{route('active.post', $value->id)}}">
                                <div class=" badge badge-success">
                                    Hiển thị
                                </div>
                            </a>
                            @else
                            <a href="{{ route('active.post', $value->id)}}">
                                <div class="badge badge-danger">
                                    Ẩn
                                </div>
                            </a>
                            @endif
                        </td>
                        <td style=" text-align: center;">

                            <a href="{{ route('edit.post', $value->id)}}" class="btn btn-info mgr-5" id="edit">
                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                            </a>

                            <a href="{{ route('delete.post', $value->id)}}" class="btn btn-danger mgr-5" id="edit">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </a>
                        </td>
                    </tr>
                    @endforeach
                    @endif
                </tbody>
            </table>
            {{ $post->links() }}
        </div>
    </form>
</div>
@stop