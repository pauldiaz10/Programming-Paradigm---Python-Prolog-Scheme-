# -----------------------------------------------------------------------------
# Name:        calculator (+ - * / #)
# Purpose:     CS 152 Python Homework 1
#
# Author:      Paul Diaz
# School:      San Jose State University
#
# -----------------------------------------------------------------------------
"""
Simple Prefix Calculator

Evaluate simple expressions using the prefix notation.
Current version only supports addition of integers and floats.
"""

def add(operands):
    """
    Compute the sum of the operands specified if they are all numbers.
    If any operand is not a valid number, the function returns None.
    :param operands: list of strings
    :return: (int or float) the sum of the operands specified if all of them
        are valid numbers or None if an invalid number is encountered.

    """
    result = 0
    for each_operand in operands:
        each_value = get_value(each_operand)  # Get the corresponding number.
        if each_value is not None:  # Each_operand is a valid number, add it.
            result += each_value
        else:    # There is an error, return None.
            return
    return result # Return the sum.

def subtract(operands):
    """
    Compute the difference of the operands specified if they are all numbers.
    If any operand is not a valid number, the function returns None.
    :param operands: list of strings
    :return: (int or float) the sum of the operands specified if all of them
        are valid numbers or None if an invalid number is encountered.
    """

    if operands:
        result = get_value(operands[0]) #put the first element in result variable
        newoperands = operands[1:] #new operands will now start from element 1 to the end
        for each_operand in newoperands:        #go through the new operands
            each_value = get_value(each_operand)
            if each_value is not None:      #finds if each operands is valid number, then subtract
                result -= each_value
            else:           #There's an error, return and do nothing
                return
    else: # returns 0 if just operand is the only thing entered
        result = 0

    return result #Return the difference

def multiply(operands):
    """
    Compute the product of the operands specified if they are all numbers.
    If any operand is not a valid number, the function returns None.
    :param operands: list of strings
    :return: (int or float) the sum of the operands specified if all of them
        are valid numbers or None if an invalid number is encountered.

    """
    if operands:
        result = get_value(operands[0]) #put the first element in result variable
        newoperands = operands[1:]  #new operands will now start from element 1 to the end
        for each_operand in newoperands: #go through the new operands
            each_value = get_value(each_operand)
            if each_value is not None:  #finds if each operands is valid number, then multiply
                result *= each_value
            else:       #There's an error, return and do nothing
                return
    else:   #Returns 0 if operand is the only thing entered
        result = 0
    return result#Return the product

def divide(operands):
    """
    Compute the quotient of the operands specified if they are all numbers.
    If any operand is not a valid number, the function returns None.
    :param operands: list of strings
    :return: (int or float) the sum of the operands specified if all of them
        are valid numbers or None if an invalid number is encountered.

    """
    if operands:
        result = get_value(operands[0])
        newoperands = operands[1:]

        zero = False
        for each_operand in newoperands:
            each_value = get_value(each_operand)
            if each_value == 0:
                zero = True
                break

        if zero:
            error("non zero", 0)
            return
        else:
            for each_operand in newoperands:
                each_value = get_value(each_operand)
                if each_value is not None:
                    result /= each_value
                else:
                    return
    else:
        result = 0
    return result #Return the quotient

def comment(operands):
    '''
    :param operands: is the operand, which is #
    :return nothing to return
    '''
    return

# Dictionary mapping supported symbols to functions.
# The functions must be defined above.
SUPPORTED_OPERATORS = {'+': add, '-': subtract, '*': multiply, '/': divide, '#': comment}
SUPPORTED_SYMBOLS = sorted(SUPPORTED_OPERATORS.keys())


def evaluate(expression):
    """
    Evaluate a single expression and print the result.
    :param expression: (string) simple expression in prefix notation
    :return: None
    """
    if not expression:
        return
    result = None
    # Split the expression into a list of words (tokens).
    tokens = expression.split()
    operator = tokens[0]  # in prefix notation, the operator comes first
    operands = tokens[1:]
    if operator in SUPPORTED_OPERATORS:
        function_name = SUPPORTED_OPERATORS[operator]
        result = function_name(operands)
    else:
        expected_operators = ' or '.join(SUPPORTED_SYMBOLS)
        error(expected_operators, operator)

    if result is not None:
        print(result)


def get_value(a_string):
    """
    Convert a string to a number (integer or float).
    If the given string is not a valid number, the function returns None.

    :param a_string(str)
    :return: (int or float) the corresponding number
    """
    try:
        # First try to convert the string to an integer.
        value = int(a_string)
    except ValueError:  #  Not a valid integer
        try:
            # Try to convert the string to a float
            value = float(a_string)
        except ValueError:
            error('number', a_string)
            return
    return value


def error(expected, error):
    """
    Print an error message when an unexpexted token is encountered.
    :param expected: (string) supported symbols or 'number' or anything else...
    :param error: (string) the actual token encountered
    :return: None
    """
    print("Error:  expected {}, got {}".format(expected, error))
    print('Please enter a valid expression in prefix notation or q to quit')


def main():
    more_input = True

    while more_input:
        expression = input("CS 152 >>>")
        if expression == 'q':
            more_input = False
            print('Exiting the CS 152 Calculator')
        else:
            evaluate(expression)


if __name__ == '__main__':
    main()