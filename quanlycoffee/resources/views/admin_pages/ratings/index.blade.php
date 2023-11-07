@extends('templates.admins.layout')
@section('content')

@if(session()->has('successStatus'))
<script>
window.addEventListener('load', (e) => {
    toastr.info("{{session()->get('successStatus')}}");
})
</script>
@endif
@if(session()->has('successSendMail'))
<script>
window.addEventListener('load', (e) => {
    toastr.success("{{session()->get('successSendMail')}}");
})
</script>
@endif
<div class="container-fluid coupon form_ql form-submit">
    <form method="post" class="form-submit" action="{{ route('sendmail.coupon')}}" enctype="multipart/form-data">
        @csrf
        <div class="card_1">
            <h3 class="card-title">Danh sách đánh giá</h3>
            <div class="action">
                {{-- <a href="{{ route('get.add.customer')}}" class="btn_add primary">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>
                    Thêm đánh giá mới
                </a> --}}
            </div>
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th scope="col"><input type="checkbox" name="checkedbox" /></th>
                        <th>STT</th>
                        <th>Sản phẩm </th>
                        <th style="width: 20%;">Tên khách</th>
                        <th>Nội dung</th>
                        <th>View Star</th>
                        <th>Hành động</th>
                       
                    </tr>
                </thead>
                <tbody>
                    @if(isset($List) && count($List))
                    @foreach($List as $key => $value)
                    <tr>
                        <td scope=" col"><input type="checkbox" value="{{ $value->id}}" name="checks[]" /></>
                        <td scope="row">{{$key + 1}}</td>
                        <td>{{ $value->products->tensp }}</td>
                        <td><span class='nowrap'>{{$value->customer->ten}}</span></td>
                        <td>{{$value->r_content}}</td>
                        <td>
                         @for ($i = 0; $i < $value->r_number; $i++)
                         <i class="fa fa-star" style="color: yellow"></i>
                          @endfor
                        </td>
                        <td>
                            <a href="{{ route('rating.delete', $value->id) }}" class="btn btn-danger mgr-5" id="edit">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </a>
                        </td>
                    </tr>
                    @endforeach
                    @endif
                </tbody>
            </table>
            @if($errors->first('checks'))
            <span class="error text-danger">{{ $errors->first('checks') }}</span>
            @endif

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