# Algorithms and Data Structures written in Ruby
A collection of data structures and algorithms written for practice and to build understanding.

## Installation

`gem install simms_structures`

And that's it. No dependencies other than Ruby 2.1.2

## Dynamic Array

##### Static Array

Restricting Ruby's built in array structure to be of fixed length.

##### Dynamic Array

A somewhat silly implementation of a Dynamic Array. Built off my own version of a Static Array (which is built off of Ruby's Built-in Dynamic Array...). The Dynamic Array is pretty fast in general but suffers from O(n) time complexity when shifting or unshifting.

##### Ring Buffer

Essentially a Dynamic Array with wrap-around, the ring buffer achieves O(1) shift and unshift (amortized) time. The wrap around is achieved by using modular arithmetic and storing an index that represents the beginning of the Array.  

## LRU Cache

##### Hash Set and HashMap

To practice the foundation of a HashMap, the Hash Set is a Dynamic Set that stores objects after applying a hashing function. Using an Array of Arrays as "buckets" to simulate memory allocation, the Set maintains distinctness and is unordered.

The HashMap uses the same structure. I included the Enumerable Module and wrote #each, which makes all the Enumerable methods available to this implementation of a HashMap.

##### Linked List

A simple doubly-linked list. I included the Enumerable module, and the Link class contains both a Key and a Value.

##### LRU Cache

The Least Recently Used Cache is a collection of objects that has a specific order. The order is determined by which object has been added most recently. My LinkedList class keeps the order of the objects, but this makes lookup on the cache quite slow. In order to keep a constant lookup time, I use a HashMap in tandem with the LinkedList. The Cache only has one main method, #get, which either stores the new value or refreshes the order of that value in the list.

## QuickSort

The famous QuickSort, before I've always implemented without mutating the original array, which is O(n) in space complexity. The method #sort2 sorts the array in place, keeping multiple pointers and using a helper method, #partition. This keeps the sort at constant space complexity.

## Binary Min Heap / Heap Sort

A Binary Minimum Heap, the beast of this data structure is the Heapify Up/Down. All the leg work in the data structure means that Heap Sort is quite simple to implement.
