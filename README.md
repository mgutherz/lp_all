# Notes
//swipe onFling?

private float x1,x2;
static final int MIN_DISTANCE = 150;

@Override
public boolean onTouchEvent(MotionEvent event)
{     
    switch(event.getAction())
    {
      case MotionEvent.ACTION_DOWN:
          x1 = event.getX();                         
      break;         
      case MotionEvent.ACTION_UP:
          x2 = event.getX();
          float deltaX = x2 - x1;

          if (Math.abs(deltaX) > MIN_DISTANCE)
          {
              // Left to Right swipe action
              if (x2 > x1)
              {
                  Toast.makeText(this, "Left to Right swipe [Next]", Toast.LENGTH_SHORT).show ();                     
              }

              // Right to left swipe action               
              else 
              {
                  Toast.makeText(this, "Right to Left swipe [Previous]", Toast.LENGTH_SHORT).show ();                    
              }

          }
          else
          {
              // consider as something else - a screen tap for example
          }                          
      break;   
    }           
    return super.onTouchEvent(event);       
}