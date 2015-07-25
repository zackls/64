package
{
	import flash.display.*
	import flash.events.*
	import flash.utils.*
	import flash.text.*
	import flash.geom.ColorTransform
	import flash.filters.BlurFilter
	public class Rook extends Sprite
	{
		public var This:Sprite
		public var team:String
		public var currentHealth:int
		public var totalHealth:int
		public var currentExp:int
		public var totalExp:int
		public var currentMana:int
		public var lvl:int
		public var model:Sprite
		public var skills:Array
		public var moved:Boolean = false
		public var everMoved:Boolean = false
		private var healthBar:Sprite = new redSquare()
		private var manaBar:Sprite = new blueSquare()
		private var xpBar:Sprite = new greenSquare()
		public var baseDamage:int = 50
		public var totalDamage:int = 50
		public var expYield:int = 50
		public var armor:int = 0
		public var strength:int
		public var shock:int
		public var protection:int = 0
		public var poisoned:Boolean = false
		public var poisonOwner:Sprite
		public var bleeding:Boolean = false
		public var bleedTurnsLeft:int = 0
		public var wounded:Boolean = false
		public var criticalChance:Number = 0
		public var instantKillChance:Number = 0
		public var dodgeChance:Number = 0
		public var stunChance:Number = 0
		public var stunned:Boolean = false
		public var manaLeech:Number = 0
		public var healthLeech:Number = 0
		public var manaRegen:Number = 1
		public var healthRegen:Number = 0.01
		public var textFormat:TextFormat = new TextFormat("Cambria", 30, 0x000000)
		public var inFrontContainer:Sprite = new Sprite();
		public var inBackContainer:Sprite = new Sprite();
		private var i:int;
		private var j:int;
		public var equipment:Array
		public var transformer:ColorTransform = new ColorTransform()
		public var startingPosition:String
		public function Rook(color:String, equipment:Array, skills:Array, lvl:int, exp:int, startingPosition:String)
		{
			this.startingPosition = startingPosition
			This = this
			this.equipment = equipment
			this.skills = skills
			this.team = color
			this.totalHealth = 120 + ((lvl - 1) * 30)
			this.currentHealth = this.totalHealth
			this.currentExp = exp
			this.totalExp = 100 + (lvl * 25)
			this.currentMana = 100
			this.lvl = lvl
			model = new (getDefinitionByName(color + "Rook") as Class)
			this.addChild(inBackContainer);
			this.addChild(model);
			this.addChild(inFrontContainer);
			this.addChild(healthBar)
			this.addChild(manaBar)
			this.addChild(xpBar)
			healthBar.alpha = 0
			manaBar.alpha = 0
			xpBar.alpha = 0
			healthBar.x = -200 / 3
			healthBar.y = 180 / 3
			healthBar.height = 5
			manaBar.x = -200 / 3
			manaBar.y = 200 / 3
			manaBar.height = 5
			xpBar.x = -200 / 3
			xpBar.y = 220 / 3
			xpBar.height = 5
			addEventListener(Event.ENTER_FRAME, constantEvents)
			addEventListener(MouseEvent.MOUSE_OVER, rollOverThis)
			addEventListener(MouseEvent.MOUSE_OUT, rollOutThis)
			for (i = 0; i < skills.length; i++)
			{
				if (skills[i] == "strength")
				{
					strength = skills[i + 1]
					baseDamage *= Math.round(1 + (strength * 0.03))
				}
				if (skills[i] == "shock")
				{
					shock = skills[i + 1]
					stunChance += shock * 0.02
				}
			}
		}
		public function rollOverThis(e:MouseEvent):void
		{
			healthBar.alpha = 1
			manaBar.alpha = 1
			xpBar.alpha = 1
		}
		public function rollOutThis(e:MouseEvent):void
		{
			healthBar.alpha = 0
			manaBar.alpha = 0
			xpBar.alpha = 0
		}
		private function constantEvents(e:Event):void
		{
			if (currentHealth > totalHealth)
			{
				currentHealth = totalHealth
			}
			if (currentMana > 100)
			{
				currentMana = 100
			}
			healthBar.width = (currentHealth / totalHealth) * (400 / 3)
			manaBar.width = (currentMana / 100) * (400 / 3)
			xpBar.width = (currentExp / totalExp) * (400 / 3)
			var stunFilter:BlurFilter = new BlurFilter(30,30,1)
			if (stunned)
			{
				model.filters = [stunFilter]
			}
			else
			{
				model.filters = []
			}
		}
		public function attack(xDistance:int, yDistance:int):void
		{
			Animations.attack(This,inFrontContainer,inBackContainer,xDistance,yDistance)
		}
		public function die(attacker:Sprite,dieFunction:Function):void
		{
			Animations.die(This,inFrontContainer,inBackContainer,attacker,dieFunction)
		}
		public function gainExp(amount:int):void
		{
			Animations.gainExp(This,inFrontContainer,inBackContainer,amount)
		}
		public function loseExp(amount:int):void
		{
			Animations.loseExp(This,inFrontContainer,inBackContainer,amount)
		}
		public function levelUp():void
		{
			Animations.levelUp(This,inFrontContainer,inBackContainer)
		}
		public function hurt(amount:int, attacker:Sprite, dieFunction:Function):Boolean
		{
			return Animations.hurt(This,inFrontContainer,inBackContainer,amount,attacker,dieFunction)
		}
		public function bleed():void
		{
			Animations.bleed(This,inFrontContainer,inBackContainer)
		}
		public function heal(amount:int):void
		{
			Animations.heal(This,inFrontContainer,inBackContainer,amount)
		}
		public function recharge(amount:int):void
		{
			Animations.recharge(This,inFrontContainer,inBackContainer,amount)
		}
		public function becomeProtected(amount:int):void
		{
			Animations.becomeProtected(This,inFrontContainer,inBackContainer,amount)
		}
		public function decharge(amount:int):void
		{
			Animations.decharge(This,inFrontContainer,inBackContainer,amount)
		}
		public function freeze():void
		{
			Animations.freeze(This,inFrontContainer,inBackContainer)
		}
		public function addPoison(attacker:Sprite):void
		{
			Animations.addPoison(This,inFrontContainer,inBackContainer,attacker)
		}
		public function smash():void
		{
			Animations.smash(This,inFrontContainer,inBackContainer)
		}
		public function recieveFireball():void
		{
			Animations.recieveFireball(This,inFrontContainer,inBackContainer)
		}
		public function wound():void
		{
			Animations.wound(This,inFrontContainer,inBackContainer)
		}
		public function enrage():void
		{
			Animations.enrage(This,inFrontContainer,inBackContainer)
		}
		public function throwAxe(xDistance:int,yDistance:int):void
		{
			Animations.throwAxe(This,inFrontContainer,inBackContainer,xDistance,yDistance)
		}
		public function startAttack(currentSet:String, playerStart:Boolean, sideLength:int):void
		{
			removeChild(inFrontContainer)
			removeChild(inBackContainer)
			removeChild(model)
			removeChild(healthBar)
			removeChild(manaBar)
			removeChild(xpBar)
			var frontBack:String
			model = new (getDefinitionByName(team + currentSet + "Rook") as Class)
			addChild(inBackContainer)
			addChild(model);
			addChild(inFrontContainer)
			model.height = 600 / sideLength
			model.width = 100
			model.rotationX = 90
		}
		public function endAttack():void
		{
			removeChild(model)
			model = new (getDefinitionByName(team + "Rook") as Class);
			addChild(model);
			addChild(healthBar);
			addChild(manaBar);
			addChild(xpBar);
		}
	}
}