import os
import re
import json
import copy
from text_cleaner import TextCleaner
from tokenizer import Tokenizer
from sentence_splitter import Splitter


class TextProcessor:
    """
    Contains mathods for turning a string into a list of sentences.
    """

    def __init__(self, settings, categories):
        self.settings = copy.deepcopy(settings)
        self.categories = copy.deepcopy(categories)
        self.cleaner = TextCleaner(settings=self.settings)
        self.tokenizer = Tokenizer(settings=self.settings)
        self.splitter = Splitter(settings=self.settings)

    def process_string(self, s):
        """
        Turn a string into a list of JSON sentences.
        Return the list and the statistics (number of words etc.).
        """
        s = self.cleaner.clean_text(s)
        tokens = self.tokenizer.tokenize(s)
        sentences = self.splitter.split(tokens, s)
        return sentences