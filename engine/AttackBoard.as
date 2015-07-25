package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.events.*;
	import flash.text.*;
	import fl.motion.Color;
	import flash.filters.GlowFilter;

	public class AttackBoard extends Sprite
	{
		public function AttackBoard(originalSquares:Array, firstSquare:String, model:String, currentSet:String, playerStart:Boolean, recievingSquare:Sprite, initiatingSquare:Sprite, orderContainer:Sprite, displayPieceInfo:Function, clearDisplayPieceInfo:Function, attackContainer:Sprite, universalActionValues:Function, currentLevel:int, currentRound:int, pastActionContainer:Sprite, endAttack:Function, originalColumn:Array, originalStage:Stage)
		{
			var This:Sprite = this
			var playerColor:String;
			if (playerStart)
			{
				playerColor = "White";
			}
			else
			{
				playerColor = "Black";
			}
			var originalPositions:Array = [];
			var colorController:int = 0;
			var i:int;
			var j:int = 0;
			var k:int;
			var l:int;
			var m:int;
			var n:int;
			var kmax:int;
			var lmax:int;
			var movePiece:Boolean = false
			var actionContainer:Sprite = new Sprite();
			var oppositeSquare:String;
			var topContainer:Sprite = new Sprite  ;
			var continueText:TextField = new TextField();
			var regressText:TextField = new TextField();
			attackContainer.addChild(continueText);
			var attackingSquare:Object;
			var defendingSquare:Object;
			var descriptionText:TextField= new TextField();
			var titleText:TextField= new TextField();
			var selectedAction:int;
			var column:Array = [];
			column[0] = new Array();
			j = 0;
			if (firstSquare == "White")
			{
				oppositeSquare = "Black";
			}
			else
			{
				oppositeSquare = "White";
			}
			for (i = 0; i < 2 * originalSquares.length; i += 2)
			{
				originalPositions[i] = originalSquares[i / 2].x;
				originalPositions[i + 1] = originalSquares[i / 2].y;
			}
			for (i = 0; ; i++)
			{
				if (i >= Math.sqrt(originalSquares.length))
				{
					i -=  Math.sqrt(originalSquares.length);
					j++;
					if (j != Math.sqrt(originalSquares.length))
					{
						column[j] = new Array();
					}
				}
				if (j == Math.sqrt(originalSquares.length))
				{
					break;
				}
				column[j].push(originalSquares[i + (j * Math.sqrt(originalSquares.length))]);
				var newSquare:Sprite;
				if ((j + i) / 2 is int)
				{
					newSquare = new (getDefinitionByName(model + firstSquare) as Class);
				}
				else
				{
					newSquare = new (getDefinitionByName(model + oppositeSquare) as Class);
				}
				newSquare.width = 500 / 3;
				newSquare.height = 500 / 3;
				newSquare.x = (500 / 3) * (i - ((Math.sqrt(originalSquares.length) - 1) / 2));
				newSquare.y = (500 / 3) * (j - ((Math.sqrt(originalSquares.length) - 1) / 2));
				addChild(newSquare);
			}
			j = 0;
			for (i = 0; ; i++)
			{
				if (i >= Math.sqrt(originalSquares.length))
				{
					i -=  Math.sqrt(originalSquares.length);
					j++;
				}
				if (j == Math.sqrt(originalSquares.length))
				{
					break;
				}
				originalSquares[i + (j * Math.sqrt(originalSquares.length))].x = (500 / 3) * (i - ((Math.sqrt(originalSquares.length) - 1) / 2));
				originalSquares[i + (j * Math.sqrt(originalSquares.length))].y = (500 / 3) * (j - ((Math.sqrt(originalSquares.length) - 1) / 2));
				if (originalSquares[i + (j * Math.sqrt(originalSquares.length))].piece is Sprite)
				{
					originalSquares[i + (j * Math.sqrt(originalSquares.length))].piece.startAttack(currentSet,playerStart,Math.sqrt(originalSquares.length));
					originalSquares[i + (j * Math.sqrt(originalSquares.length))].addEventListener(MouseEvent.MOUSE_UP, illuminate);
				}
				else
				{
					originalSquares[i + (j * Math.sqrt(originalSquares.length))].addEventListener(MouseEvent.MOUSE_UP, dilluminateAll);
				}
				addChild(originalSquares[i + (j * Math.sqrt(originalSquares.length))]);
			}
			var moveOrder:Array = [];
			var currentMovePosition:int = -1;
			var textOrder:Array = [];
			moveOrder.push(initiatingSquare);
			moveOrder.push(recievingSquare);
			var initiatingOrder:Array = [];
			var recievingOrder:Array = [];
			var possibleValues:Array = [];
			for (i = 0; i < originalSquares.length; i++)
			{
				possibleValues.push(i);
			}
			while (possibleValues.length > 0)
			{
				var randomIndex:int = Math.round(Math.random() * (possibleValues.length - 1));
				if (originalSquares[possibleValues[randomIndex]].piece is Sprite && originalSquares[possibleValues[randomIndex]] != recievingSquare && originalSquares[possibleValues[randomIndex]] != initiatingSquare)
				{
					if (moveOrder[0].piece.team == originalSquares[possibleValues[randomIndex]].piece.team)
					{
						initiatingOrder.push(originalSquares[possibleValues[randomIndex]]);
					}
					else if (moveOrder[1].piece.team == originalSquares[possibleValues[randomIndex]].piece.team)
					{
						recievingOrder.push(originalSquares[possibleValues[randomIndex]]);
					}
				}
				possibleValues.splice(randomIndex,1);
			}
			for (i = 0; i < initiatingOrder.length; i++)
			{
				moveOrder.push(initiatingOrder[i]);
			}
			for (i = 0; i < recievingOrder.length; i++)
			{
				moveOrder.push(recievingOrder[i]);
			}
			for (i = 0; i < moveOrder.length; i++)
			{
				var orderText:TextField = new TextField();
				var orderFormat:TextFormat = new TextFormat("Cambria",10,0xFFFFFF);
				orderText.defaultTextFormat = orderFormat;
				orderText.selectable = false;
				orderText.y = 15 * i;
				var pieceString:TextField = new TextField();
				pieceString.text = moveOrder[i].piece.toString();
				pieceString.replaceText(0,8,"");
				pieceString.replaceText(pieceString.getLineLength(0) - 1,pieceString.getLineLength(0),"");
				orderText.text = (i + 1) + ". " + moveOrder[i].piece.team + " " + pieceString.text;
				orderText.autoSize = TextFieldAutoSize.LEFT;
				textOrder.push(orderText);
				orderContainer.addChild(orderText);
			}
			textOrder[0].textColor = 0xFFFF33;
			moveOrder[0].IlluminateYellow();
			addChild(topContainer);
			addEventListener(Event.ENTER_FRAME,constantEvents);
			this.width = 700;
			this.height = 700;
			beginActions();
			function constantEvents(e:Event):void
			{
				for (i = 0; i < moveOrder.length; i++)
				{
					if (moveOrder[i].displayInfo)
					{
						var displayClass:String;
						if (moveOrder[i].piece is Sprite)
						{
							if (moveOrder[i].piece is Pawn)
							{
								displayClass = moveOrder[i].piece.team + currentSet + "SidePawn";
							}
							else if (moveOrder[i].piece is Bishop)
							{
								displayClass = moveOrder[i].piece.team + currentSet + "SideBishop";
							}
							else if (moveOrder[i].piece is Knight)
							{
								displayClass = moveOrder[i].piece.team + currentSet + "SideKnight";
							}
							else if (moveOrder[i].piece is Rook)
							{
								displayClass = moveOrder[i].piece.team + currentSet + "SideRook";
							}
							else if (moveOrder[i].piece is Queen)
							{
								displayClass = moveOrder[i].piece.team + currentSet + "SideQueen";
							}
							else if (moveOrder[i].piece is King)
							{
								displayClass = moveOrder[i].piece.team + currentSet + "SideKing";
							}
							displayPieceInfo(true, moveOrder[i].piece, getDefinitionByName(displayClass) as Class);
						}
						else if (moveOrder[i].holdingPiece is Sprite)
						{
							if (moveOrder[i].holdingPiece is Pawn)
							{
								displayClass = moveOrder[i].holdingPiece.team + currentSet + "SidePawn";
							}
							else if (moveOrder[i].holdingPiece is Bishop)
							{
								displayClass = moveOrder[i].holdingPiece.team + currentSet + "SideBishop";
							}
							else if (moveOrder[i].holdingPiece is Knight)
							{
								displayClass = moveOrder[i].holdingPiece.team + currentSet + "SideKnight";
							}
							else if (moveOrder[i].holdingPiece is Rook)
							{
								displayClass = moveOrder[i].holdingPiece.team + currentSet + "SideRook";
							}
							else if (moveOrder[i].holdingPiece is Queen)
							{
								displayClass = moveOrder[i].holdingPiece.team + currentSet + "SideQueen";
							}
							else if (moveOrder[i].holdingPiece is King)
							{
								displayClass = moveOrder[i].holdingPiece.team + currentSet + "SideKing";
							}
							displayPieceInfo(true, moveOrder[i].holdingPiece, getDefinitionByName(displayClass) as Class);
						}
						moveOrder[i].displayInfo = false;
					}
				}
			}
			function illuminate(e:MouseEvent):void
			{
				dilluminate();
				if (currentMovePosition >= 0)
				{
					if (e.currentTarget.piece.team == playerColor)
					{
						textOrder[currentMovePosition].textColor = 0xFFFFFF;
						textOrder[moveOrder.lastIndexOf(e.currentTarget)].textColor = 0xFFFF33;
						e.currentTarget.IlluminateYellow();
					}
					else
					{
						textOrder[currentMovePosition].textColor = 0xFFFFFF;
						textOrder[moveOrder.lastIndexOf(e.currentTarget)].textColor = 0x00CCCC;
						e.currentTarget.IlluminateBlue();
					}
				}
				else
				{
					if (e.currentTarget.piece.team == playerColor)
					{
						textOrder[0].textColor = 0xFFFFFF;
						textOrder[moveOrder.lastIndexOf(e.currentTarget)].textColor = 0xFFFF33;
						e.currentTarget.IlluminateYellow();
					}
					else
					{
						textOrder[0].textColor = 0xFFFFFF;
						textOrder[moveOrder.lastIndexOf(e.currentTarget)].textColor = 0x00CCCC;
						e.currentTarget.IlluminateBlue();
					}
				}
			}
			function dilluminateAll(e:MouseEvent):void
			{
				dilluminate();
				moveOrder[currentMovePosition].IlluminateYellow();
			}
			function dilluminate():void
			{
				for (i = 0; i < textOrder.length; i++)
				{
					textOrder[i].textColor = 0xFFFFFF;
				}
				clearDisplayPieceInfo();
				for (i = 0; i < originalSquares.length; i++)
				{
					originalSquares[i].Dilluminate();
				}
				if (currentMovePosition > 0)
				{
					textOrder[currentMovePosition].textColor = 0xFFFF33;
				}
				else
				{
					textOrder[0].textColor = 0xFFFF33;
				}
			}
			function beginActions():void
			{
				var continueFormat:TextFormat = new TextFormat("Cambria",15,0xD2BC9C);
				continueFormat.align = "center";
				continueText.width = 300;
				continueText.selectable = false;
				continueText.defaultTextFormat = continueFormat;
				continueText.border = true;
				continueText.borderColor = 0xD2BC9C;
				continueText.background = true;
				continueText.backgroundColor = 0x000000;
				continueText.multiline = true;
				continueText.wordWrap = true;
				continueText.text = "Click here when ready to begin.";
				continueText.autoSize = TextFieldAutoSize.CENTER;
				continueText.y = 20;
				continueText.x = 200;
				regressText.selectable = false;
				regressText.defaultTextFormat = continueFormat;
				regressText.border = true;
				regressText.borderColor = 0xD2BC9C;
				regressText.background = true;
				regressText.backgroundColor = 0x000000;
				regressText.multiline = true;
				regressText.wordWrap = true;
				regressText.text = "Go back.";
				regressText.autoSize = TextFieldAutoSize.CENTER;
				regressText.y = 42;
				regressText.x = 250 + (regressText.width / 2);
				attackContainer.addChild(actionContainer);
				continueText.addEventListener(MouseEvent.MOUSE_UP,mouseContinueMove);
			}
			function mouseContinueMove(e:MouseEvent):void
			{
				attackingSquare = moveOrder[0];
				continueText.removeEventListener(MouseEvent.MOUSE_UP,mouseContinueMove);
				if (attackingSquare.piece.team == playerColor)
				{
					currentMovePosition = 0
					firstAction()
				}
				else
				{
					continueMoveOrder()
				}
			}
			function firstAction():void
			{
				Animations.swirlSkills(attackingSquare,selectAction,followText,universalActionValues,checkTargets)
				continueText.text = "Please select an action.";
				continueText.autoSize = TextFieldAutoSize.CENTER;
				selectedAction = 0;
				originalStage.addEventListener(KeyboardEvent.KEY_DOWN,keyboardActions)
				function keyboardActions(e:KeyboardEvent):void
				{
					for (m = 4; m < attackingSquare.piece.skills.length; m++)
					{
						if (universalActionValues(new (getDefinitionByName(attackingSquare.piece.skills[m] + "Icon") as Class), Number) == e.keyCode && !checkTargets(new (getDefinitionByName(attackingSquare.piece.skills[m] + "Icon") as Class),attackingSquare,attackingSquare.piece))
						{
							originalStage.removeEventListener(KeyboardEvent.KEY_DOWN,keyboardActions)
							transitionToSecond()
							selectedAction = m
						}
					}
				}
			}
			function backToFirst(e:MouseEvent):void
			{
				dilluminate();
				selectedAction = 0;
				for (i = 0; i < originalSquares.length; i++)
				{
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_DOWN,act);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresGreen);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquareGreen);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresRed);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresFork);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
				}
				attackContainer.removeChild(regressText);
				continueText.text = "Please select an action.";
				continueText.autoSize = TextFieldAutoSize.CENTER;
				for (i = 0; i < originalSquares.length; i++)
				{
					if (originalSquares[i].piece is Sprite)
					{
						originalSquares[i].addEventListener(MouseEvent.MOUSE_UP, illuminate);
					}
					else
					{
						originalSquares[i].addEventListener(MouseEvent.MOUSE_UP, dilluminateAll);
					}
				}
				firstAction()
			}
			function transitionToSecond():void
			{
				Animations.unswirlSkills(attackingSquare,selectAction,followText,universalActionValues,checkTargets,secondAction)
			}
			function secondAction():void
			{
				if (selectedAction > 0)
				{
					attackContainer.addChild(regressText);
					regressText.addEventListener(MouseEvent.MOUSE_UP, backToFirst);
					continueText.text = "Please choose and click a target to act.";
					continueText.autoSize = TextFieldAutoSize.CENTER;
					Animations.clearEverything(attackingSquare.piece.inFrontContainer,attackingSquare.piece.inBackContainer)
					dilluminate();
					for (i = 0; i < originalSquares.length; i++)
					{
						originalSquares[i].removeEventListener(MouseEvent.MOUSE_UP,dilluminateAll);
						originalSquares[i].removeEventListener(MouseEvent.MOUSE_UP,illuminate);
					}
					var actionInstance:Sprite = new (getDefinitionByName(attackingSquare.piece.skills[selectedAction] + "Icon") as Class);
					if (universalActionValues(actionInstance,Array) == "defensiveSelf")
					{
						attackingSquare.addEventListener(MouseEvent.MOUSE_DOWN, act);
						attackingSquare.addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareGreen);
						attackingSquare.addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
					}
					else if (universalActionValues(actionInstance,Array) == "defensiveSquareAny")
					{
						for (j = 0; j < originalSquares.length; j++)
						{
							originalSquares[j].addEventListener(MouseEvent.MOUSE_DOWN, act);
							originalSquares[j].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresGreen);
							originalSquares[j].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
						}
					}
					else if (universalActionValues(actionInstance,Array) == "defensiveAny")
					{
						for (j = 0; j < originalSquares.length; j++)
						{
							if (originalSquares[j].piece is Sprite)
							{
								if (originalSquares[j].piece.team == playerColor)
								{
									originalSquares[j].addEventListener(MouseEvent.MOUSE_DOWN, act);
									originalSquares[j].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareGreen);
									originalSquares[j].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
								}
							}
						}
					}
					else if (universalActionValues(actionInstance,Array) == "offensiveMelee")
					{
						if (attackingSquare.piece is King || attackingSquare.piece is Queen)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									kmax = 1;
									lmax = 1;
									j = column[i].lastIndexOf(attackingSquare);
									if (i > 0)
									{
										k = -1;
									}
									else if (i == 0)
									{
										k = 0;
									}
									if (i == Math.sqrt(originalSquares.length) - 1)
									{
										kmax = 0;
									}
									for (; k <= kmax; k++)
									{
										if (j > 0)
										{
											l = -1;
										}
										else if (j == 0)
										{
											l = 0;
										}
										if (j == Math.sqrt(originalSquares.length) - 1)
										{
											lmax = 0;
										}
										for (; l <= lmax; l++)
										{
											if ((k != 0 || l != 0) && column[i + k][j + l].piece is Sprite && column[i + k][j + l].piece.team != playerColor)
											{
												column[i + k][j + l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i + k][j + l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[i + k][j + l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
								}
							}
						}
						else if (attackingSquare.piece is Rook)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									k = i + 1;
									if (k < Math.sqrt(originalSquares.length))
									{
										if (column[k][j].piece is Sprite)
										{
											if (column[k][j].piece.team != playerColor)
											{
												column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][j].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[k][j].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
									k = i - 1;
									if (k > 0)
									{
										if (column[k][j].piece is Sprite)
										{
											if (column[k][j].piece.team != playerColor)
											{
												column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][j].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[k][j].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
									l = j + 1;
									if (l < Math.sqrt(originalSquares.length))
									{
										if (column[i][l].piece is Sprite)
										{
											if (column[i][l].piece.team != playerColor)
											{
												column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[i][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
									l = j - 1;
									if (l > 0)
									{
										if (column[i][l].piece is Sprite)
										{
											if (column[i][l].piece.team != playerColor)
											{
												column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[i][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
								}
							}
						}
						else if (attackingSquare.piece is Bishop)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									k = i + 1;
									l = j + 1;
									if (! (k > Math.sqrt(originalSquares.length) - 1) && ! (l > Math.sqrt(originalSquares.length) - 1))
									{
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
									k = i - 1;
									if (! (k < 0) && ! (l > Math.sqrt(originalSquares.length) - 1))
									{
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
									l = j - 1;
									if (! (k < 0) && ! (l < 0))
									{
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
									k = j + 1;
									if (! (k > Math.sqrt(originalSquares.length) - 1) && ! (l < 0))
									{
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
								}
							}
						}
						else if (attackingSquare.piece is Pawn)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									if (j != 0)
									{
										if (column[i - 1][j - 1].piece is Sprite)
										{
											if (column[i - 1][j - 1].piece.team != playerColor)
											{
												column[i - 1][j - 1].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i - 1][j - 1].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[i - 1][j - 1].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
									if (j != Math.sqrt(originalSquares.length) - 1)
									{
										if (column[i - 1][j + 1].piece is Sprite)
										{
											if (column[i - 1][j + 1].piece.team != playerColor)
											{
												column[i - 1][j + 1].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i - 1][j + 1].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
												column[i - 1][j + 1].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
											}
										}
									}
								}
							}
						}
					}
					else if (universalActionValues(actionInstance,Array) == "offensiveMeleeFork")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(attackingSquare) >= 0)
							{
								j = column[i].lastIndexOf(attackingSquare);
								if (j != 0)
								{
									if (column[i - 1][j - 1].piece is Sprite)
									{
										if (column[i - 1][j - 1].piece.team != playerColor)
										{
											column[i - 1][j - 1].addEventListener(MouseEvent.MOUSE_DOWN, act);
											column[i - 1][j - 1].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresFork);
											column[i - 1][j - 1].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
										}
									}
								}
								if (j != Math.sqrt(originalSquares.length) - 1)
								{
									if (column[i - 1][j + 1].piece is Sprite)
									{
										if (column[i - 1][j + 1].piece.team != playerColor)
										{
											column[i - 1][j + 1].addEventListener(MouseEvent.MOUSE_DOWN, act);
											column[i - 1][j + 1].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresFork);
											column[i - 1][j + 1].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
										}
									}
								}
							}
						}
					}
					else if (universalActionValues(actionInstance,Array) == "offensivePassive")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(attackingSquare) >= 0)
							{
								j = column[i].lastIndexOf(attackingSquare);
								l = j + 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
									l++;
								}
								l = j - 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
									l--;
								}
								l = j - 1;
								for (k = i - 1; k >= 0 || l >= 0; k--)
								{
									if (k < 0 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
									l--;
								}
								l = j + 1;
								for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
								{
									if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
									l++;
								}
							}
						}
					}
					else if (universalActionValues(actionInstance,Array) == "offensiveRanged")
					{
						if (attackingSquare.piece is Knight)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									for (k = -2; k <= 2; k++)
									{
										while (i == 0 && k < 0)
										{
											k++;
										}
										if (i == 1 && k < -1)
										{
											k++;
										}
										if ((i == Math.sqrt(originalSquares.length) - 2 && k > 1) || (i == Math.sqrt(originalSquares.length) - 1 && k > 0))
										{
											break;
										}
										if (k != 0 && (k == -2 || k == 2))
										{
											if (j > 0)
											{
												l = -1;
												hilightItems(k,l);
											}
											if (j < Math.sqrt(originalSquares.length) - 1)
											{
												l = 1;
												hilightItems(k,l);
											}
										}
										if (k != 0 && (k == -1 || k == 1))
										{
											if (j > 1)
											{
												l = -2;
												hilightItems(k,l);
											}
											if (j < Math.sqrt(originalSquares.length) - 2)
											{
												l = 2;
												hilightItems(k,l);
											}
										}
										function hilightItems(k:int, l:int):void
										{
											if (column[i + k][j + l].piece is Sprite)
											{
												if (column[i + k][j + l].piece.team != playerColor)
												{
													column[i + k][j + l].addEventListener(MouseEvent.MOUSE_DOWN, act);
													column[i + k][j + l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
													column[i + k][j + l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
												}
											}
										}
									}
								}
							}
						}
						else if (attackingSquare.piece is Bishop)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									l = j + 1;
									for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
									{
										if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
										l++;
									}
									l = j - 1;
									for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
									{
										if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
										l--;
									}
									l = j - 1;
									for (k = i - 1; k >= 0 || l >= 0; k--)
									{
										if (k < 0 || l < 0)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
										l--;
									}
									l = j + 1;
									for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
									{
										if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
										l++;
									}
								}
							}
						}
						else if (attackingSquare.piece is Rook)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1; k++)
									{
										if (k > Math.sqrt(originalSquares.length) - 1)
										{
											break;
										}
										if (column[k][j].piece is Sprite)
										{
											if (column[k][j].piece.team != playerColor)
											{
												column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][j].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][j].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
									}
									for (k = i - 1; k >= 0; k--)
									{
										if (k < 0)
										{
											break;
										}
										if (column[k][j].piece is Sprite)
										{
											if (column[k][j].piece.team != playerColor)
											{
												column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][j].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][j].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
									}
									for (l = j + 1; l <= Math.sqrt(originalSquares.length) - 1; l++)
									{
										if (l > Math.sqrt(originalSquares.length) - 1)
										{
											break;
										}
										if (column[i][l].piece is Sprite)
										{
											if (column[i][l].piece.team != playerColor)
											{
												column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[i][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
									}
									for (l = j - 1; l >= 0; l--)
									{
										if (l < 0)
										{
											break;
										}
										if (column[i][l].piece is Sprite)
										{
											if (column[i][l].piece.team != playerColor)
											{
												column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[i][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
									}
								}
							}
						}
						else if (attackingSquare.piece is Queen)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									l = j + 1;
									for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
									{
										if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
										l++;
									}
									l = j - 1;
									for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
									{
										if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
										l--;
									}
									l = j - 1;
									for (k = i - 1; k >= 0 || l >= 0; k--)
									{
										if (k < 0 || l < 0)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
										l--;
									}
									l = j + 1;
									for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
									{
										if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != playerColor)
											{
												column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
										l++;
									}
									for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1; k++)
									{
										if (k > Math.sqrt(originalSquares.length) - 1)
										{
											break;
										}
										if (column[k][j].piece is Sprite)
										{
											if (column[k][j].piece.team != playerColor)
											{
												column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][j].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][j].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
									}
									for (k = i - 1; k >= 0; k--)
									{
										if (k < 0)
										{
											break;
										}
										if (column[k][j].piece is Sprite)
										{
											if (column[k][j].piece.team != playerColor)
											{
												column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[k][j].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[k][j].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
									}
									for (l = j + 1; l <= Math.sqrt(originalSquares.length) - 1; l++)
									{
										if (l > Math.sqrt(originalSquares.length) - 1)
										{
											break;
										}
										if (column[i][l].piece is Sprite)
										{
											if (column[i][l].piece.team != playerColor)
											{
												column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[i][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
									}
									for (l = j - 1; l >= 0; l--)
									{
										if (l < 0)
										{
											break;
										}
										if (column[i][l].piece is Sprite)
										{
											if (column[i][l].piece.team != playerColor)
											{
												column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
												column[i][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
												column[i][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
											}
											break;
										}
									}
								}
							}
						}
					}
					else if (universalActionValues(actionInstance,Array) == "offensivePierce")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(attackingSquare) >= 0)
							{
								j = column[i].lastIndexOf(attackingSquare);
								l = j + 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
									l++;
								}
								l = j - 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
									l--;
								}
								l = j - 1;
								for (k = i - 1; k >= 0 || l >= 0; k--)
								{
									if (k < 0 || l < 0)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
									l--;
								}
								l = j + 1;
								for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
								{
									if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
									l++;
								}
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][j].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
									column[k][j].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
								}
								for (k = i - 1; k >= 0; k--)
								{
									if (k < 0)
									{
										break;
									}
									column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][j].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
									column[k][j].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
								}
								for (l = j + 1; l <= Math.sqrt(originalSquares.length) - 1; l++)
								{
									if (l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[i][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
									column[i][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
								}
								for (l = j - 1; l >= 0; l--)
								{
									if (l < 0)
									{
										break;
									}
									column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[i][l].addEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
									column[i][l].addEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
								}
							}
						}
					}
					else if (universalActionValues(actionInstance,Array) == "offensiveAny")
					{
						for (i = 0; i < originalSquares.length; i++)
						{
							if (originalSquares[i].piece is Sprite)
							{
								if (originalSquares[i].piece.team != playerColor)
								{
									originalSquares[i].addEventListener(MouseEvent.MOUSE_DOWN, act);
									originalSquares[i].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquareRed);
									originalSquares[i].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
								}
							}
						}
					}
					else if (universalActionValues(actionInstance,Array) == "offensiveRangedArea")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(attackingSquare) >= 0)
							{
								j = column[i].lastIndexOf(attackingSquare);
								l = j + 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
									if (column[k][l].piece is Sprite)
									{
										break;
									}
									l++;
								}
								l = j - 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
									if (column[k][l].piece is Sprite)
									{
										break;
									}
									l--;
								}
								l = j - 1;
								for (k = i - 1; k >= 0 || l >= 0; k--)
								{
									if (k < 0 || l < 0)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
									if (column[k][l].piece is Sprite)
									{
										break;
									}
									l--;
								}
								l = j + 1;
								for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
								{
									if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									column[k][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[k][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
									if (column[k][l].piece is Sprite)
									{
										break;
									}
									l++;
								}
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][j].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[k][j].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
									if (column[k][j].piece is Sprite)
									{
										break;
									}
								}
								for (k = i - 1; k >= 0; k--)
								{
									if (k < 0)
									{
										break;
									}
									column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][j].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[k][j].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
									if (column[k][j].piece is Sprite)
									{
										break;
									}
								}
								for (l = j + 1; l <= Math.sqrt(originalSquares.length) - 1; l++)
								{
									if (l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[i][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[i][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
									if (column[i][l].piece is Sprite)
									{
										break;
									}
								}
								for (l = j - 1; l >= 0; l--)
								{
									if (l < 0)
									{
										break;
									}
									column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[i][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[i][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
									if (column[i][l].piece is Sprite)
									{
										break;
									}
								}
							}
						}
					}
					else if (universalActionValues(actionInstance,Array) == "offensiveMeleeArea")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(attackingSquare) >= 0)
							{
								j = column[i].lastIndexOf(attackingSquare);
								k = i + 1;
								if (k < Math.sqrt(originalSquares.length))
								{
									column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][j].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[k][j].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
								}
								k = i - 1;
								if (k >= 0)
								{
									column[k][j].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[k][j].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[k][j].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
								}
								l = j + 1;
								if (l < Math.sqrt(originalSquares.length))
								{
									column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[i][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[i][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
								}
								l = j - 1;
								if (l >= 0)
								{
									column[i][l].addEventListener(MouseEvent.MOUSE_DOWN, act);
									column[i][l].addEventListener(MouseEvent.MOUSE_OVER, illuminateSquaresRed);
									column[i][l].addEventListener(MouseEvent.MOUSE_OUT, rollDilluminateAll);
								}
							}
						}
					}
				}
			}
			function act(e:MouseEvent):void
			{
				if (attackContainer.contains(regressText))
				{
					attackContainer.removeChild(regressText);
				}
				var iconClass:Class = getDefinitionByName(attackingSquare.piece.skills[selectedAction] + "Icon") as Class;
				dilluminate();
				for (i = 0; i < originalSquares.length; i++)
				{
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_DOWN,act);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresGreen);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquareGreen);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresRed);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquareRed);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresPierce);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OVER,illuminateSquaresFork);
					originalSquares[i].removeEventListener(MouseEvent.MOUSE_OUT,rollDilluminateAll);
				}
				defendingSquare = e.currentTarget as Object;
				if (iconClass == restIcon)
				{
					attackingSquare.piece.heal(Math.ceil(0.02 * attackingSquare.piece.totalHealth));
					attackingSquare.piece.recharge(5);
				}
				else if (iconClass == restoreHealthIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new restoreHealthIcon(), int));
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(defendingSquare) >= 0)
						{
							kmax = 1;
							lmax = 1;
							j = column[i].lastIndexOf(defendingSquare);
							if (i > 0)
							{
								k = -1;
							}
							else if (i == 0)
							{
								k = 0;
							}
							if (i == Math.sqrt(originalSquares.length) - 1)
							{
								kmax = 0;
							}
							for (; k <= kmax; k++)
							{
								if (j > 0)
								{
									l = -1;
								}
								else if (j == 0)
								{
									l = 0;
								}
								if (j == Math.sqrt(originalSquares.length) - 1)
								{
									lmax = 0;
								}
								for (; l <= lmax; l++)
								{
									if (column[i + k][j + l].piece is Sprite)
									{
										column[i + k][j + l].piece.heal(Math.round(column[i + k][j + l].piece.totalHealth * (0.2 * ((attackingSquare.piece.mastery * .1) + 1))));
									}
								}
							}
						}
					}
				}
				else if (iconClass == restoreManaIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new restoreManaIcon(), int));
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(defendingSquare) >= 0)
						{
							kmax = 1;
							lmax = 1;
							j = column[i].lastIndexOf(defendingSquare);
							if (i > 0)
							{
								k = -1;
							}
							else if (i == 0)
							{
								k = 0;
							}
							if (i == Math.sqrt(originalSquares.length) - 1)
							{
								kmax = 0;
							}
							for (; k <= kmax; k++)
							{
								if (j > 0)
								{
									l = -1;
								}
								else if (j == 0)
								{
									l = 0;
								}
								if (j == Math.sqrt(originalSquares.length) - 1)
								{
									lmax = 0;
								}
								for (; l <= lmax; l++)
								{
									if (column[i + k][j + l].piece is Sprite)
									{
										column[i + k][j + l].piece.recharge(100 * (0.2 * ((attackingSquare.piece.mastery * .1) + 1)));
									}
								}
							}
						}
					}
				}
				else if (iconClass == protectIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new protectIcon(), int));
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(defendingSquare) >= 0)
						{
							kmax = 1;
							lmax = 1;
							j = column[i].lastIndexOf(defendingSquare);
							if (i > 0)
							{
								k = -1;
							}
							else if (i == 0)
							{
								k = 0;
							}
							if (i == Math.sqrt(originalSquares.length) - 1)
							{
								kmax = 0;
							}
							for (; k <= kmax; k++)
							{
								if (j > 0)
								{
									l = -1;
								}
								else if (j == 0)
								{
									l = 0;
								}
								if (j == Math.sqrt(originalSquares.length) - 1)
								{
									lmax = 0;
								}
								for (; l <= lmax; l++)
								{
									if (column[i + k][j + l].piece is Sprite)
									{
										column[i + k][j + l].piece.becomeProtected(0.2 * ((attackingSquare.piece.mastery * .1) + 1));
									}
								}
							}
						}
					}
				}
				else if (iconClass == inspireIcon)
				{
					attackingSquare.piece.inspire([defendingSquare.piece]);
					attackingSquare.piece.decharge(universalActionValues(new inspireIcon(), int));
				}
				else if (iconClass == shieldIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new shieldIcon(), int));
					attackingSquare.piece.shield();
				}
				else if (iconClass == enrageIcon)
				{
					attackingSquare.piece.baseDamage += 10
					attackingSquare.piece.decharge(universalActionValues(new enrageIcon(), int));
					attackingSquare.piece.enrage();
				}
				else if (iconClass == disappearIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new disappearIcon(), int));
					attackingSquare.piece.disappear();
				}
				else if (iconClass == defendIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new defendIcon(), int));
					attackingSquare.piece.defend();
				}
				else if (iconClass == freezeIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new freezeIcon(), int));
					if (defendingSquare.piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece))
					{
						defendingSquare.piece.freeze();
						moveToEnd(defendingSquare);
					}
				}
				else if (iconClass == poisonIcon)
				{
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							attackingSquare.piece.decharge(universalActionValues(new poisonIcon(), int));
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									attackingSquare.piece.throwStar(n - j, m - i);
								}
							}
							if (defendingSquare.piece.hurt(Math.round(attackingSquare.piece.baseDamage / 2),attackingSquare,killPiece))
							{
								defendingSquare.piece.addPoison(attackingSquare);
							}
						}
					}
				}
				else if (iconClass == forkIcon)
				{
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									attackingSquare.piece.attack(n - j, m - i);
									attackingSquare.piece.decharge(universalActionValues(new forkIcon(), int));
									if (n > j)
									{
										if (j > 0)
										{
											if (column[i - 1][j - 1].piece is Sprite)
											{
												attackingSquare.piece.attack(n - j - 2, m - i);
												column[i - 1][j - 1].piece.hurt(attackingSquare.piece.totalDamage,attackingSquare,killPiece);
											}
										}
									}
									else
									{
										if (j < Math.sqrt(originalSquares.length) - 1)
										{
											if (column[i - 1][j + 1].piece is Sprite)
											{
												attackingSquare.piece.attack(n - j + 2, m - i);
												column[i - 1][j + 1].piece.hurt(attackingSquare.piece.totalDamage,attackingSquare,killPiece);
											}
										}
									}
								}
							}
							defendingSquare.piece.hurt(attackingSquare.piece.totalDamage,attackingSquare,killPiece);
						}
					}
				}
				else if (iconClass == powerAttackIcon)
				{
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									attackingSquare.piece.decharge(universalActionValues(new powerAttackIcon(), int));
									attackingSquare.piece.attack(n - j, m - i);
									attackingSquare.piece.attack(n - j, m - i);
								}
							}
							defendingSquare.piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.2),attackingSquare,killPiece);
						}
					}

				}
				else if (iconClass == bleedIcon)
				{
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									attackingSquare.piece.decharge(universalActionValues(new bleedIcon(), int));
									attackingSquare.piece.attack(n - j, m - i);
								}
							}
							if (defendingSquare.piece.hurt(Math.round(attackingSquare.piece.baseDamage / 2),attackingSquare,killPiece))
							{
								defendingSquare.piece.bleed();
							}
						}
					}
				}
				else if (iconClass == smashIcon)
				{
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(defendingSquare) >= 0)
						{
							var attackingSquareX:int;
							var attackingSquareY:int;
							for (k = 0; k < column.length; k++)
							{
								if (column[k].lastIndexOf(attackingSquare) >= 0)
								{
									attackingSquareY = k;
									attackingSquareX = column[k].lastIndexOf(attackingSquare);
									break;
								}
							}
							kmax = 1;
							lmax = 1;
							j = column[i].lastIndexOf(defendingSquare);
							if (defendingSquare.piece is Sprite)
							{
								defendingSquare.piece.smash();
							}
							else
							{
								Animations.smash(defendingSquare,defendingSquare.inFrontContainer,defendingSquare.inBackContainer);
							}
							attackingSquare.piece.decharge(universalActionValues(new smashIcon(), int));
							if (i > 0)
							{
								k = -1;
							}
							else if (i == 0)
							{
								k = 0;
							}
							if (i == Math.sqrt(originalSquares.length) - 1)
							{
								kmax = 0;
							}
							for (; k <= kmax; k++)
							{
								if (j > 0)
								{
									l = -1;
								}
								else if (j == 0)
								{
									l = 0;
								}
								if (j == Math.sqrt(originalSquares.length) - 1)
								{
									lmax = 0;
								}
								for (; l <= lmax; l++)
								{
									if (!(i + k == attackingSquareY && j + l == attackingSquareX))
									{
										if (column[i + k][j + l].piece is Sprite)
										{
											if (k == 0 && l == 0)
											{
												column[i + k][j + l].piece.hurt(attackingSquare.piece.baseDamage,attackingSquare,killPiece);
											}
											else
											{
												column[i + k][j + l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * (3 / 4)),attackingSquare,killPiece);
											}
										}
									}
								}
							}
						}
					}
				}
				else if (iconClass == assassinateIcon)
				{
					defendingSquare.piece.die(attackingSquare,killPiece);
					attackingSquare.piece.decharge(universalActionValues(new assassinateIcon(), int));
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(attackingSquare) >= 0)
						{
							n = column[m].lastIndexOf(attackingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(defendingSquare) >= 0)
								{
									j = column[i].lastIndexOf(defendingSquare);
									attackingSquare.piece.assassinate(n - j, m - i);
								}
							}
						}
					}
				}
				else if (iconClass == fireballIcon)
				{
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(defendingSquare) >= 0)
						{
							for (k = 0; k < column.length; k++)
							{
								if (column[k].lastIndexOf(attackingSquare) >= 0)
								{
									attackingSquareY = k;
									attackingSquareX = column[k].lastIndexOf(attackingSquare);
									break;
								}
							}
							kmax = 1;
							lmax = 1;
							j = column[i].lastIndexOf(defendingSquare);
							attackingSquare.piece.decharge(universalActionValues(new fireballIcon(), int));
							attackingSquare.piece.throwFireball(attackingSquareX - j, attackingSquareY - i);
							if (defendingSquare.piece is Sprite)
							{
								defendingSquare.piece.recieveFireball();
							}
							else
							{
								Animations.recieveFireball(defendingSquare,defendingSquare.inFrontContainer,defendingSquare.inBackContainer);
							}
							if (i > 0)
							{
								k = -1;
							}
							else if (i == 0)
							{
								k = 0;
							}
							if (i == Math.sqrt(originalSquares.length) - 1)
							{
								kmax = 0;
							}
							for (; k <= kmax; k++)
							{
								if (j > 0)
								{
									l = -1;
								}
								else if (j == 0)
								{
									l = 0;
								}
								if (j == Math.sqrt(originalSquares.length) - 1)
								{
									lmax = 0;
								}
								for (; l <= lmax; l++)
								{
									if (!(i + k == attackingSquareY && j + l == attackingSquareX))
									{
										if (column[i + k][j + l].piece is Sprite)
										{
											if (k == 0 && l == 0)
											{
												column[i + k][j + l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * (3 / 4)),attackingSquare,killPiece);
											}
											else
											{
												column[i + k][j + l].piece.hurt(Math.round(attackingSquare.piece.baseDamage / 2),attackingSquare,killPiece);
											}
										}
									}
								}
							}
						}
					}
				}
				else if (iconClass == woundIcon)
				{
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									attackingSquare.piece.decharge(universalActionValues(new woundIcon(), int));
									attackingSquare.piece.attack(n - j, m - i);
								}
							}
							if (defendingSquare.piece.hurt(attackingSquare.piece.baseDamage,attackingSquare,killPiece))
							{
								defendingSquare.piece.wound();
							}
						}
					}
				}
				else if (iconClass == layTrapIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new layTrapIcon(), int));
					Animations.layTrap(defendingSquare,defendingSquare.inFrontContainer,defendingSquare.inBackContainer,attackingSquare.piece);
				}
				else if (iconClass == laserIcon)
				{
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(attackingSquare) >= 0)
						{
							j = column[i].lastIndexOf(attackingSquare);
							for (k = 0; k < column.length; k++)
							{
								if (column[k].lastIndexOf(defendingSquare) >= 0)
								{
									l = column[k].lastIndexOf(defendingSquare);
									attackingSquare.piece.decharge(universalActionValues(new laserIcon(),int))
									attackingSquare.piece.shootLaser(j - l,i - k)
									break;
								}
							}
							if (k < i && l < j)
							{
								l = j + 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										column[k][l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece)
									}
									l++;
								}
							}
							if (k > i && l > j)
							{
								l = j - 1;
								for (k = i - 1; k >= 0 || l >= 0; k--)
								{
									if (k < 0 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										column[k][l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece)
									}
									l--;
								}
							}
							if (k < i && l > j)
							{
								l = j + 1;
								for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
								{
									if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										column[k][l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece)
									}
									l++;
								}
							}
							if (k > i && l < j)
							{
								l = j - 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										column[k][l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece)
									}
									l--;
								}
							}
							if (k > i && l == j)
							{
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										column[k][l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece)
									}
								}
							}
							if (k < i && l == j)
							{
								for (k = i - 1; k >= 0; k--)
								{
									if (k < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										column[k][l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece)
									}
								}
							}
							if (k == i && l > j)
							{
								for (l = j + 1; l <= Math.sqrt(originalSquares.length) - 1; l++)
								{
									if (l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										column[k][l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece)
									}
								}
							}
							if (k == i && l < j)
							{
								for (l = j - 1; l >= 0; l--)
								{
									if (l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										column[k][l].piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece)
									}
								}
							}
						}
					}
				}
				else if (iconClass == throwAxeIcon)
				{
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									attackingSquare.piece.throwAxe(n - j, m - i);
									attackingSquare.piece.decharge(universalActionValues(new throwAxeIcon(), int));
								}
							}
							defendingSquare.piece.hurt(Math.round(attackingSquare.piece.baseDamage * 1.5),attackingSquare,killPiece);
						}
					}
				}
				else if (iconClass == longshotIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new longshotIcon(), int));
					attackingSquare.piece.longshot(defendingSquare)
					defendingSquare.piece.hurt(Math.round(attackingSquare.piece.baseDamage * .15),attackingSquare,killPiece)
				}
				else if (iconClass == aimedShotIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new aimedShotIcon(), int));
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare)
									attackingSquare.piece.aimedShot(j - n, i - m)
								}
							}
						}
					}
					var chanceStorage:Number = attackingSquare.piece.criticalChance
					attackingSquare.piece.criticalChance = 0.5
					defendingSquare.piece.hurt(attackingSquare.piece.baseDamage,attackingSquare,killPiece)
					attackingSquare.piece.criticalChance = chanceStorage
				}
				else if (iconClass == injureIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new injureIcon(), int));
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare)
									attackingSquare.piece.aimedShot(j - n, i - m)
								}
							}
						}
					}
					if (defendingSquare.piece.hurt(Math.round(attackingSquare.piece.baseDamage * 0.75),attackingSquare,killPiece))
					{
						defendingSquare.piece.wound();
						moveToEnd(defendingSquare);
					}
				}
				else if (iconClass == stunIcon)
				{
					attackingSquare.piece.decharge(universalActionValues(new stunIcon(), int));
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare)
									attackingSquare.piece.aimedShot(j - n, i - m)
								}
							}
						}
					}
					var stunStorage:Number = attackingSquare.piece.stunChance
					attackingSquare.piece.stunChance = 1
					defendingSquare.piece.hurt(Math.round(attackingSquare.piece.baseDamage * 0.7),attackingSquare,killPiece)
					attackingSquare.piece.stunChance = stunStorage
				}
				else if (iconClass == pawnAttackIcon || iconClass == bishopAttackIcon || iconClass == knightAttackIcon || iconClass == rookAttackIcon || iconClass == queenAttackIcon || iconClass == unequippedAttackIcon)
				{
					for (m = 0; m < column.length; m++)
					{
						if (column[m].lastIndexOf(defendingSquare) >= 0)
						{
							n = column[m].lastIndexOf(defendingSquare);
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(attackingSquare) >= 0)
								{
									j = column[i].lastIndexOf(attackingSquare);
									attackingSquare.piece.attack(n - j, m - i);
								}
							}
							defendingSquare.piece.hurt(attackingSquare.piece.totalDamage,attackingSquare,killPiece);
						}
					}
				}
				var actionType:String = universalActionValues(new iconClass(),Array)
				if (actionType == "defensiveSelf" || actionType == "defensiveSquareAny" || actionType == "offensiveMeleeFork" || actionType == "offensivePassive" || actionType == "offensivePierce" || actionType == "offensiveMeleeArea" || actionType == "offensiveRangedArea")
				{
					displayAction(attackingSquare,false,defendingSquare,universalActionValues(new iconClass(),Sprite))
				}
				else
				{
					displayAction(attackingSquare,true,defendingSquare,universalActionValues(new iconClass(),Sprite))
				}
				wait36Frames()
			}
			function displayAction(actionCaller:Object,reciever:Boolean,actionReciever:Object,displayString:String):void
			{
				var displayText:TextField = new TextField()
				var displayFormat:TextFormat = new TextFormat("Cambria",10,0xFFFFFF);
				displayFormat.align = "right"
				displayText.defaultTextFormat = displayFormat;
				displayText.selectable = false;
				displayText.y = 500 + (currentMovePosition * 15)
				displayText.x = -displayText.width
				var startString:TextField = new TextField();
				if (actionCaller.piece is Sprite)
				{
					startString.text = actionCaller.piece.toString();
					startString.replaceText(0,8,"");
					startString.replaceText(startString.getLineLength(0) - 1,startString.getLineLength(0),"");
					displayText.text = (currentMovePosition + 1) + ". " + actionCaller.piece.team + " " + startString.text + " " + displayString
				}
				else if (actionCaller.holdingPiece is Sprite)
				{
					startString.text = actionCaller.holdingPiece.toString();
					startString.replaceText(0,8,"");
					startString.replaceText(startString.getLineLength(0) - 1,startString.getLineLength(0),"");
					displayText.text = (currentMovePosition + 1) + ". " + actionCaller.holdingPiece.team + " " + startString.text + " " + displayString
				}
				if (reciever)
				{
					var endString:TextField = new TextField();
					if (actionCaller.piece is Sprite)
					{
						endString.text = actionReciever.piece.toString();
						endString.replaceText(0,8,"");
						endString.replaceText(endString.getLineLength(0) - 1,endString.getLineLength(0),"");
						displayText.text = (currentMovePosition + 1) + ". " + actionCaller.piece.team + " " + startString.text + " " + displayString + " " + actionReciever.piece.team + " " + endString.text + "."
					}
					else if (actionCaller.holdingPiece is Sprite)
					{
						endString.text = actionReciever.holdingPiece.toString();
						endString.replaceText(0,8,"");
						endString.replaceText(endString.getLineLength(0) - 1,endString.getLineLength(0),"");
						displayText.text = (currentMovePosition + 1) + ". " + actionCaller.holdingPiece.team + " " + startString.text + " " + displayString + " " + actionReciever.piece.team + " " + endString.text + "."
					}
				}
				displayText.autoSize = TextFieldAutoSize.RIGHT;
				pastActionContainer.addChild(displayText);
				addEventListener(Event.ENTER_FRAME,ascendText)
				var displayTimer:int = 0
				function ascendText(e:Event):void
				{
					if (actionCaller.piece is Sprite)
					{
						displayText.text = (currentMovePosition + 1) + ". " + actionCaller.piece.team + " " + startString.text + " " + displayString
					}
					else if (actionCaller.holdingPiece is Sprite)
					{
						displayText.text = (currentMovePosition + 1) + ". " + actionCaller.holdingPiece.team + " " + startString.text + " " + displayString
					}
					if (reciever)
					{
						if (actionCaller.piece is Sprite)
						{
							displayText.text = (currentMovePosition + 1) + ". " + actionCaller.piece.team + " " + startString.text + " " + displayString + " " + actionReciever.piece.team + " " + endString.text + "."
						}
						else if (actionCaller.holdingPiece is Sprite)
						{
							displayText.text = (currentMovePosition + 1) + ". " + actionCaller.holdingPiece.team + " " + startString.text + " " + displayString + " " + actionReciever.piece.team + " " + endString.text + "."
						}
					}
					displayTimer++
					displayText.y -= 500 / 35
					if (displayTimer == 35)
					{
						displayText.y = (currentMovePosition) * 15
						removeEventListener(Event.ENTER_FRAME,ascendText)
					}
				}
			}
			function moveToEnd(defendingSquare:Object):void
			{
				var object:TextField = textOrder[moveOrder.lastIndexOf(defendingSquare)]
				var textTimer:int = 0;
				addEventListener(Event.ENTER_FRAME, moveText);
				var startingY:Number = object.y;
				function moveText(e:Event):void
				{
					textTimer++;
					if (textTimer <= 12)
					{
						object.x += (object.width + 10) / 12;
					}
					else if (textTimer > 12 && textTimer <= 24)
					{
						for (i = textOrder.lastIndexOf(object); i < textOrder.length; i++)
						{
							textOrder[i].y -=  15 / 12;
						}
						object.y += ((textOrder.length * 15) - startingY) / 12;
					}
					else if (textTimer > 24 && textTimer <= 35)
					{
						object.x -= (object.width + 10) / 11;
					}
					else if (textTimer == 36)
					{
						removeEventListener(Event.ENTER_FRAME, moveText);
						moveOrder.splice(moveOrder.lastIndexOf(defendingSquare), 1)
						moveOrder.push(defendingSquare);
						textOrder.splice(textOrder.lastIndexOf(object), 1)
						textOrder.push(object);
						for (i = 0; i < textOrder.length; i++)
						{
							textOrder[i].y = 15 * i;
							textOrder[i].x = 0;
						}
					}
				}
			}
			function killPiece(square:Array):void
			{
				if (square[0] == recievingSquare)
				{
					movePiece = true
				}
				var killString:TextField = new TextField();
				killString.text = moveOrder[moveOrder.lastIndexOf(square[0])].piece.toString();
				killString.replaceText(0,8,"");
				killString.replaceText(killString.getLineLength(0) - 1,killString.getLineLength(0),"");
				textOrder[moveOrder.lastIndexOf(square[0])].text = (moveOrder.lastIndexOf(square[0]) + 1) + ". " + moveOrder[moveOrder.lastIndexOf(square[0])].piece.team + " " + killString.text + " --- Dead"
			}
			function checkTargets(skill:Sprite, pieceSquare:Sprite, currentPiece:Sprite):Boolean
			{
				if (currentPiece is Pawn)
				{
					if (universalActionValues(skill,Array) == "offensiveMelee" || universalActionValues(skill,Array) == "offensiveMeleeFork")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								j = column[i].lastIndexOf(pieceSquare);
								if (j != 0 && i != 0)
								{
									if (column[i - 1][j - 1].piece is Sprite)
									{
										if (column[i - 1][j - 1].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								if (j != Math.sqrt(originalSquares.length) - 1 && i != 0)
								{
									if (column[i - 1][j + 1].piece is Sprite)
									{
										if (column[i - 1][j + 1].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								return true;
							}
						}
					}
					return false;
				}
				else if (currentPiece is Knight)
				{
					if (universalActionValues(skill,Array) == "offensiveMelee")
					{
						return true;
					}
					else if (universalActionValues(skill,Array) == "offensiveRanged")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								var tempReturn:Boolean = false;
								j = column[i].lastIndexOf(pieceSquare);
								for (k = -2; k <= 2; k++)
								{
									while (i == 0 && k < 0)
									{
										k++;
									}
									if (i == 1 && k < -1)
									{
										k++;
									}
									if ((i == Math.sqrt(originalSquares.length) - 2 && k > 1) || (i == Math.sqrt(originalSquares.length) - 1 && k > 0))
									{
										break;
									}
									if (k != 0 && (k == -2 || k == 2))
									{
										if (j > 0)
										{
											l = -1;
											hilightItems(k,l);
										}
										if (j < Math.sqrt(originalSquares.length) - 1)
										{
											l = 1;
											hilightItems(k,l);
										}
									}
									if (k != 0 && (k == -1 || k == 1))
									{
										if (j > 1)
										{
											l = -2;
											hilightItems(k,l);
										}
										if (j < Math.sqrt(originalSquares.length) - 2)
										{
											l = 2;
											hilightItems(k,l);
										}
									}
									function hilightItems(k:int, l:int):void
									{
										if (column[i + k][j + l].piece is Sprite)
										{
											if (column[i + k][j + l].piece.team != playerColor)
											{
												tempReturn = true;
											}
										}
									}
								}
								if (tempReturn)
								{
									return false;
								}
								return true;
							}
						}
					}
					return false;
				}
				else if (currentPiece is Bishop)
				{
					if (universalActionValues(skill,Array) == "offensiveMelee")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								j = column[i].lastIndexOf(pieceSquare);
								k = i + 1;
								l = j + 1;
								if (! (k > Math.sqrt(originalSquares.length) - 1) && ! (l > Math.sqrt(originalSquares.length) - 1))
								{
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								k = i - 1;
								if (! (k < 0) && ! (l > Math.sqrt(originalSquares.length) - 1))
								{
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								l = j - 1;
								if (! (k < 0) && ! (l < 0))
								{
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								k = j + 1;
								if (! (k > Math.sqrt(originalSquares.length) - 1) && ! (l < 0))
								{
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								return true;
							}
						}
					}
					else if (universalActionValues(skill,Array) == "offensiveRanged")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								j = column[i].lastIndexOf(pieceSquare);
								l = j + 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
									l++;
								}
								l = j - 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
									l--;
								}
								l = j - 1;
								for (k = i - 1; k >= 0 || l >= 0; k--)
								{
									if (k < 0 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
									l--;
								}
								l = j + 1;
								for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
								{
									if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
									l++;
								}
								return true;
							}
						}
					}
					else if (universalActionValues(skill,Array) == "offensivePassive")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								j = column[i].lastIndexOf(pieceSquare);
								k = i + 1;
								l = j + 1;
								if (! (k > Math.sqrt(originalSquares.length) - 1) && ! (l > Math.sqrt(originalSquares.length) - 1))
								{
									if (!(column[k][l].piece is Sprite))
									{
										return false;
									}
								}
								k = i - 1;
								if (! (k < 0) && ! (l > Math.sqrt(originalSquares.length) - 1))
								{
									if (!(column[k][l].piece is Sprite))
									{
										return false;
									}
								}
								l = j - 1;
								if (! (k < 0) && ! (l < 0))
								{
									if (!(column[k][l].piece is Sprite))
									{
										return false;
									}
								}
								k = j + 1;
								if (! (k > Math.sqrt(originalSquares.length) - 1) && ! (l < 0))
								{
									if (!(column[k][l].piece is Sprite))
									{
										return false;
									}
								}
								return true;
							}
						}
					}
					return false;
				}
				else if (currentPiece is Rook)
				{
					if (universalActionValues(skill,Array) == "offensiveMeleeArea")
					{
						return false;
					}
					if (universalActionValues(skill,Array) == "offensiveMelee")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								j = column[i].lastIndexOf(pieceSquare);
								k = i + 1;
								if (k < Math.sqrt(originalSquares.length))
								{
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								k = i - 1;
								if (k > 0)
								{
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								l = j + 1;
								if (l < Math.sqrt(originalSquares.length))
								{
									if (column[i][l].piece is Sprite)
									{
										if (column[i][l].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								l = j - 1;
								if (l > 0)
								{
									if (column[i][l].piece is Sprite)
									{
										if (column[i][l].piece.team != playerColor)
										{
											return false;
										}
									}
								}
								return true;
							}
						}
					}
					else if (universalActionValues(skill,Array) == "offensiveRanged")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								j = column[i].lastIndexOf(pieceSquare);
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
								}
								for (k = i - 1; k >= 0; k--)
								{
									if (k < 0)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
								}
								for (l = j + 1; l <= Math.sqrt(originalSquares.length) - 1; l++)
								{
									if (l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[i][l].piece is Sprite)
									{
										if (column[i][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
								}
								for (l = j - 1; l >= 0; l--)
								{
									if (l < 0)
									{
										break;
									}
									if (column[i][l].piece is Sprite)
									{
										if (column[i][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
								}
								return true;
							}
						}
					}
					return false;
				}
				else if (currentPiece is Queen)
				{
					if (universalActionValues(skill,Array) == "offensiveMelee")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								kmax = 1;
								lmax = 1;
								j = column[i].lastIndexOf(pieceSquare);
								if (i > 0)
								{
									k = -1;
								}
								else if (i == 0)
								{
									k = 0;
								}
								if (i == Math.sqrt(originalSquares.length) - 1)
								{
									kmax = 0;
								}
								for (; k <= kmax; k++)
								{
									if (j > 0)
									{
										l = -1;
									}
									else if (j == 0)
									{
										l = 0;
									}
									if (j == Math.sqrt(originalSquares.length) - 1)
									{
										lmax = 0;
									}
									for (; l <= lmax; l++)
									{
										if (column[i + k][j + l].piece is Sprite)
										{
											if (column[i + k][j + l].piece.team != playerColor)
											{
												return false;
											}
										}
									}
								}
								return true;
							}
						}
					}
					else if (universalActionValues(skill,Array) == "offensiveRanged" || universalActionValues(skill,Array) == "offensivePierce" || universalActionValues(skill,Array) == "offensiveRangedArea")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								j = column[i].lastIndexOf(pieceSquare);
								l = j + 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
									l++;
								}
								l = j - 1;
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
									l--;
								}
								l = j - 1;
								for (k = i - 1; k >= 0 || l >= 0; k--)
								{
									if (k < 0 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
									l--;
								}
								l = j + 1;
								for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
								{
									if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
									l++;
								}
								for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1; k++)
								{
									if (k > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
								}
								for (k = i - 1; k >= 0; k--)
								{
									if (k < 0)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
								}
								for (l = j + 1; l <= Math.sqrt(originalSquares.length) - 1; l++)
								{
									if (l > Math.sqrt(originalSquares.length) - 1)
									{
										break;
									}
									if (column[i][l].piece is Sprite)
									{
										if (column[i][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
								}
								for (l = j - 1; l >= 0; l--)
								{
									if (l < 0)
									{
										break;
									}
									if (column[i][l].piece is Sprite)
									{
										if (column[i][l].piece.team != playerColor)
										{
											return false;
										}
										break;
									}
								}
								return true;
							}
						}
					}
					return false;
				}
				else if (currentPiece is King)
				{
					if (universalActionValues(skill,Array) == "offensiveMelee")
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(pieceSquare) >= 0)
							{
								kmax = 1;
								lmax = 1;
								j = column[i].lastIndexOf(pieceSquare);
								if (i > 0)
								{
									k = -1;
								}
								else if (i == 0)
								{
									k = 0;
								}
								if (i == Math.sqrt(originalSquares.length) - 1)
								{
									kmax = 0;
								}
								for (; k <= kmax; k++)
								{
									if (j > 0)
									{
										l = -1;
									}
									else if (j == 0)
									{
										l = 0;
									}
									if (j == Math.sqrt(originalSquares.length) - 1)
									{
										lmax = 0;
									}
									for (; l <= lmax; l++)
									{
										if (column[i + k][j + l].piece is Sprite)
										{
											if (column[i + k][j + l].piece.team != playerColor)
											{
												return false;
											}
										}
									}
								}
								return true;
							}
						}
					}
					return false;
				}
				return true;
			}
			function illuminateSquareGreen(e:MouseEvent)
			{
				dilluminate();
				for (i = 0; i < column.length; i++)
				{
					if (column[i].lastIndexOf(e.currentTarget) >= 0)
					{
						j = column[i].lastIndexOf(e.currentTarget);
						if (column[i][j].piece is Sprite)
						{
							textOrder[moveOrder.lastIndexOf(column[i][j])].textColor = 0x00AA00;
						}
						column[i][j].IlluminateLightGreen();
					}
				}
			}
			function illuminateSquareRed(e:MouseEvent)
			{
				dilluminate();
				for (i = 0; i < column.length; i++)
				{
					if (column[i].lastIndexOf(e.currentTarget) >= 0)
					{
						j = column[i].lastIndexOf(e.currentTarget);
						if (column[i][j].piece is Sprite)
						{
							textOrder[moveOrder.lastIndexOf(column[i][j])].textColor = 0xFF0000;
						}
						column[i][j].IlluminateLightRed();
					}
				}
			}
			function illuminateSquaresPierce(e:MouseEvent)
			{
				for (i = 0; i < column.length; i++)
				{
					if (column[i].lastIndexOf(attackingSquare) >= 0)
					{
						j = column[i].lastIndexOf(attackingSquare);
						for (k = 0; k < column.length; k++)
						{
							if (column[k].lastIndexOf(e.currentTarget) >= 0)
							{
								l = column[k].lastIndexOf(e.currentTarget);
								break;
							}
						}
						if (k < i && l < j)
						{
							l = j + 1;
							for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l <= Math.sqrt(originalSquares.length) - 1; k++)
							{
								if (k > Math.sqrt(originalSquares.length) - 1 || l > Math.sqrt(originalSquares.length) - 1)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[k][l])].textColor = 0xFF0000;
								}
								column[k][l].IlluminateLightRed();
								l++;
							}
						}
						if (k > i && l > j)
						{
							l = j - 1;
							for (k = i - 1; k >= 0 || l >= 0; k--)
							{
								if (k < 0 || l < 0)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[k][l])].textColor = 0xFF0000;
								}
								column[k][l].IlluminateLightRed();
								l--;
							}
						}
						if (k < i && l > j)
						{
							l = j + 1;
							for (k = i - 1; k >= 0 || l <= Math.sqrt(originalSquares.length) - 1; k--)
							{
								if (k < 0 || l > Math.sqrt(originalSquares.length) - 1)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[k][l])].textColor = 0xFF0000;
								}
								column[k][l].IlluminateLightRed();
								l++;
							}
						}
						if (k > i && l < j)
						{
							l = j - 1;
							for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1 || l >= 0; k++)
							{
								if (k > Math.sqrt(originalSquares.length) - 1 || l < 0)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[k][l])].textColor = 0xFF0000;
								}
								column[k][l].IlluminateLightRed();
								l--;
							}
						}
						if (k > i && l == j)
						{
							for (k = i + 1; k <= Math.sqrt(originalSquares.length) - 1; k++)
							{
								if (k > Math.sqrt(originalSquares.length) - 1)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[k][l])].textColor = 0xFF0000;
								}
								column[k][l].IlluminateLightRed();
							}
						}
						if (k < i && l == j)
						{
							for (k = i - 1; k >= 0; k--)
							{
								if (k < 0)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[k][l])].textColor = 0xFF0000;
								}
								column[k][l].IlluminateLightRed();
							}
						}
						if (k == i && l > j)
						{
							for (l = j + 1; l <= Math.sqrt(originalSquares.length) - 1; l++)
							{
								if (l > Math.sqrt(originalSquares.length) - 1)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[k][l])].textColor = 0xFF0000;
								}
								column[k][l].IlluminateLightRed();
							}
						}
						if (k == i && l < j)
						{
							for (l = j - 1; l >= 0; l--)
							{
								if (l < 0)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[k][l])].textColor = 0xFF0000;
								}
								column[k][l].IlluminateLightRed();
							}
						}
					}
				}
			}
			function illuminateSquaresFork(e:MouseEvent)
			{
				dilluminate();
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						if (column[i][j].hasEventListener(MouseEvent.MOUSE_OVER))
						{
							if (column[i][j].piece is Sprite)
							{
								textOrder[moveOrder.lastIndexOf(column[i][j])].textColor = 0xFF0000;
							}
							column[i][j].IlluminateLightRed();
						}
					}
				}
			}
			function rollDilluminateAll(e:MouseEvent)
			{
				dilluminate();
			}
			function illuminateSquaresRed(e:MouseEvent)
			{
				dilluminate();
				for (i = 0; i < column.length; i++)
				{
					if (column[i].lastIndexOf(e.currentTarget) >= 0)
					{
						var attackingSquareX:int;
						var attackingSquareY:int;
						for (k = 0; k < column.length; k++)
						{
							if (column[k].lastIndexOf(attackingSquare) >= 0)
							{
								attackingSquareY = k;
								attackingSquareX = column[k].lastIndexOf(attackingSquare);
								break;
							}
						}
						kmax = 1;
						lmax = 1;
						j = column[i].lastIndexOf(e.currentTarget);
						if (i > 0)
						{
							k = -1;
						}
						else if (i == 0)
						{
							k = 0;
						}
						if (i == Math.sqrt(originalSquares.length) - 1)
						{
							kmax = 0;
						}
						for (; k <= kmax; k++)
						{
							if (j > 0)
							{
								l = -1;
							}
							else if (j == 0)
							{
								l = 0;
							}
							if (j == Math.sqrt(originalSquares.length) - 1)
							{
								lmax = 0;
							}
							for (; l <= lmax; l++)
							{
								if (!(i + k == attackingSquareY && j + l == attackingSquareX))
								{
									if (column[i + k][j + l].piece is Sprite)
									{
										textOrder[moveOrder.lastIndexOf(column[i + k][j + l])].textColor = 0xFF0000;
									}
									column[i + k][j + l].IlluminateLightRed();
								}
							}
						}
					}
				}
			}
			function illuminateSquaresGreen(e:MouseEvent)
			{
				dilluminate();
				for (i = 0; i < column.length; i++)
				{
					if (column[i].lastIndexOf(e.currentTarget) >= 0)
					{
						kmax = 1;
						lmax = 1;
						j = column[i].lastIndexOf(e.currentTarget);
						if (i > 0)
						{
							k = -1;
						}
						else if (i == 0)
						{
							k = 0;
						}
						if (i == Math.sqrt(originalSquares.length) - 1)
						{
							kmax = 0;
						}
						for (; k <= kmax; k++)
						{
							if (j > 0)
							{
								l = -1;
							}
							else if (j == 0)
							{
								l = 0;
							}
							if (j == Math.sqrt(originalSquares.length) - 1)
							{
								lmax = 0;
							}
							for (; l <= lmax; l++)
							{
								if (column[i + k][j + l].piece is Sprite)
								{
									textOrder[moveOrder.lastIndexOf(column[i + k][j + l])].textColor = 0x00AA00;
								}
								column[i + k][j + l].IlluminateLightGreen();
							}
						}
						return true;
					}
				}
			}
			function selectAction(e:MouseEvent):void
			{
				for (j = 0; j < attackingSquare.piece.inFrontContainer.numChildren; j++)
				{
					if (attackingSquare.piece.inFrontContainer.getChildAt(j) == e.target)
					{
						selectedAction = j + 4;
						transitionToSecond()
					}
				}
			}
			function followText(e:MouseEvent):void
			{
				e.target.addEventListener(Event.ENTER_FRAME, deleteText);
				e.target.removeEventListener(MouseEvent.MOUSE_MOVE, followText);
				attackContainer.addChild(titleText);
				attackContainer.addChild(descriptionText);
				var descriptionFormat:TextFormat = new TextFormat("Cambria",14,0xD2BC9C);
				descriptionFormat.align = "center";
				descriptionFormat.bold = true
				titleText.width = 150;
				titleText.selectable = false;
				titleText.defaultTextFormat = descriptionFormat;
				titleText.border = true;
				titleText.borderColor = 0xD2BC9C;
				titleText.background = true;
				titleText.backgroundColor = 0x000000;
				titleText.multiline = true;
				titleText.wordWrap = true;
				titleText.autoSize = TextFieldAutoSize.CENTER;
				titleText.text = universalActionValues(e.target as Sprite,MovieClip);
				descriptionFormat.bold = false
				descriptionText.width = 150;
				descriptionText.selectable = false;
				descriptionText.defaultTextFormat = descriptionFormat;
				descriptionText.border = true;
				descriptionText.borderColor = 0xD2BC9C;
				descriptionText.background = true;
				descriptionText.backgroundColor = 0x000000;
				descriptionText.multiline = true;
				descriptionText.wordWrap = true;
				descriptionText.autoSize = TextFieldAutoSize.CENTER;
				descriptionText.text = universalActionValues(e.target as Sprite,String);
			}
			function deleteText(e:Event):void
			{
				if (attackContainer.mouseY - descriptionText.height - 1 - titleText.height >= 0)
				{
					descriptionText.x = attackContainer.mouseX - descriptionText.width - 1;
					descriptionText.y = attackContainer.mouseY - descriptionText.height - 1;
					titleText.x = attackContainer.mouseX - titleText.width - 1;
					titleText.y = attackContainer.mouseY - titleText.height - 1 - descriptionText.height
				}
				else 
				{
					descriptionText.x = attackContainer.mouseX - descriptionText.width - 1;
					descriptionText.y = attackContainer.mouseY + 1 + titleText.height;
					titleText.x = attackContainer.mouseX - titleText.width - 1;
					titleText.y = attackContainer.mouseY + 1
				}
				if (! e.target.hitTestPoint(attackContainer.mouseX,attackContainer.mouseY))
				{
					e.target.removeEventListener(Event.ENTER_FRAME, deleteText);
					e.target.addEventListener(MouseEvent.MOUSE_MOVE, followText);
					if (attackContainer.contains(descriptionText))
					{
						attackContainer.removeChild(descriptionText);
					}
					if (attackContainer.contains(titleText))
					{
						attackContainer.removeChild(titleText);
					}
				}
			}
			function continueMoveOrder():void
			{
				if (currentMovePosition >= 0)
				{
					if (moveOrder[currentMovePosition].piece is Sprite)
					{
						moveOrder[currentMovePosition].piece.moved = true
					}
				}
				currentMovePosition++
				if (moveOrder[currentMovePosition] is Square)
				{
					while (!(moveOrder[currentMovePosition].piece is Sprite))
					{
						var deathText:TextField = new TextField()
						var deathFormat:TextFormat = new TextFormat("Cambria",10,0xFFFFFF);
						deathFormat.align = "right"
						deathText.defaultTextFormat = deathFormat;
						deathText.selectable = false;
						deathText.y = currentMovePosition * 15
						deathText.x = -deathText.width
						deathText.text = "--Dead--"
						pastActionContainer.addChild(deathText)
						currentMovePosition++
						if (currentMovePosition >= moveOrder.length)
						{
							break
						}
					}
				}
				if (currentMovePosition >= moveOrder.length)
				{
					for (i = 0; i < originalSquares.length; i++)
					{
						if (originalSquares[i].holdingPiece is Sprite)
						{
							originalSquares[i].piece = originalSquares[i].holdingPiece
							originalSquares[i].holdingPiece = null
							originalSquares[i].piece.model.alpha = 1
							originalSquares[i].piece.disappeared = false
						}
						if (originalSquares[i].piece is Sprite)
						{
							originalSquares[i].piece.totalDamage = originalSquares[i].piece.baseDamage
							originalSquares[i].piece.stunned = false
							originalSquares[i].piece.moved = false
							if (originalSquares[i].piece is Queen)
							{
								originalSquares[i].piece.shielded = false
							}
							else if (originalSquares[i].piece is Pawn)
							{
								originalSquares[i].piece.defending = false
							}
						}
					}
					endAttack(This,originalSquares,originalPositions,originalColumn,initiatingSquare,recievingSquare,movePiece)
				}
				else
				{
					dilluminate()
					while (moveOrder[currentMovePosition].piece.stunned)
					{
						if (moveOrder[currentMovePosition] is Square)
						{
							moveOrder[currentMovePosition].piece.stunned = false
							currentMovePosition++
						}
						else
						{
							break
						}
					}
					moveOrder[currentMovePosition].IlluminateYellow()
					if (moveOrder[currentMovePosition].piece.team == playerColor)
					{
						attackingSquare = moveOrder[currentMovePosition]
						firstAction()
						for (i = 0; i < originalSquares.length; i++)
						{
							if (originalSquares[i].piece is Sprite)
							{
								originalSquares[i].addEventListener(MouseEvent.MOUSE_UP,illuminate)
							}
							else
							{
								originalSquares[i].addEventListener(MouseEvent.MOUSE_UP, dilluminateAll);
							}
						}
					}
					else
					{
						continueText.text = "Enemy acting..."
						AI.actEnemyPiece(column,moveOrder[currentMovePosition],Math.sqrt(originalSquares.length),universalActionValues,killPiece,moveToEnd,textOrder,moveOrder,currentLevel,currentRound,displayAction)
						wait36Frames()
					}
				}
			}
			function wait36Frames():void
			{
				var trackingTimer:int = 0
				addEventListener(Event.ENTER_FRAME,trackTimer)
				function trackTimer(e:Event):void
				{
					trackingTimer++
					if (trackingTimer == 36)
					{
						continueMoveOrder()
						removeEventListener(Event.ENTER_FRAME,trackTimer)
					}
				}
			}
		}
	}
}