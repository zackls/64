package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*
	
	public class Board extends Sprite
	{
		public var endAttack:Function = new Function()
		public function Board(model:Class, playerStart:Boolean, displayPieceInfo:Function, clearDisplayPieceInfo:Function, beginAttack:Function, startText:Function, currentLevel:int)
		{
			var This:Sprite = this
			endAttack = stopAttack
			var instance:Sprite = new model();
			addChild(instance);
			var topChild:Sprite = new Sprite();
			var offenseCoefficient:Number = 0.5
			var i:int;
			var j:int;
			var k:int;
			var l:int;
			var currentRound:int = 0
			var opponentColor:String;
			var playerColor:String;
			var top:Boolean = false
			if (playerStart)
			{
				opponentColor = "Black";
				playerColor = "White";
			}
			else
			{
				opponentColor = "White";
				playerColor = "Black";
			}
			var pieces:Array;
			pieces = [new Rook(opponentColor, [], ["strength",0,"shock",0,"rest","rookAttack"], 1, 0,"top"), new Knight(opponentColor, [], ["critical",0,"channeling",0,"rest","knightAttack"], 1, 0,"top"), new Bishop(opponentColor, [], ["lethality",0,"reflexes",0,"rest","bishopAttack"], 1, 0,"top"),,, new Bishop(opponentColor, [], ["lethality",0,"reflexes",0,"rest","bishopAttack"], 1, 0,"top"), new Knight(opponentColor, [], ["critical",0,"channeling",0,"rest","knightAttack"], 1, 0,"top"), new Rook(opponentColor, [], ["strength",0,"shock",0,"rest","rookAttack"], 1, 0,"top"),
					  new Pawn(opponentColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"top"), new Pawn(opponentColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"top"), new Pawn(opponentColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"top"), new Pawn(opponentColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"top"), new Pawn(opponentColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"top"), new Pawn(opponentColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"top"), new Pawn(opponentColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"top"), new Pawn(opponentColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"top"),
					  ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
					  new Pawn(playerColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"bottom"), new Pawn(playerColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"bottom"), new Pawn(playerColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"bottom"), new Pawn(playerColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"bottom"), new Pawn(playerColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"bottom"), new Pawn(playerColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"bottom"), new Pawn(playerColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"bottom"), new Pawn(playerColor, [], ["defense",0,"vitality",0,"rest","pawnAttack"], 1, 0,"bottom"),
					  new Rook(playerColor, [], ["strength",0,"shock",0,"rest","rookAttack"], 1, 0,"bottom"), new Knight(playerColor, [], ["critical",0,"channeling",0,"rest","knightAttack"], 1, 0,"bottom"), new Bishop(playerColor, [], ["lethality",0,"reflexes",0,"rest","bishopAttack","assassinate"], 1, 0,"bottom"),,, new Bishop(playerColor, [], ["lethality",0,"reflexes",0,"rest","bishopAttack"], 1, 0,"bottom"), new Knight(playerColor, [], ["critical",0,"channeling",0,"rest","knightAttack"], 1, 0,"bottom"), new Rook(playerColor, [], ["strength",0,"shock",0,"rest","rookAttack"], 1, 0,"bottom")];
			if (playerStart)
			{
				pieces[59] = new Queen(playerColor,[],["focus",0,"vitality",0,"rest","queenAttack","laser"],1,0,"top");
				pieces[60] = new King(playerColor,[],["focus",0,"mastery",0,"rest","unequippedAttack","protect"],1,0,"top");
				pieces[3] = new Queen(opponentColor,[],["focus",0,"vitality",0,"rest","queenAttack","laser"],1,0,"bottom");
				pieces[4] = new King(opponentColor,[],["focus",0,"mastery",0,"rest","unequippedAttack","protect"],1,0,"bottom");
			}
			else
			{
				pieces[60] = new Queen(playerColor,[],["focus",0,"vitality",0,"rest","queenAttack","laser"],1,0,"top");
				pieces[59] = new King(playerColor,[],["focus",0,"mastery",0,"rest","unequippedAttack","protect"],1,0,"top");
				pieces[4] = new Queen(opponentColor,[],["focus",0,"vitality",0,"rest","queenAttack","laser"],1,0,"bottom");
				pieces[3] = new King(opponentColor,[],["focus",0,"mastery",0,"rest","unequippedAttack","protect"],1,0,"bottom");
			}
			var startMove:Boolean = false;
			var longChess:Boolean;
			var shortChess:Boolean;
			var startChess:Boolean = false;
			var originSquare:Object;
			var destinationSquare:Object;
			var originSquare2:Object;
			var destinationSquare2:Object;
			var moveTimer:int = 0;
			var pieceToMove:Sprite;
			var pieceToMove2:Sprite;
			var recievingSquare:Sprite
			var initiatingSquare:Sprite
			var recievingSquareX:int
			var recievingSquareY:int
			var initiatingSquareX:int
			var initiatingSquareY:int
			var xDistanceToTravel:Number
			var yDistanceToTravel:Number
			var row1:Array = [new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square()];
			var row2:Array = [new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square()];
			var row3:Array = [new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square()];
			var row4:Array = [new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square()];
			var row5:Array = [new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square()];
			var row6:Array = [new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square()];
			var row7:Array = [new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square()];
			var row8:Array = [new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square(), new Square()];
			var column:Array = [row1,row2,row3,row4,row5,row6,row7,row8];
			for (i = 0; i < column.length; i++)
			{
				for (j = 0; j < column[i].length; j++)
				{
					this.addChild(column[i][j]);
					column[i][j].x = (-1750 / 3) + ((500 / 3) * j);
					column[i][j].y = (-1750 / 3) + ((500 / 3) * i);
					if (pieces[(8 * i) + j] is Sprite)
					{
						column[i][j].piece = pieces[(8 * i) + j];
						column[i][j].addChild(pieces[(8 * i) + j]);
					}
				}
			}
			currentRound++
			startText()
			var weighedMoves:Array = AI.weighMoves(column,playerColor,currentRound,instance)
			progressOrder()
			this.addChild(topChild);
			function constantEvents(e:Event):void
			{
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						if (column[i][j].displayInfo)
						{
							displayPieceInfo(false, column[i][j].piece, getDefinitionByName(getQualifiedClassName(column[i][j].piece.model)) as Class);
							column[i][j].displayInfo = false;
						}
					}
				}
			}
			function illuminate(e:MouseEvent):void
			{
				dilluminate();
				if (e.currentTarget.piece.team == playerColor)
				{
					clearDisplayPieceInfo();
					e.currentTarget.IlluminateYellow();
				}
				else
				{
					clearDisplayPieceInfo();
					e.currentTarget.IlluminateBlue();
				}
				if (e.currentTarget.piece.team == playerColor)
				{
					if (e.currentTarget.piece is King)
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(e.currentTarget) >= 0)
							{
								j = column[i].lastIndexOf(e.currentTarget);
								if (! e.currentTarget.piece.everMoved)
								{
									if (playerStart)
									{
										if (column[i][j + 3].piece is Sprite && !column[i][j + 3].piece.everMoved && !(column[i][j + 2].piece is Sprite) && !(column[i][j + 1].piece is Sprite))
										{
											column[i][j + 2].IlluminatePurple();
											column[i][j + 2].addEventListener(MouseEvent.MOUSE_UP, initiateChess);
										}
										if (column[i][j - 4].piece is Sprite && !column[i][j - 4].piece.everMoved && !(column[i][j - 3].piece is Sprite) && !(column[i][j - 2].piece is Sprite) && !(column[i][j - 1].piece is Sprite))
										{
											column[i][j - 2].IlluminatePurple();
											column[i][j - 2].addEventListener(MouseEvent.MOUSE_UP, initiateChess);
										}
									}
									else
									{
										if (column[i][j + 4].piece is Sprite && !column[i][j + 4].piece.everMoved && !(column[i][j + 3].piece is Sprite) && !(column[i][j + 2].piece is Sprite) && !(column[i][j + 1].piece is Sprite))
										{
											column[i][j + 2].IlluminatePurple();
											column[i][j + 2].addEventListener(MouseEvent.MOUSE_UP, initiateChess);
										}
										if (column[i][j - 3].piece is Sprite && !column[i][j - 3].piece.everMoved && !(column[i][j - 2].piece is Sprite) && !(column[i][j - 1].piece is Sprite))
										{
											column[i][j - 2].IlluminatePurple();
											column[i][j - 2].addEventListener(MouseEvent.MOUSE_UP, initiateChess);
										}
									}
								}
								var kmax:int = 1;
								var lmax:int = 1;
								if (i > 0)
								{
									k = -1;
								}
								else if (i == 0)
								{
									k = 0;
								}
								if (i == 7)
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
									if (j == 7)
									{
										lmax = 0;
									}
									for (; l <= lmax; l++)
									{
										if (column[i + k][j + l].piece is Sprite)
										{
											if (column[i + k][j + l].piece.team != playerColor)
											{
												column[i + k][j + l].IlluminateRed();
												initiatingSquare = column[i][j]
												column[i + k][j + l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
											}
										}
										else
										{
											column[i + k][j + l].IlluminateGreen();
											column[i + k][j + l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
										}
									}
								}
							}
						}
					}
					else if (e.currentTarget.piece is Queen)
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(e.currentTarget) >= 0)
							{
								j = column[i].lastIndexOf(e.currentTarget);
								for (k = i + 1; k <= 7; k++)
								{
									if (k > 7)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != playerColor)
										{
											column[k][j].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][j].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][j].IlluminateGreen();
										column[k][j].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
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
											column[k][j].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][j].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][j].IlluminateGreen();
										column[k][j].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
								}
								for (l = j + 1; l <= 7; l++)
								{
									if (l > 7)
									{
										break;
									}
									if (column[i][l].piece is Sprite)
									{
										if (column[i][l].piece.team != playerColor)
										{
											column[i][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[i][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[i][l].IlluminateGreen();
										column[i][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
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
											column[i][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[i][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[i][l].IlluminateGreen();
										column[i][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
								}
								l = j + 1;
								for (k = i + 1; k <= 7 || l <= 7; k++)
								{
									if (k > 7 || l > 7)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											column[k][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][l].IlluminateGreen();
										column[k][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
									l++;
								}
								l = j - 1;
								for (k = i + 1; k <= 7 || l >= 0; k++)
								{
									if (k > 7 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											column[k][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][l].IlluminateGreen();
										column[k][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
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
											column[k][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][l].IlluminateGreen();
										column[k][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
									l--;
								}
								l = j + 1;
								for (k = i - 1; k >= 0 || l <= 7; k--)
								{
									if (k < 0 || l > 7)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											column[k][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][l].IlluminateGreen();
										column[k][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
									l++;
								}
							}
						}
					}
					else if (e.currentTarget.piece is Rook)
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(e.currentTarget) >= 0)
							{
								j = column[i].lastIndexOf(e.currentTarget);
								for (k = i + 1; k <= 7; k++)
								{
									if (k > 7)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != playerColor)
										{
											column[k][j].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][j].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][j].IlluminateGreen();
										column[k][j].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
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
											column[k][j].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][j].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][j].IlluminateGreen();
										column[k][j].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
								}
								for (l = j + 1; l <= 7; l++)
								{
									if (l > 7)
									{
										break;
									}
									if (column[i][l].piece is Sprite)
									{
										if (column[i][l].piece.team != playerColor)
										{
											column[i][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[i][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[i][l].IlluminateGreen();
										column[i][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
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
											column[i][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[i][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[i][l].IlluminateGreen();
										column[i][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
								}
							}
						}
					}
					else if (e.currentTarget.piece is Knight)
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(e.currentTarget) >= 0)
							{
								j = column[i].lastIndexOf(e.currentTarget);
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
									if ((i == 6 && k > 1) || (i == 7 && k > 0))
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
										if (j < 7)
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
										if (j < 6)
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
												column[i + k][j + l].IlluminateRed();
												initiatingSquare = column[i][j]
												column[i + k][j + l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
											}
										}
										else
										{
											column[i + k][j + l].IlluminateGreen();
											column[i + k][j + l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
										}
									}
								}
							}
						}
					}
					else if (e.currentTarget.piece is Bishop)
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(e.currentTarget) >= 0)
							{
								j = column[i].lastIndexOf(e.currentTarget);
								l = j + 1;
								for (k = i + 1; k <= 7 || l <= 7; k++)
								{
									if (k > 7 || l > 7)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											column[k][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][l].IlluminateGreen();
										column[k][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
									l++;
								}
								l = j - 1;
								for (k = i + 1; k <= 7 || l >= 0; k++)
								{
									if (k > 7 || l < 0)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											column[k][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][l].IlluminateGreen();
										column[k][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
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
											column[k][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][l].IlluminateGreen();
										column[k][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
									l--;
								}
								l = j + 1;
								for (k = i - 1; k >= 0 || l <= 7; k--)
								{
									if (k < 0 || l > 7)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != playerColor)
										{
											column[k][l].IlluminateRed();
											initiatingSquare = column[i][j]
											column[k][l].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
										break;
									}
									else
									{
										column[k][l].IlluminateGreen();
										column[k][l].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
									l++;
								}
							}
						}
					}
					else if (e.currentTarget.piece is Pawn)
					{
						for (i = 0; i < column.length; i++)
						{
							if (column[i].lastIndexOf(e.currentTarget) >= 0)
							{
								j = column[i].lastIndexOf(e.currentTarget);
								if (!(column[i - 1][j].piece is Sprite))
								{
									column[i - 1][j].IlluminateGreen();
									column[i - 1][j].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									if (! e.currentTarget.piece.everMoved && !(column[i - 2][j].piece is Sprite))
									{
										column[i - 2][j].IlluminateGreen();
										column[i - 2][j].addEventListener(MouseEvent.MOUSE_UP, initiateMove);
									}
								}
								if (j != 0)
								{
									if (column[i - 1][j - 1].piece is Sprite)
									{
										if (column[i - 1][j - 1].piece.team != playerColor)
										{
											column[i - 1][j - 1].IlluminateRed();
											initiatingSquare = column[i][j]
											column[i - 1][j - 1].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
									}
								}
								if (j != 7)
								{
									if (column[i - 1][j + 1].piece is Sprite)
									{
										if (column[i - 1][j + 1].piece.team != playerColor)
										{
											column[i - 1][j + 1].IlluminateRed();
											initiatingSquare = column[i][j]
											column[i - 1][j + 1].addEventListener(MouseEvent.MOUSE_UP,initiateAttack)
										}
									}
								}
							}
						}
					}
				}
				originSquare = e.currentTarget;
			}
			function dilluminateAll(e:MouseEvent):void
			{
				dilluminate();
			}
			function dilluminate():void
			{
				clearDisplayPieceInfo();
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						column[i][j].removeEventListener(MouseEvent.MOUSE_UP, initiateMove);
						column[i][j].removeEventListener(MouseEvent.MOUSE_UP, initiateChess);
						column[i][j].removeEventListener(MouseEvent.MOUSE_UP, initiateAttack);
						column[i][j].Dilluminate();
					}
				}
			}
			function initiateChess(e:MouseEvent):void
			{
				pieceToMove = originSquare.piece;
				originSquare.removeChild(pieceToMove);
				topChild.addChild(pieceToMove);
				destinationSquare = e.currentTarget;
				pieceToMove.x = originSquare.x;
				pieceToMove.y = originSquare.y;
				if (playerStart)
				{
					if (e.currentTarget == column[7][6])
					{
						shortChess = true
						longChess = false
						originSquare2 = column[7][7];
						destinationSquare2 = column[7][5];
					}
					else if (e.currentTarget == column[7][2])
					{
						shortChess = false
						longChess = true
						originSquare2 = column[7][0];
						destinationSquare2 = column[7][3];
					}
				}
				else
				{
					if (e.currentTarget == column[7][5])
					{
						shortChess = false
						longChess = true
						originSquare2 = column[7][7];
						destinationSquare2 = column[7][4];
					}
					else if (e.currentTarget == column[7][1])
					{
						shortChess = true
						longChess = false
						originSquare2 = column[7][0];
						destinationSquare2 = column[7][2];
					}
				}
				pieceToMove2 = originSquare2.piece;
				originSquare2.removeChild(pieceToMove2);
				topChild.addChild(pieceToMove2);
				pieceToMove2.x = originSquare2.x;
				pieceToMove2.y = originSquare2.y;
				startChess = true;
				startMove = true;
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						column[i][j].removeEventListener(MouseEvent.MOUSE_UP, illuminate);
					}
				}
			}
			function initiateMove(e:MouseEvent):void
			{
				pieceToMove = originSquare.piece;
				originSquare.removeChild(pieceToMove);
				topChild.addChild(pieceToMove);
				destinationSquare = e.currentTarget;
				startMove = true;
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						column[i][j].removeEventListener(MouseEvent.MOUSE_UP, illuminate);
					}
				}
				pieceToMove.x = originSquare.x;
				pieceToMove.y = originSquare.y;
				offenseCoefficient = AI.analyzeMovement(column,originSquare,destinationSquare,weighedMoves,offenseCoefficient)
			}
			function movePiece(e:Event):void
			{
				if (startMove)
				{
					moveTimer++;
					xDistanceToTravel = destinationSquare.x - originSquare.x;
					yDistanceToTravel = destinationSquare.y - originSquare.y;
					if (startChess)
					{
						var xDistanceToTravel2:Number = destinationSquare2.x - originSquare2.x;
						var yDistanceToTravel2:Number = destinationSquare2.y - originSquare2.y;
					}
					if (moveTimer <= 30)
					{
						pieceToMove.x += xDistanceToTravel * ((-Math.pow(15 - moveTimer, 2) + (2 * moveTimer) + 225) / 5425);
						pieceToMove.y += yDistanceToTravel * ((-Math.pow(15 - moveTimer, 2) + (2 * moveTimer) + 225) / 5425);
						if (startChess)
						{
							pieceToMove2.x += xDistanceToTravel2 * ((-Math.pow(15 - moveTimer, 2) + (2 * moveTimer) + 225) / 5425);
							pieceToMove2.y += yDistanceToTravel2 * ((-Math.pow(15 - moveTimer, 2) + (2 * moveTimer) + 225) / 5425);
						}
					}
					else if (moveTimer > 30)
					{
						topChild.removeChild(pieceToMove);
						pieceToMove.x = 0;
						pieceToMove.y = 0;
						originSquare.piece = null;
						destinationSquare.piece = pieceToMove;
						destinationSquare.addChild(destinationSquare.piece);
						destinationSquare.piece.everMoved = true;
						startMove = false;
						if (startChess)
						{
							topChild.removeChild(pieceToMove2);
							pieceToMove2.x = 0;
							pieceToMove2.y = 0;
							originSquare2.piece = null;
							destinationSquare2.piece = pieceToMove2;
							destinationSquare2.addChild(destinationSquare2.piece);
							destinationSquare2.piece.everMoved = true;
							startChess = false;
						}
						for (i = 0; i < column.length; i++)
						{
							for (j = 0; j < column[i].length; j++)
							{
								if (column[i][j].piece is Sprite)
								{
									column[i][j].addEventListener(MouseEvent.MOUSE_UP, illuminate);
								}
								else
								{
									column[i][j].addEventListener(MouseEvent.MOUSE_UP, dilluminateAll);
								}
							}
						}
						moveTimer = 0;
						if (!playerStart && !top)
						{
							currentRound++
							progressOrder()
						}
						else
						{
							progressOrder()
						}
					}
				}
			}
			function initiateAttack(e:MouseEvent):void
			{
				recievingSquare = e.currentTarget as Sprite
				dilluminate()
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						column[i][j].removeEventListener(MouseEvent.MOUSE_UP, illuminate)
						column[i][j].removeEventListener(MouseEvent.MOUSE_UP, dilluminateAll)
						if (column[i][j] == recievingSquare)
						{
							column[i][j].IlluminateRed()
						}
						else if (column[i][j] == initiatingSquare)
						{
							column[i][j].IlluminateYellow()
						}
						
					}
				}
				var squareTester:Sprite = new Sprite()
				squareTester.graphics.beginFill(0x000000,1)
				squareTester.graphics.drawRect(-125 / 3, -125 / 3, 250 / 3, 250 / 3)
				squareTester.graphics.endFill()
				squareTester.alpha = 0
				squareTester.x = (initiatingSquare.x + recievingSquare.x) / 2
				squareTester.y = (initiatingSquare.y + recievingSquare.y) / 2
				addChild(squareTester)
				do
				{
					squareTester.width += 500 / 3
					squareTester.height += 500 / 3
				}
				while(!(squareTester.hitTestObject(initiatingSquare) && squareTester.hitTestObject(recievingSquare)))
				while((squareTester.width / 2) + squareTester.x + (instance.width / 2) > instance.width)
				{
					squareTester.x -= 500 / 3
				}
				while(squareTester.x - (squareTester.width / 2) + (instance.width / 2) < 0)
				{
					squareTester.x += 500 / 3
				}
				while((squareTester.height / 2) + squareTester.y + (instance.height / 2) > instance.height)
				{
					squareTester.y -= 500 / 3
				}
				while(squareTester.y - (squareTester.height / 2) + (instance.height / 2) < 0)
				{
					squareTester.y += 500 / 3
				}
				var testerCollisions:Array = []
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						if (squareTester.hitTestObject(column[i][j]))
						{
							testerCollisions.push(column[i][j])
						}
					}
				}
				if (!(Math.sqrt(testerCollisions.length) is int) || Math.sqrt(testerCollisions.length) == 2)
				{
					squareTester.x += (recievingSquare.x - initiatingSquare.x) / (squareTester.width / 5)
					squareTester.y += (recievingSquare.y - initiatingSquare.y) / (squareTester.height / 5)
				}
				while (!(Math.sqrt(testerCollisions.length) is int) || Math.sqrt(testerCollisions.length) == 2)
				{
					testerCollisions = []
					squareTester.width++
					squareTester.height++
					for (i = 0; i < column.length; i++)
					{
						for (j = 0; j < column[i].length; j++)
						{
							if (squareTester.hitTestObject(column[i][j]))
							{
								testerCollisions.push(column[i][j])
							}
						}
					}
				}
				var firstSquare:String = "Black"
				for (i = 0; i < column.length; i++)
				{
					if (column[i].lastIndexOf(testerCollisions[0]) >= 0)
					{
						j = column[i].lastIndexOf(testerCollisions[0])
						if (((i / 2) is int && (j / 2) is int) || (!((i / 2) is int) && (!(j / 2) is int)))
						{
							firstSquare = "White"
						}
						break
					}
				}
				removeChild(squareTester)
				removeEventListener(Event.ENTER_FRAME, constantEvents)
				removeEventListener(Event.ENTER_FRAME, movePiece)
				offenseCoefficient = AI.analyzeMovement(column,initiatingSquare,recievingSquare,weighedMoves,offenseCoefficient)
				beginAttack(testerCollisions,firstSquare,initiatingSquare,recievingSquare,currentRound,column)
			}
			function stopAttack(movePieceBoolean:Boolean,initiatingSquare:Object,recievingSquare:Object):void
			{
				removeChild(topChild)
				addChild(topChild)
				removeListeners()
				if (movePieceBoolean)
				{
					originSquare = initiatingSquare
					destinationSquare = recievingSquare
					pieceToMove = initiatingSquare.piece;
					initiatingSquare.removeChild(pieceToMove);
					topChild.addChild(pieceToMove);
					startMove = true;
					pieceToMove.x = initiatingSquare.x;
					pieceToMove.y = initiatingSquare.y;
				}
				else
				{
					if (!playerStart && !top)
					{
						currentRound++
						progressOrder()
					}
					else
					{
						progressOrder()
					}
				}
				addEventListener(Event.ENTER_FRAME, constantEvents)
				addEventListener(Event.ENTER_FRAME, movePiece)
			}
			function progressOrder():void
			{
				top = !top
				removeListeners()
				if (playerStart && top)
				{
					weighedMoves = AI.weighMoves(column,playerColor,currentRound,instance)
					addListeners()
				}
				else if (playerStart && !top)
				{
					AI.moveEnemyPiece(column,opponentColor,topChild,currentLevel,finishAI,currentRound,instance,beginAttack)
				}
				else if (!playerStart && top)
				{
					AI.moveEnemyPiece(column,opponentColor,topChild,currentLevel,finishAI,currentRound,instance,beginAttack)
				}
				else if (!playerStart && !top)
				{
					weighedMoves = AI.weighMoves(column,playerColor,currentRound,instance)
					addListeners()
				}
			}
			function wait30():void
			{
				addEventListener(Event.ENTER_FRAME,waitFrames)
				var frameTimer:int = 0
				removeListeners()
				function waitFrames(e:Event):void
				{
					frameTimer++
					if (frameTimer == 30)
					{
						removeEventListener(Event.ENTER_FRAME,waitFrames)
					}
				}
			}
			function wait72():void
			{
				addEventListener(Event.ENTER_FRAME,wait)
				var waitTimer:int = 0
				removeListeners()
				function wait(e:Event):void
				{
					waitTimer++
					if (waitTimer == 72)
					{
						removeEventListener(Event.ENTER_FRAME,wait)
						progressOrder()
					}
				}
			}
			function addListeners():void
			{
				addEventListener(Event.ENTER_FRAME,constantEvents)
				addEventListener(Event.ENTER_FRAME,movePiece)
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						if (column[i][j].piece is Sprite)
						{
							column[i][j].addEventListener(MouseEvent.MOUSE_UP, illuminate);
						}
						else
						{
							column[i][j].addEventListener(MouseEvent.MOUSE_UP, dilluminateAll);
						}
					}
				}
			}
			function removeListeners():void
			{
				removeEventListener(Event.ENTER_FRAME,constantEvents)
				removeEventListener(Event.ENTER_FRAME,movePiece)
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						if (column[i][j].piece is Sprite)
						{
							column[i][j].removeEventListener(MouseEvent.MOUSE_UP, illuminate);
						}
					}
				}
			}
			function finishAI():void
			{
				if (!top && playerStart)
				{
					currentRound++
					progressOrder()
				}
				else
				{
					progressOrder()
				}
			}
		}
	}
}