<nav class="navbar navbar-expand navbar-light navbar-bg"
    style="background-color: #243943; box-shadow: rgba(149, 157, 165, 0.2) 10px 10px 24px;">
    <a class="sidebar-toggle js-sidebar-toggle">
        <i class="hamburger align-self-center"></i>
    </a>
    <h3 style="font-family: Quicksand, sans-serif !important;font-weight: 600px ; color:white; text-align: center; padding-left: 7px; padding-top: 7px;">HỆ THỐNG QUẢN LÝ QUÁN CÀ PHÊ</h3>
    <div class="text-center">
        <img src="{{asset('img/logo_chu.png')}}" class="rounded" style="padding-left: 10px; height:40px;width: 200px; border-radius:50%; object-fit: cover; ">
    </div>
    
    <div class="navbar-collapse collapse">
        <ul class="navbar-nav navbar-align">
            <li class="nav-item dropdown">
                <div class="dropdown">
                    <!-- <img style="height:50px;width:50px;border-radius:50%;object-fit: cover;"
                        src="{{asset('img/v2.png')}}"> -->
                    <button class="btn dropdown-toggle-menu" type="button" id="dropdownMenuButton1"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background: #3e6a95; margin-left: 10px; color: white;">
                        {{ getNameLog() }}
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item" href="{{route('infologin')}}">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                class="bi bi-info-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
                                <path
                                    d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
                            </svg></i>Thông tin tài khoản</a>
                        <a class="dropdown-item" href="{{route('auth.logout')}}">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                class="bi bi-box-arrow-left" viewBox="0 0 16 16">
                                <path fill-rule="evenodd"
                                    d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0v2z" />
                                <path fill-rule="evenodd"
                                    d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z" />
                            </svg>Logout</a>

                    </div>
            </li>
        </ul>
    </div>
</nav>