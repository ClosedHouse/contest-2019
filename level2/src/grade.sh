#!/bin/bash
tail -c +116 $0 > /tmp/grade.tmp
python3 /tmp/grade.tmp
exit_code=$?
rm /tmp/grade.tmp
exit $exit_code
B
    ��\�  �               @   s:   d dl Z d dlZd dlZdd� Zdd� Zedkr6e�  dS )�    Nc             C   s*   d}x | D ]}|t t|�d �7 }q
W |S )N� i7  )�chr�ord)�s�r�c� r   �grade.py�d   s    
r
   c              C   sl   t �d� td�} td�}tjddd�}t|j�}t�| |�}|sTt	d� t
d� nt	d	| � t
d
� d S )Nz=/home/jheger/projects/contest-2019/level2/src/tests/factorialu(   ƆƍżƉŸƃƃŗƉżƊƌƃƋűŗƇŸƊƊu   ƦƟŨŰŤƀŻŻƈŻZmakeT)Zcapture_outputz=It seems some tests are still failing. Try to fix the issues.�   zTODO congratz, code is: r   )�os�chdirr
   �
subprocess�run�str�stderr�re�search�print�exit)Zcsr   Zspr   Zmcsr   r   r	   �main   s    


r   �__main__)r   r   r   r
   r   �__name__r   r   r   r	   �<module>   s   