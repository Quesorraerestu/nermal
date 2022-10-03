move = 120
offset = 65
timer = 0.1
thing = false
movecam = false

function onCreate()
  makeLuaSprite('blueoverlay', '', 0, 0)
  makeGraphic('blueoverlay', getPropertyFromClass('flixel.FlxG', 'width'), getPropertyFromClass('flixel.FlxG', 'height'), '0000ff')
  setProperty('blueoverlay.alpha', 0.3)
  setProperty('blueoverlay.visible', false)
  setObjectCamera('blueoverlay', 'camOther')
  addLuaSprite('blueoverlay')
  
  makeLuaSprite('redoverlay', '', 0, 0)
  makeGraphic('redoverlay', getPropertyFromClass('flixel.FlxG', 'width'), getPropertyFromClass('flixel.FlxG', 'height'), 'ff0000')
  setProperty('redoverlay.alpha', 0.3)
  setProperty('redoverlay.visible', false)
  setObjectCamera('redoverlay', 'camOther')
  addLuaSprite('redoverlay')
  
  makeLuaSprite('blackSCREENOMG', '', 0, 0)
  makeGraphic('blackSCREENOMG', getPropertyFromClass('flixel.FlxG', 'width'), getPropertyFromClass('flixel.FlxG', 'height'), '000000')
  setObjectCamera('blackSCREENOMG', 'camOther')
  addLuaSprite('blackSCREENOMG')

  setProperty('skipCountdown', true)

  makeLuaSprite('Cinematic1', '', 0, 720 + 160 + offset);
  makeGraphic('Cinematic1', getPropertyFromClass('flixel.FlxG', 'width'), 160, '000000')
	setScrollFactor('Cinematic1', 0, 0)
  setObjectCamera('Cinematic1', 'camOther')
	addLuaSprite('Cinematic1', false)
	
  makeLuaSprite('Cinematic2', '', 0, 0 - 160 - offset)
  makeGraphic('Cinematic2', getPropertyFromClass('flixel.FlxG', 'width'), 160, '000000')
	setScrollFactor('Cinematic2', 0, 0)
  setObjectCamera('Cinematic2', 'camOther')
	addLuaSprite('Cinematic2', false)
end
-- Event notes hooks
function CamZoom(value1, value2, tween)
		targetZoom = value1
		duration = value2
		if duration < 0 then
			duration = 0;
		end
		
		setProperty('defaultCamZoom', targetZoom);
		if duration == 0 then
			setProperty('camGame.screenZoom', targetZoom);
		else
			doTweenZoom('screenZoom', 'camGame', targetZoom, duration, tween);
		end
end
function onStepHit()
  if curStep == 1152 then
    setProperty('blueoverlay.visible', false)
    cameraFlash('camOther', '0xFFFFFF', 0.5)
  end
  if curStep == 1296 then
    movecam = true
    cameraFlash('camGame', '0xFFFFFF', 0.5)
    CamZoom(0.7, 0.2, 'linear')
    setProperty('redoverlay.visible', true)
    if downscroll then
      for i = 0,7 do
      noteTweenY('Tween'..i, i, defaultOpponentStrumY0 - move + offset, timer, 'quadOut')
      end
    else
      noteTweenY('Tween'..i, i, defaultOpponentStrumY0 + move - offset, timer, 'quadOut')

    end
    doTweenY('TweenCine1', 'Cinematic1', 720 - 160 + offset, timer, 'linear')
    doTweenY('TweenCine2', 'Cinematic2', 0 - offset, timer, 'linear')
  end
end

function onBeatHit()
  if curBeat == 144 then
    doTweenAlpha('bgstuff', 'bg', 0.4, 0.1, 'linear')
    CamZoom(2, 0.2, 'linear')
  end
  if curBeat == 152 then
    doTweenAlpha('bgstuff', 'bg', 1, 0.1, 'linear')
    CamZoom(0.7, 1, 'cubeOut')
  end
  if curBeat == 224 then
    CamZoom(0.7, 0.2, 'cubeInOut')
    cameraFlash('camOther', '0xFFFFFF', 0.5)
    setProperty('blueoverlay.visible', true)
  end
  if curBeat % 1 == 0 and movecam == true then
    if thing == false then
      setProperty('camGame.angle', -2)
      thing = true
    elseif thing == true then
      setProperty('camGame.angle', 2)
      thing = false
    end
    doTweenAngle('CamTween0', 'camGame', 0, 0.5, 'cubeOut')
  end
end

function onCreatePost()
  doTweenAlpha('hi', 'blackSCREENOMG', 0, 2, 'linear')
end