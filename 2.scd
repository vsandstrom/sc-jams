
s.options.outDevice = "BlackHole 16ch";
s.reboot;


{SinOsc.ar(260).tanh !2 * 0.2}.play;
{SinOsc.ar(260*5/4).tanh !2 * 0.3}.play;

{LFTri.ar(60)!2 }.play;

{SoundIn.ar([0, 1]).tanh*8}.play; 

(
  fork {
    b = Bus.control(s, 1);

    SynthDef(\tut, {
      var env = Env.perc().kr();
      var sig = SinOscFB.ar(\freq.kr(145), \fb.kr(0.5), env*\vol.kr(1)).tanh;
      Out.ar(0, sig!2);
    }).add

    {JPverb.ar(In.ar(0, 2), 8)}.play;

    x = 4.2;
    y = 8.8;
    z = [1, 3.3, 5, 9/8, 6, 4];
    loop{
      z.do{|i|
        d = Synth.new(\tut, [freq: 30*i, vol: y, fb: b.asMap]);
        wait(x);
      };
    }
  }
)

