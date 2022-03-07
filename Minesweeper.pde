import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS; r++) {
      for (int c = 0; c<NUM_COLS; c++) {
        buttons[r][c] = new MSButton(r,c);
      }
    }
    setMines();
}
public void setMines()
{
  while(mines.size() < 40) {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[r][c])){
    mines.add(buttons[r][c]);
  }
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
        //else if(clicked.MSButton()&& mines.contains(this))
        //fill(255,0,0);
}
public boolean isWon()
{
   int num = 0;
    for(int r = 0;r<mines.size();r++){
      if(mines.get(r).flagged ==true){
          num++;
        }     
    }
    if(num==mines.size()){
      return true;
    }
    return false;
}
public void displayLosingMessage()
{
    for(int r = 0;r<mines.size();r++){
      mines.get(r).clicked=true;
    }
    stroke(255,0,0);
}
public void displayWinningMessage()
{
    stroke(0,255,0);
}
public boolean isValid(int r, int c)
{
    if((r>=0 && r<NUM_ROWS)&&(c>=0 && c<NUM_COLS)) {
      return true;
    }
      else 
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int r = row-1;r<=row+1;r++)
    for(int c = col-1; c<=col+1;c++)
      if(isValid(r,c) && mines.contains(buttons[r][c]))
        numMines++;
  //if(mines.contains(buttons[row][col])==true)
    //numMines--;
   return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton==RIGHT) {
          flagged = !flagged;
          clicked = false;
          myLabel = "";
        }
        else if(mines.contains(this)) {
          displayLosingMessage();
        }
        else if(countMines(this.myRow,this.myCol)>0) {
          flagged=false;
          myLabel = countMines(myRow,myCol)+"";
        }
        if(countMines(myRow,myCol)==0){
          /*for(int r = -1; r<=1;r++) {
            for(int c = -1-1;r<=1;r++) {
              if(isValid(myRow+r,myCol+c)==true&&buttons[myRow+r][myCol+c].clicked)
              buttons[r][c].mousePressed();
            }
          }*/
          if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].unClicked()) buttons[myRow-1][myCol-1].mousePressed();
          if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].unClicked()) buttons[myRow-1][myCol].mousePressed();
          if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].unClicked()) buttons[myRow-1][myCol+1].mousePressed();
          if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].unClicked()) buttons[myRow][myCol-1].mousePressed();
          if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].unClicked()) buttons[myRow][myCol+1].mousePressed();
          if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].unClicked()) buttons[myRow+1][myCol-1].mousePressed();
          if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].unClicked()) buttons[myRow+1][myCol].mousePressed();
          if(isValid(myRow+1,myCol+1) && buttons[myRow+1][myCol+1].unClicked()) buttons[myRow+1][myCol+1].mousePressed();
        }
    }
    public boolean unClicked() {
      return !clicked; }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
