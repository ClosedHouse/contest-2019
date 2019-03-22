#!/usr/bin/python3

import base64
import pickle
import os
import shutil
import tempfile
import subprocess
import sys
import argparse

DBPATH='/var/lib/misc/task-behave.db'
LANG="en" # or cz
MSGS = {}
MSGS['cz'] = {
    'CREATE_TESTDIR': 'Vytvoren novy testovaci adresar',
    'OK': 'OK',
    'FAIL': 'CHYBA',
    'TEST1': 'Poustim originalni scenar file.feature',
    'TEST2': 'Poustim uzivateluv scenar grep.feature',
    'TEST3': 'Poustim korektni implementaci grep.feature',
    'TEST4': 'Poustim dodatecne testovaci scenare',
    'SOLUTION_CHECK': "Overuji spravnost implementace testu",
    'SOLUTION_OK': "Gratuluji! Tajny kod pro tuto uroven je",
    'SOLUTION_NOK': "Bohuzel, snazte se lepe.",
    'LANG_NOK': "Nepodporovany jazyk, moznosti jsou",
    'LANG_SET': "Jazyk byl nastaven na",
    }
MSGS['en'] = {
    'CREATE_TESTDIR': 'Creating new directory with tests',
    'OK': 'OK',
    'FAIL': 'FAILED',
    'TEST1': 'Running original test scenario file.feature',
    'TEST2': "Running user's implementation of test scenario grep.feature",
    'TEST3': 'Running correct implementation of grep.feature',
    'TEST4': 'Running additional test scenarios',
    'SOLUTION_CHECK': "Validating your test implementation",
    'SOLUTION_OK': "Congratulations! The secred code for this level is",
    'SOLUTION_NOK': "This is not good enough, keep on trying!",
    'LANG_NOK': "Unsupported language, choose from",
    'LANG_SET': "Language has been changed to",
    }


def read_file(path):
    with open(path, 'r') as f:
      text = f.read()
      f.close()
    return text

def encode_text(text):
    return base64.b64encode(text.encode())

def decode_text(text):
    s = base64.b64decode(text)
    return base64.b64decode(text).decode()

def initDB():
    db = {}
    for filename in ['file.feature', 'grep.feature', 'correct-grep.feature', 'failing-steps.feature', 'description.en', 'description.cz', 'hint1.en', 'hint2.en', 'hint1.cz', 'hint2.cz', 'level_code', 'generic_steps.py', 'introduction.en', 'introduction.cz', 'README.txt']:
        db[filename] = encode_text(read_file(filename))
    db['LANG'] = encode_text(LANG)
    f = open(DBPATH, 'wb')
    pickle.dump(db, f)
    f.close()

def readDB():
    db_dec = {}
    f = open(DBPATH, 'rb')
    db_enc = pickle.load(f)
    f.close()
    for k in db_enc:
        db_dec[k] = decode_text(db_enc[k])
    return db_dec

def saveDB(db):
    db_enc = {}
    for k in db:
        db_enc[k] = encode_text(db[k])
    f = open(DBPATH, 'wb')
    pickle.dump(db_enc, f)
    f.close()

def write_file(text, path):
    f = open(path, 'w')
    f.write(text)
    f.close()

def run_behave_scenario(feature_file, tmpdir):
    process = subprocess.Popen(['/usr/bin/behave', feature_file], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, cwd=tmpdir)
    stdout, stderr = process.communicate()
    return(process.returncode, stdout, stderr)

def init_workdir(workdir):
    os.makedirs(os.path.join(workdir, 'steps'))
    for name in ['file.feature', 'grep.feature', 'README.txt']:
        write_file(db[name], os.path.join(workdir, name))
    write_file(db['generic_steps.py'], os.path.join(workdir, 'steps', 'generic_steps.py'))
    print("%s %s" % (MSGS[LANG]['CREATE_TESTDIR'], workdir))

def verify_test_result_simple(ret_values, test_msg, ok_msg, err_msg, verbose=False, code_expected=0):
    print(test_msg)
    if ret_values[0] == code_expected:
        print(ok_msg)
        return 0
    else:
        print(err_msg)
        return 1

def test_solution(workdir):
    db = readDB()
    # create temporary directory
    testdir = tempfile.mkdtemp()
    # save feature files and step implementation
    for name in ['file.feature', 'correct-grep.feature', 'failing-steps.feature']:
        write_file(db[name], os.path.join(testdir, name))
    os.mkdir(os.path.join(testdir, 'steps'))
    shutil.copy(os.path.join(workdir, 'grep.feature'), testdir)
    shutil.copy(os.path.join(workdir, 'steps', 'generic_steps.py'), os.path.join(testdir, 'steps'))
    print(MSGS[LANG]['SOLUTION_CHECK'])
    # run tests
    counter = 0
    result = run_behave_scenario('file.feature', testdir)
    counter += verify_test_result_simple(result, MSGS[LANG]['TEST1'], MSGS[LANG]['OK'],  MSGS[LANG]['FAIL'])
    result = run_behave_scenario('grep.feature', testdir)
    counter += verify_test_result_simple(result, MSGS[LANG]['TEST2'], MSGS[LANG]['OK'],  MSGS[LANG]['FAIL'])
    result = run_behave_scenario('correct-grep.feature', testdir)
    counter += verify_test_result_simple(result, MSGS[LANG]['TEST3'], MSGS[LANG]['OK'],  MSGS[LANG]['FAIL'])
    result = run_behave_scenario('failing-steps.feature', testdir)
    counter += verify_test_result_simple(result, MSGS[LANG]['TEST4'], MSGS[LANG]['OK'],  MSGS[LANG]['FAIL'], code_expected=1)
    if counter == 0:
        print("%s %s" % (MSGS[LANG]['SOLUTION_OK'],  db['level_code']))
    else:
        print(MSGS[LANG]['SOLUTION_NOK'])
    shutil.rmtree(testdir)


# parse arguments
parser = argparse.ArgumentParser(description='Behave exercise.')
parser.add_argument('--init-db', dest='initdb', action='store_true',
                    default=False, help=argparse.SUPPRESS)
parser.add_argument('--set-lang', nargs=1, dest='lang', action='store',
                    default=[], help="Set language of text outputs (%s)" % ','.join(MSGS.keys()))
parser.add_argument('--intro', dest='intro', action='store_true',
                    default=False, help="print introduction")
parser.add_argument('--desc', dest='desc', action='store_true',
                    default=False, help="print task description")
parser.add_argument('--hint1', dest='hint1', action='store_true',
                    default=False, help="print 1st hint")
parser.add_argument('--hint2', dest='hint2', action='store_true',
                    default=False, help="print 2nd hint")
parser.add_argument('--setup', dest='setup', nargs='?', action='store', metavar='DIR',
                    default="NA", help="setup the task in a given directory (current by default)")
parser.add_argument('--eval', dest='eval', nargs='?', action='store', metavar='DIR',
                    default="NA", help="evaluate the solution in a given directory (current by default)")
args = parser.parse_args()

if args.initdb:
  initDB()

if not os.path.isfile(DBPATH):
    print('database missing, did you run --init-db')
    sys.exit(1)

db = readDB()
LANG=db['LANG']

if args.lang:
    if args.lang[0] in MSGS.keys():
        db['LANG'] = args.lang[0]
        LANG = args.lang[0]
        saveDB(db)
        print("%s %s" % (MSGS[LANG]['LANG_SET'], LANG))
        sys.exit(0)
    else:
        print("%s %s" % (MSGS[LANG]['LANG_NOK'], ', '.join(MSGS.keys())))
        sys.exit(1)

if args.hint1:
    key = 'hint1.%s' % LANG
    if key not in db:
        key = 'hint1.en'
    print(db[key])
    sys.exit(0)

if args.hint2:
    key = 'hint2.%s' % LANG
    if key not in db:
        key = 'hint2.en'
    print(db[key])
    sys.exit(0)

if args.intro:
    key = 'introduction.%s' % LANG
    if key not in db:
        key = 'introduction.en'
    print(db[key])
    sys.exit(0)

if args.desc:
    key = 'description.%s' % LANG
    if key not in db:
        key = 'description.en'
    print(db[key])
    sys.exit(0)

if args.setup != "NA":
    if args.setup:
        workdir = args.setup
    else:
        workdir = "."
    init_workdir(workdir)

if args.eval != "NA":
    if args.eval:
        workdir = args.eval
    else:
        workdir = "."
    test_solution(workdir)

