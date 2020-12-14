import sys
import rdflib
import argparse
import tempfile
import os
import multiprocessing
from concurrent.futures import ThreadPoolExecutor


# These two rel predicates do not have an easily
# translation into agrelon. They have been left out
# If this ever changes, they will need to be added
#rel:antagonistOf
#rel:ambivalentOf

rel_map = {
    "childOf":"hasParent",
    "acquaintanceOf": "hasAcquaintance",
    "ancestorOf": "hasOffspring",
    "collaboratesWith": "hasCooperator",
    "descendantOf": "hasAncestor",
    "employedBy": "hasEmployer",
    "employerOf": "hasEmployee",
    "fosterSiblingOf": "hasFosterSibling",
    "friendOf": "hasFriend",
    "grandparentOf": "hasGrandChild",
    "livesWith": "hasCohabitee",
    "parentOf": "hasChild",
    "siblingOf": "hasSibling",
    "spouseOf": "hasSpouse",
    "worksWith": "hasColleague",
    "mentorOf": "hasStudent",
    "hasMet": "hasAcquaintance"
}

irish_rel_map = {
    "loverOf": "hasLover",
    "fosterChildOf": "hasFosterParent",
    "fosterParentOf": "hasFosterChild",
    "fosterSiblingOf": "hasFosterSibling"
}
    
def rel_swap(g, rel, agrelon):
    for subject, predicate, object, context in g.quads((None, rdflib.URIRef(f'http://purl.org/vocab/relationship/{rel}'), None, None)):
        g.add((subject, rdflib.URIRef(f'https://d-nb.info/standards/elementset/agrelon#{agrelon}'), object, context))

def irish_rel_swap(g, irish_rel, agrelon):
    for subject, predicate, object, context in g.quads((None, rdflib.URIRef(f'http://example.com/earlyIrishRelationship.ttl#{irish_rel}'), None, None)):
        g.add((subject, rdflib.URIRef(f'https://d-nb.info/standards/elementset/agrelon#{agrelon}'), object, context))

def write_file(filename, output, dest):
    with open(f'{dest}/{filename}', "w") as writer:
        writer.write(output)
            
def process_file(t):
    (file_full_path, filename, dest, base) = t
    print_filename(t)
    g = rdflib.Dataset()
    g.parse(file_full_path, format="trig")
    g.namespace_manager.bind('argrel', rdflib.URIRef("https://d-nb.info/standards/elementset/agrelon#"))
    for key in rel_map.keys():
        rel_swap(g, key, rel_map[key])
    for key in irish_rel_map.keys():
        irish_rel_swap(g, key, irish_rel_map[key])
    output = g.serialize(format='trig', base=rdflib.URIRef(base + "/" + filename)).decode('utf-8')
    write_file(filename, output, dest)

def print_filename(t):
    (file_full_path, filename, dest, base) = t
    print(f'Processing file {file_full_path} to dest {args.dest}/{filename} with base url {args.base_url}')
    
def init_argparse():
    parser = argparse.ArgumentParser(
        description="Adds argrelon as a set of predicates to IrishGen"
        )
    parser.add_argument("--base_url", default='http://example.com/LL')
    parser.add_argument("--dest", default=tempfile.gettempdir())
    parser.add_argument("--dry_run", action="store_true")
    parser.add_argument('files', nargs='+')
    return parser
    
if __name__ == "__main__":
    args = init_argparse().parse_args()
    file_args_list = []
    for file_full_path in args.files:
        path, filename = os.path.split(file_full_path)
        file_args_list.append((file_full_path, filename, args.dest, args.base_url))
    with ThreadPoolExecutor(max_workers=multiprocessing.cpu_count()) as executor:
        if args.dry_run:
            executor.map(print_filename, file_args_list)
            executor.shutdown()
        else:
            executor.map(process_file, file_args_list)
            executor.shutdown()
