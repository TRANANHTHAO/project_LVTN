@extends('templates.admins.layout')
@section('content')
<head>
    <link href="{{ asset('admin_asset/css/highcharts.css') }}" rel="stylesheet">
</head>
<div class="main">
    <main class="content">
        <div class="container-fluid p-0">
            <!-- <h1 class="h3 mb-3"><strong>Analytics</strong> Dashboard</h1> -->

            <div class="row" style="gap:30px; padding-bottom: 50px;">
                <div class="col show-visitor text-view-visitor" 
                    style="background: linear-gradient(-50deg, #34a5de, #d2ebf7);padding-top:30px;padding-bottom:30px;text-align:center;margin: 0%">
                    <h3 style="color: white; font-weight: 700;">Truy cập hôm nay</h3>
                    <span id="visitor_views" style="font-size: 24px ; color:white;" ></span>
                </div>
                <div class="col sale-by-date text-view-visitor" id="statis-view"
                    style="background: linear-gradient(-50deg, #df7f15, #fbefd7);padding-top:30px;padding-bottom:30px;text-align:center;margin: 0%;font-weight:bold ; color: white;">
                    <h3 style="color: white; font-weight: 700;">Doanh thu hôm nay</h3>
                    <span style="color: white; font-size: 24px" id="numberMoney"></span> VND

                </div>
                <div class="col"
                    style="background: linear-gradient(-50deg, #13c0d6, #d7f4f7);padding-top:30px;padding-bottom:30px;text-align:center;margin: 0%;font-weight:bold; border-radius: 16px;">
                    <h3 style="color: white; font-weight: 700;">Sản phẩm</h3>
                    <span style="color: white; font-size: 24px">{{$countProduct}}</span>
                </div>
                <div class="col"
                    style="background: linear-gradient(-50deg, #2ce4a0, #d0fbeb);padding-top:30px;padding-bottom:30px;text-align:center;margin: 0%;font-weight:bold; border-radius: 16px;">
                    <h3 style="color: white; font-weight: 700;">Đơn hàng hôm nay</h3>
                    <span style="color: white; font-size: 24px">{{$countOrder}}</span>
                </div>
            </div>
        </div>
        <div class="export-file">
            <!-- <button id="exportFile" class="btn btn-primary">xuất file exel</button> -->
        </div>
        <div class="row"  style="gap:10px;">
            <div class="col-7" >
                <figure class="highcharts-figure">
                    <div id="container-staticbyyear" data-staticbyyear="{{$statisByYear}}"
                        data-staticbyday="{{$statisByDay}}" style="border-radius: 15px;">
                    </div>
                </figure>
            </div>
            <div class="col">
                <figure class="highcharts-figure">
                    <div id="container-topproduct" data-topproduct="{{$topproduct}}" style="border-radius: 15px;"></div>
                </figure>
            </div>
        </div>
    </main>
</div>


{{-- modal 'exportFile' --}}
<div class="modal fade" id="exportModel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Xuất file exel</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="{{ route('exportFile') }}" method="post">
                    @csrf
                    <div class="form-group">
                        <label>Chọn xuất theo: </label>
                        <select name="chooseTypeExport" id="chooseTypeExport">
                            <option value="1">Theo ngày</option>
                            <option value="2">Theo tháng</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Chọn thời gian</label>
                        <div class="chooseDayExport" id="chooseDayExport">
                            <label for="">Chọn ngày</label>
                            <input type="date" name="dataExport" id="dataExport" class="form-control">
                        </div>
                        <div class="exportbyMonth" id="exportbyMonth">
                            <label for="">Chọn tháng</label>
                            <select name="chooseMonthExport" id="chooseMonthExport">
                                <?php $monthCurr = date('m'); ?>

                                @for ($i = 1; $i < 13; $i++) { @if ($i <=$monthCurr) <option value="{{ $i }}">Tháng:
                                    {{ $i }}</option>
                                    @endif
                                    }
                                    @endfor
                            </select>
                        </div>
                        <div class="exportbyyear">
                            <label for="">Chọn năm</label>
                            <input type="text" class="form-control" name="datepickyear" id="datepickyear" />
                        </div>
                    </div>
            </div>


            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="submit" class="btn btn-primary" id="exportExel">Xuất file</button>
            </div>
            </form>
        </div>
    </div>
</div>
@section('script')
<script src="https://code.highcharts.com/highcharts.js">
</script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script type="text/javascript">
let value = document.querySelector('#container-topproduct').getAttribute('data-topproduct');
value = JSON.parse(value);
Highcharts.chart('container-topproduct', {
    chart: {
        type: 'pie',
        options3d: {
      enabled: true,
      alpha: 45,
      beta: 0
    }

    },
    title: {
        text: 'TOP 5 SẢN PHẨM ĐƯỢC MUA NHỀU NHẤT',
        style: {
            fontSize: '20px',
        
        }
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.y}%</b>',
    },
    accessibility: {
        point: {
            valueSuffix: '%'
        }
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            depth: 35,
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                    fontSize: '14px',
                }
            },
            showInLegend: true
        }
    },
    series: [{
        name: 'Số lượng',
        colorByPoint: true,
        data: value
    }]
});

const formatCurrency = (x) => {
    x = x.toLocaleString('it-IT', {
        style: 'currency',
        currency: 'VND'
    });
    return x;
}
// thong ke theo nam 
var nowYear = new Date();
var getNowYear = nowYear.getFullYear();
let statisByYear = document.querySelector('#container-staticbyyear').getAttribute('data-staticbyyear');
statisByYear = JSON.parse(statisByYear);
let statisByDay = document.querySelector('#container-staticbyyear').getAttribute('data-staticbyday');
statisByDay = JSON.parse(statisByDay);
Highcharts.chart('container-staticbyyear', {
    chart: {
        type: 'column',
       
    },
    lang: {
        drillUpText: '◁ {series.name}\' e Geri Dön',
        decimalPoint: ',', // <== Most locales that use `.` for thousands use `,` for decimal, but adjust if that's not true in your locale
        thousandsSep: '.' // <== Uses `.` for thousands
    },
    title: {
        align: 'center',
        text: `DOANH THU NĂM ${getNowYear}`,
       
       
    },
    accessibility: {
        announceNewData: {
            enabled: true
        }
    },
    xAxis: {
        type: 'category',
        crosshair: true
    },
    yAxis: {
        
        title: {
            text: '',
            
        }

    },
    legend: {
        enabled: false,
    },
    plotOptions: {
        column: {
            borderRadius: 6
        },
        series: {
            borderWidth: 0,
            dataLabels: {
                enabled: true,
                format: `{point.y}`
            }
        }
    },

    tooltip: {
        headerFormat: '<span style="font-size:14px; color:white;">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b style="color:white;">{point.y}</b><br/>',
        valueSuffix: "vnd",
        backgroundColor: '#4f697d',
        borderColor: '#4f697d',
        borderRadius: 10,
        
        
    },

    series: [{
        name: `Doanh thu năm ${getNowYear}`,
        colorByPoint: true,
        data: statisByYear,
        
    }],
    drilldown: {
        breadcrumbs: {
            position: {
                align: 'right',
                
            }
        },
        series: statisByDay
    }
});
</script>
@stop
@stop