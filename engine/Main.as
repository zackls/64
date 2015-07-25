package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.events.*;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import fl.motion.Color;
	import flash.geom.Point;

	public class Main extends MovieClip
	{
		private var currentSet:String;
		private var currentBoard:String;
		private var currentBackground:Class;
		private var currentBorder:Class;
		private var defaultBoard:Class;
		private var displayPieceContainer:Sprite = new Sprite();
		private var attackContainer:Sprite = new Sprite();
		private var board:Sprite;
		private var ingameSideMenu:Sprite;
		private var inattackSideMenu:Sprite = new Sprite();
		private var playerStart:Boolean = false;
		private var currentLevel:int = 1;
		private var usedValues:Array = [];
		private var roundContainer:Sprite = new Sprite();
		public function Main()
		{
			startGame();
		}
		public function startGame():void
		{
			currentSet = "Marble";
			defaultBoard = defaultboard1;
			currentBoard = "board1";
			currentBackground = background1;
			if (Math.random() > 0.5)
			{
				playerStart = true;
			}
			board = new Board(defaultBoard,playerStart,displayPieceInfo,clearDisplayPieceInfo,beginAttack,startingText,currentLevel);
			addChild(board);
			board.x = 250;
			board.y = 250;
			board.width = 500;
			board.height = 500;
			ingameSideMenu = new ingameMenu();
			addChild(attackContainer);
			addChild(ingameSideMenu);
			ingameSideMenu.x = 600;
			ingameSideMenu.y = 250;
			addChild(displayPieceContainer);
			addChild(roundContainer);
		}
		public function beginAttack(squares:Array, firstSquare:String, initiatingSquare:Sprite, recievingSquare:Sprite, currentRound:int,originalColumn:Array):void
		{
			usedValues = [];
			var transitionTimer:int = 0;
			var j:int;
			for (j = 0; j < squares.length; j++)
			{
				if (squares[j] == initiatingSquare || squares[j] == recievingSquare)
				{
					usedValues.push(j);
				}
			}
			var i:int = usedValues.length;
			var whiteFlash:Sprite = new whiteSquare();
			addEventListener(Event.ENTER_FRAME,transitionToAttack);
			function transitionToAttack(e:Event):void
			{
				transitionTimer++;
				if (transitionTimer / 2 is int)
				{
					if (i < squares.length)
					{
						for (; ; )
						{
							var randomValue:int = Math.round(Math.random() * (squares.length - 1));
							if (checkValues(usedValues,squares.length,randomValue))
							{
								squares[randomValue].IlluminateOrange();
								usedValues.push(randomValue);
								i++;
								break;
							}
						}
					}
					else if (i == squares.length)
					{
						for (j = 0; j < squares.length; j++)
						{
							squares[j].Dilluminate();
							board.removeChild(squares[j]);
						}
						clearDisplayPieceInfo();
						removeChild(board);
						removeChild(ingameSideMenu);
						var scrollArrow:Sprite = new attackMenuArrow();
						var shiftColor:Array = new Array();
						shiftColor = shiftColor.concat([1.5,0,0,0,0]);// red
						shiftColor = shiftColor.concat([0,1.5,0,0,0]);// green
						shiftColor = shiftColor.concat([0,0,1.5,0,0]);// blue
						shiftColor = shiftColor.concat([1,1,0,1,0]);// alpha
						var colorFilter:ColorMatrixFilter = new ColorMatrixFilter(shiftColor);
						scrollArrow.x = 700;
						scrollArrow.y = 250;
						scrollArrow.addEventListener(MouseEvent.MOUSE_UP,scrollLeftController);
						inattackSideMenu = new inattackMenu();
						inattackSideMenu.x = 800;
						inattackSideMenu.y = 250;
						whiteFlash.x = 350;
						whiteFlash.y = 250;
						whiteFlash.alpha = 1;
						whiteFlash.width = 700;
						whiteFlash.height = 500;
						var orderContainer:Sprite = new Sprite();
						var pastActionContainer:Sprite= new Sprite();
						var orderMask:Shape = new Shape();
						orderContainer.cacheAsBitmap = true;
						orderMask.cacheAsBitmap = true;
						orderContainer.mask = orderMask;
						var mxBox:Matrix = new Matrix();
						mxBox.createGradientBox(300, 300);
						orderMask.graphics.beginGradientFill(GradientType.LINEAR,[0x000000, 0x000000, 0x000000], [0,1,0], [0,50,100], mxBox);
						orderMask.graphics.drawRect(0,0,500,200);
						orderMask.graphics.endFill();
						orderMask.rotation = 90;
						orderMask.x = 200;
						orderMask.width = 700;
						orderMask.height = 500;
						orderMask.y = -45;
						pastActionContainer.x = 700;
						orderContainer.addEventListener(MouseEvent.MOUSE_MOVE,followMask);
						var tempContainer:Sprite = new Sprite();
						var attackBoard:Sprite = new AttackBoard(squares,firstSquare,currentBoard,currentSet,playerStart,recievingSquare,initiatingSquare,orderContainer,displayPieceInfo,clearDisplayPieceInfo,tempContainer,universalActionValues,currentLevel,currentRound,pastActionContainer,endAttack,originalColumn,stage);
						attackBoard.filters = [colorFilter];
						attackBoard.x = 350;
						attackBoard.y = 320;
						attackBoard.z = 700;
						attackBoard.rotationX = -62;
						var attackBackground:Sprite = new currentBackground();
						attackBackground.x = 350;
						attackBackground.y = 250;
						graphics.beginFill(0x000000,1);
						graphics.drawRect(0,0,700,500);
						graphics.endFill();
						attackContainer.addChild(attackBackground);
						attackContainer.addChild(attackBoard);
						attackContainer.addChild(tempContainer);
						attackContainer.addChild(scrollArrow);
						attackContainer.addChild(orderContainer);
						attackContainer.addChild(pastActionContainer);
						attackContainer.addChild(inattackSideMenu);
						attackContainer.addChild(orderMask);
						attackContainer.addChild(whiteFlash);
						i++;
						function followMask(e:MouseEvent):void
						{
							orderMask.y = mouseY - 60;
						}
						function scrollLeftController(e:MouseEvent):void
						{
							addEventListener(Event.ENTER_FRAME, scrollLeft);
							scrollArrow.removeEventListener(MouseEvent.MOUSE_UP,scrollLeftController);
						}
						function scrollLeft(e:Event):void
						{
							if (inattackSideMenu.x > 600)
							{
								scrollArrow.x -=  5;
								inattackSideMenu.x -=  5;
							}
							else
							{
								scrollArrow.rotation = 180;
								scrollArrow.x = 500 - scrollArrow.width;
								inattackSideMenu.x = 600;
								removeEventListener(Event.ENTER_FRAME, scrollLeft);
								scrollArrow.addEventListener(MouseEvent.MOUSE_UP,scrollRightController);
							}
						}
						function scrollRightController(e:MouseEvent):void
						{
							addEventListener(Event.ENTER_FRAME, scrollRight);
							scrollArrow.removeEventListener(MouseEvent.MOUSE_UP,scrollRightController);
						}
						function scrollRight(e:Event):void
						{
							if (inattackSideMenu.x < 800)
							{
								scrollArrow.x +=  5;
								inattackSideMenu.x +=  5;
							}
							else
							{
								scrollArrow.rotation = 0;
								scrollArrow.x = 700;
								inattackSideMenu.x = 800;
								removeEventListener(Event.ENTER_FRAME, scrollRight);
								scrollArrow.addEventListener(MouseEvent.MOUSE_UP,scrollLeftController);
							}
						}
					}
					else
					{
						if (whiteFlash.alpha > 0.07)
						{
							whiteFlash.alpha /=  1.1;
						}
						else
						{
							whiteFlash.alpha = 0;
							if (attackContainer.contains(whiteFlash))
							{
								attackContainer.removeChild(whiteFlash);
							}
						}
					}
				}
				function checkValues(usedValues:Array, squaresLength:int, testValue:int):Boolean
				{
					for (j = 0; j < usedValues.length; j++)
					{
						if (testValue == usedValues[j])
						{
							return false;
						}
					}
					return true;
				}
			}
		}
		public function endAttack(container:Object,squares:Array,squarePositions:Array,originalColumn:Array,initiatingSquare:Object,recievingSquare:Object,movePiece:Boolean):void
		{
			if (!(initiatingSquare.piece is Sprite))
			{
				movePiece = false;
			}
			var i:int = 0;
			var j:int = 0;
			var k:int = 0;
			while (container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
			while (attackContainer.numChildren > 0)
			{
				attackContainer.removeChildAt(0);
			}
			var dumbBoardArray:Array = [board];
			var sideLength:int = Math.sqrt(squares.length);
			var topLeftIndex:Point;
			var newSquareArray:Array = [];
			for (i = 0; i < originalColumn.length; i++)
			{
				if (originalColumn[i].lastIndexOf(squares[0]) >= 0)
				{
					topLeftIndex = new Point(i,originalColumn[i].lastIndexOf(squares[0]));
					break;
				}
			}
			for (i = 0; i < squares.length; i++)
			{
				var newSquare:Object = new Square();
				if (squares[i].piece is Sprite)
				{
					squares[i].piece.endAttack();
					var newPiece:Object = new (getDefinitionByName(getQualifiedClassName(squares[i].piece)) as Class)(squares[i].piece.team,squares[i].piece.equipment,squares[i].piece.skills,squares[i].piece.lvl,squares[i].piece.currentExp,squares[i].piece.startingPosition);
					newPiece.currentHealth = squares[i].piece.currentHealth;
					newPiece.totalHealth = squares[i].piece.totalHealth;
					newPiece.currentMana = squares[i].piece.currentMana;
					newPiece.baseDamage = squares[i].piece.baseDamage;
					newPiece.armor = squares[i].piece.armor;
					newPiece.protection = squares[i].piece.protection;
					newPiece.poisoned = squares[i].piece.poisoned;
					newPiece.poisonOwner = squares[i].piece.poisonOwner;
					newPiece.bleeding = squares[i].piece.bleeding;
					newPiece.bleedTurnsLeft = squares[i].piece.bleedTurnsLeft;
					newPiece.wounded = squares[i].piece.wounded;
					newPiece.criticalChance = squares[i].piece.criticalChance;
					newPiece.instantKillChance = squares[i].piece.instantKillChance;
					newPiece.dodgeChance = squares[i].piece.dodgeChance;
					newPiece.stunChance = squares[i].piece.stunChance;
					newPiece.manaLeech = squares[i].piece.manaLeech;
					newPiece.healthLeech = squares[i].piece.healthLeech;
					newPiece.manaRegen = squares[i].piece.manaRegen;
					newPiece.healthRegen = squares[i].piece.healthRegen;
					newPiece.moved = squares[i].piece.moved;
					if (newPiece is King)
					{
						newPiece.mastery = squares[i].piece.mastery;
					}
					squares[i].removeChild(squares[i].piece);
					newSquare.piece = newPiece;
					newSquare.addChild(newPiece);
				}
				board.addChild(newSquare as Sprite);
				if (k == sideLength)
				{
					j++;
					k -=  sideLength;
				}
				newSquare.x = squarePositions[2 * i];
				newSquare.y = squarePositions[(2 * i) + 1];
				originalColumn[j + topLeftIndex.x][k + topLeftIndex.y] = newSquare;
				if (squares[i] != initiatingSquare && squares[i] != recievingSquare)
				{
					newSquare.IlluminateOrange();
				}
				else if (squares[i] == initiatingSquare)
				{
					initiatingSquare = newSquare;
					initiatingSquare.IlluminateYellow();
				}
				else if (squares[i] == recievingSquare)
				{
					recievingSquare = newSquare;
					recievingSquare.IlluminateRed();
				}
				newSquareArray.push(newSquare);
				k++;
			}
			addEventListener(Event.ENTER_FRAME,dilluminateSquares);
			var timer:int = 0;
			removeChild(displayPieceContainer);
			addChild(board);
			addChild(ingameSideMenu);
			addChild(displayPieceContainer);
			function dilluminateSquares(e:Event):void
			{
				newSquareArray[usedValues[timer]].Dilluminate();
				timer++;
				if (timer >= usedValues.length)
				{
					graphics.clear();
					clearDisplayPieceInfo();
					dumbBoardArray[0].endAttack(movePiece,initiatingSquare,recievingSquare);
					removeEventListener(Event.ENTER_FRAME,dilluminateSquares);
				}
			}
		}
		public function displayPieceInfo(attack:Boolean, caller:Object, type:Class):void
		{
			var pieceModel:Sprite = new type();
			var pieceText:TextField = new TextField();
			var pieceString:TextField = new TextField();
			var pieceTitleFormat:TextFormat;
			var barTextFormat:TextFormat;
			pieceString.text = pieceModel.toString();
			var healthBarText:TextField = new TextField();
			var manaBarText:TextField = new TextField();
			var expBarText:TextField = new TextField();
			var smallTextFormat:TextFormat = new TextFormat("Cambria",11,0x665420);
			var damageText:TextField = new TextField();
			var dodgeText:TextField = new TextField();
			var instantKillText:TextField = new TextField();
			var criticalText:TextField = new TextField();
			var stunText:TextField = new TextField();
			var armorText:TextField = new TextField();
			var healthRegenText:TextField = new TextField();
			var manaRegenText:TextField = new TextField();
			var healthLeechText:TextField = new TextField();
			var manaLeechText:TextField = new TextField();
			var bottomTexts:Array = [damageText,dodgeText,instantKillText,criticalText,stunText,armorText,healthRegenText,manaRegenText,healthLeechText,manaLeechText];
			var pieceHealthBar:Sprite = new redSquare();
			var pieceManaBar:Sprite = new blueSquare();
			var pieceExpBar:Sprite = new greenSquare();
			var i:int;
			var bottomAction1:Sprite = new (getDefinitionByName(caller.skills[0] + "Icon") as Class);
			var bottomAction2:Sprite = new (getDefinitionByName(caller.skills[2] + "Icon") as Class);
			var newAction:Sprite;
			var descriptionText:TextField = new TextField();
			var redTint:Color = new Color();
			var titleText:TextField = new TextField();
			if (attack)
			{
				damageText.x = -95;
				damageText.y = 125;
				dodgeText.x = -95;
				dodgeText.y = 145;
				instantKillText.x = -95;
				instantKillText.y = 165;
				criticalText.x = -95;
				criticalText.y = 185;
				stunText.x = -95;
				stunText.y = 205;
				armorText.x = 5;
				armorText.y = 125;
				healthRegenText.x = 5;
				healthRegenText.y = 145;
				manaRegenText.x = 5;
				manaRegenText.y = 165;
				healthLeechText.x = 5;
				healthLeechText.y = 185;
				manaLeechText.x = 5;
				manaLeechText.y = 205;
				pieceModel.y = -130;
				inattackSideMenu.addChild(pieceModel);
				pieceTitleFormat = new TextFormat("Cambria",20,0xD2BC9C);
				pieceString.replaceText(0,23,"");
				pieceString.replaceText(pieceString.getLineLength(0) - 1,pieceString.getLineLength(0),"");
				inattackSideMenu.addChild(pieceText);
				pieceText.x =  -  pieceText.width;
				pieceText.y = -220;
				healthBarText.x =  -  healthBarText.width / 2;
				healthBarText.y = -60;
				manaBarText.x =  -  manaBarText.width / 2;
				manaBarText.y = -30;
				expBarText.x =  -  expBarText.width / 2;
				var blackSquare:Sprite = new Sprite();
				blackSquare.graphics.beginFill(0x000000, 1);
				blackSquare.graphics.drawRect(-60, -62.5, 120, 25);
				blackSquare.graphics.drawRect(-60, -32.5, 120, 25);
				blackSquare.graphics.drawRect(-60, -2.5, 120, 25);
				blackSquare.graphics.endFill();
				inattackSideMenu.addChild(blackSquare);
				pieceHealthBar.x = -60;
				pieceHealthBar.y = -50;
				pieceManaBar.x = -60;
				pieceManaBar.y = -20;
				pieceExpBar.x = -60;
				pieceExpBar.y = 10;
				bottomAction1.x = -25;
				bottomAction1.y = 100;
				bottomAction2.x = 25;
				bottomAction2.y = 100;
				for (i = 0; i < 4; i++)
				{
					blackSquare = new Sprite();
					inattackSideMenu.addChild(blackSquare);
					blackSquare.graphics.beginFill(0x000000, 1);
					blackSquare.graphics.drawRect(-95 + (50 * i), 30, 40, 40);
					blackSquare.graphics.endFill();
				}
				for (i = 4; i < caller.skills.length; i++)
				{
					newAction = new (getDefinitionByName(caller.skills[i] + "Icon") as Class);
					newAction.scaleX = 0.5;
					newAction.scaleY = 0.5;
					newAction.x = -75 + (50 * (i - 4));
					newAction.y = 50;
					inattackSideMenu.addChild(newAction);
					if (universalActionValues(newAction, int) > caller.currentMana)
					{
						redTint = new Color();
						redTint.setTint(0xFF0000,0.5);
						newAction.transform.colorTransform = redTint;
					}
					newAction.addEventListener(MouseEvent.MOUSE_MOVE,followText);
				}
				inattackSideMenu.addChild(damageText);
				inattackSideMenu.addChild(dodgeText);
				inattackSideMenu.addChild(instantKillText);
				inattackSideMenu.addChild(criticalText);
				inattackSideMenu.addChild(stunText);
				inattackSideMenu.addChild(pieceHealthBar);
				inattackSideMenu.addChild(pieceManaBar);
				inattackSideMenu.addChild(pieceExpBar);
				inattackSideMenu.addChild(healthBarText);
				inattackSideMenu.addChild(manaBarText);
				inattackSideMenu.addChild(expBarText);
				inattackSideMenu.addChild(bottomAction1);
				inattackSideMenu.addChild(bottomAction2);
			}
			else
			{
				damageText.x = 505;
				damageText.y = 375;
				dodgeText.x = 505;
				dodgeText.y = 395;
				instantKillText.x = 505;
				instantKillText.y = 415;
				criticalText.x = 505;
				criticalText.y = 435;
				stunText.x = 505;
				stunText.y = 455;
				armorText.x = 605;
				armorText.y = 375;
				healthRegenText.x = 605;
				healthRegenText.y = 395;
				manaRegenText.x = 605;
				manaRegenText.y = 415;
				healthLeechText.x = 605;
				healthLeechText.y = 435;
				manaLeechText.x = 605;
				manaLeechText.y = 455;
				pieceModel.x = 600;
				pieceModel.y = 120;
				displayPieceContainer.addChild(pieceModel);
				pieceTitleFormat = new TextFormat("Cambria",20,0x957D2E);
				pieceString.replaceText(0,13,"");
				pieceString.replaceText(pieceString.getLineLength(0) - 1,pieceString.getLineLength(0),"");
				displayPieceContainer.addChild(pieceText);
				pieceText.x = 600 - (pieceText.width);
				pieceText.y = 30;
				healthBarText.x = 600 - (healthBarText.width / 2);
				healthBarText.y = 190;
				manaBarText.x = 600 - (manaBarText.width / 2);
				manaBarText.y = 220;
				expBarText.x = 600 - (expBarText.width / 2);
				expBarText.y = 250;
				displayPieceContainer.graphics.beginFill(0x000000, 1);
				displayPieceContainer.graphics.drawRect(540, 187.5, 120, 25);
				displayPieceContainer.graphics.drawRect(540, 217.5, 120, 25);
				displayPieceContainer.graphics.drawRect(540, 247.5, 120, 25);
				displayPieceContainer.graphics.endFill();
				pieceHealthBar.x = 540;
				pieceHealthBar.y = 200;
				pieceManaBar.x = 540;
				pieceManaBar.y = 230;
				pieceExpBar.x = 540;
				pieceExpBar.y = 260;
				bottomAction1.x = 575;
				bottomAction1.y = 350;
				bottomAction2.x = 625;
				bottomAction2.y = 350;
				for (i = 0; i < 4; i++)
				{
					displayPieceContainer.graphics.beginFill(0x000000, 1);
					displayPieceContainer.graphics.drawRect(505 + (50 * i), 280, 40, 40);
					displayPieceContainer.graphics.endFill();
				}
				for (i = 4; i < caller.skills.length; i++)
				{
					newAction = new (getDefinitionByName(caller.skills[i] + "Icon") as Class);
					newAction.scaleX = 0.5;
					newAction.scaleY = 0.5;
					newAction.x = 525 + (50 * (i - 4));
					newAction.y = 300;
					displayPieceContainer.addChild(newAction);
					if (universalActionValues(newAction, int) > caller.currentMana)
					{
						redTint = new Color();
						redTint.setTint(0xFF0000,0.5);
						newAction.transform.colorTransform = redTint;
					}
					newAction.addEventListener(MouseEvent.MOUSE_MOVE,followText);
				}
				displayPieceContainer.addChild(pieceHealthBar);
				displayPieceContainer.addChild(pieceManaBar);
				displayPieceContainer.addChild(pieceExpBar);
				displayPieceContainer.addChild(healthBarText);
				displayPieceContainer.addChild(manaBarText);
				displayPieceContainer.addChild(expBarText);
				displayPieceContainer.addChild(bottomAction1);
				displayPieceContainer.addChild(bottomAction2);
			}
			for (i = 0; i < bottomTexts.length; i++)
			{
				bottomTexts[i].defaultTextFormat = smallTextFormat;
				bottomTexts[i].border = true;
				bottomTexts[i].background = true;
				bottomTexts[i].backgroundColor = 0x000000;
				bottomTexts[i].selectable = false;
				bottomTexts[i].width = 90;
				bottomTexts[i].height = 15;
				if (attack)
				{
					inattackSideMenu.addChild(bottomTexts[i]);
					bottomTexts[i].borderColor = 0xD2BC9C;
				}
				else
				{
					displayPieceContainer.addChild(bottomTexts[i]);
					bottomTexts[i].borderColor = 0x3E3D3D;
				}
			}
			damageText.text = "Damage- " + caller.totalDamage;
			dodgeText.text = "Dodge- " + caller.dodgeChance * 100 + "%";
			instantKillText.text = "Instant Kill- " + caller.instantKillChance * 100 + "%";
			criticalText.text = "Critical- " + caller.criticalChance * 100 + "%";
			stunText.text = "Stun- " + caller.stunChance * 100 + "%";
			armorText.text = "Armor- " + caller.armor;
			healthRegenText.text = "Hp Regen- " + caller.healthRegen * 100 + "%";
			manaRegenText.text = "Mp Regen- " + caller.manaRegen;
			healthLeechText.text = "Hp Leech- " + caller.healthLeech * 100 + "%";
			manaLeechText.text = "Mp Leech- " + caller.manaLeech;
			stunText.text = "Stun- " + caller.stunChance * 100 + "%";
			pieceModel.height = 120;
			pieceModel.scaleX = pieceModel.scaleY;
			pieceText.selectable = false;
			pieceTitleFormat.align = "center";
			pieceText.defaultTextFormat = pieceTitleFormat;
			pieceText.width = 200;
			pieceText.alpha = 0.8;
			pieceText.text = "Level " + caller.lvl + " " + pieceString.text;
			pieceTitleFormat.size = 15;
			healthBarText.defaultTextFormat = pieceTitleFormat;
			manaBarText.defaultTextFormat = pieceTitleFormat;
			expBarText.defaultTextFormat = pieceTitleFormat;
			healthBarText.selectable = false;
			manaBarText.selectable = false;
			expBarText.selectable = false;
			healthBarText.text = caller.currentHealth + " / " + caller.totalHealth;
			manaBarText.text = caller.currentMana + " / " + 100;
			expBarText.text = caller.currentExp + " / " + caller.totalExp;
			healthBarText.height = 20;
			manaBarText.height = 20;
			expBarText.height = 20;
			pieceHealthBar.height = 25;
			pieceHealthBar.width = 120 * (caller.currentHealth / caller.totalHealth);
			pieceManaBar.height = 25;
			pieceManaBar.width = 120 * (caller.currentMana / 100);
			pieceExpBar.height = 25;
			pieceExpBar.width = 120 * (caller.currentExp / caller.totalExp);
			bottomAction1.scaleX = 0.5;
			bottomAction1.scaleY = 0.5;
			bottomAction2.scaleX = 0.5;
			bottomAction2.scaleY = 0.5;
			bottomAction1.addEventListener(MouseEvent.MOUSE_MOVE,followText);
			bottomAction2.addEventListener(MouseEvent.MOUSE_MOVE,followText);
			function followText(e:MouseEvent):void
			{
				e.target.addEventListener(Event.ENTER_FRAME, deleteText);
				e.target.removeEventListener(MouseEvent.MOUSE_MOVE, followText);
				if (attack)
				{
					inattackSideMenu.addChild(titleText);
					inattackSideMenu.addChild(descriptionText);
				}
				else
				{
					displayPieceContainer.addChild(titleText);
					displayPieceContainer.addChild(descriptionText);
				}
				var descriptionFormat:TextFormat = new TextFormat("Cambria",14,0x665420);
				descriptionFormat.align = "center";
				descriptionFormat.bold = true;
				titleText.width = 150;
				titleText.selectable = false;
				titleText.defaultTextFormat = descriptionFormat;
				titleText.border = true;
				descriptionFormat.bold = false;
				descriptionText.width = 150;
				descriptionText.selectable = false;
				descriptionText.defaultTextFormat = descriptionFormat;
				descriptionText.border = true;
				if (attack)
				{
					titleText.borderColor = 0xD2BC9C;
					descriptionText.borderColor = 0xD2BC9C;
				}
				else
				{
					titleText.borderColor = 0x3E3D3D;
					descriptionText.borderColor = 0x3E3D3D;
				}
				titleText.background = true;
				titleText.backgroundColor = 0x000000;
				titleText.multiline = true;
				titleText.wordWrap = true;
				titleText.autoSize = TextFieldAutoSize.CENTER;
				titleText.text = universalActionValues(e.target as Sprite,MovieClip);
				descriptionText.background = true;
				descriptionText.backgroundColor = 0x000000;
				descriptionText.multiline = true;
				descriptionText.wordWrap = true;
				descriptionText.autoSize = TextFieldAutoSize.CENTER;
				descriptionText.text = universalActionValues(e.target as Sprite,String);
			}
			function deleteText(e:Event):void
			{
				if (attack)
				{
					titleText.x = inattackSideMenu.mouseX - titleText.width;
					titleText.y = inattackSideMenu.mouseY - titleText.height - descriptionText.height;
					descriptionText.x = inattackSideMenu.mouseX - descriptionText.width;
					descriptionText.y = inattackSideMenu.mouseY - descriptionText.height;
				}
				else
				{
					titleText.x = mouseX - titleText.width;
					titleText.y = mouseY - titleText.height - descriptionText.height;
					descriptionText.x = mouseX - descriptionText.width;
					descriptionText.y = mouseY - descriptionText.height;
				}
				if (! e.target.hitTestPoint(mouseX,mouseY))
				{
					e.target.removeEventListener(Event.ENTER_FRAME, deleteText);
					e.target.addEventListener(MouseEvent.MOUSE_MOVE, followText);
					if (attack)
					{
						if (inattackSideMenu.contains(descriptionText))
						{
							inattackSideMenu.removeChild(descriptionText);
						}
						if (inattackSideMenu.contains(titleText))
						{
							inattackSideMenu.removeChild(titleText);
						}
					}
					else
					{
						if (displayPieceContainer.contains(descriptionText))
						{
							displayPieceContainer.removeChild(descriptionText);
						}
						if (displayPieceContainer.contains(titleText))
						{
							displayPieceContainer.removeChild(titleText);
						}
					}
				}
			}
		}
		public function clearDisplayPieceInfo():void
		{
			while (displayPieceContainer.numChildren > 0)
			{
				displayPieceContainer.removeChildAt(0);
			}
			displayPieceContainer.graphics.clear();
			while (inattackSideMenu.numChildren > 1)
			{
				inattackSideMenu.removeChildAt(1);
			}
			inattackSideMenu.graphics.clear();
		}
		public function universalActionValues(action:Sprite, type:Class):*
		{
			var possibleActions:Array = [restIcon,unequippedAttackIcon,focusIcon,vitalityIcon,
										 //king
										 restoreHealthIcon,protectIcon,inspireIcon,restoreManaIcon,masteryIcon,
										 //queen
										 fireballIcon,freezeIcon,laserIcon,queenAttackIcon,shieldIcon,
										 //rook
										 enrageIcon,rookAttackIcon,woundIcon,shockIcon,smashIcon,strengthIcon,throwAxeIcon,
										 //bishop
										 assassinateIcon,bishopAttackIcon,disappearIcon,layTrapIcon,lethalityIcon,poisonIcon,reflexesIcon,
										 //knight
										 aimedShotIcon,channelingIcon,criticalIcon,injureIcon,knightAttackIcon,longshotIcon,stunIcon,
										 //pawn
										 bleedIcon,defendIcon,defenseIcon,forkIcon,pawnAttackIcon,powerAttackIcon];
			//called by Number
			var hotkeys:Array = [32,65,,,
								 72,80,73,77,,
								 70,90,76,65,83,
								 69,65,87,,83,,84,
								 88,65,68,76,,80,,
								 83,,,73,65,76,84,
								 66,68,,70,65,80]
			//called by int
			var actionCosts:Array = [0,0,0,0,
									 70,100,30,40,0,
									 50,50,90,0,30,
									 50,0,90,0,75,0,60,
									 100,0,50,50,0,75,0,
									 60,0,0,40,0,75,50,
									 100,100,0,75,0,50];
			//called by String
			var descriptions:Array = ["Restore health and mana. No cost.","Standard melee attack for normal damage. No cost.","For every point spent, 1 more mana is regenerated at the end of every turn.","For every point spent, 1% more health is regenerated at the end of every turn.",
									  "Restore 20% health to a 3x3 square of units, including enemies. Costs 70 mana.","Increase armor by 20% to a 3x3 square of units, including enemies, lasts the remainder of the battle. Costs 100 mana.","Raise an ally's damage by 150%, lasts the remainder of the turn. Costs 30 mana.","Restore 20% mana to a 3x3 square of units, including enemies. Costs 40 mana.","For every point spent, spells cast by this unit are 10% more effective.",
									  "Ranged attack for 75% damage. All adjacent targets (including allies) take 50% damage. Costs 50 mana.","Ranged attack for 150% damage. Target acts last in turn order. Costs 50 mana.","Ranged attack for 150% damage. Shoots a laser that damages all enemies in a diagonal or row/column (including allies). Costs 90 mana.","Standard ranged attack for normal damage. No cost.","Queen only takes 25% the normal damage she would take normally. Lasts the rest of the turn. Costs 30 mana.",
									  "Increase this rook's damage by 10 for the rest of the battle. Costs 50 mana.","Standard ranged attack for normal damage. No cost.","Ranged attack for normal damage. The target won't be able to regenerate health for the rest of the battle. Costs 90 mana.","For every point spent, the rook has a 2% greater chance to stun the target on attack.","Melee attack for normal damage. Does 75% damage to all adjacent and immediately diagonal squares, including allies but not including this unit. Costs 75 mana.","For every point spent, 3% more damage is added to the base damage of this unit.","Ranged attack for 150% damage. Costs 60 mana.",
									  "Melee attack that immediately kills the target, can't be dodged. Costs 100 mana.","Standard ranged attack for normal damage. No cost.","This bishop cannot be attacked, lasts until the end of the turn. Costs 50 mana.","Lays a trap on an empty square in range. Trap deals 200% of the bishop's attack to the next piece that steps on it, allies too. Costs 50 mana.","For every point spent, there is a 0.5% greater chance an attack will instantly kill a target.","Ranged attack for half damage. Target will lose 5% of its hp for the rest of the game. Costs 75 mana.","For every point spent, this bishop has a 1% greater chance to dodge an attack",
									  "Ranged attack for normal damage with a 50% chance to be a critical shot (200% damage). Costs 60 mana.","For every point spent, every attack this knight does steals 1% mana from the target.","For every point spent, every attack has a 1% greater chance of being a critical hit.","Ranged attack for 75% damage, target will act last in the action order. Costs 40 mana.","Standard ranged attack for normal damage. No cost.","Ranged attack for 15% damage to any piece on the board. Costs 75 mana.","Ranged attack for 70% damage, target cannot act for the rest of the turn. Costs 50 mana.",
									  "Melee attack for 50% damage. Causes a piece to lose 15% of its hp over 3 turns. Costs 100 mana.","Pawn takes no damage for the rest of the turn. Costs 100 mana.","For every point spent, this pawn's armor is 3% more effective.","Simultaneous attack for normal damage on two targets in range. Costs 75 mana.","Standard melee attack for normal damage. No cost.","Melee attack for 120% damage. Costs 50 mana."];

			//called by Array
			var actionTypes:Array = ["defensiveSelf","offensiveMelee","skill","skill",
									 "defensiveSquareAny","defensiveSquareAny","defensiveAny","defensiveSquareAny","skill",
									 "offensiveRangedArea","offensiveRanged","offensivePierce","offensiveRanged","defensiveSelf",
									 "defensiveSelf","offensiveRanged","offensiveRanged","skill","offensiveMeleeArea","skill","offensiveRanged",
									 "offensiveMelee","offensiveRanged","defensiveSelf","offensivePassive","skill","offensiveRanged","skill",
									 "offensiveRanged","skill","skill","offensiveRanged","offensiveRanged","offensiveAny","offensiveRanged",
									 "offensiveMelee","defensiveSelf","skill","offensiveMeleeFork","offensiveMelee","offensiveMelee"];
			//called by MovieClip
			var titles:Array = ["Rest - Space","Standard Attack - A","Focus","Vitality",
								"Restore Health - H","Protect - P","Inspire - I","Restore Mana - M","Mastery",
								"Fireball - F","Freeze - Z","Laser - L","Attack - A","Shield - S",
								"Enrage - E","Attack - A","Wound - W","Shock","Smash - S","Strength","Throw Axe - T",
								"Assassinate - X","Attack - A","Disappear - D","Lay Trap - L","Lethality","Poison - P","Reflexes",
								"Aimed Shot - S","Channeling","Critical","Injure - I","Attack - A","Longshot - L","Stun - T",
								"Bleed - B","Defend - D","Defense","Fork - F","Attack - A","Power Attack - P"];
			//called by Sprite
			var actions:Array = ["rested.","attacked",,,
								 "restored health.","protected his allies.","inspired","restored mana.",,
								 "threw a fireball.","froze","shot a laser.","attacked","became shielded.",
								 "became enraged.","attacked","wounded",,"smashed the ground.",,"threw an axe at",
								 "assassinated","attacked","disappeared.","laid a trap.",,"poisoned",,
								 "aimed a shot at",,,"injured","attacked","fired a longshot at","stunned",
								 "bled","became invincible.",,"forked two pieces.","attacked","power-attacked"];
			var i:int;
			for (i = 0; i < possibleActions.length; i++)
			{
				if (action is possibleActions[i])
				{
					if (type == int)
					{
						return actionCosts[i];
					}
					else if (type == String)
					{
						return descriptions[i];
					}
					else if (type == Array)
					{
						return actionTypes[i];
					}
					else if (type == MovieClip)
					{
						return titles[i];
					}
					else if (type == Sprite)
					{
						return actions[i];
					}
					else if (type == Number)
					{
						return hotkeys[i];
					}
					
				}
			}
			if (type == String || type == Array || type == MovieClip || type == Sprite)
			{
				return "";
			}
			if (type == int || type == Number)
			{
				return 100;
			}
			return [];
		}
		public function startingText():void
		{
			var topFlourish:Sprite = new roundFlourish();
			var bottomFlourish:Sprite = new roundFlourish();
			bottomFlourish.rotation = 180;
			topFlourish.y = -10;
			bottomFlourish.y = 10;
			topFlourish.scaleX = 1.2;
			bottomFlourish.scaleX = 1.2;
			roundContainer.addChild(topFlourish);
			roundContainer.addChild(bottomFlourish);
			var roundText:TextField = new TextField();
			var roundFormat:TextFormat = new TextFormat("Cambria",20,0x8C6007);
			roundFormat.align = "center";
			roundText.selectable = false;
			roundText.defaultTextFormat = roundFormat;
			roundText.text = "Good Luck!"
			roundText.width = 100;
			roundText.x = -50;
			roundText.autoSize = TextFieldAutoSize.CENTER;
			roundText.y =  -  roundText.height / 2;
			roundContainer.addChild(topFlourish);
			roundContainer.addChild(bottomFlourish);
			roundContainer.addChild(roundText);
			roundContainer.y = 550;
			roundContainer.x = 250;
			var roundGlow:GlowFilter = new GlowFilter(0xFFFFFF,1,2.5,2.5,1);
			var roundGlow2:GlowFilter = new GlowFilter(0x000000,1,2.5,2.5,1);
			var roundGlow3:GlowFilter = new GlowFilter(0x8C6007,1,2.5,2.5,2);
			bottomFlourish.filters = [roundGlow3];
			topFlourish.filters = [roundGlow3];
			roundText.filters = [roundGlow2,roundGlow];
			addEventListener(Event.ENTER_FRAME, moveText);
			var moveTimer:int = 0;
			function moveText(e:Event):void
			{
				moveTimer++
				roundContainer.y -= 600 * (Math.pow(moveTimer - 36,2) / 29820);
				if (moveTimer == 72)
				{
					while (roundContainer.numChildren > 0)
					{
						roundContainer.removeChildAt(0);
					}
					roundContainer.graphics.clear();
					removeEventListener(Event.ENTER_FRAME, moveText);
				}
			}
		}
	}
}