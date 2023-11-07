@extends('templates.admins.layout')
@section('content')
@if(session()->has('messageupdate'))
<script>
window.addEventListener('load', (e) => {
    toastr.warning("{{session()->get('messageupdate')}}");
})
</script>
@endif
<div class="container-fluid coupon form_ql">
    <div class="card_1">
        <h3 class="card-title">Danh Sách Khuyến Mãi</h3>
        <div class="action" style="padding-bottom: 15px;">
            <a href="{{ route('add.coupon')}}" class="btn_add primary" style="padding: 12px;">
                <!-- <i class="fa fa-plus-circle" aria-hidden="true"></i> -->
                Thêm khuyến mãi mới
            </a>
        </div>
        <table class="table table-dark table-striped">
            <thead>
                <tr>
                    <th scope="col"><input type="checkbox" /></th>
                    <th style="text-align: left;">STT</th>
                    <th style="width: 25%;">Tên</th>
                    <th style="text-align: left;">Code</th>
                    <th style="text-align: left;">Giảm</th>
                    <th >Kết thúc</th>
                    <th style="text-align: left;">Dành cho</th>
                    <th style="text-align: left;">Trạng Thái</th>
                    <th>Thao Tác</th>
                </tr>
            </thead>
            <tbody>
                @if(isset($coupon) && count($coupon))
                @foreach($coupon as $key => $value)
                <tr>
                    <td scope=" col"><input type="checkbox" /></>
                    <td scope="row">{{$key + 1}}</td>
                    <td><span class='nowrap'>{{$value->ten}}</span></td>
                    <td>{{$value->code}}</td>
                    <td>{{currency_format($value->giamgia, ($value->loaigiam === 2) ? 'đ' : '%')}}</td>
                    <td>
                        <?php
                        echo date('d/m/Y', strtotime($value->ngaykt))
                        ?>
                    </td>
                    <td>
                        @if(+$value->hienthi === 1 )
                        <a href="{{route('show.coupon', $value->id)}}">
                            <div class=" badge badge-info" >
                                Hiển thị
                            </div>
                        </a>
                        @else
                        <a href="{{ route('show.coupon', $value->id)}}">
                            <div class="badge badge-warning">
                                Không
                            </div>
                        </a>
                        @endif

                    </td>
                    
                    <td>
                        @if(+$value->trangthai === 1 )
                        <a href="{{route('active.coupon', $value->id)}}">
                            <div class="badge badge-success">
                                Hoạt động
                            </div>
                        </a>
                        @else
                        <a href="{{ route('active.coupon', $value->id)}}">
                            <div class="badge badge-danger">
                                Ngừng
                            </div>
                        </a>
                        @endif

                    </td>
                    <td>
                        <a href="{{ route('get.detail.coupon', $value->id)}}" class="btn btn-primary mgr-5">
                            <i class="fa fa-eye" aria-hidden="true"></i>
                        </a>

                        <a href="{{ route('get.edit', $value->id)}}" class="btn btn-info mgr-5" id="edit">
                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                        </a>

                        <a href="{{ route('delete.coupon', $value->id)}}" class="btn btn-danger mgr-5" id="edit">
                            <i class="fa fa-trash" aria-hidden="true"></i>
                        </a>
                    </td>

                </tr>

                @endforeach
                @endif
            </tbody>
        </table>
    </div>
</div>


@stop