![Workflow](https://github.com/projectcypress/promoting-interoperability-test-artifacts/blob/867ceae3e7604fd3a457bd1fad702c5ce0ce1f39/exports/who_data/WHO_AUDIT_L2.png)
--------------------------------------------------------------------------------------------------------------------------------------------
# STEP 1: Consider Alcohol Pre-Screen

### Inclusion:
<pre>
Patient is >= 18 years old
</pre>

### Exclusion:
<pre>
Evidence of alcohol screening in the past 12 months (final, amended, corrected)
    AND NOT
    Pregnant (active, recurring)
    OR Pregnancy Observation in the past 42 weeks (final, amended, corrected)
OR
    Evidence of alcohol screening in the past three months
    AND
        Pregnancy (active/recurring) with onset date BEFORE screening
        OR Pregnancy (active/recurring) with recorded date BEFORE screening
        OR Pregnancy observation (final, amended, corrected) in past 42 weeks
        OR Pregnancy (active/recurring)
OR
   AUD (active, recurrence, relapse)
</pre>

### Interventions and Actions:
<pre>
- Introduce the purpose of alcohol use screening
- Display the Alcohol Pre-Screen (PS) Question: Do you sometimes drink beer, wine, or other alcoholic beverages?
- Display the standard drink size graphic
- Record and display the response to the alcohol pre-screen question
</pre>

--------------------------------------------------------------------------------------------------------------------------------------------
# STEP 2: Consider (WHO) AUDIT-C Screening: 

## LOGIC PATH #1 (continue screening):

### Inclusion:
<pre>
Patient is >= 18 years old
AND most recent Alcohol PS Question response is 'YES'
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
</pre>

### Interventions and Actions:
<pre>
- Display (WHO) AUDIT-C screening instructions
- Display U.S. standard drink size graphic
- Display Question #1 of the (WHO) AUDIT-C
- Record and display the response to Question #1
</pre>

----------------------------------------------------------------------
## LOGIC PATH #2 (stop screening):

### Inclusion:
<pre>
Patient is >= 18 years old
AND most recent Alcohol PS Question response is 'NO'
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
</pre>

### Interventions and Actions:
<pre>
- End screening
</pre>

--------------------------------------------------------------------------------------------------------------------------------------------
# STEP 3: Consider administering Question #2  and Question #3  of the (WHO) AUDIT-C: 

## LOGIC PATH #1: Continue screening for women, men > 65 y.o., or individuals whose sex at birth is unknown:

### Inclusion:
<pre>
Patient is >= 18 years old
AND most recent Alcohol PS Question response is 'YES'
AND NOT most recent (WHO) AUDIT-C Question #1 response is 'Never'
AND
     Female
     OR Male > 65 years old
     OR Sex at birth is unknown
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
</pre>

### Interventions and Actions:
<pre>
- Continue to display (WHO) AUDIT-C screening instructions
- Continue to display U.S. standard drink size graphic
- Display Question #2 and Question #3 of the (WHO) AUDIT-C (Question #3 = How often do you have four or more drinks on one occasion?)
- Record and display the response to Question #2  and Question #3
- Calculate (WHO) AUDIT-C score
- Record and display (WHO) AUDIT-C score
</pre>

----------------------------------------------------------------------
## LOGIC PATH #2: Continue screening for men <= 65:

### Inclusion:
<pre>
Patient is >= 18 years old
AND most recent Alcohol PS Question response is 'YES'
AND NOT most recent (WHO) AUDIT-C Question #1 response is 'Never'
AND Male <= 65 years old
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
</pre>

### Interventions and Actions:
<pre>
- Continue to display (WHO) AUDIT-C screening instructions
- Continue to display standard drink size graphic
- Display Question #2  and Question #3 of the (WHO) AUDIT-C (Question #3 = How often do you have five or more drinks on one occasion?)
- Record and display responses to Question #2 and Question #3
- Calculate (WHO) AUDIT-C score
- Record and display (WHO) AUDIT-C score
</pre>

--------------------------------------------------------------------------------------------------------------------------------------------
# STEP 4: Consider presenting Question #9 and Question #10 of the (WHO) AUDIT when not administering the full (WHO) AUDIT: 

## LOGIC PATH #1: Jump from Question #1 to Question #9 & Question #10 OR jump from end of (WHO) AUDIT-C to Question #9 & Question #10:

### Inclusion:
<pre>
Patient is >= 18 years old
AND most recent Alcohol PS Question response is 'YES'
AND
     Most recent (WHO) AUDIT-C Question #1 response is 'Never'
OR
     Most recent (WHO) AUDIT-C Question #1 score < 3
     AND most recent (WHO) AUDIT-C Question #2 score = 0
     AND most recent (WHO) AUDIT-C Question #3 score = 0
     AND
           Female
          OR Sex at birth is unknown
          Male > 65 years old 
 OR   
      Most recent (WHO) AUDIT-C Question #1 score < 4
      AND most recent (WHO) AUDIT-C Question #2 score = 0
      AND most recent (WHO) AUDIT-C Question #3 score = 0
      AND Male
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
</pre>

### Interventions and Actions:
<pre>
- Display Question #9 & Question #10 of the (WHO) AUDIT
- Record and display responses to Question #9 & Question #10  of the (WHO) AUDIT
</pre>

--------------------------------------------------------------------------------------------------------------------------------------------
# STEP 5: Consider additional screening: 

## LOGIC PATH #1: Provide full (WHO) AUDIT:

### Inclusion:
<pre>
Patient is >= 18 years old
AND most recent Alcohol PS Question Response is 'YES'
AND NOT most recent (WHO) AUDIT-C Q1 response is 'Never'
AND most recent (WHO) AUDIT-C score >=3
     AND Female
     OR Male > 65 years old
     OR Sex at birth is unknown
OR most recent (WHO) AUDIT-C score >=4 AND Male <=65 years old
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
</pre>

### Interventions and Actions:
<pre>
- Display Question #4-Question #10 of the (WHO) AUDIT
- Record and display responses to Question #4-Question #10 of the (WHO) AUDIT
- Calculate score of (WHO) AUDIT
- Record score of (WHO) AUDIT
</pre>

--------------------------------------------------------------------------------------------------------------------------------------------
# STEP 6: Consider pregnancy status: 

## LOGIC PATH #1: Post (WHO) AUDIT Questions #1, #9, and #10:

### Inclusion:
<pre>
Patient is >= 18 years old and < 50 years old
AND Female
AND most recent (WHO) AUDIT-C Question #1 response is 'Never'
AND most recent response to (WHO) AUDIT Question #9 and #10 is present
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
AND Pregnant (active, recurring)
    OR Pregnancy Observation in past 42 weeks (final, amended, corrected)
    OR Hysterectomy (completed)
</pre>

### Interventions and Actions:
<pre>
- Display 'Pregnancy Question'  (i.e., Are you pregnant or trying to become pregnant?)
- Record and display 'Pregnancy Question' response
</pre>

----------------------------------------------------------------------
## LOGIC PATH #2: Post (WHO) AUDIT-C (with or without responses to Question #9 and Question #10):

### Inclusion:
<pre>
Patient is >= 18 years old and < 50 years old
AND Female
AND Most recent (WHO) AUDIT-C score < 3
AND
        Most recent (WHO) AUDIT-C Question #2 score >  0
        OR Most recent (WHO) AUDIT -C Question #3 score > 0
OR
     Most recent (WHO) AUDIT Question #2 score = 0
     AND most recent (WHO) AUDIT Question #3 score = 0
     AND most recent response to (WHO) AUDIT Question #9 and #10
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
AND Pregnant (active, recurring)
    OR Pregnancy Observation in past 42 weeks (final, amended, corrected)
    OR Hysterectomy (completed)
</pre>

### Interventions and Actions:
<pre>
- Display 'Pregnancy Question'  (i.e., Are you pregnant or trying to become pregnant?)
- Record and display 'Pregnancy Question' response
</pre>

----------------------------------------------------------------------
## LOGIC PATH #3: Post the full (WHO) AUDIT:

### Inclusion:
<pre>
Patient is >= 18 years old and < 50 years old
AND Female
AND most recent (WHO) AUDIT score >=3
</pre>

### Exclusion:
<pre>
Carry over exclusions from Step 1
AND Pregnant (active, recurring)
    OR Pregnancy Observation in past 42 weeks (final, amended, corrected)
    OR Hysterectomy (completed)
</pre>

### Interventions and Actions:
<pre>
- Display 'Pregnancy Question'
- Record and display 'Pregnancy Question;' response
</pre>
