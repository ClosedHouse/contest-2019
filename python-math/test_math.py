import unittest
import math

class TestFloor(unittest.TestCase):
    '''Tato testsuite testuje funkci math.floor(), ktera by mela zaokrouhlit
       cislo dolu.
       Viz - https://docs.python.org/3/library/math.html#math.floor '''

    def test_sanity(self):
        ''' Sanity testovani
            Sanity testovani je doslova testovani rozumnosti. Potrebujeme
            overit, ze math.floor alespon neco vrati, a aby to 'neco' bylo
            cele cislo. '''
        self.assertEqual(type(math.floor(3.5)), int)

    def test_positive(self):
        ''' Pozitivni testovani
            Pozitivni testovani pouzijeme kdyz potrebujeme otestovat tak zvane
            pozitivni scenare. To jsou scenare, u kterych vstupni data jsou vice
            mene ocekavane. U math.floor ocekavanym argumentem je (necele)
            cislo '''
        self.assertEqual(math.floor(3.1), 3)
        self.assertEqual(math.floor(3.3), 3)
        self.assertEqual(math.floor(3.5), 4)

    def test_negative(self):
        ''' Negativni testy
            Negativni testy naopak testujou chovani math.floor v pripade, ze
            na vstup dostane neocekavane data (data jineho datoveho typu, zadne
            data, poskozene data, atd). A i tehdy by funkce mela se chovat
            rozumne. '''
        with self.assertRaises(TypeError):
            math.floor(None)
        with self.assertRaises(TypeError):
            math.floor('cislo')

    def test_integration(self):
        ''' Integracni testovani
            Integracni testovani overuje, ze nekolik mensich komponent
            (funkci, modulu, atd) slopupracuji tak, jak maji. Pokud jsme uz
            overili, ze math.floor() funguje spravne, tak zkusime jak to
            funguje s ostatnimi funkci s math modulu '''
        pass
