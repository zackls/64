package 
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.utils.getDefinitionByName
	import fl.motion.Color
	import flash.filters.GlowFilter
	public class Animations
	{
		public static function critical(actionCaller:Object):void
		{
			actionCaller.textFormat.color = 0xFFFFFF;
			actionCaller.textFormat.align = "center";
			var criticalText:TextField = new TextField();
			criticalText.defaultTextFormat = actionCaller.textFormat;
			criticalText.text = "Critical!";
			criticalText.height = 45;
			criticalText.autoSize = TextFieldAutoSize.CENTER;
			criticalText.x =  -  criticalText.width / 2;
			criticalText.z =  -  criticalText.height / 2;
			criticalText.z -=  250;
			criticalText.rotationX = 90;
			criticalText.alpha = 0.25;
			var timer:int = 0;
			actionCaller.addChild(criticalText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendCritical);
			function ascendCritical(e:Event):void
			{
				timer++;
				if (criticalText.alpha > 0.07)
				{
					criticalText.alpha = 1 / (Math.pow((timer - 12) / 6,2) + 0.01);
					criticalText.z -=  1.5;
				}
				else
				{
					if (actionCaller.contains(criticalText))
					{
						actionCaller.removeChild(criticalText);
					}
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendCritical);
				}
			}
		}
		public static function dodge(actionCaller:Object):void
		{
			actionCaller.textFormat.color = 0xAAAAAA;
			actionCaller.textFormat.align = "center";
			var dodgeText:TextField = new TextField();
			dodgeText.defaultTextFormat = actionCaller.textFormat;
			dodgeText.text = "Dodge!";
			dodgeText.height = 45;
			dodgeText.autoSize = TextFieldAutoSize.CENTER;
			dodgeText.x =  -  dodgeText.width / 2;
			dodgeText.z =  -  dodgeText.height / 2;
			dodgeText.z -=  250;
			dodgeText.rotationX = 90;
			dodgeText.alpha = 0.25;
			var timer:int = 0;
			actionCaller.addChild(dodgeText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendDodge);
			function ascendDodge(e:Event):void
			{
				timer++;
				if (dodgeText.alpha > 0.07)
				{
					dodgeText.alpha = 1 / (Math.pow((timer - 12) / 6,2) + 0.01);
					dodgeText.z -=  1.5;
				}
				else
				{
					if (actionCaller.contains(dodgeText))
					{
						actionCaller.removeChild(dodgeText);
					}
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendDodge);
				}
			}
		}
		public static function instantKill(actionCaller:Object):void
		{
			actionCaller.textFormat.color = 0x000000;
			actionCaller.textFormat.align = "center";
			var killText:TextField = new TextField();
			killText.defaultTextFormat = actionCaller.textFormat;
			killText.text = "Instant Kill!";
			killText.height = 45;
			killText.autoSize = TextFieldAutoSize.CENTER;
			killText.x =  -  killText.width / 2;
			killText.z =  -  killText.height / 2;
			killText.z -=  250;
			killText.rotationX = 90;
			killText.alpha = 0.25;
			var timer:int = 0;
			actionCaller.addChild(killText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendKill);
			function ascendKill(e:Event):void
			{
				timer++;
				if (killText.alpha > 0.07)
				{
					killText.alpha = 1 / (Math.pow((timer - 12) / 6,2) + 0.01);
					killText.z -=  1.5;
				}
				else
				{
					if (actionCaller.contains(killText))
					{
						actionCaller.removeChild(killText);
					}
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendKill);
				}
			}
		}
		public static function stun(actionCaller:Object):void
		{
			actionCaller.textFormat.color = 0xFFFFFF;
			actionCaller.textFormat.align = "center";
			var stunText:TextField = new TextField();
			stunText.defaultTextFormat = actionCaller.textFormat;
			stunText.text = "Stun!";
			stunText.height = 45;
			stunText.autoSize = TextFieldAutoSize.CENTER;
			stunText.x =  -  stunText.width / 2;
			stunText.z =  -  stunText.height / 2;
			stunText.z -=  290;
			stunText.rotationX = 90;
			stunText.alpha = 0.25;
			var timer:int = 0;
			actionCaller.addChild(stunText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendStun);
			function ascendStun(e:Event):void
			{
				timer++;
				if (stunText.alpha > 0.07)
				{
					stunText.alpha = 1 / (Math.pow((timer - 12) / 6,2) + 0.01);
					stunText.z -=  1.5;
				}
				else
				{
					if (actionCaller.contains(stunText))
					{
						actionCaller.removeChild(stunText);
					}
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendStun);
				}
			}
		}
		public static function die(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,attacker:Object,dieFunction:Function):void
		{
			var parentArray:Array = [actionCaller.parent];
			dieFunction(parentArray);
			if (attacker.piece.team == actionCaller.team)
			{
				attacker.piece.loseExp(actionCaller.expYield);
			}
			else
			{
				attacker.piece.gainExp(actionCaller.expYield);
			}
			var dieTimer:int = 0;
			var alphaStorage:Number = 1;
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendDie);
			function ascendDie(e:Event):void
			{
				dieTimer++;
				if (dieTimer < 36)
				{
					actionCaller.model.alpha = alphaStorage;
					if (Math.random() * dieTimer > 15)
					{
						actionCaller.model.alpha = 0;
					}
					alphaStorage -=  1 / 36;
				}
				else if (dieTimer == 36)
				{
					while (actionCaller.numChildren > 0)
					{
						actionCaller.removeChildAt(0);
					}
					parentArray[0].removeChild(parentArray[0].piece);
					parentArray[0].piece = null;
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendDie);
				}
			}
		}
		public static function gainExp(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,amount:int):void
		{
			var i:int = 0;
			actionCaller.currentExp +=  amount;
			actionCaller.textFormat.align = "center";
			var expText:TextField = new TextField();
			var particleColor:int = 0x009900;
			if (actionCaller.currentExp >= actionCaller.totalExp)
			{
				actionCaller.currentExp -=  actionCaller.totalExp;
				actionCaller.levelUp();
				actionCaller.textFormat.color = 0xD2BC9C;
				particleColor = 0xD2BC9C;
				expText.defaultTextFormat = actionCaller.textFormat;
				expText.text = "Level up!";
			}
			else
			{
				actionCaller.textFormat.color = 0x009900;
				expText.defaultTextFormat = actionCaller.textFormat;
				expText.text = "+" + amount;
			}
			while (actionCaller.currentExp >= actionCaller.totalExp)
			{
				actionCaller.currentExp -=  actionCaller.totalExp;
				levelUp(actionCaller,inFrontContainer,inBackContainer);
			}
			expText.height = 45;
			expText.autoSize = TextFieldAutoSize.CENTER;
			expText.x =  -  expText.width / 2;
			expText.z =  -  expText.height / 2;
			expText.z -=  200;
			expText.rotationX = 90;
			expText.alpha = 0.25;
			var particleContainer:Array = [];
			var expTimer:int = 0;
			actionCaller.addChild(expText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendExp);
			function ascendExp(e:Event):void
			{
				if (expTimer <= 18)
				{
					var particle:Sprite = new blackBlur();
					actionCaller.transformer.color = particleColor;
					particle.transform.colorTransform = actionCaller.transformer;
					particle.x = (Math.random() * 400 / 3) - (200 / 3);
					particle.y = (Math.random() * 400 / 3) - (200 / 3);
					particle.width = 4;
					particle.height = 15;
					particle.rotationX = 90;
					particle.z = 0;
					particleContainer.push(particle);
					if (particle.y < 0)
					{
						inBackContainer.addChild(particle);
					}
					else
					{
						inFrontContainer.addChild(particle);
					}
				}
				for (i = 0; i < particleContainer.length; i++)
				{
					particleContainer[i].z -=  20;
					if (particleContainer[i].z < -240)
					{
						if (inFrontContainer.contains(particleContainer[i]))
						{
							inFrontContainer.removeChild(particleContainer[i]);
						}
						if (inBackContainer.contains(particleContainer[i]))
						{
							inBackContainer.removeChild(particleContainer[i]);
						}
					}
				}
				expTimer++;
				if (expText.alpha > 0.07)
				{
					expText.alpha = 1 / (Math.pow((expTimer - 12) / 6,2) + 0.01);
					expText.z -=  1.5;
				}
				else
				{
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendExp);
					actionCaller.removeChild(expText);
				}
			}
		}
		public static function loseExp(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,amount:int):void
		{
			var i:int = 0;
			if (actionCaller.currentExp - amount < 0)
			{
				amount = actionCaller.currentExp;
			}
			actionCaller.currentExp -=  amount;
			actionCaller.textFormat.align = "center";
			var expText:TextField = new TextField();
			var particleColor:int = 0x003300;
			actionCaller.transformer.color = 0x003300
			expText.transform.colorTransform = actionCaller.transformer
			expText.text = "-" + amount;
			expText.height = 45;
			expText.autoSize = TextFieldAutoSize.CENTER;
			expText.x =  -  expText.width / 2;
			expText.z =  -  expText.height / 2;
			expText.z -=  250;
			expText.rotationX = 90;
			expText.alpha = 0.25;
			var particleContainer:Array = [];
			var expTimer:int = 0;
			actionCaller.addChild(expText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendExp);
			function ascendExp(e:Event):void
			{
				if (expTimer <= 18)
				{
					var particle:Sprite = new blackBlur();
					actionCaller.transformer.color = particleColor;
					particle.transform.colorTransform = actionCaller.transformer;
					particle.x = (Math.random() * 400 / 3) - (200 / 3);
					particle.y = (Math.random() * 400 / 3) - (200 / 3);
					particle.width = 4;
					particle.height = 15;
					particle.rotationX = 90;
					particle.z = -240;
					particleContainer.push(particle);
					if (particle.y < 0)
					{
						inBackContainer.addChild(particle);
					}
					else
					{
						inFrontContainer.addChild(particle);
					}
				}
				for (i = 0; i < particleContainer.length; i++)
				{
					particleContainer[i].z +=  20;
					if (particleContainer[i].z > 0)
					{
						if (inFrontContainer.contains(particleContainer[i]))
						{
							inFrontContainer.removeChild(particleContainer[i]);
						}
						if (inBackContainer.contains(particleContainer[i]))
						{
							inBackContainer.removeChild(particleContainer[i]);
						}
					}
				}
				expTimer++;
				if (expText.alpha > 0.07)
				{
					expText.alpha = 1 / (Math.pow((expTimer - 12) / 6,2) + 0.01);
					expText.z +=  1.5;
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendExp);
					actionCaller.removeChild(expText);
				}
			}
		}
		public static function levelUp(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			actionCaller.lvl++;
			actionCaller.totalExp = 100 + (actionCaller.lvl * 25);
			actionCaller.totalHealth = 200 + ((actionCaller.lvl - 1) * 50);
			actionCaller.currentHealth = actionCaller.totalHealth;
		}
		public static function hurt(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,amount:int,attacker:Object,dieFunction:Function):Boolean
		{
			var i:int = 0;
			var dodged:Boolean = false;
			if (Math.random() < actionCaller.dodgeChance)
			{
				dodged = true;
				dodge(actionCaller);
			}
			else if (Math.random() < attacker.piece.instantKillChance)
			{
				instantKill(actionCaller);
				actionCaller.die(attacker, dieFunction);
			}
			else
			{
				if (Math.random() < attacker.piece.criticalChance)
				{
					amount *=  2;
					critical(actionCaller);
				}
				if (Math.random() < attacker.piece.stunChance)
				{
					actionCaller.stunned = true
					stun(actionCaller);
				}
				if (actionCaller is Queen)
				{
					if (actionCaller.shielded)
					{
						amount *= 0.25
					}
				}
				else if (actionCaller is Pawn)
				{
					if (actionCaller.defending)
					{
						amount = 0
					}
				}
				if (actionCaller.armor >= amount)
				{
					amount = 0;
				}
				if (attacker.piece.manaLeech > 0)
				{
					attacker.piece.recharge(Math.round(attacker.piece.manaLeech))
				}
				if (attacker.piece.healthLeech > 0)
				{
					attacker.piece.heal(Math.round(attacker.piece.totalHealth * attacker.piece.healthLeech))
				}
				else
				{
					actionCaller.currentHealth -=  amount - actionCaller.armor;
				}
				if (actionCaller.currentHealth <= 0)
				{
					actionCaller.die(attacker, dieFunction);
				}
				actionCaller.textFormat.color = 0xFF0000;
				actionCaller.textFormat.align = "center";
				var hurtText:TextField = new TextField();
				hurtText.defaultTextFormat = actionCaller.textFormat;
				hurtText.text = "-" + amount;
				hurtText.height = 45;
				hurtText.autoSize = TextFieldAutoSize.CENTER;
				hurtText.x =  -  hurtText.width / 2;
				hurtText.z =  -  hurtText.height / 2;
				hurtText.z -=  170;
				hurtText.rotationX = 90;
				hurtText.alpha = 0.25;
				var hurtTimer:int = 0;
				var bloodContainer:Array = [];
				var angleContainer:Array = [];
				for (i = 0; i < Math.round(50 * (amount / actionCaller.totalHealth)); i++)
				{
					var blood:Sprite = new blackBlur();
					actionCaller.transformer.color = 0xBB0000;
					blood.transform.colorTransform = actionCaller.transformer;
					blood.height = 7;
					blood.width = 7;
					blood.x = -10 + (Math.random() * 20);
					blood.y = -10 + (Math.random() * 20);
					angleContainer.push(Math.atan2(blood.y, blood.x));
					blood.z = -100 + (Math.random() * 50);
					bloodContainer.push(blood);
					if (blood.y > 0)
					{
						inFrontContainer.addChild(blood);
					}
					else
					{
						inBackContainer.addChild(blood);
					}
				}
				actionCaller.addChild(hurtText);
				actionCaller.addEventListener(Event.ENTER_FRAME, ascendHurt);
				function ascendHurt(e:Event):void
				{
					hurtTimer++;
					for (i = 0; i < bloodContainer.length; i++)
					{
						bloodContainer[i].x +=  Math.cos(angleContainer[i]) * 5;
						bloodContainer[i].y +=  Math.sin(angleContainer[i]) * 5;
						bloodContainer[i].z +=  hurtTimer * 4;
						if (bloodContainer[i].z > 0)
						{
							if (inFrontContainer.contains(bloodContainer[i]))
							{
								inFrontContainer.removeChild(bloodContainer[i]);
							}
							if (inBackContainer.contains(bloodContainer[i]))
							{
								inBackContainer.removeChild(bloodContainer[i]);
							}
						}
					}
					if (hurtText.alpha > 0.07)
					{
						hurtText.alpha = 1 / (Math.pow((hurtTimer - 12) / 6,2) + 0.01);
						hurtText.z -=  1.5;
					}
					else
					{
						if (actionCaller.contains(hurtText))
						{
							actionCaller.removeChild(hurtText);
						}
						actionCaller.removeEventListener(Event.ENTER_FRAME, ascendHurt);
					}
				}
			}
			if (dodged)
			{
				return false;
			}
			return true;
		}
		public static function bleed(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			var i:int = 0;
			actionCaller.bleeding = true;
			actionCaller.bleedTurnsLeft = 3;
			var bleedTimer:int = 0;
			var bleedContainer:Array = [];
			var bleedAngleContainer:Array = [];
			var startContainer:Array = [];
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendBleed);
			function ascendBleed(e:Event):void
			{
				var bleed:Sprite = new blackBlur();
				actionCaller.transformer.color = 0xBB0000;
				bleed.transform.colorTransform = actionCaller.transformer;
				bleed.height = 7;
				bleed.width = 7;
				bleed.x = -10 + (Math.random() * 20);
				bleed.y = -10 + (Math.random() * 20);
				bleedAngleContainer.push(Math.atan2(bleed.y, bleed.x));
				bleed.z = -100 + (Math.random() * 50);
				bleedContainer.push(bleed);
				startContainer.push(bleedTimer);
				if (bleed.y > 0)
				{
					inFrontContainer.addChild(bleed);
				}
				else
				{
					inBackContainer.addChild(bleed);
				}
				bleedTimer++;
				for (i = 0; i < bleedContainer.length; i++)
				{
					bleedContainer[i].x +=  Math.cos(bleedAngleContainer[i]) * 5;
					bleedContainer[i].y +=  Math.sin(bleedAngleContainer[i]) * 5;
					bleedContainer[i].z +=  (bleedTimer - startContainer[i]) * 4;
					if (bleedContainer[i].z > 0)
					{
						if (inFrontContainer.contains(bleedContainer[i]))
						{
							inFrontContainer.removeChild(bleedContainer[i]);
						}
						if (inBackContainer.contains(bleedContainer[i]))
						{
							inBackContainer.removeChild(bleedContainer[i]);
						}
					}
				}
				if (bleedTimer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendBleed);
				}
			}

		}
		public static function wound(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			var i:int = 0;
			actionCaller.wounded = true;
			var bleedTimer:int = 0;
			var bleedContainer:Array = [];
			var bleedAngleContainer:Array = [];
			var startContainer:Array = [];
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendBleed);
			function ascendBleed(e:Event):void
			{
				var bleed:Sprite = new blackBlur();
				actionCaller.transformer.color = 0xBB0000;
				bleed.transform.colorTransform = actionCaller.transformer;
				bleed.height = 7;
				bleed.width = 7;
				bleed.x = -10 + (Math.random() * 20);
				bleed.y = -10 + (Math.random() * 20);
				bleedAngleContainer.push(Math.atan2(bleed.y, bleed.x));
				bleed.z = -100 + (Math.random() * 50);
				bleedContainer.push(bleed);
				startContainer.push(bleedTimer);
				if (bleed.y > 0)
				{
					inFrontContainer.addChild(bleed);
				}
				else
				{
					inBackContainer.addChild(bleed);
				}
				bleedTimer++;
				for (i = 0; i < bleedContainer.length; i++)
				{
					bleedContainer[i].x +=  Math.cos(bleedAngleContainer[i]) * 5;
					bleedContainer[i].y +=  Math.sin(bleedAngleContainer[i]) * 5;
					bleedContainer[i].z +=  (bleedTimer - startContainer[i]) * 4;
					if (bleedContainer[i].z > 0)
					{
						if (inFrontContainer.contains(bleedContainer[i]))
						{
							inFrontContainer.removeChild(bleedContainer[i]);
						}
						if (inBackContainer.contains(bleedContainer[i]))
						{
							inBackContainer.removeChild(bleedContainer[i]);
						}
					}
				}
				if (bleedTimer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendBleed);
				}
			}

		}
		public static function heal(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,amount:int):void
		{
			var i:int = 0;
			if (actionCaller.wounded)
			{
				amount = 0;
			}
			if (actionCaller.totalHealth - actionCaller.currentHealth < amount)
			{
				amount = actionCaller.totalHealth - actionCaller.currentHealth;
			}
			actionCaller.currentHealth +=  amount;
			actionCaller.textFormat.color = 0xFF0000;
			actionCaller.textFormat.align = "center";
			var healText:TextField = new TextField();
			healText.defaultTextFormat = actionCaller.textFormat;
			healText.text = "+" + amount;
			healText.height = 45;
			healText.autoSize = TextFieldAutoSize.CENTER;
			healText.x =  -  healText.width / 2;
			healText.z =  -  healText.height / 2;
			healText.z -=  170;
			healText.rotationX = 90;
			healText.alpha = 0.25;
			var healTimer:int = 0;
			var container:Array = [];
			actionCaller.addChild(healText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendHeal);
			function ascendHeal(e:Event):void
			{
				if (healTimer <= 18)
				{
					for (i = 0; i < Math.ceil((amount + 1) / (actionCaller.totalHealth / 20)); i++)
					{
						var healParticle:Sprite = new blackBlur();
						actionCaller.transformer.color = 0xBB0000;
						healParticle.transform.colorTransform = actionCaller.transformer;
						healParticle.x = (Math.random() * 400 / 3) - (200 / 3);
						healParticle.y = (Math.random() * 400 / 3) - (200 / 3);
						healParticle.width = 4;
						healParticle.height = 15;
						healParticle.rotationX = 90;
						healParticle.z = 0;
						container.push(healParticle);
						if (healParticle.y < 0)
						{
							inBackContainer.addChild(healParticle);
						}
						else
						{
							inFrontContainer.addChild(healParticle);
						}
					}
				}
				for (i = 0; i < container.length; i++)
				{
					container[i].z -=  20;
					if (container[i].z < -240)
					{
						if (inBackContainer.contains(container[i]))
						{
							inBackContainer.removeChild(container[i]);
						}
						else if (inFrontContainer.contains(container[i]))
						{
							inFrontContainer.removeChild(container[i]);
						}
					}
				}
				healTimer++;
				if (healText.alpha > 0.07)
				{
					healText.alpha = 1 / (Math.pow((healTimer - 12) / 6,2) + 0.01);
					healText.z -=  1.5;
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendHeal);
					actionCaller.removeChild(healText);
				}
			}
		}
		public static function recharge(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,amount:int):void
		{
			if (100 - actionCaller.currentMana < amount)
			{
				amount = 100 - actionCaller.currentMana;
			}
			actionCaller.currentMana +=  amount;
			actionCaller.textFormat.color = 0x0000FF;
			actionCaller.textFormat.align = "center";
			var rechargeText:TextField = new TextField();
			rechargeText.defaultTextFormat = actionCaller.textFormat;
			rechargeText.text = "+" + amount;
			rechargeText.height = 45;
			rechargeText.autoSize = TextFieldAutoSize.CENTER;
			rechargeText.x =  -  rechargeText.width / 2;
			rechargeText.z =  -  rechargeText.height / 2;
			rechargeText.z -=  140;
			rechargeText.rotationX = 90;
			rechargeText.alpha = 0.25;
			var rechargeTimer:int = 0;
			var frontRing:Sprite = new blackHalfRing();
			inFrontContainer.addChild(frontRing);
			var backRing:Sprite = new blackHalfRing();
			inBackContainer.addChild(backRing);
			backRing.rotation = 180;
			frontRing.width = 400 / 3;
			frontRing.height = 200 / 3;
			backRing.width = 400 / 3;
			backRing.height = 200 / 3;
			frontRing.z = 0;
			backRing.z = 0;
			actionCaller.transformer.color = 0x0000FF;
			frontRing.transform.colorTransform = actionCaller.transformer;
			backRing.transform.colorTransform = actionCaller.transformer;
			actionCaller.addChild(rechargeText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendRecharge);
			function ascendRecharge(e:Event):void
			{
				backRing.z -= 240 * ((-Math.pow(15 - rechargeTimer, 2) + (2 * rechargeTimer) + 225) / 5425);
				frontRing.z -= 240 * ((-Math.pow(15 - rechargeTimer, 2) + (2 * rechargeTimer) + 225) / 5425);
				rechargeTimer++;
				if (rechargeText.alpha > 0.07)
				{
					rechargeText.alpha = 1 / (Math.pow((rechargeTimer - 12) / 6,2) + 0.01);
					rechargeText.z -=  1.5;
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeChild(rechargeText);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendRecharge);
				}
			}
		}
		public static function becomeProtected(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,amount:int):void
		{
			actionCaller.textFormat.color = 0xAAAAAA;
			actionCaller.textFormat.align = "center";
			var protectionText:TextField = new TextField();
			protectionText.defaultTextFormat = actionCaller.textFormat;
			if (amount >= actionCaller.protection)
			{
				protectionText.text = "+" + (Math.round(actionCaller.armor * (amount - actionCaller.protection)) - actionCaller.armor);
				actionCaller.armor = Math.round(actionCaller.armor * (amount - actionCaller.protection));
				actionCaller.protection = amount;
			}
			else
			{
				protectionText.text = "+0";
			}
			var boxTop:Sprite = new whiteBarrier();
			var boxRight:Sprite = new whiteBarrier();
			var boxLeft:Sprite = new whiteBarrier();
			var boxBack:Sprite = new whiteBarrier();
			var boxFront:Sprite = new whiteBarrier();
			inFrontContainer.addChild(boxLeft);
			inFrontContainer.addChild(boxRight);
			inFrontContainer.addChild(boxTop);
			inFrontContainer.addChild(boxFront);
			inBackContainer.addChild(boxBack);
			actionCaller.transformer.color = 0xAAAAAA;
			boxFront.transform.colorTransform = actionCaller.transformer;
			boxBack.transform.colorTransform = actionCaller.transformer;
			boxTop.transform.colorTransform = actionCaller.transformer;
			boxRight.transform.colorTransform = actionCaller.transformer;
			boxLeft.transform.colorTransform = actionCaller.transformer;
			boxTop.height = 500 / 3;
			boxTop.width = 500 / 3;
			boxRight.x = 250 / 3;
			boxLeft.x = -250 / 3;
			boxFront.y = 250 / 3;
			boxBack.y = -250 / 3;
			boxBack.z = -130;
			boxLeft.z = -130;
			boxFront.z = -130;
			boxRight.z = -130;
			boxTop.z = -260;
			boxLeft.rotationZ = 90;
			boxRight.rotationZ = 90;
			boxRight.rotationX = 90;
			boxLeft.rotationX = 90;
			boxFront.rotationX = 90;
			boxBack.rotationX = 90;
			protectionText.height = 45;
			protectionText.autoSize = TextFieldAutoSize.CENTER;
			protectionText.x =  -  protectionText.width / 2;
			protectionText.z =  -  protectionText.height / 2;
			protectionText.z -=  170;
			protectionText.rotationX = 90;
			protectionText.alpha = 0.25;
			var protectionTimer:int = 0;
			actionCaller.addChild(protectionText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendProtect);
			function ascendProtect(e:Event):void
			{
				boxTop.alpha = 3 * ((-Math.pow(10 - protectionTimer, 2) + (2 * protectionTimer) + 225) / 5425);
				if (Math.round(Math.random() * protectionTimer) > 20)
				{
					boxTop.alpha = 0;
				}
				boxFront.alpha = boxTop.alpha;
				boxBack.alpha = boxTop.alpha;
				boxLeft.alpha = boxTop.alpha;
				boxRight.alpha = boxTop.alpha;
				protectionTimer++;
				if (protectionText.alpha > 0.07)
				{
					protectionText.alpha = 1 / (Math.pow((protectionTimer - 12) / 6,2) + 0.01);
					protectionText.z -=  1.5;
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeChild(protectionText);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendProtect);
				}
			}
		}
		public static function inspire(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,target:Object):void
		{
			target.totalDamage = Math.round(target.baseDamage * 1.5);
			actionCaller.textFormat.color = 0xAA0000;
			actionCaller.textFormat.align = "center";
			var inspireText:TextField = new TextField();
			inspireText.defaultTextFormat = actionCaller.textFormat;
			inspireText.text = "+150%";
			inspireText.height = 45;
			inspireText.autoSize = TextFieldAutoSize.CENTER;
			inspireText.x =  -  inspireText.width / 2;
			inspireText.z =  -  inspireText.height / 2;
			inspireText.z -=  170;
			inspireText.rotationX = 90;
			inspireText.alpha = 0.25;
			var flag1:MovieClip = new wavingFlag();
			var flag2:MovieClip = new wavingFlag();
			var flag3:MovieClip = new wavingFlag();
			var flag4:MovieClip = new wavingFlag();
			target.inBackContainer.addChild(flag1);
			target.inBackContainer.addChild(flag2);
			target.inFrontContainer.addChild(flag3);
			target.inFrontContainer.addChild(flag4);
			flag1.play();
			flag1.height = 150;
			flag1.width = 60;
			flag1.x = -70;
			flag1.y = -50;
			flag2.play();
			flag2.height = 150;
			flag2.width = 60;
			flag2.x = 30;
			flag2.y = -50;
			flag3.play();
			flag3.height = 150;
			flag3.width = 60;
			flag3.x = -70;
			flag3.y = 50;
			flag4.play();
			flag4.height = 150;
			flag4.width = 60;
			flag4.x = 30;
			flag4.y = 50;
			flag1.rotationX = 90;
			flag2.rotationX = 90;
			flag3.rotationX = 90;
			flag4.rotationX = 90;
			var inspireTimer:int = 0;
			target.addChild(inspireText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendInspire);
			function ascendInspire(e:Event):void
			{
				inspireTimer++;
				if (inspireText.alpha > 0.07)
				{
					inspireText.alpha = 1 / (Math.pow((inspireTimer - 12) / 6,2) + 0.01);
					inspireText.z -=  1.5;
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					target.removeChild(inspireText);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendInspire);
				}
			}
		}
		public static function attack(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,xDistance:int,yDistance:int):void
		{
			var i:int = 0;
			var attackTimer:int = 0;
			var attackContainer:Array = [];
			actionCaller.addEventListener(Event.ENTER_FRAME, attackParticles);
			function attackParticles(e:Event):void
			{
				attackTimer++;
				if (attackTimer < 25)
				{
					for (i = 0; i < Math.ceil(40 / (attackTimer * attackTimer)); i++)
					{
						var attackParticle:Sprite = new blackBlur();
						actionCaller.transformer.color = 0xFFFFFF;
						attackParticle.transform.colorTransform = actionCaller.transformer;
						attackContainer.push(attackParticle);
						attackParticle.z = -110 + (Math.random() * 30);
						attackParticle.x = -15 + (Math.random() * 30);
						attackParticle.y = -15 + (Math.random() * 30);
						attackParticle.width = 10;
						attackParticle.height = 10;
						if (attackParticle.y > 0)
						{
							inFrontContainer.addChild(attackParticle);
						}
						else
						{
							inBackContainer.addChild(attackParticle);
						}
					}
				}
				else
				{
					for (i = 0; i < attackContainer.length; i++)
					{
						attackContainer[i].alpha -=  attackTimer / 200;
					}
				}
				for (i = 0; i < attackContainer.length; i++)
				{
					attackContainer[i].x +=  (40 / attackTimer) * xDistance;
					attackContainer[i].y +=  (40 / attackTimer) * yDistance;
				}
				if (attackTimer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, attackParticles);
				}
			}

		}
		public static function decharge(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,amount:int):void
		{
			actionCaller.currentMana -=  amount;
			actionCaller.textFormat.color = 0x0000FF;
			actionCaller.textFormat.align = "center";
			var dechargeText:TextField = new TextField();
			dechargeText.defaultTextFormat = actionCaller.textFormat;
			dechargeText.text = "-" + amount;
			dechargeText.height = 45;
			dechargeText.autoSize = TextFieldAutoSize.CENTER;
			dechargeText.x =  -  dechargeText.width / 2;
			dechargeText.z =  -  dechargeText.height / 2;
			dechargeText.z -=  140;
			dechargeText.rotationX = 90;
			dechargeText.alpha = 0.25;
			actionCaller.addChild(dechargeText);
			var dechargeTimer:int = 0;
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendDecharge);
			function ascendDecharge(e:Event):void
			{
				dechargeTimer++;
				if (dechargeText.alpha > 0.07)
				{
					dechargeText.alpha = 1 / (Math.pow((dechargeTimer - 12) / 6,2) + 0.01);
					dechargeText.z -=  1.5;
				}
				else
				{
					actionCaller.removeChild(dechargeText);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendDecharge);
				}
			}
		}
		public static function freeze(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			var i:int = 0;
			var frontWall:Sprite = new cyanGradient();
			var backWall:Sprite = new cyanGradient();
			var leftWall:Sprite = new cyanGradient();
			var rightWall:Sprite = new cyanGradient();
			frontWall.alpha = 0.1;
			backWall.alpha = 0.1;
			leftWall.alpha = 0.1;
			rightWall.alpha = 0.1;
			inFrontContainer.addChild(frontWall);
			inFrontContainer.addChild(leftWall);
			inFrontContainer.addChild(rightWall);
			inBackContainer.addChild(backWall);
			frontWall.y = 250 / 3;
			backWall.y = -250 / 3;
			rightWall.x = 250 / 3;
			leftWall.x = -250 / 3;
			frontWall.rotationX = 90;
			backWall.rotationX = 90;
			rightWall.rotationX = 90;
			leftWall.rotationX = 90;
			rightWall.rotationZ = 90;
			leftWall.rotationZ = 90;
			var freezeTimer:int = 0;
			var snowContainer:Array = [];
			actionCaller.addEventListener(Event.ENTER_FRAME,freezeShit);
			function freezeShit(e:Event):void
			{
				freezeTimer++;
				if (freezeTimer < 36)
				{
					var snow:Sprite = new snowflake();
					snow.x = (Math.random() * 400 / 3) - (200 / 3);
					snow.y = (Math.random() * 400 / 3) - (200 / 3);
					snow.z = -(Math.random() * 600 / 3) - (200 / 3);
					snow.width = 20;
					snow.height = 20;
					if (snow.y > 0)
					{
						inFrontContainer.addChild(snow);
					}
					else
					{
						inBackContainer.addChild(snow);
					}
					snow.rotationX = 90;
					snow.alpha = 0;
					snowContainer.push(snow);
					for (i = 0; i < snowContainer.length; i++)
					{
						if (freezeTimer <= 30)
						{
							snowContainer[i].alpha +=  0.1;
						}
						else
						{
							frontWall.alpha -= 1 / (snowContainer.length * 6);
							backWall.alpha -= 1 / (snowContainer.length * 6);
							leftWall.alpha -= 1 / (snowContainer.length * 6);
							rightWall.alpha -= 1 / (snowContainer.length * 6);
							snowContainer[i].alpha -=  1 / 6;
						}
						snowContainer[i].z +=  2;
					}
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, freezeShit);
				}
			}
		}
		public static function addPoison(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,attacker:Sprite):void
		{
			actionCaller.poisonOwner = attacker;
			actionCaller.poisoned = true;
			var poisontimer:int = 0;
			var bottomSquare:Sprite = new whiteBarrier();
			actionCaller.transformer.color = 0x00AA00;
			bottomSquare.transform.colorTransform = actionCaller.transformer;
			bottomSquare.width = 500 / 3;
			bottomSquare.height = 500 / 3;
			bottomSquare.alpha = 0;
			inBackContainer.addChild(bottomSquare);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendPoison);
			function ascendPoison(e:Event)
			{
				poisontimer++;
				bottomSquare.alpha = 3 * ((-Math.pow(18 - poisontimer, 2) + (2 * poisontimer) + 225) / 5425);
				if (poisontimer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendPoison);
				}
			}
		}
		public static function smash(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			var i:int = 0;
			var particleContainer:Array = [];
			var angleContainer:Array = [];
			for (i = 0; i < 60; i++)
			{
				var particle:Sprite = new blackBlur();
				actionCaller.transformer.color = 0xFFFFFF;
				particle.transform.colorTransform = actionCaller.transformer;
				particle.z = -200 - (100 * Math.random());
				var randomAngle:Number = Math.random() * (2 * Math.PI);
				particle.x = 50 * Math.cos(randomAngle);
				particle.y = 50 * Math.sin(randomAngle);
				particle.width = 7;
				particle.height = 7;
				if (particle.y < 0)
				{
					inBackContainer.addChild(particle);
				}
				else
				{
					inFrontContainer.addChild(particle);
				}
				particle.rotationX = 90;
				particleContainer.push(particle);
				angleContainer.push(randomAngle);
				particle.alpha = 0;
			}
			var timer:int = 0;
			actionCaller.addEventListener(Event.ENTER_FRAME,moveParticles);
			function moveParticles(e:Event):void
			{
				timer++;
				for (i = 0; i < particleContainer.length; i++)
				{
					if (particleContainer[i].z < -5)
					{
						particleContainer[i].z +=  (timer + 10);
					}
					else
					{
						particleContainer[i].x += 80 * (Math.cos(angleContainer[i]) / (timer - 10));
						particleContainer[i].y += 80 * (Math.sin(angleContainer[i]) / (timer - 10));
					}
					if (timer < 6)
					{
						particleContainer[i].alpha +=  0.2;
					}
					if (timer > 26)
					{
						particleContainer[i].alpha -=  0.1;
					}
				}
				if (timer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME,moveParticles);
				}
			}
		}
		public static function shield(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			var i:int = 0;
			actionCaller.shielded = true;
			actionCaller.textFormat.color = 0xAAAAAA;
			actionCaller.textFormat.align = "center";
			var shieldText:TextField = new TextField();
			shieldText.defaultTextFormat = actionCaller.textFormat;
			shieldText.text = "+75%";
			shieldText.height = 45;
			shieldText.autoSize = TextFieldAutoSize.CENTER;
			shieldText.x =  -  shieldText.width / 2;
			shieldText.z =  -  shieldText.height / 2;
			shieldText.z -=  130;
			shieldText.rotationX = 90;
			shieldText.alpha = 0.25;
			var shieldTimer:int = 0;
			var shield1:Sprite = new whiteShield();
			var shield2:Sprite = new whiteShield();
			var shield3:Sprite = new whiteShield();
			var shield4:Sprite = new whiteShield();
			shield1.z = -125;
			shield2.z = -125;
			shield3.z = -125;
			shield4.z = -125;
			shield1.width = 75;
			shield1.height = 75;
			shield2.width = 75;
			shield2.height = 75;
			shield3.width = 75;
			shield3.height = 75;
			shield4.width = 75;
			shield4.height = 75;
			shield1.rotationX = 90;
			shield2.rotationX = 90;
			shield3.rotationX = 90;
			shield4.rotationX = 90;
			inFrontContainer.addChild(shield1);
			inFrontContainer.addChild(shield2);
			inFrontContainer.addChild(shield3);
			inFrontContainer.addChild(shield4);
			var shields:Array = [shield1,shield2,shield3,shield4];
			actionCaller.addChild(shieldText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendShield);
			function ascendShield(e:Event):void
			{
				for (i = 0; i < shields.length; i++)
				{
					if (inFrontContainer.contains(shields[i]) && shields[i].y < 0)
					{
						inFrontContainer.removeChild(shields[i]);
						inBackContainer.addChild(shields[i]);
					}
					if (inBackContainer.contains(shields[i]) && shields[i].y > 0)
					{
						inBackContainer.removeChild(shields[i]);
						inFrontContainer.addChild(shields[i]);
					}
				}
				shield1.alpha = 25 * ((-Math.pow(18 - shieldTimer, 2) + (2 * (18 - shieldTimer)) + 225) / 5425);
				shield2.alpha = 25 * ((-Math.pow(18 - shieldTimer, 2) + (2 * (18 - shieldTimer)) + 225) / 5425);
				shield3.alpha = 25 * ((-Math.pow(18 - shieldTimer, 2) + (2 * (18 - shieldTimer)) + 225) / 5425);
				shield4.alpha = 25 * ((-Math.pow(18 - shieldTimer, 2) + (2 * (18 - shieldTimer)) + 225) / 5425);
				shield1.x = 75 * Math.cos((shieldTimer * 20) * (Math.PI / 180));
				shield1.y = 75 * Math.sin((shieldTimer * 20) * (Math.PI / 180));
				shield1.rotationZ = (shieldTimer * 20) + 90;
				shield2.x = 75 * Math.cos(((shieldTimer * 20) + 180) * (Math.PI / 180));
				shield2.y = 75 * Math.sin(((shieldTimer * 20) + 180) * (Math.PI / 180));
				shield2.rotationZ = (shieldTimer * 20) + 90;
				shield3.x = 75 * Math.cos(((shieldTimer * 20) + 90) * (Math.PI / 180));
				shield3.y = 75 * Math.sin(((shieldTimer * 20) + 90) * (Math.PI / 180));
				shield3.rotationZ = (shieldTimer * 20);
				shield4.x = 75 * Math.cos(((shieldTimer * 20) - 90) * (Math.PI / 180));
				shield4.y = 75 * Math.sin(((shieldTimer * 20) - 90) * (Math.PI / 180));
				shield4.rotationZ = (shieldTimer * 20);
				shieldTimer++;
				if (shieldText.alpha > 0.07)
				{
					shieldText.alpha = 1 / (Math.pow((shieldTimer - 12) / 6,2) + 0.01);
					shieldText.z -=  1.5;
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeChild(shieldText);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendShield);
				}
			}
		}
		public static function enrage(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			actionCaller.baseDamage +=  10;
			actionCaller.textFormat.color = 0xFF9900;
			actionCaller.textFormat.align = "center";
			var enrageText:TextField = new TextField();
			enrageText.defaultTextFormat = actionCaller.textFormat;
			enrageText.text = "Roar";
			enrageText.height = 45;
			enrageText.autoSize = TextFieldAutoSize.CENTER;
			enrageText.x =  -  enrageText.width / 2;
			enrageText.z =  -  enrageText.height / 2;
			enrageText.z -=  200;
			enrageText.rotationX = 90;
			enrageText.alpha = 0.25;
			var fireball:MovieClip = new fire40();
			fireball.play();
			inFrontContainer.addChild(fireball);
			fireball.z = -200;
			fireball.rotationX = 90;
			var enrageTimer:int = 0;
			actionCaller.addChild(enrageText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendEnrage);
			function ascendEnrage(e:Event):void
			{
				if (enrageTimer > 30)
				{
					fireball.alpha = (36 - enrageTimer) / 6;
				}
				enrageTimer++;
				if (enrageText.alpha > 0.07)
				{
					enrageText.alpha = 1 / (Math.pow((enrageTimer - 12) / 6,2) + 0.01);
					enrageText.z -=  1.5;
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeChild(enrageText);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendEnrage);
				}
			}
		}
		public static function throwStar(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,xDistance:int,yDistance:int):void
		{
			var star1:MovieClip = new poisonStar();
			var star2:MovieClip = new poisonStar();
			var star3:MovieClip = new poisonStar();
			star1.play();
			if (yDistance > 0)
			{
				inFrontContainer.addChild(star1);
			}
			else
			{
				inBackContainer.addChild(star1);
			}
			star1.z = -50 - (Math.random() * 100);
			star2.z = -50 - (Math.random() * 100);
			star3.z = -50 - (Math.random() * 100);
			star1.width = 50;
			star1.height = 50;
			star2.width = 50;
			star2.height = 50;
			star3.width = 50;
			star3.height = 50;
			star1.rotationX = 90;
			star2.rotationX = 90;
			star3.rotationX = 90;
			star1.rotationZ = Math.atan2(yDistance,xDistance) * (180 / Math.PI);
			star2.rotationZ = Math.atan2(yDistance,xDistance) * (180 / Math.PI);
			star3.rotationZ = Math.atan2(yDistance,xDistance) * (180 / Math.PI);
			var starTimer:int = 0;
			actionCaller.addEventListener(Event.ENTER_FRAME, moveStars);
			function moveStars(e:Event):void
			{
				starTimer++;
				if (starTimer < 20)
				{
					star1.x += ((500 / 3) * xDistance) / 20;
					star1.y += ((500 / 3) * yDistance) / 20;
				}
				if (starTimer == 20)
				{
					if (inFrontContainer.contains(star1))
					{
						inFrontContainer.removeChild(star1);
					}
					if (inBackContainer.contains(star1))
					{
						inBackContainer.removeChild(star1);
					}
				}
				if (starTimer == 8)
				{
					star2.play();
					if (yDistance > 0)
					{
						inFrontContainer.addChild(star2);
					}
					else
					{
						inBackContainer.addChild(star2);
					}
				}
				if (starTimer >= 8 && starTimer < 28)
				{
					star2.x += ((500 / 3) * xDistance) / 20;
					star2.y += ((500 / 3) * yDistance) / 20;
				}
				if (starTimer == 28)
				{
					if (inFrontContainer.contains(star2))
					{
						inFrontContainer.removeChild(star2);
					}
					if (inBackContainer.contains(star2))
					{
						inBackContainer.removeChild(star2);
					}
				}
				if (starTimer == 16)
				{
					star3.play();
					if (yDistance > 0)
					{
						inFrontContainer.addChild(star3);
					}
					else
					{
						inBackContainer.addChild(star3);
					}
				}
				if (starTimer >= 16)
				{
					star3.x += ((500 / 3) * xDistance) / 20;
					star3.y += ((500 / 3) * yDistance) / 20;
				}
				if (starTimer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, moveStars);
				}
			}
		}
		public static function disappear(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			var Parent:Array = [actionCaller.parent];
			Parent[0].holdingPiece = actionCaller;
			Parent[0].removeChild(Parent[0].piece);
			Parent[0].addChild(Parent[0].holdingPiece);
			Parent[0].piece = null;
			actionCaller.disappeared = true;
			actionCaller.model.alpha = 0.3;
			actionCaller.textFormat.color = 0x000000;
			actionCaller.textFormat.align = "center";
			var disappearText:TextField = new TextField();
			disappearText.defaultTextFormat = actionCaller.textFormat;
			disappearText.text = "Poof";
			disappearText.height = 45;
			disappearText.autoSize = TextFieldAutoSize.CENTER;
			disappearText.x =  -  disappearText.width / 2;
			disappearText.z =  -  disappearText.height / 2;
			disappearText.z -=  170;
			disappearText.rotationX = 90;
			disappearText.alpha = 0.25;
			var disappearTimer:int = 0;
			actionCaller.addChild(disappearText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendDisappear);
			function ascendDisappear(e:Event):void
			{
				disappearTimer++;
				if (disappearText.alpha > 0.07)
				{
					disappearText.alpha = 1 / (Math.pow((disappearTimer - 12) / 6,2) + 0.01);
					disappearText.z -=  1.5;
				}
				else
				{
					actionCaller.removeChild(disappearText);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendDisappear);
				}
			}
		}
		public static function defend(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			var i:int = 0;
			actionCaller.defending = true;
			actionCaller.textFormat.color = 0xFFFFFF;
			actionCaller.textFormat.align = "center";
			var defendText:TextField = new TextField();
			defendText.defaultTextFormat = actionCaller.textFormat;
			defendText.text = "Come at me";
			defendText.height = 45;
			defendText.autoSize = TextFieldAutoSize.CENTER;
			defendText.x =  -  defendText.width / 2;
			defendText.z =  -  defendText.height / 2;
			defendText.z -=  130;
			defendText.rotationX = 90;
			defendText.alpha = 0.25;
			var defendTimer:int = 0;
			var shield1:Sprite = new whiteShield();
			var shield2:Sprite = new whiteShield();
			var shield3:Sprite = new whiteShield();
			var shield4:Sprite = new whiteShield();
			shield1.z = -100;
			shield2.z = -100;
			shield3.z = -100;
			shield4.z = -100;
			shield1.width = 75;
			shield1.height = 75;
			shield2.width = 75;
			shield2.height = 75;
			shield3.width = 75;
			shield3.height = 75;
			shield4.width = 75;
			shield4.height = 75;
			shield1.rotationX = 90;
			shield2.rotationX = 90;
			shield3.rotationX = 90;
			shield4.rotationX = 90;
			inFrontContainer.addChild(shield1);
			inFrontContainer.addChild(shield2);
			inFrontContainer.addChild(shield3);
			inFrontContainer.addChild(shield4);
			var shields:Array = [shield1,shield2,shield3,shield4];
			actionCaller.addChild(defendText);
			actionCaller.addEventListener(Event.ENTER_FRAME, ascendDefend);
			function ascendDefend(e:Event):void
			{
				for (i = 0; i < shields.length; i++)
				{
					if (inFrontContainer.contains(shields[i]) && shields[i].y < 0)
					{
						inFrontContainer.removeChild(shields[i]);
						inBackContainer.addChild(shields[i]);
					}
					if (inBackContainer.contains(shields[i]) && shields[i].y > 0)
					{
						inBackContainer.removeChild(shields[i]);
						inFrontContainer.addChild(shields[i]);
					}
				}
				shield1.alpha = 25 * ((-Math.pow(18 - defendTimer, 2) + (2 * (18 - defendTimer)) + 225) / 5425);
				shield2.alpha = 25 * ((-Math.pow(18 - defendTimer, 2) + (2 * (18 - defendTimer)) + 225) / 5425);
				shield3.alpha = 25 * ((-Math.pow(18 - defendTimer, 2) + (2 * (18 - defendTimer)) + 225) / 5425);
				shield4.alpha = 25 * ((-Math.pow(18 - defendTimer, 2) + (2 * (18 - defendTimer)) + 225) / 5425);
				shield1.x = 75 * Math.cos((defendTimer * 20) * (Math.PI / 180));
				shield1.y = 75 * Math.sin((defendTimer * 20) * (Math.PI / 180));
				shield1.rotationZ = (defendTimer * 20) + 90;
				shield2.x = 75 * Math.cos(((defendTimer * 20) + 180) * (Math.PI / 180));
				shield2.y = 75 * Math.sin(((defendTimer * 20) + 180) * (Math.PI / 180));
				shield2.rotationZ = (defendTimer * 20) + 90;
				shield3.x = 75 * Math.cos(((defendTimer * 20) + 90) * (Math.PI / 180));
				shield3.y = 75 * Math.sin(((defendTimer * 20) + 90) * (Math.PI / 180));
				shield3.rotationZ = (defendTimer * 20);
				shield4.x = 75 * Math.cos(((defendTimer * 20) - 90) * (Math.PI / 180));
				shield4.y = 75 * Math.sin(((defendTimer * 20) - 90) * (Math.PI / 180));
				shield4.rotationZ = (defendTimer * 20);
				defendTimer++;
				if (defendText.alpha > 0.07)
				{
					defendText.alpha = 1 / (Math.pow((defendTimer - 12) / 6,2) + 0.01);
					defendText.z -=  1.5;
				}
				else
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeChild(defendText);
					actionCaller.removeEventListener(Event.ENTER_FRAME, ascendDefend);
				}
			}
		}
		public static function assassinate(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,xDistance:int,yDistance:int):void
		{
			var i:int = 0;
			var particleContainer:Array = [];
			var zTransformations:Array = [];
			var birthTime:Array = [];
			var angle:Number = Math.atan2(yDistance,xDistance);
			var timer:int = 0;
			actionCaller.addEventListener(Event.ENTER_FRAME, moveParticles);
			function moveParticles(e:Event):void
			{
				for (i = 0; i < particleContainer.length; i++)
				{
					if (timer - birthTime[i] < 20)
					{
						particleContainer[i].x = -150 * Math.cos((angle - (Math.PI / 4)) + ((Math.PI / 2) * ((timer - birthTime[i]) / 10))) + (Math.random() * 20) - 10;
						particleContainer[i].y = -150 * Math.sin((angle - (Math.PI / 4)) + ((Math.PI / 2) * ((timer - birthTime[i]) / 10))) + (Math.random() * 20) - 10;
						particleContainer[i].z += zTransformations[i] + (Math.random() * 5) - 2.5;
					}
					else if (timer - birthTime[i] == 20)
					{
						if (inFrontContainer.contains(particleContainer[i]))
						{
							inFrontContainer.removeChild(particleContainer[i]);
						}
						else if (inBackContainer.contains(particleContainer[i]))
						{
							inBackContainer.removeChild(particleContainer[i]);
						}
					}
				}
				timer++;
				if (timer <= 21)
				{
					for (i = 0; i < 7; i++)
					{
						var particle:Sprite = new blackBlur();
						actionCaller.transformer.color = 0xFFFFFF;
						particle.transform.colorTransform = actionCaller.transformer;
						particle.width = 7;
						particle.height = 7;
						particle.x = -150 * Math.cos(angle - (Math.PI / 4)) + (Math.random() * 10) - 5;
						particle.y = -150 * Math.sin(angle - (Math.PI / 4)) + (Math.random() * 10) - 5;
						particle.z = -25 + (Math.random() * 10) - 5;
						particle.rotationX = 90;
						zTransformations.push(-5.5 + Math.random());
						particleContainer.push(particle);
						birthTime.push(timer);
						if (angle * (180 / Math.PI) >= -45)
						{
							inBackContainer.addChild(particle);
						}
						else
						{
							inFrontContainer.addChild(particle);
						}
					}
				}
				if (timer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME,moveParticles);
				}
			}
		}
		public static function throwFireball(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,xDistance:int,yDistance:int):void
		{
			var i:int = 0;
			var particleContainer:Array = [];
			var fireball:MovieClip = new fire40();
			fireball.play();
			var angle:Number = Math.atan2(yDistance,xDistance);
			if (angle <= Math.PI && angle >= 0)
			{
				inBackContainer.addChild(fireball);
			}
			else
			{
				inFrontContainer.addChild(fireball);
			}
			fireball.z = -150;
			fireball.rotationX = 90;
			var timer:int = 0;
			actionCaller.addEventListener(Event.ENTER_FRAME, moveParticles);
			function moveParticles(e:Event):void
			{
				timer++;
				fireball.x -= ((500 / 3) / 25) * xDistance;
				fireball.y -= ((500 / 3) / 25) * yDistance;
				if (timer == 25)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME,moveParticles);
				}
			}
		}
		public static function recieveFireball(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite):void
		{
			var i:int = 0;
			var timer:int = 0;
			var particleContainer:Array = [];
			var angleContainer:Array = [];
			for (i = 0; i < 75; i++)
			{
				var particle:Sprite = new blackBlur();
				actionCaller.transformer.color = new uint("0xFF" + (Math.round(Math.random() * 205) + 25).toString(16).toUpperCase() + "00");
				particle.transform.colorTransform = actionCaller.transformer;
				particle.x = Math.cos(Math.random() * (2 * Math.PI)) * 50;
				particle.y = Math.sin(Math.random() * (2 * Math.PI)) * 50;
				particle.height = 10;
				particle.width = 10;
				particleContainer.push(particle);
				angleContainer.push(Math.atan2(particle.y,particle.x));
			}
			actionCaller.addEventListener(Event.ENTER_FRAME,moveParticles);
			function moveParticles(e:Event):void
			{
				timer++;
				if (timer == 26)
				{
					for (i = 0; i < particleContainer.length; i++)
					{
						if (particleContainer[i].y > 0)
						{
							inFrontContainer.addChild(particleContainer[i]);
						}
						else
						{
							inBackContainer.addChild(particleContainer[i]);
						}
					}
				}
				if (timer > 26)
				{
					for (i = 0; i < particleContainer.length; i++)
					{
						particleContainer[i].x +=  Math.cos(angleContainer[i]) * (30 / (timer - 26));
						particleContainer[i].y +=  Math.sin(angleContainer[i]) * (30 / (timer - 26));
						if (timer > 31)
						{
							particleContainer[i].alpha -=  0.2;
						}
					}
				}
				if (timer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME, moveParticles);
				}
			}
		}
		public static function layTrap(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,attacker:Object)
		{
			var i:int = 0;
			actionCaller.trap = true;
			actionCaller.trapDamage = attacker.totalDamage * 2;
			actionCaller.trapOwner = attacker as Sprite;
			var timer:int = 0;
			var birthTime:Array = [];
			var particleContainer:Array = [];
			actionCaller.addEventListener(Event.ENTER_FRAME,moveParticles);
			function moveParticles(e:Event):void
			{
				timer++;
				for (i = 0; i < particleContainer.length; i++)
				{
					particleContainer[i].z -=  timer - birthTime[i];
					if (particleContainer[i].z < -50)
					{
						particleContainer[i].alpha -=  0.1;
					}
					if (particleContainer[i].alpha <= 0)
					{
						if (inFrontContainer.contains(particleContainer[i]))
						{
							inFrontContainer.removeChild(particleContainer[i]);
						}
						else if (inBackContainer.contains(particleContainer[i]))
						{
							inBackContainer.removeChild(particleContainer[i]);
						}
					}
				}
				if (timer < 26)
				{
					for (i = 0; i < 5; i++)
					{
						var particle:Sprite = new blackBlur();
						actionCaller.transformer.color = 0xFFFF00;
						particle.transform.colorTransform = actionCaller.transformer;
						particle.x = Math.random() * (400 / 3) - (200 / 3);
						particle.y = Math.random() * (400 / 3) - (200 / 3);
						particle.width = 5;
						particle.height = 10;
						particle.rotationX = 90;
						particleContainer.push(particle);
						birthTime.push(timer);
						if (particle.y > 0)
						{
							inFrontContainer.addChild(particle);
						}
						else
						{
							inBackContainer.addChild(particle);
						}
					}
				}
				else if (timer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME,moveParticles);
				}
			}
		}
		public static function shootLaser(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,xDistance:int,yDistance:int):void
		{
			var i:int = 0;
			var timer:int = 0;
			var particleContainer:Array = [];
			var birthTime:Array = [];
			actionCaller.addEventListener(Event.ENTER_FRAME,moveParticles);
			function moveParticles(e:Event):void
			{
				timer++;
				for (i = 0; i < particleContainer.length; i++)
				{
					particleContainer[i].x -= (((500 / 3) * xDistance) * ((Math.random() / 4) + 1)) / 4;
					particleContainer[i].y -= (((500 / 3) * yDistance) * ((Math.random() / 4) + 1)) / 4;
					if (timer - birthTime[i] > 10)
					{
						if (inFrontContainer.contains(particleContainer[i]))
						{
							inFrontContainer.removeChild(particleContainer[i]);
						}
						if (inBackContainer.contains(particleContainer[i]))
						{
							inBackContainer.removeChild(particleContainer[i]);
						}
					}
				}
				if (timer < 26)
				{
					for (i = 0; i < 10; i++)
					{
						var particle:Sprite = new blackBlur();
						actionCaller.transformer.color = 0xFF0000;
						particle.transform.colorTransform = actionCaller.transformer;
						particle.x = xDistance + (10 * Math.random()) - 5;
						particle.y = yDistance + (10 * Math.random()) - 5;
						particle.z = (Math.random() * -10) - 50;
						particle.rotationX = 90;
						particle.width = 10;
						particle.height = 10;
						if (particle.y > 0)
						{
							inFrontContainer.addChild(particle);
						}
						else
						{
							inBackContainer.addChild(particle);
						}
						birthTime.push(timer);
						particleContainer.push(particle);
					}
				}
				else if (timer == 36)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME,moveParticles);
				}
			}
		}
		public static function throwAxe(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,xDistance:int,yDistance:int):void
		{
			var timer:int = 0;
			var axe:MovieClip;
			if (Math.atan2(yDistance,xDistance) * 180 / Math.PI == -90)
			{
				axe = new axeFront();
				inBackContainer.addChild(axe);
			}
			else if (Math.atan2(yDistance,xDistance) * 180 / Math.PI == 90)
			{
				axe = new axeBack();
				inFrontContainer.addChild(axe);
			}
			else
			{
				axe = new axeSide();
				inBackContainer.addChild(axe);
				axe.rotationY = 180;
				if (Math.atan2(yDistance,xDistance) * 180 / Math.PI == 0)
				{
					axe.rotationY = 0;
				}
			}
			axe.height = 100;
			axe.width = 100;
			axe.rotationX = 90;
			axe.z = -100;
			axe.play();
			actionCaller.addEventListener(Event.ENTER_FRAME,moveAxe);
			function moveAxe(e:Event):void
			{
				timer++;
				axe.x += ((500 / 3) * xDistance) / 20;
				axe.y += ((500 / 3) * yDistance) / 20;
				if (timer == 20)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME,moveAxe);
				}
			}
		}
		public static function longshot(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,target:Object):void
		{
			var upArrow:Sprite = new arrowSide();
			var downArrow:Sprite = new arrowSide();
			inBackContainer.addChild(upArrow);
			upArrow.height = 10;
			upArrow.width = 100;
			downArrow.height = 10;
			downArrow.width = 100;
			upArrow.rotation = -90;
			upArrow.rotationY = 90;
			downArrow.rotation = -90;
			downArrow.rotationY = -90;
			downArrow.z = -800;
			downArrow.alpha = 0;
			var timer:int = 0;
			actionCaller.addEventListener(Event.ENTER_FRAME,moveArrows);
			function moveArrows(e:Event):void
			{
				timer++;
				if (timer <= 15)
				{
					upArrow.z -=  800 / 15;
					if (timer > 10)
					{
						upArrow.alpha -=  0.2;
					}
					if (timer == 15)
					{
						inBackContainer.removeChild(upArrow);
					}
				}
				if (timer >= 21)
				{
					if (timer == 21)
					{
						target.inBackContainer.addChild(downArrow);
					}
					downArrow.z +=  800 / 17;
					if (timer < 26)
					{
						downArrow.alpha +=  0.2;
					}
				}
				if (timer == 36)
				{
					clearEverything(target.inBackContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME,moveArrows);
				}
			}
		}
		public static function aimedShot(actionCaller:Object,inFrontContainer:Sprite,inBackContainer:Sprite,xDistance:int,yDistance:int):void
		{
			var timer:int = 0;
			var arrowShot:Sprite = new arrowSide();
			if (yDistance > 0)
			{
				inFrontContainer.addChild(arrowShot);
			}
			else
			{
				inBackContainer.addChild(arrowShot);
			}
			arrowShot.height = 10;
			arrowShot.width = 100;
			arrowShot.rotationX = (Math.atan2(yDistance,xDistance) * (180 / Math.PI)) + 90;
			arrowShot.rotationZ = (Math.atan2(yDistance,xDistance) * (180 / Math.PI)) + 180;
			arrowShot.z = -100;
			actionCaller.addEventListener(Event.ENTER_FRAME,moveArrow);
			function moveArrow(e:Event):void
			{
				timer++;
				arrowShot.x -= ((500 / 3) * xDistance) / 12;
				arrowShot.y -= ((500 / 3) * yDistance) / 12;
				if (timer == 10)
				{
					clearEverything(inFrontContainer,inBackContainer);
					actionCaller.removeEventListener(Event.ENTER_FRAME,moveArrow);
				}
			}
		}
		public static function swirlSkills(attackingSquare:Object,selectAction:Function,followText:Function,universalActionValues:Function,checkTargets:Function):void
		{
			var m:int
			var i:int
			var inFrontContainer:Sprite = attackingSquare.piece.inFrontContainer
			var inBackContainer:Sprite = attackingSquare.piece.inBackContainer
			var actionContainer:Array = []
			var startingRadii:Array = []
			for (m = 4; m < attackingSquare.piece.skills.length; m++)
			{
				var newAction:Sprite = new (getDefinitionByName(attackingSquare.piece.skills[m] + "Icon") as Class);
				actionContainer.push(newAction)
				newAction.x = (- ((attackingSquare.piece.skills.length - 5) / 2) + m - 4) * 40
				newAction.y = 10
				attackingSquare.piece.model.rotationX = 0
				newAction.z = -attackingSquare.piece.model.height
				attackingSquare.piece.model.rotationX = 90
				newAction.width /= 2.5
				newAction.height /= 2.5
				newAction.rotationX = 90
				newAction.alpha = 0
				var whiteGlow:GlowFilter = new GlowFilter(0xFFFFFF,1,5,5,2,1,false,false);
				newAction.filters = [whiteGlow];
				inFrontContainer.addChild(newAction)
			}
			var timer:int = 0
			attackingSquare.addEventListener(Event.ENTER_FRAME,moveSkills)
			function moveSkills(e:Event):void
			{
				timer++
				if (timer < 18)
				{
					for (i = 0; i < actionContainer.length; i++)
					{
						actionContainer[i].alpha += 1 / 17
						actionContainer[i].z -= 8 / ((timer / 4) + 2)
					}
				}
				else if (timer == 18)
				{
					for (i = 0; i < actionContainer.length; i++)
					{
						if (universalActionValues(actionContainer[i], int) > attackingSquare.piece.currentMana || checkTargets(actionContainer[i],attackingSquare,attackingSquare.piece))
						{
							var redTint:Color = new Color();
							redTint.setTint(0xFF0000,0.5);
							actionContainer[i].transform.colorTransform = redTint;
						}
						else
						{
							actionContainer[i].addEventListener(MouseEvent.MOUSE_UP,selectAction);
						}
						actionContainer[i].addEventListener(MouseEvent.MOUSE_OVER,followText);
					}
					attackingSquare.removeEventListener(Event.ENTER_FRAME,moveSkills)
				}
			}
		}
		public static function unswirlSkills(attackingSquare:Object,selectAction:Function,followText:Function,universalActionValues:Function,checkTargets:Function,secondAction:Function):void
		{
			var i:int
			var inFrontContainer:Sprite = attackingSquare.piece.inFrontContainer
			var inBackContainer:Sprite = attackingSquare.piece.inBackContainer
			var actionContainer:Array = []
			var startingRadii:Array = []
			for (i = 0; i < inFrontContainer.numChildren; i++)
			{
				actionContainer[i] = inFrontContainer.getChildAt(i)
			}
			var timer:int = 0
			attackingSquare.addEventListener(Event.ENTER_FRAME,moveSkills)
			function moveSkills(e:Event):void
			{
				timer++
				if (timer < 12)
				{
					for (i = 0; i < actionContainer.length; i++)
					{
						actionContainer[i].alpha -= 1 / 11
						actionContainer[i].z += 8 / ((timer / 4) + 2)
					}
				}
				else if (timer == 12)
				{
					for (i = 0; i < actionContainer.length; i++)
					{
						actionContainer[i].removeEventListener(MouseEvent.MOUSE_UP,selectAction);
						actionContainer[i].removeEventListener(MouseEvent.MOUSE_OVER,followText);
					}
					attackingSquare.removeEventListener(Event.ENTER_FRAME,moveSkills)
					secondAction()
				}
			}
		}
		public static function clearEverything(inFrontContainer:Sprite,inBackContainer:Sprite)
		{
			while (inFrontContainer.numChildren > 0)
			{
				inFrontContainer.removeChildAt(0);
			}
			while (inBackContainer.numChildren > 0)
			{
				inBackContainer.removeChildAt(0);
			}
		}
	}
}