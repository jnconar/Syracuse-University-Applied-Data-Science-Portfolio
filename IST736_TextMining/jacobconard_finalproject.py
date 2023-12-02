# -*- coding: utf-8 -*-
"""
Created on Mon Dec  5 07:29:11 2022
IST 736 Final Project
@author: jncon
"""

#Imports

import numpy as np
import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics import confusion_matrix
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
from sklearn.metrics import classification_report
from sklearn.svm import LinearSVC
import sklearn
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB
from sklearn import svm
from sklearn.model_selection import cross_val_score

# Read in the data and create training and testing data

train=pd.read_csv("C:/Users/jncon/Desktop/Syracuse/IST736/FinalProject/twitter_training.csv", encoding='latin-1')
y=train['Sentiment'].values
X=train['Tweet'].values

# split the data into training and testing and print out the examples
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=0)
print(X_train.shape, y_train.shape, X_test.shape, y_test.shape)

# Make sure that we have an even split for the training data
unique, counts = np.unique(y_train, return_counts=True)
print(np.asarray((unique, counts)))

#  unigram term frequency vectorizer, set minimum document frequency to 5
unigram_count_vectorizer = CountVectorizer(encoding='latin-1', binary=False, min_df=5, stop_words='english')

# fit vocabulary in training documents and transform the training documents into vectors
X_train_vec = unigram_count_vectorizer.fit_transform(X_train)

# check the size of the constructed vocabulary
print(len(unigram_count_vectorizer.vocabulary_))

# print out the first 10 items in the vocabulary
print(list(unigram_count_vectorizer.vocabulary_.items())[:10])

#vectorize the test and the train

X_test_vec = unigram_count_vectorizer.transform(X_test)
X_train_vec = unigram_count_vectorizer.transform(X_train)

# print out #examples and #features in the test set
print(X_test_vec.shape)
print(X_train_vec.shape)

# MNB

# initialize the MNB model
nb_clf= MultinomialNB()

# use the training data to train the MNB model
nb_clf.fit(X_train_vec,y_train)

# print the negative features

feature_ranks = sorted(zip(nb_clf.feature_log_prob_[0], unigram_count_vectorizer.get_feature_names_out()))
very_negative_features = feature_ranks[-10:]
print(very_negative_features)

# print the positive features

feature_ranks = sorted(zip(nb_clf.feature_log_prob_[1], unigram_count_vectorizer.get_feature_names_out()))
very_positive_features = feature_ranks[-10:]
print(very_positive_features)

#pretty print the positive and negative features for the report

feature_ranks = sorted(zip(nb_clf.feature_log_prob_[1], unigram_count_vectorizer.get_feature_names_out()))
very_positive_features = feature_ranks[-10:]
print('These are the very POSITIVE features\n\n')
print(very_positive_features)

print('\n<><><><><><><><><><><><><><><><><><><><>\n')

feature_ranks = sorted(zip(nb_clf.feature_log_prob_[0], unigram_count_vectorizer.get_feature_names_out()))
very_negative_features = feature_ranks[-10:]
print('These are the very NEGATIVE features\n\n')
print(very_negative_features)

# test the classifier on the test data set, print accuracy score

print(nb_clf.score(X_test_vec,y_test))

# print confusion matrix (row: ground truth; col: prediction)
y_pred = nb_clf.fit(X_train_vec, y_train).predict(X_test_vec)
cm=confusion_matrix(y_test, y_pred, labels=['Negative','Positive'])
print(cm)

#classification report for MNB

print(precision_score(y_test, y_pred, average=None))
print(recall_score(y_test, y_pred, average=None))
target_names = ['Negative','Positive']
print(classification_report(y_test, y_pred, target_names=target_names))

# Error count for Positive tweets that were predicited negative

err_cnt = 0
for i in range(0, len(y_test)):
    if(y_test[i]=='Positive' and y_pred[i]=='Negative'):
        #print(X_test[i])
        err_cnt = err_cnt+1
print("errors:", err_cnt)

# SVM Linear Kernel

# initialize the LinearSVC model
svm_clf = LinearSVC(C=1)

# use the training data to train the model
svm_clf.fit(X_train_vec,y_train)

# Posiitve and Negative Features

feature_ranks = sorted(zip(svm_clf.coef_[0], unigram_count_vectorizer.get_feature_names()))
very_positive_features = feature_ranks[-10:]
print('These are the very POSITIVE features\n\n')
print(very_positive_features)

print('\n<><><><><><><><><><><><><><><><><><><><>\n')

feature_ranks = sorted(zip(svm_clf.coef_[0], unigram_count_vectorizer.get_feature_names()))
very_negative_features = feature_ranks[:10]
print('These are the very NEGATIVE features\n\n')
print(very_negative_features)

# test the classifier on the test data set, print accuracy score

print(svm_clf.score(X_test_vec,y_test))

# print confusion matrix and classification report
y_pred = svm_clf.predict(X_test_vec)
cm=confusion_matrix(y_test, y_pred, labels=['Negative','Positive'])
print(cm)
print()

target_names = ['Negative', 'Positive']
print(classification_report(y_test, y_pred, target_names=target_names))

# Error Count

#Error Count for the SVM Linear Classifier
err_cnt = 0
for i in range(0, len(y_test)):
    if(y_test[i]=='Negative' and y_pred[i]=='Positive'):
        #print(X_test[i])
        err_cnt = err_cnt+1
print("errors:", err_cnt)

# SVM with cross vaildation

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=0)
clf = svm.SVC(kernel='linear', C=1).fit(X_train_vec, y_train)
print(clf.score(X_test_vec, y_test))

scores = cross_val_score(clf, X_test_vec, y_test, cv=5)
print(scores)
print("%0.2f accuracy with a standard deviation of %0.2f" % (scores.mean(), scores.std()))

# SVM RBF

SVM_RBF = sklearn.svm.SVC(C=10, kernel='rbf', verbose=True, gamma="auto")

# use the training data to train the model
SVM_RBF.fit(X_train_vec,y_train)

# test the classifier on the test data set, print accuracy score

SVM_RBF.score(X_test_vec,y_test)

# print confusion matrix and classification report
y_pred = SVM_RBF.predict(X_test_vec)
cm=confusion_matrix(y_test, y_pred, labels=['Negative','Positive'])
print(cm)
print()

target_names = ['Negative', 'Positive']
print(classification_report(y_test, y_pred, target_names=target_names))

#Error Count for the SVM RBF Classifier
err_cnt = 0
for i in range(0, len(y_test)):
    if(y_test[i]=='Positive' and y_pred[i]=='Negative'):
        #print(X_test[i])
        err_cnt = err_cnt+1
print("errors:", err_cnt)

# SVM Poly

SVM_POLY = sklearn.svm.SVC(C=10, kernel='poly',degree=3, gamma="auto", verbose=True)

# use the training data to train the model
SVM_POLY.fit(X_train_vec,y_train)

# test the classifier on the test data set, print accuracy score

SVM_POLY.score(X_test_vec,y_test)

# print confusion matrix and classification report
y_pred = SVM_POLY.predict(X_test_vec)
cm=confusion_matrix(y_test, y_pred, labels=['Negative','Positive'])
print(cm)
print()

target_names = ['Negative', 'Positive']
print(classification_report(y_test, y_pred, target_names=target_names))

#Error Count for the SVM Poly Classifier
err_cnt = 0
for i in range(0, len(y_test)):
    if(y_test[i]=='Negative' and y_pred[i]=='Positive'):
        #print(X_test[i])
        err_cnt = err_cnt+1
print("errors:", err_cnt)
























