<pre>
# Notes
PERL! http://www.ece.umd.edu/~blj/algorithmic_composition/


Here is what the file TRVABRY128F1476445.json looks like. Keys are artist, title, timestamp, similars and tags.

{"artist": "Jos\u00e9 Merc\u00e9", "timestamp": "2011-08-16 01:34:38.887856", "similars":
[["TRNIEVD128F147645F", 1], ["TRTXPMH128F1476447", 1], ["TRZIWPD12903CDE96C", 0.66243399999999997], ["TRLILVX12903CDE95E", 0.62811899999999998], 
["TRLSYHL128F428C7CB", 0.55656099999999997], ["TRWDJQC12903CB287F", 
0.50215799999999999], ["TROJDSM128F9304E70", 0.50215799999999999], 
["TRZOIRZ128F42A9659", 0.474242], ["TROMZDT128F92EFE12", 0.472804], 
["TRVWRLB128F148F534", 0.46567999999999998], ["TRFYKLP128F92EFE18", 
0.46275100000000002], ["TRTTOVG128F148F533", 0.46058300000000002], ["TRSXYZI128F42A9663", 0.41137699999999999], ["TRRCXTY128F4277F63", 
0.19137299999999999], ["TRUTJAF128F4277F4C", 0.17661499999999999], 
["TRHEWAO128F935F427", 0.011253300000000001], ["TRNHEHN128F4293C4E", 
0.011253300000000001], ["TRNXBQQ12903CEEF46", 0.011253300000000001], 
["TRXEWMB128F42772F4", 0.0111964], ["TRCUSYP128F428633D", 0.0111485], 
["TRNGAKK128F4244109", 0.011090600000000001], ["TRQPBGA128F42772EC", 0.0110475], 
["TRANHDB128F4244103", 0.0110405], ["TRBXSTV128F4287DF5", 0.011037699999999999], 
["TRFOECV128F428633E", 0.011037699999999999], ["TRAHJXO128F424C7A3", 
0.011037699999999999], "tags": [["Flamenco", "100"], ["world", "50"], ["cante flamenco", "50"],
["jose merce", "50"], ["MyFlamenco", "50"], ["okFlamenco", "50"]], "track_id": 
"TRVABRY128F1476445", "title": "Campesino y minero (Tarantos)"}

track_id & tags

    # EXAMPLE 4
    print '************** DEMO 4 **************'
    tag = 'Acid Smurfs'
    print 'We get all tracks for the tag: %s' % tag
    sql = "SELECT tids.tid FROM tid_tag, tids, tags WHERE tids.ROWID=tid_tag.tid AND tid_tag.tag=tags.ROWID AND tags.tag='%s'" % sanitize(tag)
    res = conn.execute(sql)
    data = res.fetchall()
    print map(lambda x: x[0], data)


Sharing
https://developer.android.com/training/secure-file-sharing/setup-sharing.html

FileProvider
https://developer.android.com/reference/android/support/v4/content/FileProvider.html 
https://developer.android.com/reference/android/support/v4/content/FileProvider.html

AppBar
ActionBar (native,version dependent)
Toolbar (recommended)
https://developer.android.com/training/appbar/setting-up.html#java

https://developer.android.com/training/sharing/shareaction.html

https://developer.android.com/reference/android/support/v7/widget/ShareActionProvider.html
MIME type
  text/*
  */*
*something different*
https://developer.android.com/training/secure-file-sharing/setup-sharing.html
  
  
  set SingleChoice when getting the view
  https://stackoverflow.com/questions/7413272/how-to-set-choice-mode-single-for-listview-with-images
  ListView list = getListView();
    list.setChoiceMode(ListView.CHOICE_MODE_SINGLE);
    list.setAdapter(new ArrayAdapter<String>(this, R.layout.list_item,
  
onClick
  clear all/selected
  Invert visual / BOLD / highlight
    https://stackoverflow.com/questions/35035839/change-color-of-one-textview-on-listview-without-change-others
    
  grab value
  
  *Zero sum game*
  boxes 1-10 (min=1), Right, Left(min = 2), split
  All your money in one box
  
  Robber will come in Left or Right door and take all money on that side
  
  pass the trash
  
  Dice - Bullshit Dice[] = [rnd(6),rnd(6)]
  
  class roll( // two 6s
  int leng;
  int value;
  
  bool gt(roll input){
    if(this.leng > input.leng){
      return TRUE
    } elif(this.leng == input.leng && this.value > input.value){
      return TRUE
    }else{
      return FLASE
    }
  }     
  
  if input.improb
    input.call
  elif roll > input
    roll.raise
  else //Lie
    while fakeroll < inpu {} // fakeroll.leng <= input.leng +1
    fakeroll.raise
  
  
  CANVAS
  https://google-developer-training.gitbooks.io/android-developer-advanced-course-practicals/unit-5-advanced-graphics-and-views/lesson-11-canvas/11-1a-p-create-a-simple-canvas/11-1a-p-create-a-simple-canvas.html
  https://github.com/google-developer-training/android-advanced/blob/master/SimpleCanvas/app/src/main/java/com/example/simplecanvas/MainActivity.java
  https://developer.android.com/reference/android/graphics/Canvas.html
  
  Excel Dice
  
=MOD((ROW()-1),6)+1
=MOD(INT((ROW()-1)/6),6)+1
=MOD(INT((ROW()-1)/6^2),6)+1
=MOD(INT((ROW()-1)/6^3),6)+1
=MOD(INT((ROW()-1)/6^4),6)+1
=MOD(INT((ROW()-1)/6^5),6)+1

=COUNTIF(B1:G1, 1)
=COUNTIF(B1:G1, 2)
=COUNTIF(B1:G1, 3)
=COUNTIF(B1:G1, 4)
=COUNTIF(B1:G1, 5)
=COUNTIF(B1:G1, 6)

=IF((COUNTIF(I1:N1, 2)>0), 1,0)
=IF((COUNTIF(I1:N1, 3)>0), 1,0)
=IF((COUNTIF(I1:N1, 4)>0), 1,0)
=IF((COUNTIF(I1:N1, 5)>0), 1,0)
=IF((COUNTIF(I1:N1, 6)>0), 1,0)

=IF((COUNTIF(Q1:U1, 1)>0), 1,0)
=IF((COUNTIF(R1:U1, 1)>0), 1,0)
=IF((COUNTIF(S1:U1, 1)>0), 1,0)
=IF((COUNTIF(T1:U1, 1)>0), 1,0)
=IF((COUNTIF(U1, 1)>0), 1,0)
</pre>
