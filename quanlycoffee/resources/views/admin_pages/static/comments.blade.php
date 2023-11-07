@extends('templates.admins.layout')
@section('content')

@if(session()->has('massage'))
<script>
window.addEventListener('load', (e) => {
    toastr.error("{{session()->get('massage')}}");
})
</script>
@endif
<div class="container-fluid coupon form_ql">
    <form method="post" class="form-submit" action="{{ route('sendmail.all.contact')}}" enctype="multipart/form-data">
        @csrf
        <div class="card_1">
            <h3 class="card-title">Bình luận</h3>
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col"><input type="checkbox" name="checkedbox" /></th>
                        <th>STT</th>
                        <th style="width: 20%;">Nội dung</th>
                        <th style="width: 20%;">Tên</th>
                        <th>Ngày</th>
                        <th style="width: 5%;">Chủ đề</th>
                        <th style="width: 20%;">Loại</th>
                        <th style="width: 15%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    @if(isset($comments) && count($comments))
                    @foreach($comments as $key => $value)
                    <tr>
                        <td style=" text-align: center;" scope=" col"><input type="checkbox" value="{{ $value->id}}" name="checks[]" /></>
                        <td scope="row">{{$key + 1}}</td>
                        <td style=" text-align: justify;" ><span class='nowrap'>{{$value->noidung}}</span></td>
                        <td scope="row" style=" text-align: center;">{{$value->customer->ten ?? 'hiih'}}</td>
                        <td>
                            <?php
                            echo gmdate('d/m/Y', strtotime($value->ngaybl))
                            ?>
                        </td>
                        @if($value->type === 'product')
                        <td>
                            <div class="badge badge-info">
                                {{$value->sanpham->tensp}}
                            </div>
                        </td>
                        <td style=" text-align: center;">
                            <div class="badge badge-warning">
                                Sản phẩm
                            </div>

                        </td>
                        @else
                        <td>
                            <div class="badge badge-info">
                                {{$value->baiviet->tieude}}
                            </div>
                        </td>
                        <td style=" text-align: center;">
                            <div class="badge badge-warning">
                                Bài viết
                            </div>
                        </td>
                        @endif
                        <td style=" text-align: center;">
                            <a href="{{ route('delete.comments', $value->id)}}" class="btn btn-danger mgr-5" id="edit">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </a>
                        </td>

                    </tr>

                    @endforeach
                    @endif
                </tbody>
            </table>
            {{ $comments->links() }}
        </div>
    </form>
</div>

<script>
window.onload = () => {

    const checkbox = document.querySelector('input[name="checkedbox"]');
    const allCheckBox = document.querySelectorAll('input[name="checks[]"]');
    checkbox.addEventListener('change', (e) => {
        let isCheck = e.target.checked;
        allCheckBox.forEach(item => {
            item.checked = isCheck;
        })
    })

    function getCount() {
        let count = Array.from(allCheckBox).reduce((initial, item) => {
            return item.checked ? initial + 1 : initial;
        }, 0);

        return count;
    }

    allCheckBox.forEach(item => {
        item.addEventListener('change', (e) => {
            checkbox.checked = allCheckBox.length === getCount();
        })
    })
}
</script>

@stop