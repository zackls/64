package
{
	import flash.display.*
	import flash.utils.getDefinitionByName
	import flash.geom.Point
	import flash.events.Event
	public class AI
	{
		public static function actEnemyPiece(column:Array,actingSquare:Object,sideLength:uint,universalActionValues:Function,killPiece:Function,moveToEnd:Function,textOrder:Array,moveOrder:Array,AILevel:int,roundNumber:int,displayAction:Function):void
		{
			var p:int
			var q:int
			var i:int
			var j:int
			var k:int
			var l:int
			var m:int
			var n:int
			var kmax:int
			var lmax:int
			var maxValue:Number = -10
			var maxValueIndex:Point = new Point(0,0)
			var possibleActions:Array = []
			var actionTargets:Array = []
			var actionValues:Array = []
			for (i = 4; i < actingSquare.piece.skills.length; i++)
			{
				possibleActions.push((getDefinitionByName(actingSquare.piece.skills[i] + "Icon")) as Class)
				actionTargets.push([])
				actionValues.push([])
			}
			findTargets()
			valueTargets()
			addRandomSeed()
			pickTarget()
			act()
			function findTargets():void
			{
				for (p = 0; p < possibleActions.length; p++)
				{
					if (universalActionValues(new possibleActions[p](),int) <= actingSquare.piece.currentMana)
					{
						if (possibleActions[p] == restIcon || possibleActions[p] == enrageIcon || possibleActions[p] == disappearIcon || possibleActions[p] == shieldIcon || possibleActions[p] == defendIcon)
						{
							actionTargets[p].push(actingSquare)
						}
						else if (possibleActions[p] == queenAttackIcon || possibleActions[p] == freezeIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									l = j + 1;
									for (k = i + 1; k <= sideLength - 1 || l <= sideLength - 1; k++)
									{
										if (k > sideLength - 1 || l > sideLength - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
											break;
										}
										l++;
									}
									l = j - 1;
									for (k = i + 1; k <= sideLength - 1 || l >= 0; k++)
									{
										if (k > sideLength - 1 || l < 0)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
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
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
											break;
										}
										l--;
									}
									l = j + 1;
									for (k = i - 1; k >= 0 || l <= sideLength - 1; k--)
									{
										if (k < 0 || l > sideLength - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
											break;
										}
										l++;
									}
									for (k = i + 1; k <= sideLength - 1; k++)
									{
										if (k > sideLength - 1)
										{
											break;
										}
										if (column[k][j].piece is Sprite)
										{
											if (column[k][j].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][j])
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
											if (column[k][j].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][j])
											}
											break;
										}
									}
									for (l = j + 1; l <= sideLength - 1; l++)
									{
										if (l > sideLength - 1)
										{
											break;
										}
										if (column[i][l].piece is Sprite)
										{
											if (column[i][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[i][l])
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
											if (column[i][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[i][l])
											}
											break;
										}
									}
								}
							}
						}
						else if (possibleActions[p] == rookAttackIcon || possibleActions[p] == throwAxeIcon || possibleActions[p] == woundIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare)
									for (k = i + 1; k <= sideLength - 1; k++)
									{
										if (k > sideLength - 1)
										{
											break;
										}
										if (column[k][j].piece is Sprite)
										{
											if (column[k][j].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][j])
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
											if (column[k][j].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][j])
											}
											break;
										}
									}
									for (l = j + 1; l <= sideLength - 1; l++)
									{
										if (l > sideLength - 1)
										{
											break;
										}
										if (column[i][l].piece is Sprite)
										{
											if (column[i][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[i][l])
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
											if (column[i][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[i][l])
											}
											break;
										}
									}
								}
							}
						}
						else if (possibleActions[p] == bishopAttackIcon || possibleActions[p] == poisonIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									l = j + 1;
									for (k = i + 1; k <= sideLength - 1 || l <= sideLength - 1; k++)
									{
										if (k > sideLength - 1 || l > sideLength - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
											break;
										}
										l++;
									}
									l = j - 1;
									for (k = i + 1; k <= sideLength - 1 || l >= 0; k++)
									{
										if (k > sideLength - 1 || l < 0)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
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
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
											break;
										}
										l--;
									}
									l = j + 1;
									for (k = i - 1; k >= 0 || l <= sideLength - 1; k--)
									{
										if (k < 0 || l > sideLength - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
											break;
										}
										l++;
									}
								}
							}
						}
						else if (possibleActions[p] == knightAttackIcon || possibleActions[p] == aimedShotIcon || possibleActions[p] == injureIcon || possibleActions[p] == stunIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
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
										if ((i == sideLength - 2 && k > 1) || (i == sideLength - 1 && k > 0))
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
											if (j < sideLength - 1)
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
											if (j < sideLength - 2)
											{
												l = 2;
												hilightItems(k,l);
											}
										}
										function hilightItems(k:int, l:int):void
										{
											if (column[i + k][j + l].piece is Sprite)
											{
												if (column[i + k][j + l].piece.team != actingSquare.piece.team)
												{
													actionTargets[p].push(column[i + k][j + l])
												}
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == pawnAttackIcon || possibleActions[p] == powerAttackIcon || possibleActions[p] == bleedIcon || possibleActions[p] == forkIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									if (j != 0 && i != sideLength - 1)
									{
										if (column[i + 1][j - 1].piece is Sprite)
										{
											if (column[i + 1][j - 1].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[i + 1][j - 1])
											}
										}
									}
									if (j != sideLength - 1 && i != sideLength - 1)
									{
										if (column[i + 1][j + 1].piece is Sprite)
										{
											if (column[i + 1][j + 1].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[i + 1][j + 1])
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == longshotIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								for (j = 0; j < column[i].length; j++)
								{
									if (column[i][j].piece is Sprite)
									{
										if (column[i][j].piece.team != actingSquare.piece.team)
										{
											actionTargets[p].push(column[i][j])
										}
									}
								}
							}
						}
						else if (possibleActions[p] == assassinateIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									l = j + 1;
									k = i + 1;
									if (!(k > sideLength - 1 || l > sideLength - 1))
									{
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
										}
									}
									l = j - 1;
									k = i + 1;
									if (!(k > sideLength - 1 || l < 0))
									{
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
										}
									}
									l = j - 1;
									k = i - 1;
									if (!(k < 0 || l < 0))
									{
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
										}
									}
									l = j + 1;
									k = i - 1;
									if (!(k < 0 || l > sideLength - 1))
									{
										if (column[k][l].piece is Sprite)
										{
											if (column[k][l].piece.team != actingSquare.piece.team)
											{
												actionTargets[p].push(column[k][l])
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == layTrapIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									l = j + 1;
									for (k = i + 1; k <= sideLength - 1 || l <= sideLength - 1; k++)
									{
										if (k > sideLength - 1 || l > sideLength - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
										l++;
									}
									l = j - 1;
									for (k = i + 1; k <= sideLength - 1 || l >= 0; k++)
									{
										if (k > sideLength - 1 || l < 0)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
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
										actionTargets[p].push(column[k][l])
										l--;
									}
									l = j + 1;
									for (k = i - 1; k >= 0 || l <= sideLength - 1; k--)
									{
										if (k < 0 || l > sideLength - 1)
										{
											break;
										}
										if (column[k][l].piece is Sprite)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
										l++;
									}
								}
							}
						}
						else if (possibleActions[p] == protectIcon || possibleActions[p] == restoreManaIcon || possibleActions[p] == restoreHealthIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								for (j = 0; j < column[i].length; j++)
								{
									actionTargets[p].push(column[i][j])
								}
							}
						}
						else if (possibleActions[p] == inspireIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								for (j = 0; j < column[i].length; j++)
								{
									if (column[i][j].piece is Sprite)
									{
										actionTargets[p].push(column[i][j])
									}
								}
							}
						}
						else if (possibleActions[p] == fireballIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									l = j + 1;
									for (k = i + 1; k <= sideLength - 1 || l <= sideLength - 1; k++)
									{
										if (k > sideLength - 1 || l > sideLength - 1)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
										if (column[k][l].piece is Sprite)
										{
											break;
										}
										l++;
									}
									l = j - 1;
									for (k = i + 1; k <= sideLength - 1 || l >= 0; k++)
									{
										if (k > sideLength - 1 || l < 0)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
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
										actionTargets[p].push(column[k][l])
										if (column[k][l].piece is Sprite)
										{
											break;
										}
										l--;
									}
									l = j + 1;
									for (k = i - 1; k >= 0 || l <= sideLength - 1; k--)
									{
										if (k < 0 || l > sideLength - 1)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
										if (column[k][l].piece is Sprite)
										{
											break;
										}
										l++;
									}
									for (k = i + 1; k <= sideLength - 1; k++)
									{
										if (k > sideLength - 1)
										{
											break;
										}
										actionTargets[p].push(column[k][j])
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
										actionTargets[p].push(column[k][j])
										if (column[k][j].piece is Sprite)
										{
											break;
										}
									}
									for (l = j + 1; l <= sideLength - 1; l++)
									{
										if (l > sideLength - 1)
										{
											break;
										}
										actionTargets[p].push(column[i][l])
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
										actionTargets[p].push(column[i][l])
										if (column[i][l].piece is Sprite)
										{
											break;
										}
									}
								}
							}
						}
						else if (possibleActions[p] == smashIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									k = i + 1;
									if (k < sideLength)
									{
										actionTargets[p].push(column[k][j])
									}
									k = i - 1;
									if (k >= 0)
									{
										actionTargets[p].push(column[k][j])
									}
									l = j + 1;
									if (l < sideLength)
									{
										actionTargets[p].push(column[i][l])
									}
									l = j - 1;
									if (l >= 0)
									{
										actionTargets[p].push(column[i][l])
									}
								}
							}
						}
						else if (possibleActions[p] == laserIcon)
						{
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									l = j + 1;
									for (k = i + 1; k <= sideLength - 1 || l <= sideLength - 1; k++)
									{
										if (k > sideLength - 1 || l > sideLength - 1)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
										l++;
									}
									l = j - 1;
									for (k = i + 1; k <= sideLength - 1 || l >= 0; k++)
									{
										if (k > sideLength - 1 || l < 0)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
										l--;
									}
									l = j - 1;
									for (k = i - 1; k >= 0 || l >= 0; k--)
									{
										if (k < 0 || l < 0)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
										l--;
									}
									l = j + 1;
									for (k = i - 1; k >= 0 || l <= sideLength - 1; k--)
									{
										if (k < 0 || l > sideLength - 1)
										{
											break;
										}
										actionTargets[p].push(column[k][l])
										l++;
									}
									for (k = i + 1; k <= sideLength - 1; k++)
									{
										if (k > sideLength - 1)
										{
											break;
										}
										actionTargets[p].push(column[k][j])
									}
									for (k = i - 1; k >= 0; k--)
									{
										if (k < 0)
										{
											break;
										}
										actionTargets[p].push(column[k][j])
									}
									for (l = j + 1; l <= sideLength - 1; l++)
									{
										if (l > sideLength - 1)
										{
											break;
										}
										actionTargets[p].push(column[i][l])
									}
									for (l = j - 1; l >= 0; l--)
									{
										if (l < 0)
										{
											break;
										}
										actionTargets[p].push(column[i][l])
									}
								}
							}
						}
					}
				}
			}
			function valueTargets():void
			{
				var attackerArray:Array
				for (p = 0; p < actionTargets.length; p++)
				{
					for (q = 0; q < actionTargets[p].length; q++)
					{
						if (possibleActions[p] == restIcon)
						{
							actionValues[p][q] = 0.25
						}
						else if (possibleActions[p] == queenAttackIcon)
						{
							actionValues[p][q] = actingSquare.piece.totalDamage / 60
							valuePieces(p,q)
						}
						else if (possibleActions[p] == rookAttackIcon)
						{
							actionValues[p][q] = actingSquare.piece.totalDamage / 70
							valuePieces(p,q)
						}
						else if (possibleActions[p] == bishopAttackIcon)
						{
							actionValues[p][q] = actingSquare.piece.totalDamage / 40
							valuePieces(p,q)
						}
						else if (possibleActions[p] == knightAttackIcon)
						{
							actionValues[p][q] = actingSquare.piece.totalDamage / 60
							valuePieces(p,q)
						}
						else if (possibleActions[p] == pawnAttackIcon)
						{
							actionValues[p][q] = actingSquare.piece.totalDamage / 40
							valuePieces(p,q)
						}
						else if (possibleActions[p] == freezeIcon)
						{
							actionValues[p][q] = 0.9
							if (!actionTargets[p][q].piece.moved)
							{
								actionValues[p][q] *= 1.5
							}
							else
							{
								actionValues[p][q] /= 1.5
							}
							valuePieces(p,q)
						}
						else if (possibleActions[p] == injureIcon)
						{
							actionValues[p][q] = 0.8
							if (!actionTargets[p][q].piece.moved)
							{
								actionValues[p][q] *= 1.5
							}
							else
							{
								actionValues[p][q] /= 1.5
							}
							valuePieces[p][q]
						}
						else if (possibleActions[p] == enrageIcon)
						{
							actionValues[p][q] = 1
							if (roundNumber >= 20 + (Math.random() * 10))
							{
								actionValues[p][q] /= 2
							}
							else
							{
								actionValues[p][q] *= 1.2
							}
							attackerArray = checkAttackers(actingSquare)
							actionValues[p][q] -= attackerArray.length / 10
						}
						else if (possibleActions[p] == poisonIcon)
						{
							actionValues[p][q] = 1.1
							if (roundNumber >= 15 + (Math.random() * 10))
							{
								actionValues[p][q] /= 2
							}
							else
							{
								actionValues[p][q] *= 1.2
							}
							valuePieces(p,q)
						}
						else if (possibleActions[p] == layTrapIcon)
						{
							actionValues[p][q] = 0.5
							if (roundNumber >= 15 + (Math.random() * 5))
							{
								actionValues[p][q] /= 2
							}
							else
							{
								actionValues[p][q] *= 1.2
							}
							if (actionTargets[p][q].trap)
							{
								actionValues[p][q] = -1
							}
						}
						else if (possibleActions[p] == woundIcon)
						{
							actionValues[p][q] = 1.2
							if (roundNumber >= 10 + (Math.random() * 10))
							{
								actionValues[p][q] /= 4
							}
							else
							{
								actionValues[p][q] *= 2
							}
							if (actionTargets[p][q].piece.wounded)
							{
								actionValues[p][q] = -1
							}
						}
						else if (possibleActions[p] == disappearIcon)
						{
							actionValues[p][q] = 0
							if (actingSquare.piece.currentHealth < actingSquare.piece.totalHealth * 0.4)
							{
								actionValues[p][q] += 1
							}
							else
							{
								actionValues[p][q] /= 3
							}
							attackerArray = checkAttackers(actingSquare)
							actionValues[p][q] += attackerArray.length / 2
						}
						else if (possibleActions[p] == shieldIcon)
						{
							actionValues[p][q] = -1.2
							if (actingSquare.piece.currentHealth < actingSquare.piece.totalHealth * 0.4)
							{
								actionValues[p][q] /= 2
							}
							else
							{
								actionValues[p][q] *= 3
							}
							attackerArray = checkAttackers(actingSquare)
							actionValues[p][q] += attackerArray.length * 2
						}
						else if (possibleActions[p] == defendIcon)
						{
							actionValues[p][q] = -1
							if (actingSquare.piece.currentHealth < actingSquare.piece.totalHealth * 0.5)
							{
								actionValues[p][q] /= 2
							}
							else
							{
								actionValues[p][q] *= 3
							}
							attackerArray = checkAttackers(actingSquare)
							actionValues[p][q] += attackerArray.length * 2
						}
						else if (possibleActions[p] == throwAxeIcon)
						{
							actionValues[p][q] = 1.15
							valuePieces(p,q)
						}
						else if (possibleActions[p] == stunIcon)
						{
							actionValues[p][q] = 1.2
							if (actionTargets[p][q].piece.stunned || actionTargets[p][q].piece.moved)
							{
								actionValues[p][q] /= 10
							}
							valuePieces(p,q)
						}
						else if (possibleActions[p] == aimedShotIcon)
						{
							actionValues[p][q] = 1.1
							valuePieces(p,q)
						}
						else if (possibleActions[p] == powerAttackIcon)
						{
							actionValues[p][q] = 1.1
							valuePieces(p,q)
						}
						else if (possibleActions[p] == bleedIcon)
						{
							actionValues[p][q] = 1.5
							if (actionTargets[p][q].piece.bleeding)
							{
								actionValues[p][q] /= actionTargets[p][q].piece.bleedTurnsLeft + 1
							}
							valuePieces(p,q)
						}
						else if (possibleActions[p] == longshotIcon)
						{
							actionValues[p][q] = 0.2
							if (actionTargets[p][q].piece.currentHealth <= (actingSquare.piece.baseDamage * 0.15) - actionTargets[p][q].piece.armor)
							{
								actionValues[p][q] *= 6
							}
							valuePieces(p,q)
						}
						else if (possibleActions[p] == assassinateIcon)
						{
							actionValues[p][q] = 2
							valuePieces(p,q)
						}
						else if (possibleActions[p] == inspireIcon)
						{
							actionValues[p][q] = 0.1
							if (actionTargets[p][q].piece.moved || actionTargets[p][q] == actingSquare)
							{
								actionValues[p][q] = -1
							}
							else
							{
								actionValues[p][q] *= 3
							}
						}
						else if (possibleActions[p] == protectIcon)
						{
							actionValues[p][q] = 1.1
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									kmax = 1;
									lmax = 1;
									j = column[i].lastIndexOf(actingSquare);
									if (i > 0)
									{
										k = -1;
									}
									else if (i == 0)
									{
										k = 0;
									}
									if (i == sideLength - 1)
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
										if (j == sideLength - 1)
										{
											lmax = 0;
										}
										for (; l <= lmax; l++)
										{
											if (column[i + k][j + l].piece is Sprite)
											{
												if (column[i + k][j + l].piece.team != actingSquare.piece.team)
												{
													actionValues[p][q] /= 1.1
												}
												else
												{
													actionValues[p][q] *= 1.1
												}
												if (actionTargets[p][q].piece is Sprite)
												{
													if (actionTargets[p][q].piece.protection > 0)
													{
														actionValues[p][q] /= 1.1
													}
												}
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == restoreHealthIcon)
						{
							actionValues[p][q] = -1
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									kmax = 1;
									lmax = 1;
									j = column[i].lastIndexOf(actingSquare);
									if (i > 0)
									{
										k = -1;
									}
									else if (i == 0)
									{
										k = 0;
									}
									if (i == sideLength - 1)
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
										if (j == sideLength - 1)
										{
											lmax = 0;
										}
										for (; l <= lmax; l++)
										{
											if (column[i + k][j + l].piece is Sprite)
											{
												if (column[i + k][j + l].piece.team != actingSquare.piece.team)
												{
													actionValues[p][q]--
												}
												else
												{
													if (column[i + k][j + l].piece.currentHealth <= column[i + k][j + l].piece.totalHealth * 0.8)
													{
														actionValues[p][q]++
													}
													else
													{
														actionValues[p][q] += 0.3
													}
												}
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == restoreManaIcon)
						{
							actionValues[p][q] = -1.1
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									kmax = 1;
									lmax = 1;
									j = column[i].lastIndexOf(actingSquare);
									if (i > 0)
									{
										k = -1;
									}
									else if (i == 0)
									{
										k = 0;
									}
									if (i == sideLength - 1)
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
										if (j == sideLength - 1)
										{
											lmax = 0;
										}
										for (; l <= lmax; l++)
										{
											if (column[i + k][j + l].piece is Sprite)
											{
												if (column[i + k][j + l].piece.team != actingSquare.piece.team)
												{
													actionValues[p][q]--
												}
												else
												{
													if (column[i + k][j + l].piece.currentMana <= 80)
													{
														actionValues[p][q]++
													}
													else
													{
														actionValues[p][q] += 0.3
													}
												}
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == fireballIcon)
						{
							actionValues[p][q] = -0.5
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									kmax = 1;
									lmax = 1;
									j = column[i].lastIndexOf(actingSquare);
									if (i > 0)
									{
										k = -1;
									}
									else if (i == 0)
									{
										k = 0;
									}
									if (i == sideLength - 1)
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
										if (j == sideLength - 1)
										{
											lmax = 0;
										}
										for (; l <= lmax; l++)
										{
											if (column[i + k][j + l].piece is Sprite)
											{
												if (column[i + k][j + l].piece.team == actingSquare.piece.team)
												{
													if (!(k == 0 && l == 0))
													{
														actionValues[p][q] /= 1.15
													}
												}
												else
												{
													actionValues[p][q] *= 1.1
												}
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == smashIcon)
						{
							actionValues[p][q] = -0.5
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									kmax = 1;
									lmax = 1;
									j = column[i].lastIndexOf(actingSquare);
									if (i > 0)
									{
										k = -1;
									}
									else if (i == 0)
									{
										k = 0;
									}
									if (i == sideLength - 1)
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
										if (j == sideLength - 1)
										{
											lmax = 0;
										}
										for (; l <= lmax; l++)
										{
											if (column[i + k][j + l].piece is Sprite)
											{
												if (column[i + k][j + l].piece.team == actingSquare.piece.team)
												{
													if (!(k == 0 && l == 0))
													{
														actionValues[p][q]--
													}
												}
												else
												{
													actionValues[p][q]++
												}
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == forkIcon)
						{
							actionValues[p][q] = 0.5
							actionValues[p][q] /= 10
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									if (j != 0 && j != sideLength - 1)
									{
										if (column[i + 1][j - 1].piece is Sprite && column[i + 1][j + 1].piece is Sprite)
										{
											if (column[i + 1][j - 1].piece.team != actingSquare.piece.team && column[i + 1][j + 1].piece.team != actingSquare.piece.team)
											{
												actionValues[p][q] *= 40
											}
										}
									}
								}
							}
						}
						else if (possibleActions[p] == laserIcon)
						{
							actionValues[p][q] = -0.5
							for (i = 0; i < column.length; i++)
							{
								if (column[i].lastIndexOf(actingSquare) >= 0)
								{
									j = column[i].lastIndexOf(actingSquare);
									for (k = 0; k < column.length; k++)
									{
										if (column[k].lastIndexOf(actionTargets[p][q]) >= 0)
										{
											l = column[k].lastIndexOf(actionTargets[p][q]);
											break;
										}
									}
									if (k < i && l < j)
									{
										l = j + 1;
										for (k = i + 1; k <= sideLength - 1 || l <= sideLength - 1; k++)
										{
											if (k > sideLength - 1 || l > sideLength - 1)
											{
												break;
											}
											if (column[k][l].piece is Sprite)
											{
												if (column[k][l].piece.team == actingSquare.piece.team)
												{
													actionValues[p][q] -= 1.5
												}
												else
												{
													actionValues[p][q] += 1.5
												}
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
												if (column[k][l].piece.team == actingSquare.piece.team)
												{
													actionValues[p][q] -= 1.5
												}
												else
												{
													actionValues[p][q] += 1.5
												}
											}
											l--;
										}
									}
									if (k < i && l > j)
									{
										l = j + 1;
										for (k = i - 1; k >= 0 || l <= sideLength - 1; k--)
										{
											if (k < 0 || l > sideLength - 1)
											{
												break;
											}
											if (column[k][l].piece is Sprite)
											{
												if (column[k][l].piece.team == actingSquare.piece.team)
												{
													actionValues[p][q] -= 1.5
												}
												else
												{
													actionValues[p][q] += 1.5
												}
											}
											l++;
										}
									}
									if (k > i && l < j)
									{
										l = j - 1;
										for (k = i + 1; k <= sideLength - 1 || l >= 0; k++)
										{
											if (k > sideLength - 1 || l < 0)
											{
												break;
											}
											if (column[k][l].piece is Sprite)
											{
												if (column[k][l].piece.team == actingSquare.piece.team)
												{
													actionValues[p][q] -= 1.5
												}
												else
												{
													actionValues[p][q] += 1.5
												}
											}
											l--;
										}
									}
									if (k > i && l == j)
									{
										l = j
										for (k = i + 1; k <= sideLength - 1; k++)
										{
											if (k > sideLength - 1)
											{
												break;
											}
											if (column[k][l].piece is Sprite)
											{
												if (column[k][l].piece.team == actingSquare.piece.team)
												{
													actionValues[p][q] -= 1.5
												}
												else
												{
													actionValues[p][q] += 1.5
												}
											}
										}
									}
									if (k < i && l == j)
									{
										l = j
										for (k = i - 1; k >= 0; k--)
										{
											if (k < 0)
											{
												break;
											}
											if (column[k][l].piece is Sprite)
											{
												if (column[k][l].piece.team == actingSquare.piece.team)
												{
													actionValues[p][q] -= 1.5
												}
												else
												{
													actionValues[p][q] += 1.5
												}
											}
										}
									}
									if (k == i && l > j)
									{
										k = i
										for (l = j + 1; l <= sideLength - 1; l++)
										{
											if (l > sideLength - 1)
											{
												break;
											}
											if (column[k][l].piece is Sprite)
											{
												if (column[k][l].piece.team == actingSquare.piece.team)
												{
													actionValues[p][q] -= 1.5
												}
												else
												{
													actionValues[p][q] += 1.5
												}
											}
										}
									}
									if (k == i && l < j)
									{
										k = i
										for (l = j - 1; l >= 0; l--)
										{
											if (l < 0)
											{
												break;
											}
											if (column[k][l].piece is Sprite)
											{
												if (column[k][l].piece.team == actingSquare.piece.team)
												{
													actionValues[p][q] -= 1.5
												}
												else
												{
													actionValues[p][q] += 1.5
												}
											}
										}
									}
								}
							}
						}
					}
				}
				function checkAttackers(reciever:Object):Array
				{
					var returnArray:Array = []
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(actingSquare) >= 0)
						{
							j = column[i].lastIndexOf(actingSquare);
							l = j + 1;
							for (k = i + 1; k <= sideLength - 1 || l <= sideLength - 1; k++)
							{
								if (k > sideLength - 1 || l > sideLength - 1)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									if (column[k][l].piece.team != actingSquare.piece.team && !column[k][l].piece.moved)
									{
										if (column[k][l].piece is Queen || column[k][l].piece is Bishop)
										{
											returnArray.push(column[k][l])
										}
									}
									break;
								}
								l++;
							}
							l = j - 1;
							for (k = i + 1; k <= sideLength - 1 || l >= 0; k++)
							{
								if (k > sideLength - 1 || l < 0)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									if (column[k][l].piece.team != actingSquare.piece.team && !column[k][l].piece.moved)
									{
										if (column[k][l].piece is Queen || column[k][l].piece is Bishop)
										{
											returnArray.push(column[k][l])
										}
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
									if (column[k][l].piece.team != actingSquare.piece.team && !column[k][l].piece.moved)
									{
										if (column[k][l].piece is Queen || column[k][l].piece is Bishop)
										{
											returnArray.push(column[k][l])
										}
										if (column[k][l].piece is Pawn)
										{
											if (k == i - 1 && l == j - 1)
											{
												returnArray.push(column[k][l])
											}
										}
									}
									break;
								}
								l--;
							}
							l = j + 1;
							for (k = i - 1; k >= 0 || l <= sideLength - 1; k--)
							{
								if (k < 0 || l > sideLength - 1)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									if (column[k][l].piece.team != actingSquare.piece.team && !column[k][l].piece.moved)
									{
										if (column[k][l].piece is Queen || column[k][l].piece is Bishop)
										{
											returnArray.push(column[k][l])
										}
										if (column[k][l].piece is Pawn)
										{
											if (k == i - 1 && l == j + 1)
											{
												returnArray.push(column[k][l])
											}
										}
									}
									break;
								}
								l++;
							}
							for (k = i + 1; k <= sideLength - 1; k++)
							{
								if (k > sideLength - 1)
								{
									break;
								}
								if (column[k][j].piece is Sprite)
								{
									if (column[k][j].piece.team != actingSquare.piece.team && !column[k][j].piece.moved)
									{
										if (column[k][j].piece is Queen || column[k][j].piece is Rook)
										{
											returnArray.push(column[k][j])
										}
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
									if (column[k][j].piece.team != actingSquare.piece.team && !column[k][j].piece.moved)
									{
										if (column[k][j].piece is Queen || column[k][j].piece is Rook)
										{
											returnArray.push(column[k][j])
										}
									}
									break;
								}
							}
							for (l = j + 1; l <= sideLength - 1; l++)
							{
								if (l > sideLength - 1)
								{
									break;
								}
								if (column[i][l].piece is Sprite)
								{
									if (column[i][l].piece.team != actingSquare.piece.team && !column[i][l].piece.moved)
									{
										if (column[i][l].piece is Queen || column[i][l].piece is Rook)
										{
											returnArray.push(column[i][l])
										}
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
									if (column[i][l].piece.team != actingSquare.piece.team && !column[i][l].piece.moved)
									{
										if (column[i][l].piece is Queen || column[i][l].piece is Rook)
										{
											returnArray.push(column[i][l])
										}
									}
									break;
								}
							}
							j = column[i].lastIndexOf(actingSquare);
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
								if ((i == sideLength - 2 && k > 1) || (i == sideLength - 1 && k > 0))
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
									if (j < sideLength - 1)
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
									if (j < sideLength - 2)
									{
										l = 2;
										hilightItems(k,l);
									}
								}
								function hilightItems(k:int, l:int):void
								{
									if (column[i + k][j + l].piece is Sprite)
									{
										if (column[i + k][j + l].piece.team != actingSquare.piece.team && !column[i + k][j + l].piece.moved)
										{
											if (column[i + k][j + l].piece is Knight)
											{
												returnArray.push(column[i + k][j + l])
											}
										}
									}
								}
							}
						}
					}
					return returnArray
				}
				function valuePieces(p:int,q:int):void
				{
					if (actionTargets[p][q].piece is King)
					{
						actionValues[p][q] *= 3
					}
					else if (actionTargets[p][q].piece is Queen)
					{
						actionValues[p][q] *= 1.5
					}
					else if (actionTargets[p][q].piece is Rook)
					{
						actionValues[p][q] *= 1.25
					}
					else if (actionTargets[p][q].piece is Bishop || actionTargets[p][q].piece is Knight)
					{
						actionValues[p][q] *= 1.1
					}
					actionValues[p][q] *= (actionTargets[p][q].piece.totalHealth / actionTargets[p][q].piece.currentHealth)
					if (!actionTargets[p][q].piece.moved)
					{
						actionValues[p][q] *= 1.1
					}
					var kingSquare:Object
					var queenSquare:Object
					for (i = 0; i < column.length; i++)
					{
						for (j = 0; j < column[i].length; j++)
						{
							if (column[i][j].piece is Sprite)
							{
								if (column[i][j].piece.team == actingSquare.piece.team)
								{
									if (column[i][j].piece is King)
									{
										kingSquare = column[i][j]
									}
									if (column[i][j].piece is Queen)
									{
										queenSquare = column[i][j]
									}
								}
							}
						}
					}
					if (kingSquare is Square)
					{
						attackerArray = checkAttackers(kingSquare)
						for (i = 0; i < attackerArray.length; i++)
						{
							if (attackerArray[i] == actionTargets[p][q])
							{
								actionValues[p][q] *= 1.75
							}
						}
					}
					if (queenSquare is Square)
					{
						attackerArray = checkAttackers(queenSquare)
						for (i = 0; i < attackerArray.length; i++)
						{
							if (attackerArray[i] == actionTargets[p][q])
							{
								actionValues[p][q] *= 1.25
							}
						}
					}
					attackerArray = checkAttackers(actingSquare)
					for (i = 0; i < attackerArray.length; i++)
					{
						if (attackerArray[i] == actionTargets[p][q])
						{
							actionValues[p][q] *= 1.1
						}
					}
				}
			}
			function addRandomSeed():void
			{
				for (p = 0; p < actionValues.length; p++)
				{
					for (q = 0; q < actionValues[p].length; q++)
					{
						actionValues[p][q] *= 1 + ((Math.random() / 3) / AILevel)
					}
				}
			}
			function pickTarget():void
			{
				for (p = 0; p < actionTargets.length; p++)
				{
					for (q = 0; q < actionTargets[p].length; q++)
					{
						if (actionValues[p][q] >= maxValue)
						{
							maxValue = actionValues[p][q]
							maxValueIndex = new Point(p,q)
						}
					}
				}
			}
			function act():void
			{
				var iconClass:Class = possibleActions[maxValueIndex.x]
				var attackingSquare:Object = actingSquare
				var defendingSquare:Object = actionTargets[maxValueIndex.x][maxValueIndex.y]
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
							if (i == sideLength - 1)
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
								if (j == sideLength - 1)
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
							if (i == sideLength - 1)
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
								if (j == sideLength - 1)
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
							if (i == sideLength - 1)
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
								if (j == sideLength - 1)
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
											if (column[i + 1][j - 1].piece is Sprite)
											{
												attackingSquare.piece.attack(n - j - 2, m - i);
												column[i + 1][j - 1].piece.hurt(attackingSquare.piece.totalDamage,attackingSquare,killPiece);
											}
										}
									}
									else
									{
										if (j < sideLength - 1)
										{
											if (column[i + 1][j + 1].piece is Sprite)
											{
												attackingSquare.piece.attack(n - j + 2, m - i);
												column[i + 1][j + 1].piece.hurt(attackingSquare.piece.totalDamage,attackingSquare,killPiece);
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
							if (i == sideLength - 1)
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
								if (j == sideLength - 1)
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
							if (i == sideLength - 1)
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
								if (j == sideLength - 1)
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
								for (k = i + 1; k <= sideLength - 1 || l <= sideLength - 1; k++)
								{
									if (k > sideLength - 1 || l > sideLength - 1)
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
								for (k = i - 1; k >= 0 || l <= sideLength - 1; k--)
								{
									if (k < 0 || l > sideLength - 1)
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
								for (k = i + 1; k <= sideLength - 1 || l >= 0; k++)
								{
									if (k > sideLength - 1 || l < 0)
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
								for (k = i + 1; k <= sideLength - 1; k++)
								{
									if (k > sideLength - 1)
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
								for (l = j + 1; l <= sideLength - 1; l++)
								{
									if (l > sideLength - 1)
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
			}
		}
		public static function moveEnemyPiece(column:Array,color:String,topChild:Sprite,AILevel:int,finishAI:Function,currentRound:int,instance:Sprite,beginAttack:Function):void
		{
			var p:int
			var q:int
			var i:int
			var j:int
			var pieceToMove:Sprite
			var pieceToMove2:Sprite
			var originSquare:Object
			var destinationSquare:Object
			var originSquare2:Object
			var destinationSquare2:Object
			var startChess:Boolean = false
			var squareTester:Sprite = new Sprite()
			var testerCollisions:Array = []
			var maxIndex:Point
			var maxValue:Number = -10
			var maxValueIndex:Point = new Point(0,0)
			var weighedOptions:Array = weighMoves(column,color,currentRound,instance)
			var moveablePieces:Array = weighedOptions[0]
			var destinations:Array = weighedOptions[1]
			var values:Array = weighedOptions[2]
			addRandomSeed()
			weighOptions()
			finish()
			function addRandomSeed():void
			{
				for (p = 0; p < values.length; p++)
				{
					for (q = 0; q < values[i].length; q++)
					{
						values[p][q] *= 1 + ((Math.random() / (4 * 15)))
					}
				}
			}
			function weighOptions():void
			{
				var max:Number = -5
				for (p = 0; p < values.length; p++)
				{
					for (q = 0; q < values[p].length; q++)
					{
						if (values[p][q] >= max)
						{
							max = values[p][q]
							maxIndex = new Point(p,q)
						}
					}
				}
			}
			function finish():void
			{
				if (destinations[maxIndex.x][maxIndex.y].piece is Sprite)
				{
					var initiatingSquare:Sprite = moveablePieces[maxIndex.x] as Sprite
					var recievingSquare:Sprite = destinations[maxIndex.x][maxIndex.y] as Sprite
					var initiatingSquareObject:Object = moveablePieces[maxIndex.x] as Object
					var recievingSquareObject:Object = destinations[maxIndex.x][maxIndex.y] as Object
					squareTester = new Sprite()
					squareTester.graphics.beginFill(0x000000,1)
					squareTester.graphics.drawRect(-125 / 3, -125 / 3, 250 / 3, 250 / 3)
					squareTester.graphics.endFill()
					squareTester.alpha = 0
					squareTester.x = (initiatingSquare.x + recievingSquare.x) / 2
					squareTester.y = (initiatingSquare.y + recievingSquare.y) / 2
					instance.addChild(squareTester)
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
					testerCollisions = []
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
					instance.removeChild(squareTester)
					recievingSquareObject.IlluminateRed()
					initiatingSquareObject.IlluminateYellow()
					beginAttack(testerCollisions,firstSquare,initiatingSquare,recievingSquare,currentRound,column)
				}
				else
				{
					originSquare = moveablePieces[maxIndex.x]
					destinationSquare = destinations[maxIndex.x][maxIndex.y]
					pieceToMove = originSquare.piece
					var moveTimer:int = 0
					originSquare.removeChild(pieceToMove);
					topChild.addChild(pieceToMove);
					pieceToMove.x = originSquare.x;
					pieceToMove.y = originSquare.y;
					pieceToMove.addEventListener(Event.ENTER_FRAME,movePiece)
					function movePiece(e:Event):void
					{
						moveTimer++;
						var xDistanceToTravel:Number = destinationSquare.x - originSquare.x;
						var yDistanceToTravel:Number = destinationSquare.y - originSquare.y;
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
							pieceToMove.removeEventListener(Event.ENTER_FRAME,movePiece)
							finishAI()
						}
					}
				}
			}
		}
		public static function weighMoves(column:Array,color:String,currentRound:int,instance:Sprite):Array
		{
			var p:int
			var q:int
			var i:int
			var j:int
			var k:int
			var l:int
			var m:int
			var n:int
			var kmax:int
			var lmax:int
			var iModifier:int
			var squareTester:Sprite = new Sprite()
			var testerCollisions:Array = []
			var moveablePieces:Array = []
			var destinations:Array = []
			var values:Array = []
			findPiecesAndDestinations()
			valueDestinations()
			function findPiecesAndDestinations():void
			{
				for (i = 0; i < column.length; i++)
				{
					for (j = 0; j < column[i].length; j++)
					{
						var pieceDestinations:Array = checkTargets(column[i][j],i,j)
						if (pieceDestinations.length > 0)
						{
							moveablePieces.push(column[i][j])
							destinations.push(pieceDestinations)
						}
					}
				}
				function checkTargets(square:Object,i:int,j:int):Array
				{
					var returnArray:Array = []
					if (square.piece is Sprite)
					{
						if (square.piece.team == color)
						{
							if (square.piece is King)
							{
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
											if (column[i + k][j + l].piece.team != color)
											{
												returnArray.push(column[i + k][j + l])
											}
										}
										else
										{
											returnArray.push(column[i + k][j + l])
										}
									}
								}
							}
							else if (square.piece is Queen)
							{
								for (k = i + 1; k <= 7; k++)
								{
									if (k > 7)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != color)
										{
											returnArray.push(column[k][j])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][j])
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
										if (column[k][j].piece.team != color)
										{
											returnArray.push(column[k][j])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][j])
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
										if (column[i][l].piece.team != color)
										{
											returnArray.push(column[i][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[i][l])
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
										if (column[i][l].piece.team != color)
										{
											returnArray.push(column[i][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[i][l])
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
										if (column[k][l].piece.team != color)
										{
											returnArray.push(column[k][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][l])
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
										if (column[k][l].piece.team != color)
										{
											returnArray.push(column[k][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][l])
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
										if (column[k][l].piece.team != color)
										{
											returnArray.push(column[k][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][l])
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
										if (column[k][l].piece.team != color)
										{
											returnArray.push(column[k][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][l])
									}
									l++;
								}
							}
							else if (square.piece is Rook)
							{
								for (k = i + 1; k <= 7; k++)
								{
									if (k > 7)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != color)
										{
											returnArray.push(column[k][j])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][j])
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
										if (column[k][j].piece.team != color)
										{
											returnArray.push(column[k][j])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][j])
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
										if (column[i][l].piece.team != color)
										{
											returnArray.push(column[i][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[i][l])
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
										if (column[i][l].piece.team != color)
										{
											returnArray.push(column[i][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[i][l])
									}
								}
							}
							else if (square.piece is Bishop)
							{
								l = j + 1;
								for (k = i + 1; k <= 7 || l <= 7; k++)
								{
									if (k > 7 || l > 7)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != color)
										{
											returnArray.push(column[k][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][l])
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
										if (column[k][l].piece.team != color)
										{
											returnArray.push(column[k][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][l])
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
										if (column[k][l].piece.team != color)
										{
											returnArray.push(column[k][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][l])
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
										if (column[k][l].piece.team != color)
										{
											returnArray.push(column[k][l])
										}
										break;
									}
									else
									{
										returnArray.push(column[k][l])
									}
									l++;
								}
							}
							else if (square.piece is Knight)
							{
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
											checkItems(k,l);
										}
										if (j < 7)
										{
											l = 1;
											checkItems(k,l);
										}
									}
									if (k != 0 && (k == -1 || k == 1))
									{
										if (j > 1)
										{
											l = -2;
											checkItems(k,l);
										}
										if (j < 6)
										{
											l = 2;
											checkItems(k,l);
										}
									}
									function checkItems(k:int, l:int):void
									{
										if (column[i + k][j + l].piece is Sprite)
										{
											if (column[i + k][j + l].piece.team != color)
											{
												returnArray.push(column[i + k][j + l])
											}
										}
										else
										{
											returnArray.push(column[i + k][j + l])
										}
									}
								}
							}
							else if (square.piece is Pawn)
							{
								if (square.piece.startingPosition == "top")
								{
									iModifier = 1
								}
								else
								{
									iModifier = -1
								}
								if (i != 7)
								{
									if (!(column[i + iModifier][j].piece is Sprite))
									{
										returnArray.push(column[i + iModifier][j])
										if (! square.piece.everMoved && !(column[i + (2 * iModifier)][j].piece is Sprite))
										{
											returnArray.push(column[i + (2 * iModifier)][j])
										}
									}
									if (j != 0)
									{
										if (column[i + iModifier][j - 1].piece is Sprite)
										{
											if (column[i + iModifier][j - 1].piece.team != color)
											{
												returnArray.push(column[i + iModifier][j - 1])
											}
										}
									}
									if (j != 7)
									{
										if (column[i + iModifier][j + 1].piece is Sprite)
										{
											if (column[i + iModifier][j + 1].piece.team != color)
											{
												returnArray.push(column[i + iModifier][j + 1])
											}
										}
									}
								}
							}
						}
					}
					return returnArray
				}
			}
			function valueDestinations():void
			{
				for (p = 0; p < destinations.length; p++)
				{
					values[p] = new Array()
					for (q = 0; q < destinations[p].length; q++)
					{
						var currentPossibleAttackers:Array = checkAttackers(moveablePieces[p])
						var futurePossibleAttackers:Array = checkAttackers(destinations[p][q])
						if (destinations[p][q].piece is Sprite)
						{
							var territory:Array = findTerritory(moveablePieces[p] as Sprite,destinations[p][q] as Sprite)
							values[p][q] = 1.1
							if (moveablePieces[p].piece is King)
							{
								values[p][q] /= 1.3
							}
							values[p][q] *= weighPieces(destinations[p][q]) * 1.2
							values[p][q] *= findImportanceOfTargets(destinations[p][q],destinations[p][q].piece.team)
							var valueModifier:Number = 1
							if (destinations[p][q].piece is Queen)
							{
								if (destinations[p][q].piece.shielded)
								{
									valueModifier *= 0.25
								}
							}
							else if (destinations[p][q].piece is Pawn)
							{
								if (destinations[p][q].piece.defending)
								{
									valueModifier = 0
								}
							}
							if (moveablePieces[p].piece.manaLeech > 0)
							{
								valueModifier *= 1 + (moveablePieces[p].piece.manaLeech / 25)
							}
							if (moveablePieces[p].piece.healthLeech > 0)
							{
								valueModifier *= 1 + (moveablePieces[p].piece.manaLeech / 25)
							}
							if (destinations[p][q].piece.armor >= moveablePieces[p].piece.totalDamage)
							{
								valueModifier = 0;
							}
							else
							{
								valueModifier *= 1.075 + ((moveablePieces[p].piece.totalDamage + (moveablePieces[p].piece.currentMana / 2) - (destinations[p][q].piece.armor + destinations[p][q].piece.currentHealth)) / (destinations[p][q].piece.totalHealth * 2))
							}
							var possibleAttackers:Array = checkAttackers(moveablePieces[p])
							if (destinations[p][q].piece.armor + destinations[p][q].piece.currentHealth > moveablePieces[p].piece.totalDamage)
							{
								if (possibleAttackers.lastIndexOf(destinations[p][q]) >= 0)
								{
									valueModifier /= 1.05 + ((destinations[p][q].piece.totalDamage + (destinations[p][q].piece.currentMana / 2) - (moveablePieces[p].piece.armor + moveablePieces[p].piece.currentHealth)) / (moveablePieces[p].piece.totalHealth * 6))
								}
							}
							values[p][q] *= valueModifier
							for (m = 0; m < territory.length; m++)
							{
								if (territory[m].piece is Sprite)
								{
									var tempAttackers:Array = checkAttackers(territory[m])
									if (territory[m].piece.team == moveablePieces[p].piece.team)
									{
										values[p][q] *= 1 + (1.1 / territory.length)
										values[p][q] *= 1 + ((findImportanceOfTargets(territory[m],territory[m].piece.team) - 1) / (territory.length * 24))
									}
									else if (territory[m].piece.team != moveablePieces[p].piece.team)
									{
										values[p][q] /= 1 + (1.15 / territory.length)
										values[p][q] /= 1 + ((findImportanceOfTargets(territory[m],territory[m].piece.team) - 1) / (territory.length * 18))
									}
									for (n = 0; n < territory.length; n++)
									{
										if (territory[m].piece.team == moveablePieces[p].piece.team)
										{
											if (tempAttackers.lastIndexOf(territory[n]) >= 0)
											{
												values[p][q] *= 1.01 + (1 / territory.length)
											}
										}
										else if (territory[m].piece.team != moveablePieces[p].piece.team)
										{
											if (tempAttackers.lastIndexOf(territory[n]) >= 0)
											{
												values[p][q] /= 1 + (1 / territory.length)
											}
										}
									}
								}
							}
						}
						else
						{
							var totalMovesBefore:int = findTotalMoves()
							var importanceOfCurrentTargets:Number = findImportanceOfTargets(moveablePieces[p],color)
							destinations[p][q].piece = moveablePieces[p].piece
							moveablePieces[p].piece = null
							var totalMovesAfter:int = findTotalMoves()
							var importanceOfFutureTargets:Number = findImportanceOfTargets(destinations[p][q],color)
							moveablePieces[p].piece = destinations[p][q].piece
							destinations[p][q].piece = null
							values[p][q] = 1
							if (canBlockKing(destinations[p][q],moveablePieces[p]) == 0)
							{
								if (moveablePieces[p].piece is King)
								{
									values[p][q] /= 1.1
								}
								values[p][q] *= 1.2
							}
							else if (canBlockKing(destinations[p][q],moveablePieces[p]) == 1)
							{
								values[p][q] /= 1.2
							}
							values[p][q] *= importanceOfFutureTargets - importanceOfCurrentTargets + 1
							values[p][q] *= ((totalMovesAfter - totalMovesBefore + 5) / 100) + 1
							values[p][q] *= ((currentPossibleAttackers.length - futurePossibleAttackers.length) / 6) + 1
							values[p][q] *= weighEarlyRisks(moveablePieces[p],destinations[p][q])
						}
					}
				}
				function weighEarlyRisks(pieceSquare:Object,targetSquare:Object):Number
				{
					var baseReturn:Number = 1
					if (pieceSquare.piece is Queen)
					{
						if (!pieceSquare.piece.everMoved)
						{
							baseReturn /= 1.03
						}
					}
					if (pieceSquare.piece is Knight || pieceSquare.piece is Bishop)
					{
						if (!pieceSquare.piece.everMoved)
						{
							baseReturn *= 1.03
						}
					}
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(targetSquare) >= 0)
						{
							j = column[i].lastIndexOf(targetSquare)
							if (!(pieceSquare.piece is King) && i == 0)
							{
								baseReturn /= ((10 / (currentRound + 10)) / 10) + 1
							}
						}
					}
					baseReturn *= (1 / ((100 / currentRound) * (weighPieces(pieceSquare)))) + 1
					return baseReturn
				}
				function weighPieces(square:Object):Number
				{
					var returnNumber:Number = 1
					if (square.piece is King)
					{
						returnNumber *= 1.4
					}
					else if (square.piece is Queen)
					{
						returnNumber *= 1.16
					}
					else if (square.piece is Rook)
					{
						returnNumber *= 1.08
					}
					else if (square.piece is Bishop)
					{
						returnNumber *= 1.03
					}
					else if (square.piece is Knight)
					{
						returnNumber *= 1.03
					}
					return returnNumber
				}
				function findImportanceOfTargets(square:Object,friendlyColor:String):Number
				{
					var squareArray:Array = []
					var returnNumber:Number = 1
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(square) >= 0)
						{
							j = column[i].lastIndexOf(square)
							if (square.piece is King)
							{
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
											if (column[i + k][j + l].piece.team != friendlyColor)
											{
												squareArray.push(column[i + k][j + l])
											}
										}
									}
								}
							}
							else if (square.piece is Queen)
							{
								for (k = i + 1; k <= 7; k++)
								{
									if (k > 7)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != friendlyColor)
										{
											squareArray.push(column[k][j])
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
										if (column[k][j].piece.team != friendlyColor)
										{
											squareArray.push(column[k][j])
										}
										break;
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
										if (column[i][l].piece.team != friendlyColor)
										{
											squareArray.push(column[i][l])
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
										if (column[i][l].piece.team != friendlyColor)
										{
											squareArray.push(column[i][l])
										}
										break;
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
										if (column[k][l].piece.team != friendlyColor)
										{
											squareArray.push(column[k][l])
										}
										break;
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
										if (column[k][l].piece.team != friendlyColor)
										{
											squareArray.push(column[k][l])
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
										if (column[k][l].piece.team != friendlyColor)
										{
											squareArray.push(column[k][l])
										}
										break;
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
										if (column[k][l].piece.team != friendlyColor)
										{
											squareArray.push(column[k][l])
										}
										break;
									}
									l++;
								}
							}
							else if (square.piece is Rook)
							{
								for (k = i + 1; k <= 7; k++)
								{
									if (k > 7)
									{
										break;
									}
									if (column[k][j].piece is Sprite)
									{
										if (column[k][j].piece.team != friendlyColor)
										{
											squareArray.push(column[k][j])
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
										if (column[k][j].piece.team != friendlyColor)
										{
											squareArray.push(column[k][j])
										}
										break;
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
										if (column[i][l].piece.team != friendlyColor)
										{
											squareArray.push(column[i][l])
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
										if (column[i][l].piece.team != friendlyColor)
										{
											squareArray.push(column[i][l])
										}
										break;
									}
								}
							}
							else if (square.piece is Bishop)
							{
								l = j + 1;
								for (k = i + 1; k <= 7 || l <= 7; k++)
								{
									if (k > 7 || l > 7)
									{
										break;
									}
									if (column[k][l].piece is Sprite)
									{
										if (column[k][l].piece.team != friendlyColor)
										{
											squareArray.push(column[k][l])
										}
										break;
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
										if (column[k][l].piece.team != friendlyColor)
										{
											squareArray.push(column[k][l])
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
										if (column[k][l].piece.team != friendlyColor)
										{
											squareArray.push(column[k][l])
										}
										break;
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
										if (column[k][l].piece.team != friendlyColor)
										{
											squareArray.push(column[k][l])
										}
										break;
									}
									l++;
								}
							}
							else if (square.piece is Knight)
							{
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
											checkItems(k,l);
										}
										if (j < 7)
										{
											l = 1;
											checkItems(k,l);
										}
									}
									if (k != 0 && (k == -1 || k == 1))
									{
										if (j > 1)
										{
											l = -2;
											checkItems(k,l);
										}
										if (j < 6)
										{
											l = 2;
											checkItems(k,l);
										}
									}
									function checkItems(k:int, l:int):void
									{
										if (column[i + k][j + l].piece is Sprite)
										{
											if (column[i + k][j + l].piece.team != friendlyColor)
											{
												squareArray.push(column[i + k][j + l])
											}
										}
									}
								}
							}
							else if (square.piece is Pawn)
							{
								if (i != 7)
								{
									if (j != 0)
									{
										if (column[i + 1][j - 1].piece is Sprite)
										{
											if (column[i + 1][j - 1].piece.team != friendlyColor)
											{
												squareArray.push(column[i + 1][j - 1])
											}
										}
									}
									if (j != 7)
									{
										if (column[i + 1][j + 1].piece is Sprite)
										{
											if (column[i + 1][j + 1].piece.team != friendlyColor)
											{
												squareArray.push(column[i + 1][j + 1])
											}
										}
									}
								}
							}
						}
					}
					for (i = 0; i < squareArray.length; i++)
					{
						returnNumber *= ((weighPieces(squareArray[i]) - 1) / 4) + 1
					}
					return returnNumber
				}
				function canBlockKing(possibleSquare:Object,mover:Object):int
				{
					var kingSquare:Object
					for (i = 0; i < column.length; i++)
					{
						for (j = 0; j < column[i].length; j++)
						{
							if (column[i][j].piece is Sprite)
							{
								if (column[i][j].piece is King && column[i][j].piece.team == color)
								{
									kingSquare = column[i][j]
								}
							}
						}
					}
					var attackersBefore:Array = checkAttackers(kingSquare)
					possibleSquare.piece = mover.piece
					mover.piece = null
					var attackersAfter = checkAttackers(kingSquare)
					mover.piece = possibleSquare.piece
					possibleSquare.piece = null
					if (attackersAfter.length < attackersBefore.length)
					{
						return 0
					}
					else if (attackersAfter.length > attackersBefore.length)
					{
						return 1
					}
					return 2
				}
				function findTotalMoves():int
				{
					var total:int = 0
					for (i = 0; i < column.length; i++)
					{
						for (j = 0; j < column[i].length; j++)
						{
							if (column[i][j].piece is Sprite)
							{
								if (column[i][j].piece.team == color)
								{
									if (column[i][j].piece is King)
									{
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
												if (!(column[i + k][j + l].piece is Sprite))
												{
													total++
												}
											}
										}
									}
									else if (column[i][j].piece is Queen)
									{
										for (k = i + 1; k <= 7; k++)
										{
											if (k > 7)
											{
												break;
											}
											if (column[k][j].piece is Sprite)
											{
												if (column[k][j].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][j].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[i][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[i][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
											}
											l++;
										}
									}
									else if (column[i][j].piece is Rook)
									{
										for (k = i + 1; k <= 7; k++)
										{
											if (k > 7)
											{
												break;
											}
											if (column[k][j].piece is Sprite)
											{
												if (column[k][j].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][j].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[i][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[i][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
											}
										}
									}
									else if (column[i][j].piece is Bishop)
									{
										l = j + 1;
										for (k = i + 1; k <= 7 || l <= 7; k++)
										{
											if (k > 7 || l > 7)
											{
												break;
											}
											if (column[k][l].piece is Sprite)
											{
												if (column[k][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
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
												if (column[k][l].piece.team != color)
												{
													total++
												}
												break;
											}
											else
											{
												total++
											}
											l++;
										}
									}
									else if (column[i][j].piece is Knight)
									{
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
													checkItems(k,l);
												}
												if (j < 7)
												{
													l = 1;
													checkItems(k,l);
												}
											}
											if (k != 0 && (k == -1 || k == 1))
											{
												if (j > 1)
												{
													l = -2;
													checkItems(k,l);
												}
												if (j < 6)
												{
													l = 2;
													checkItems(k,l);
												}
											}
											function checkItems(k:int, l:int):void
											{
												if (column[i + k][j + l].piece is Sprite)
												{
													if (column[i + k][j + l].piece.team != color)
													{
														total++
													}
												}
												else
												{
													total++
												}
											}
										}
									}
									else if (column[i][j].piece is Pawn)
									{
										if (column[i][j].piece.startingPosition == "top")
										{
											iModifier = 1
										}
										else
										{
											iModifier = -1
										}
										if (i != 7)
										{
											if (!(column[i + iModifier][j].piece is Sprite))
											{
												total++
												if (! column[i][j].piece.everMoved && !(column[i + (2 * iModifier)][j].piece is Sprite))
												{
													total++
												}
											}
											if (j != 0)
											{
												if (column[i + iModifier][j - 1].piece is Sprite)
												{
													if (column[i + iModifier][j - 1].piece.team != color)
													{
														total++
													}
												}
											}
											if (j != 7)
											{
												if (column[i + iModifier][j + 1].piece is Sprite)
												{
													if (column[i + iModifier][j + 1].piece.team != color)
													{
														total++
													}
												}
											}
										}
									}
								}
							}
						}
					}
					return total
				}
				function checkAttackers(reciever:Object):Array
				{
					var returnArray:Array = []
					for (i = 0; i < column.length; i++)
					{
						if (column[i].lastIndexOf(reciever) >= 0)
						{
							j = column[i].lastIndexOf(reciever);
							l = j + 1;
							for (k = i + 1; k <= 7 || l <= 7; k++)
							{
								if (k > 7 || l > 7)
								{
									break;
								}
								if (column[k][l].piece is Sprite)
								{
									if (column[k][l].piece.team != color)
									{
										if (k == i + 1 && l == j + 1)
										{
											if (column[k][l].piece is Pawn)
											{
												returnArray.push(column[k][l])
											}
										}
										if (column[k][l].piece is Queen || column[k][l].piece is Bishop)
										{
											returnArray.push(column[k][l])
										}
									}
									break;
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
									if (column[k][l].piece.team != color)
									{
										if (k == i + 1 && l == j - 1)
										{
											if (column[k][l].piece is Pawn)
											{
												returnArray.push(column[k][l])
											}
										}
										if (column[k][l].piece is Queen || column[k][l].piece is Bishop)
										{
											returnArray.push(column[k][l])
										}
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
									if (column[k][l].piece.team != color)
									{
										if (column[k][l].piece is Queen || column[k][l].piece is Bishop)
										{
											returnArray.push(column[k][l])
										}
										if (column[k][l].piece is Pawn)
										{
											if (k == i - 1 && l == j - 1)
											{
												returnArray.push(column[k][l])
											}
										}
									}
									break;
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
									if (column[k][l].piece.team != color)
									{
										if (column[k][l].piece is Queen || column[k][l].piece is Bishop)
										{
											returnArray.push(column[k][l])
										}
										if (column[k][l].piece is Pawn)
										{
											if (k == i - 1 && l == j + 1)
											{
												returnArray.push(column[k][l])
											}
										}
									}
									break;
								}
								l++;
							}
							for (k = i + 1; k <= 7; k++)
							{
								if (k > 7)
								{
									break;
								}
								if (column[k][j].piece is Sprite)
								{
									if (column[k][j].piece.team != color)
									{
										if (column[k][j].piece is Queen || column[k][j].piece is Rook)
										{
											returnArray.push(column[k][j])
										}
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
									if (column[k][j].piece.team != color)
									{
										if (column[k][j].piece is Queen || column[k][j].piece is Rook)
										{
											returnArray.push(column[k][j])
										}
									}
									break;
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
									if (column[i][l].piece.team != color)
									{
										if (column[i][l].piece is Queen || column[i][l].piece is Rook)
										{
											returnArray.push(column[i][l])
										}
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
									if (column[i][l].piece.team != color)
									{
										if (column[i][l].piece is Queen || column[i][l].piece is Rook)
										{
											returnArray.push(column[i][l])
										}
									}
									break;
								}
							}
							j = column[i].lastIndexOf(reciever);
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
										if (column[i + k][j + l].piece.team != color)
										{
											if (column[i + k][j + l].piece is Knight)
											{
												returnArray.push(column[i + k][j + l])
											}
										}
									}
								}
							}
						}
					}
					return returnArray
				}
				function findTerritory(attacker:Sprite,reciever:Sprite):Array
				{
					squareTester = new Sprite()
					squareTester.graphics.beginFill(0x000000,1)
					squareTester.graphics.drawRect(-125 / 3, -125 / 3, 250 / 3, 250 / 3)
					squareTester.graphics.endFill()
					squareTester.alpha = 0
					squareTester.x = (attacker.x + reciever.x) / 2
					squareTester.y = (attacker.y + reciever.y) / 2
					instance.addChild(squareTester)
					do
					{
						squareTester.width += 500 / 3
						squareTester.height += 500 / 3
					}
					while(!(squareTester.hitTestObject(attacker) && squareTester.hitTestObject(reciever)))
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
					testerCollisions = []
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
						squareTester.x += (reciever.x - attacker.x) / (squareTester.width / 5)
						squareTester.y += (reciever.y - attacker.y) / (squareTester.height / 5)
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
					instance.removeChild(squareTester)
					return testerCollisions
				}
			}
			return [moveablePieces,destinations,values]
		}
		public static function analyzeMovement(column:Array,initiatingSquare:Object,recievingSquare:Object,weighedOptions:Array,previousCoefficient):Number
		{
			var i:int
			var j:int
			var p:int
			var q:int
			var maxIndex:Point
			var X:Number = -Math.log((1 / previousCoefficient) - 1) / Math.log(2)
			i = weighedOptions[0].lastIndexOf(initiatingSquare)
			j = weighedOptions[1][i].lastIndexOf(recievingSquare)
			var max:Number = -5
			for (p = 0; p < weighedOptions[2].length; p++)
			{
				for (q = 0; q < weighedOptions[2][p].length; q++)
				{
					if (weighedOptions[2][p][q] >= max)
					{
						max = weighedOptions[2][p][q]
						maxIndex = new Point(p,q)
					}
				}
			}
			if (weighedOptions[1][i][j].piece is Sprite)
			{
				X += (max - weighedOptions[2][i][j]) / 2
			}
			else
			{
				X += (weighedOptions[2][i][j] - max) / 10
			}
			return 1 / (1 + Math.pow(2,-X))
		}
	}
}
