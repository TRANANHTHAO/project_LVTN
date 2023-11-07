<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Ratings;


class RatingController extends Controller
{
    public function index()
    {
        $ListRating = Ratings::all();
        return view('admin_pages.ratings.index')->with('List',$ListRating);
    }

    public function delete($id)
    {
        $Raings = Ratings::find($id);
        $Raings->delete();

        return back();
    }
}
