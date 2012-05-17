package Data::OpeningHours::Calendar;
use strict;
use warnings;

use Data::OpeningHours::Hours;
use DateTime::Format::Strptime;

sub new {
    my ($class) = @_;
    my $self = {};
    $self->{parser} = DateTime::Format::Strptime->new(
        pattern => '%a',
        locale => 'en_US',
        on_error => 'croak',
    );
    return bless $self, $class;
}

sub set_week_day {
    my ($self, $day, $hours) = @_;
    $self->{week}[$day] = Data::OpeningHours::Hours->new($hours);
    return;
}

sub set_special_day {
    my ($self, $date, $hours) = @_;
    $self->{days}{$date} = Data::OpeningHours::Hours->new($hours);
    return;
}
sub is_special_day {
    my ($self, $date) = @_;
    return exists $self->{days}{$date};
}

sub is_open_on_week_day {
    my ($self, $day_of_week, $hour) = @_;
    return unless exists $self->{week}[$day_of_week];
    return $self->{week}[$day_of_week]->is_open_between($hour);
}

sub is_open_on_special_day {
    my ($self, $date, $hour) = @_;
    return $self->{days}{$date}->is_open_between($hour);
}

sub is_open {
    my ($self, $date) = @_;
    if ($self->is_special_day($date->ymd('-'))){
        return $self->is_open_on_special_day(
            $date->ymd('-'),
            sprintf('%02d:%02d', $date->hour, $date->minute));
    }

    return $self->is_open_on_week_day(
        $date->wday,
        sprintf('%02d:%02d', $date->hour, $date->minute));
}

1;

