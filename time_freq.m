% Set the duration of the sinusoid
duration = 2;

% Set the sample rate and number of samples
fs = 2000;
N = duration*fs;

% Generate a time vector
t = linspace(0, duration, N);

% Set the range of frequencies of the sinusoid
f_min = 0;
f_max = 1000;
f_step = 10;
frequencies = f_min:f_step:f_max;

% Initialize a matrix to store the sinusoids
x = zeros(length(frequencies), N);


% Generate the sinusoids
for i = 1:length(frequencies)
    f = frequencies(i);
    x(i, :) = sin(2*pi*f*t);
end
% Compute the single-sided spectra of the sinusoids
X = fft(x, [], 2);
X = X(:, 1:N/2+1);
f = fs*(0:N/2)/N;
% Plot the sinusoids in the time domain
figure;
for i = 1:length(frequencies)-1
    subplot(2, 1, 1);
    plot(t, x(i, :));
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Sinusoid in Time Domain (f = %d Hz)', frequencies(i)));

    subplot(2, 1, 2);
    plot(f, abs(X(i, :)));
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title(sprintf('Single-Sided Spectrum of Sinusoid (f = %d Hz)', frequencies(i)));
    ylim([0,1000])
    % Add a legend to the plot
    legend(num2str(frequencies(i))); 
    pause(0.3)
    MM(i)=getframe(gcf);

end


drawnow;

v = VideoWriter('timefreq.mp4','MPEG-4');
open(v)
writeVideo(v,MM)
close(v)


