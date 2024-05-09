% Insert name here
% Insert email address here


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

% Insert answers here

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
% Define Arduino object
clear
% Setup and data acquisition
d = 600; % Duration in seconds
time = linspace(0, d, d + 1); % Time array from 0 to 600 seconds
temperaturedata = zeros(1, d + 1); % Initialize temperature data array
a= arduino('COM3', 'Uno');
tempsensorPin= 'A0' ;
T_c = 0.01; % Temperature coefficient 
V_0 = 0.5; % Zero-degree voltage 

for i = 1:length(time)
    voltage = readVoltage(a, 'A0'); % Read voltage from sensor
    Temp_data(i) = (voltage - V_0) / T_c; % Convert voltage to temperature
    pause(1); % Pause for 1 second
end

temp_min = min(Temp_data);
temp_max = max(Temp_data);
avg_temp = mean(Temp_data);

%  Plotting
figure;
plot(time, Temp_data);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature vs. Time');

% display the filled box
fprintf('Data logging initiated - 25/4/2024\n');
fprintf('Location - Nottingham\n\n');

for i = 0:10
    fprintf('Minute\t\t%d\n', i);
    fprintf('Temperature\t%.2f C\n\n', Temp_data(i * 60 + 1));
end

fprintf('Max temp\t%.2f C\n', temp_max);
fprintf('Min temp\t%.2f C\n', temp_min);
fprintf('Average temp\t%.2f C\n', avg_temp);
fprintf('Data logging terminated\n');

% file
fileID = fopen('cabin_temperature.txt', 'w');
fprintf(fileID, 'Data logging initiated - 5/3/2024\n');
fprintf(fileID, 'Location - Nottingham\n\n');

for i = 0:10
    fprintf(fileID, 'Minute\t\t%d\n', i);
    fprintf(fileID, 'Temperature\t%.2f C\n\n', Temp_data(i * 60 + 1));
end

fprintf(fileID, 'Max temp\t%.2f C\n', temp_max);
fprintf(fileID, 'Min temp\t%.2f C\n', temp_min);
fprintf(fileID, 'Average temp\t%.2f C\n', avg_temp);
fprintf(fileID, 'Data logging terminated\n');
fclose(fileID);

% Check the file content
fileID = fopen('cabin_temperature.txt', 'r');
fileContent = fread(fileID, '*char')';
fclose(fileID);
disp(fileContent);

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

a = arduino('COM3', 'Uno');
    % Temperature sensor pin
    tempsensorPin = 'A0';
time = 0
temperature = 0;
 figure;
 plot(time,temperature,"*");
 xlabel('Time')
 ylabel('Temperature')
 title('temp menitoring by time')
 hold on ;
 grid on;
    for x = 1:inf
    voltage = readVoltage(a, tempsensorPin);
    [temperature] = temp_monitor1 (a,voltage);
    % Setup LED pins
    greenLED = 'D9';
    yellowLED = 'D10';
    redLED = 'D11';
    
  % Setup figure for live plotting
    plot(time,temperature, "*")
    time = time + 1;
    pause(1);
    
    end


% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

function ret = run_temp_prediction(a)
    % Initialize Arduino object
    a = arduino('COM3', 'Uno');
    
    % Call temp_prediction function
    temp_prediction(a);
    
    % Clear Arduino object
    clear a;
end



% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here
% Simulate temperature sensor data acquisition (replace with actual Arduino code)
function temp = get_temperature()
  % Replace this with code that reads temperature sensor using Arduino object 'a'
  % This example simulates random temperature changes between -2 and 2 degrees Celsius
  temp = randi([-2, 2]);
end

% Call the temperature prediction function
while (true)
  temp_data = get_temperature();  % Simulate data acquisition
  temp_prediction(temp_data);      % Call the function with simulated data
  pause(1);                         % Adjust pause time as needed
end
