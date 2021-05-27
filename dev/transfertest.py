import requests
import re
import subprocess
import random
import os


def run_test(input_sentence, output_sentence, direction, fname, directory="."):
    with open(fname, "w") as outfile:
        outfile.write(input_sentence.strip())
    result = subprocess.run(['apertium', '-d', directory, direction, fname], stdout=subprocess.PIPE)
    output = result.stdout.decode("utf-8")
    if output.strip() == output_sentence.strip():
        print("SUCCESS:", input_sentence, "→", output)
    else:
        print("FAILED:", input_sentence)
        print("GOT:", output)
        print("EXPECTED:", output_sentence )
    print()


def run_tests(url, fname):
    r = requests.get(url)
    test_exp = "\{\s*\{\s*test\s*\|(.*)\|(.*)\|(.*)\}\s*\}"
    tests = []
    for line in r.text.split("\n"):
        m = re.search(test_exp, line)
        if m:
            test = m.groups()
            run_test(test[1], test[2], dirs[test[0]], fname)
    if os.path.exists(fname):
        os.remove(fname)


if __name__ == "__main__":
    fname = "/tmp/" + str(random.randint(100000,999999)) + ".txt"
    dirs = {"uzb":"uzb-tur", "tur":"tur-uzb"}
    regression = "https://wiki.apertium.org/w/index.php?title=Apertium-tur-uzb/Regression_tests&action=edit"
    pending = "https://wiki.apertium.org/w/index.php?title=Apertium-tur-uzb/Pending_tests&action=edit"
    print("*** PENDING ***")
    run_tests(pending, fname)
    print("*** REGRESSION ***")
    run_tests(regression, fname)

    
        

