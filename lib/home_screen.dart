import 'package:flutter/material.dart';
import 'package:tictac/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activeplayer = 'X';
  bool gameOver =false;
  int turn =0;
  String resulte = '';
  Game game = Game();
  bool isSwitched =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              title: const Text('Turn On/Off Two player',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              value: isSwitched, 
              onChanged: (bool newval){
                setState(() {
                  isSwitched = newval;
                });
              },
            ),
            Text("It's $activeplayer Turn ".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                ),
                textAlign: TextAlign.center,
              ),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8,//الفراغ بين المحاور الرئيسية
                crossAxisSpacing: 8,
                childAspectRatio: 1,//نسبه العرض للطول 

                children: List.generate(9, (index) => 
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap:gameOver? null: ()=> _onTap(index) ,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).shadowColor,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child:  Center(
                        child: Text(
                          Player.playerX.contains(index)? 
                           'X'
                           : Player.playerO.contains(index)? 
                            'O':'' ,
                          style: TextStyle(
                             color: Player.playerX.contains(index)?
                               Colors.blue :Colors.pink,
                             fontSize: 52,
                          ),
                        ),
                      ),
                    ),
                  )
                ),
              ),
            ),

            Text(resulte ,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                ),
                textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: (){
                setState(() {
                  activeplayer = 'X';
                  gameOver =false;
                  turn =0;
                  resulte = '';
                  Player.playerX=[];
                  Player.playerO=[];
                });
              }, 
              label: const Text('Repeat The Game'),
              icon: const Icon(Icons.replay),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).splashColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onTap(int index) async{
    if(
      (Player.playerX.isEmpty||!Player.playerX.contains(index)) &&
      (Player.playerO.isEmpty||!Player.playerO.contains(index))
    ) {
      game.playGame(index,activeplayer);
      updateState();

      if(!isSwitched && !gameOver && turn != 9){
        await game.autoPlay(activeplayer);
        updateState();
      }
    }

  }

  void updateState() {
    return setState(() {
    activeplayer =(activeplayer=='X')? 'O':'X';
    turn++;

    String winnerPlayer = game.checkWinner();
      if(winnerPlayer != ''){
        gameOver =true;
        resulte = 'The winner is $winnerPlayer';
      }
      else if(!gameOver && turn==9) {resulte ='It\'s Draw !!';}
  });
  }
}