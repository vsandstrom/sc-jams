s.options.outDevice = "BlackHole 16ch";
s.reboot;

(
fork {
  var f = 70;
  var chords = [
    f*[1, 6/2, 10/4],
    f*[2/3, 12/5, 8/3],
    f*[7/5, 6/2, 10/3]
  ];
  var speed = 0.125;
  var x = 0;
  var fold = 0.3;
  loop {

    chords.do {|notes|
      notes.do{|note, i|
        if (note < 200) {note = note * [0.5, 0.66, 1].wchoose([0.1, 0.2, 0.7])} {note};
        if (note > 200) {note = note * [2, 3, 1].wchoose([0.1, 0.2, 0.7])} {note};
        {
          [
            EnvGen.kr(
              Env.perc(0.001, 0.1 * x),
              gate: 1,
              doneAction: 2
            ) * 
            SinOsc.ar(
              (note*i), 
              phase: SinOsc.ar(225 * i)*0.1, 
              mul: 0.1*SinOsc.ar(125).range(0,1)
            ).fold((fold.sum3rand.abs).neg, fold),

            EnvGen.kr(
              Env.perc(0.001, 0.1 * (x*0.978)),
              gate: TDelay.kr(Impulse.kr(), 0.1.rand.abs),
              doneAction: 2
            ) * 
            SinOsc.ar(
              (note*i) + 5.0.rand,
              phase: SinOsc.ar(225 * i)*0.1,
              mul: 0.1*SinOsc.ar(125).range(0,1)
            ).fold(-1 * fold, fold.sum3rand.abs)
          ]}.play;
          x = (x+0.33) % 32;
          wait(0.1.rand.abs);
      };
      wait(speed+0.1.rand);
    };
  }
}
)

s.meter
s.tree
