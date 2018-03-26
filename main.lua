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
local totalSeconds = 5
local secondsLeft = 5 
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2

--*** ADD LOCAL VARIABLE FOR: INCORRECT OBJECT, POINTS OBJECT, POINTS

---------------------------------------------------------------------------
-- LOCAL FUNCTIONS
---------------------------------------------------------------------------

local function UpdateTime()

	-- decrwement the number of seconds
	secondsLeft = seconds - 1

	--display the number of seconds left in the clock object 
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0 ) then
		-- reset the number of seconds left
		secondsLeft = totalSeconds
		lives = lives - 1

		-- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A YOU LOSE IMAGE
		-- AND  CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE
		if (lives == 2) then 
			heart2.isVisible = false
		elseif (lives == 1) then
			heart1.isVisible = false
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
	randomNumber2 = math.random(1, 10)
	randomNumber3 = math.random(10, 20)
	formula = math.random(1, 3)

	if (formula == 1) then
		correctAnswer = randomNumber1 + randomNumber2
		-- Create question in a text object
		questionObject.text = randomNumber1 .. "+" .. randomNumber2 .. "="

	elseif (formula == 2) then
		correctAnswer = randomNumber1 * randomNumber2
		questionObject2.text = randomNumber1 .. "*" .. randomNumber2 .. "="
		timer.performWithDelay(1500, HidequestionObject2)

		if (formula == 3) then 
			correctAnswer = randomNumber1 - randomNumber2
			questionObject3.text = randomNumber1 .. "-" .. randomNumber2 .. "="

		elseif (correctAnswer < 0) then
			correctAnswer = randomNumber2 - randomNumber1
			questionObject2.text = randomNumber2 .. "-" .. randomNumber1 .. "="
					
		end
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

		-- Clear text field
		event.target.text = ""

	elseif event.phase == "submitted" then

		-- When the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- If the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			timer.performWithDelay(1500, HideCorrect)

			-- calls points function
			Points()

		elseif (userAnswer ~= correctAnswer) then
			incorrectObject.isVisible = true
			timer.performWithDelay(1500, Hideincorrect)

		end
	end
end

---------------------------------------------------------------------------------------
-- OBJECT CREATION
--------------------------------------------------------------------------------------

-- Displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/2.75, display.contentHeight/2, nil, 110 )
questionObject:setTextColor(155/255, 42/255, 198/255)
timer.performWithDelay(1500, HidequestionObject)

-- Displays a question and sets the colour
questionObject2 = display.newText( "", display.contentWidth/2.75, display.contentHeight/2, nil, 110 )
questionObject:setTextColor(155/255, 42/255, 198/255)
timer.performWithDelay(1500, HidequestionObject2)

-- Displays a question and sets the colour
questionObject3 = display.newText( "", display.contentWidth/2.75, display.contentHeight/2, nil, 110 )
questionObject:setTextColor(155/255, 42/255, 198/255)
timer.performWithDelay(1500, HidequestionObject3)


-- Create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(50/255, 233/255, 10/255)
correctObject.isVisible = false

-- displays numeber of points 
pointsObject = display.newText("Points = 0", 90, 60, "Georgia", 40)
pointsObject:setTextColor(255/255, 255/255, 255/255)
pointsObject.isVisible = true

-- Create numeric Field
numericField = native.newTextField( display.contentWidth/1.5, display.contentHeight/2, 190, 120 )
numericField.inputType = "number"

-- Create the correct text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(241/255, 62/255, 62/255)
incorrectObject.isVisible = false

-- Add the event listener for the numberic field
numericField:addEventListener( "userInput", NumericFieldListener )

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





----------------------------------------------------------------------------
-- FUNCTION CALLS
-------------------------------------------------------------------------------

-- Call the function to ask the question
AskQuestion()