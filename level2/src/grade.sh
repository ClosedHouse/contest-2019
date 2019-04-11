#!/bin/bash
tail -c +116 $0 > /tmp/grade.tmp
python3 /tmp/grade.tmp
exit_code=$?
rm /tmp/grade.tmp
exit $exit_code
B
    r,�\�  �               @   s:   d dl Z d dlZd dlZdd� Zdd� Zedkr6e�  dS )�    Nc             C   s*   d}x | D ]}|t t|�d �7 }q
W |S )N� i7  )�chr�ord)�s�r�c� r   �grade.py�d   s    
r
   c        
   	   C   s�   t �d� td�} td�}td�td�td�g}tjddd	�}t|j�}td
d��}|�� }W d Q R X xF|D ]>}dt	�
|� }t	�||t	j�d krltd| d � td� qlW t	�| |�}	|	s�td� td� ntd| � td� d S )NZtestu(   ƆƍżƉŸƃƃŗƉżƊƌƃƋűŗƇŸƊƊu   ƦƟŨŰƖƀŻŻƈŻu\   ƩƣŸƪƪƜƩƫżƨƬƘƣƪŗřźƘƣƚƬƣƘƫƜŗŧŘřŗśşƝƘƚƫƦƩƠƘƣŗŧŠŗŨu�   ƩƣƉƬƥŗřƝƘƚƫƦƩƠƘƣŗŤŨřŗŨŤũŬŬŗřŽƘƚƫƦƩƠƘƣŗƠƪŗƥƦƫŗƛƜƝƠƥƜƛŗƝƦƩŗƥƜƞƘƫƠƭƜŗƠƥƫƜƞƜƩƪřu�   ƩƣƉƬƥŗřƝƘƚƫƦƩƠƘƣŗƝƦƦŗũŵŝŨŗƳŗƞƩƜƧŗƓřŸƩƞƬƤƜƥƫŗƛƦƜƪŗƥƦƫŗƪƜƜƤŗƫƦŗƙƜŗƘƥŗƠƥƫƜƞƜƩťƓřřŗŨZmakeT)Zcapture_outputz
runtest.shr   z^\s*zTODO: 'z#' is missing from test, put it back��   z=It seems some tests are still failing. Try to fix the issues.�   zTODO congratz, code is: r   )�os�chdirr
   �
subprocess�run�str�stderr�open�read�re�escape�search�	MULTILINE�print�exit)
Zcsr   ZchlZspr   ZfhZcontZchZregZmcsr   r   r	   �main   s&    



r   �__main__)r   r   r   r
   r   �__name__r   r   r   r	   �<module>   s   &