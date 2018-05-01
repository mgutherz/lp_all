<pre>
# Notes
PERL! http://www.ece.umd.edu/~blj/algorithmic_composition/

my @score;
for ($note=1; $note < 25; $note++){
        $channel = $note %4;
        $tone = $note %8;
        printf("%d > %d\n",$channel, $note);
        $score[$channel] = {} unless exists  $score[$channel];
        $score[$channel]->{$tone} = 1;
}
for($channel=0; $channel < 4; $channel++){
        printf("Channel %d > ", $channel);
        @notes = keys %{$score[$channel]};
        print join ',',  sort @notes;
        print "\n";
}


Java spectrum
https://code.google.com/archive/p/musicg/downloads
import com.musicg.wave.extension.Spectrogram;
		spectrogram = new Spectrogram(wave, fftSampleSize, overlapFactor);
		render.renderSpectrogram(spectrogram, outFolder + "/"+filename+"2.jpg");
https://github.com/madyx/musicg/blob/master/src/com/musicg/wave/extension/Spectrogram.java

http://www.music-ir.org/evaluation/tools.html

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
