(function() {
  var interval, now, sal_to_sec, tick;

  interval = null;

  now = null;

  sal_to_sec = 1000 / 48 / 5 / 8 / 60 / 60;

  tick = function() {
    var dollars, major, minor, people, salary, time;
    time = (Date.now() - now) / 1000;
    major = numeral(time).format('00:00:00');
    minor = numeral(time % 1000).format('.00');
    $('.timer h3').text("" + major + minor);
    salary = parseInt($('input[name=inputSalary]').val());
    people = parseInt($('input[name=inputNumPeople]').val());
    dollars = salary * sal_to_sec * time * people;
    return $('.timer h1').text(numeral(dollars).format('$0.00'));
  };

  $('a.button').on('click', function(e) {
    e.preventDefault();
    if ($(this).text() === 'Start') {
      $(this).text('Stop');
      now = Date.now();
      return interval = setInterval(tick, 10);
    } else {
      $(this).text('Start');
      return clearInterval(interval);
    }
  });

}).call(this);

/*
//@ sourceMappingURL=app.js.map
*/