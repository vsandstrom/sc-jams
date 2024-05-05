(
var options = Server.default.options;
options.outDevice = "BlackHole 64ch";
)
(

	l = LinkClock(1).latency_(Server.default.latency);
	l.tempo=190/60;

)
l.beats = 1

(
	SynthDef(\osc, { |freq, out|

		//var output_gen = SinOsc.ar(freq: SinOsc.ar(90, add: freq, mul: 90), mul: 0.5)!2;
		var output_gen = SinOsc.ar(freq: freq*2, mul: 0.1)!2;
		var env = EnvGen.kr(Env.perc(releaseTime: 1.5.rand), doneAction: Done.freeSelf);
			
		Out.ar(out, output_gen*env);

	}).add;
)
(
	s.waitForBoot({
		p = Pbind(
			\instrument, \osc,
			\freq, Pseq([1, 2.1, 4/3, 5/4, 3]*110, repeats: inf),
      \dur, Pseq([1, 1, 2, 1], inf)
		).play(l, quant: 2);
			
	});
)
p.stop;
s.freeAll

Server.default.options.outDevice = "BlackHole 64ch"
s.reboot
{SinOsc.ar(12*120*SinOsc.ar(990).unipolar)*0.1!2}.play
{SinOsc.ar(110.1)*0.01!2}.play
{SinOsc.ar(440)*0.1!2}.play
{SoundIn.ar([0,1])*6}.play
s.meter
