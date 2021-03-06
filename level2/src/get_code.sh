#!/bin/bash
tail -c +125 $0 > /tmp/get_code.tmp
python3 /tmp/get_code.tmp
exit_code=$?
rm /tmp/get_code.tmp
exit $exit_code
B
    xֵ\;	  �               @   s:   d dl Z d dlZd dlZdd� Zdd� Zedkr6e�  dS )�    Nc             C   s*   d}x | D ]}|t t|�d �7 }q
W |S )N� i7  )�chr�ord)�s�r�c� r   �get_code.py�d   s    
r
   c           	   C   s>  t �d� td�} td�}td�td�td�g}td�}tjdd	d
�}t|j�}tdd��}|�� }W d Q R X xF|D ]>}dt	�
|� }	t	�|	|t	j�d krttd| d � td� qtW tt	�||��}
|
dkr�td� td� n"|
dk�rtt|
�d � t|
� t	�| |�}|�s&td� td� ntd| � td� d S )NZtestu(   ƆƍżƉŸƃƃŗƉżƊƌƃƋűŗƇŸƊƊu   ƆſŨŰƖƀŻŻƈŻu\   ƩƣŸƪƪƜƩƫżƨƬƘƣƪŗřźƘƣƚƬƣƘƫƜŗŧŘřŗśşƝƘƚƫƦƩƠƘƣŗŧŠŗŨu�   ƩƣƉƬƥŗřƝƘƚƫƦƩƠƘƣŗŤŨřŗŨŤũŬŬŗřŽƘƚƫƦƩƠƘƣŗƠƪŗƥƦƫŗƛƜƝƠƥƜƛŗƝƦƩŗƥƜƞƘƫƠƭƜŗƠƥƫƜƞƜƩƪřu�   ƩƣƉƬƥŗřƝƘƚƫƦƩƠƘƣŗƝƦƦŗũŵŝŨŗƳŗƞƩƜƧŗƓřŸƩƞƬƤƜƥƫŗƛƦƜƪŗƥƦƫŗƪƜƜƤŗƫƦŗƙƜŗƘƥŗƠƥƫƜƞƜƩťƓřřŗŨu"   űűŗŗŗƉżƊƌƃƋűŗŽŸƀƃZmakeT)Zcapture_outputz
runtest.shr   z^\s*zLine:
z#
is missing from test, put it back.��   �   z:1 test phase is failing. Fix it to receive the level code.z= test phases are failing. Fix them to receive the level code.z=It seems some tests are still failing. Try to fix the issues.�   zRCongratulations! You managed to fix both the test and the package.
Level code is: r   )�os�chdirr
   �
subprocess�run�str�stderr�open�read�re�escape�search�	MULTILINE�print�exit�len�findall)Zcsr   Zchl�fZspr   ZfhZcontZchZregZfcZmcsr   r   r	   �main   s8    





r   �__main__)r   r   r   r
   r   �__name__r   r   r   r	   �<module>   s   1