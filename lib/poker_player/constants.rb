# Relative power of hands
NUM_REL_RANKS = 3
WORSE = 0
TIED = 1
BETTER = 2

# Maximum number of cards in a hand (Texas hold'em).
MAX_CARDS = 7

# Number of different types of hands
NUM_HANDS = 9

# Types of hands
STRAIGHT_FLUSH = 8
FOUR_OF_A_KIND = 7
FULL_HOUSE = 6
FLUSH = 5
STRAIGHT = 4
TRIPS = 3
TWO_PAIRS = 2
PAIR = 1
HIGH_CARD = 0
BAD_HAND = -1

#Card constants
CLUBS = 0;
DIAMONDS = 1;
HEARTS = 2;
SPADES = 3;

BAD_CARD = -1;
TWO = 0;
THREE = 1;
FOUR = 2;
FIVE = 3;
SIX = 4;
SEVEN = 5;
EIGHT = 6;
NINE = 7;
TEN = 8;
JACK = 9;
QUEEN = 10;
KING = 11;
ACE = 12;

NUM_SUITS = 4;
NUM_RANKS = 13;
NUM_CARDS = 52;

SHIFT = NUM_RANKS * NUM_RANKS * NUM_RANKS * NUM_RANKS * NUM_RANKS;

#For hand_potential
NUM_POTENTIALS = 2
POSITIVE = 0
NEGATIVE = 1
