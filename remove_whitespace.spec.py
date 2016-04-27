import unittest
from remove_whitespace import is_not_all_blank


def blankArray():
    out = []
    for x in range(72):
        out.append('')
    return out

def notBlankArray():
    out = []
    for x in range(72):
        out.append('stuff')
    return out

class TestAllBlank(unittest.TestCase):

    def test_replace(self):
        self.assertEqual(is_not_all_blank(blankArray()), False)
        self.assertEqual(is_not_all_blank(notBlankArray()), True)

if __name__ == '__main__':
    unittest.main()
