-----------------------------------------------------------------------------------------
-- Title: LivesAndTimers
-- Name: Maria T
-- Course: ICS2O/3C
-- This program..
-- 
----------------------------------------------------------

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Background image with width and height
local backgroundImage = display.newImageRect("Images/background.png", 2048, 1536)

--------------------------------------------------------------------------------------
-- LOCAL VARIABLES
--------------------------------------------------------------------------------------

-- create local variables
local questionObject
local questionObject2
local questionObject3
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local formula
local pointsObject
local points = 0
local formula

-----countertext---
--variables for the timer

local totalSeconds = 10
local secondsLeft = 10 
local clockText
local countDownTimer

local lives = 4
local heart1
local heart2
local heart3 
local heart4
local gameOver

--*** ADD LOCAL VARIABLE FOR: INCORRECT OBJECT, POINTS OBJECT, POINTS

---------------------------------------------------------------------------
-- LOCAL FUNCTIONS
---------------------------------------------------------------------------

local function UpdateTime()

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	--display the number of seconds left in the clock object 
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0 ) then
		-- reset the number of seconds left
		secondsLeft = totalSeconds
		lives = lives - 1

		-- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A YOU LOSE IMAGE
		-- AND  CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE
		
		if (lives == 4) then 
			heart4.isVisible = true
			heart3.isVisible = true
			heart2.isVisible = true
			heart1.isVisible = true

		elseif (lives == 3) then
			heart4.isVisible = false
			heart3.isVisible = true
			heart2.isVisible = true
			heart1.isVisible = true

		elseif (lives == 2) then
			heart4.isVisible = false
			heart3.isVisible = false
			heart2.isVisible = true
			heart1.isVisible = true

		elseif (lives == 1) then
			heart4.isVisible = false
			heart3.isVisible = false
			heart2.isVisible = false
			heart1.isVisible = true

		elseif (lives == 0) then
			heart4.isVisible = false
			heart3.isVisible = false
			heart2.isVisible = false
			heart1.isVisible = false
			numericField.isVisible = false
			gameOver.isVisible = true


		end

		--*** CALL THE FUNCTION TO ASK A NEW QUESTION
	end
end

-- Function that calls the timer 
local function StartTimer()
	-- Create a countdown timer that loops infinitely
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end


local function AskQuestion()
	-- Generate 2 random numbers betweeen a max. and a min. number
	randomNumber1 = math.random(10, 20)
	randomNumber2 = math.random(0, 10)
	randomNumber3 = math.random(10, 20)
	formula = math.random(1, 3)

	if (formula == 1) then
		correctAnswer = randomNumber1 + randomNumber2
		-- Create question in a text object
		questionObject.text = randomNumber1 .. "+" .. randomNumber2 .. "="

	elseif (formula == 2) then
		correctAnswer = randomNumber1 * randomNumber2
		questionObject.text = randomNumber1 .. "*" .. randomNumber2 .. "="

	elseif (formula == 3) then 
			correctAnswer = randomNumber1 - randomNumber2
			questionObject.text = randomNumber1 .. "-" .. randomNumber2 .. "="

	elseif (correctAnswer < 0) then
			correctAnswer = randomNumber2 - randomNumber1
			questionObject.text = randomNumber2 .. "-" .. randomNumber1 .. "="
	end
end


local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function Hideincorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end

local function Points()
	-- tracks points
	points = points + 1
	pointsObject.text = "points=" .. points  
end

local function NumericFieldListener( event )
	
	-- User begins editing "numericField"
	if ( event.phase == "began" ) then

		-- clear text field
		event.target.text = ""

	elseif (event.phase == "submitted") then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the user answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			-- play a sound when the user gets it corrct
		--	correctSoundChannel = audio.play(correctSound, {channel = 1})
			-- when the user gets it correct add one point to the code and display it in text
			points = points + 1
			pointsObject.text = "Points : " .. points
			-- clear text field
			event.target.text = ""
			-- call the HideCorrect function after 2 seconds
			timer.performWithDelay(1000, HideCorrect)
		 
		 elseif (userAnswer ~= correctAnswer) then
		 	incorrectObject.isVisible = true 
			-- clear text field
			event.target.text = ""
			-- play a sound when the user gets it incorrct
		--	incorrectSoundChannel = audio.play(incorrectSound, {channel = 2})
			lives = lives - 1
		 	-- call the HideInCorrect function after 1 second
			timer.performWithDelay(1000, Hideincorrect)
		end
		-- reset the number of seconds 
		secondsLeft = totalSeconds + 1
	end
end

---------------------------------------------------------------------------------------
-- OBJECT CREATION
--------------------------------------------------------------------------------------

--QUESTION OBJECTS
-- Displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/2.75, display.contentHeight/2, nil, 110 )
questionObject:setTextColor(155/255, 42/255, 198/255)
timer.performWithDelay(500, HidequestionObject)

-----------------------------------------------------------
--INCORRECT/CORRECT OBJECTS
-- Create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(50/255, 233/255, 10/255)
correctObject.isVisible = false

-- Create the correct text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(241/255, 62/255, 62/255)
incorrectObject.isVisible = false
-----------------------------------------------------------
--POINTS/NUMERICFIELD
-- displays number of points 
pointsObject = display.newText("Points = 0", 120, 60, "Georgia", 50)
pointsObject:setTextColor(255/255, 205/255, 205/255)
pointsObject.isVisible = true

-- Create numeric Field
numericField = native.newTextField( display.contentWidth/1.5, display.contentHeight/2, 190, 120 )
numericField.inputType = "number"
------------------------------------------------------------
--HEART OBJECTS
-- Create the lives to display on the screen 
heart1 = display.newImageRect("Images/heart1.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7 

heart2 = display.newImageRect("Images/heart2.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7 


heart3 = display.newImageRect("Images/heart3.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7 


heart4 = display.newImageRect("Images/heart4.png", 100, 100)
heart4.x = display.contentWidth * 4 / 8
heart4.y = display.contentHeight * 1 / 7 
--Aditional Functions
-- create the text object to hold the countdowm timer
clockText = display.newText(secondsLeft, 520, 600, native.systemFontBold, 150)
clockText: setFillColor( 40/255, 205/255, 198/255 )

gameOver = display.newImageRect("Images/gameOver.png", display.contentWidth, display.contentHeight)
gameOver.anchorX = 0
gameOver.anchorY = 0
gameOver.isVisible = false


-- Add the event listener for the numberic field
numericField:addEventListener( "userInput", NumericFieldListener )


----------------------------------------------------------------------------
-- FUNCTION CALLS
-------------------------------------------------------------------------------

-- Call the function to ask the question
AskQuestion()
StartTimer()
-- add sound

