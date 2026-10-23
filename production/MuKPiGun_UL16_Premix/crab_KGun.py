import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from crab_pilot_guns import make_config
config = make_config("KGun")
