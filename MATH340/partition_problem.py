import time
import random
import matplotlib.pyplot as plt
import numpy as np


def partition(collection):
    if len(collection) == 1:
        yield [collection]
        return

    first = collection[0]
    for smaller in partition(collection[1:]):
        # insert `first` in each of the subpartition's subsets
        for n, subset in enumerate(smaller):
            yield smaller[:n] + [[first] + subset] + smaller[n + 1:]
        # put `first` in its own subset
        yield [[first]] + smaller


def pos_diff(set1, set2):
    diff = 0
    for i in range(len(set1)):
        diff += 0 if set1[i] == set2[i] else 1
    return diff


def brute(collection):
    best_diff = float('inf')
    best_s1 = None
    best_s2 = None
    partitions = list(partition(collection))[1:]
    refined_partitions = []
    for part in partitions:
        if len(part) == 2:
            refined_partitions.append(part)
    for s1, s2 in refined_partitions:
        if sum(s1) == sum(s2):
            return 0, s1, s2
        else:
            diff = abs(sum(s1) - sum(s2)) + pos_diff(s1 + s2, collection)
            if diff < best_diff:
                best_diff = abs(sum(s1) - sum(s2))
                best_s1 = s1
                best_s2 = s2
    return best_diff, best_s1, best_s2


def karmakar_karp(collection):
    nums = collection[:]
    steps = []

    while len(nums) > 1:
        nums.sort(reverse=True)
        largest1 = nums[0]
        largest2 = nums[1]
        diff = largest1 - largest2
        nums = nums[2:]
        nums.append(diff)
        steps.append((largest1, largest2))
    minimal_difference = nums[0] if nums else 0

    subset1 = []
    subset2 = []
    first = True
    for step in reversed(steps):
        largest1, largest2 = step
        diff = abs(largest1 - largest2)
        if first:
            subset1.append(largest1)
            subset2.append(largest2)
            first = False
        else:
            if diff in subset1:
                subset1[subset1.index(diff)] = largest1
                subset2.append(largest2)
            elif diff in subset2:
                subset2[subset2.index(diff)] = largest1
                subset1.append(largest2)
    return minimal_difference, subset1, subset2


def generate_random_partitionable_lists(min_size=2, max_size=100, digits=1):
    random.seed(66)
    rand_lists = []
    for i in range(min_size, max_size + 1):
        rand_list = []
        for j in range(i):
            rand_list.append(random.randint(1, (10 ** digits) - 1))
        rand_lists.append(rand_list)
    return rand_lists


def main():
    brute_num = 11
    sample = [1 + i for i in range(99)]
    rand_lists = generate_random_partitionable_lists()

    y1 = []
    diff_brute = []
    bs = []
    for collection in rand_lists[:brute_num]:
        start = time.time()
        brute_diff, bs1, bs2 = brute(collection)
        end = time.time()
        y1.append(end - start)
        bs.append(bs1 + bs2)
        diff_brute.append(brute_diff)

    y2 = []
    diff_kk = []
    ks = []
    for collection in rand_lists:
        start = time.time()
        kk_diff, ks1, ks2 = karmakar_karp(collection)
        end = time.time()
        y2.append(end - start)
        ks.append(ks1 + ks2)
        diff_kk.append(kk_diff)

    plt.plot(sample[:brute_num], y1, label="Brute")

    # Graph setup
    plt.title("Runtime of Brute Force")
    plt.xlabel("Length of Set")
    plt.ylabel("Time (s)")
    plt.grid()
    plt.show()

    plt.plot(sample, np.array(y2) * 1000, label="KK")

    # Graph setup
    plt.title("Runtime of Karmakar-Karp Algorithm")
    plt.xlabel("Length of Set")
    plt.ylabel("Time (ms)")
    plt.grid()
    plt.show()

    diff = abs(np.array(diff_kk[:brute_num]) - diff_brute)
    print(bs)
    print(ks[:brute_num])
    position_diff = []
    for i in range(len(bs)):
        position_diff.append(pos_diff(ks[i], bs[i]))
    print(position_diff)
    total_diff = diff + position_diff

    plt.plot(sample[:brute_num], position_diff, label="Position Difference")
    plt.plot(sample[:brute_num], diff, label="Subset Sum Difference")
    plt.plot(sample[:brute_num], total_diff, label="Total Differences")

    # Graph setup
    plt.title("Differences")
    plt.xlabel("Length of Set")
    plt.ylabel("Number of Differences")
    plt.grid()
    plt.legend()
    plt.show()


if __name__ == '__main__':
    main()
