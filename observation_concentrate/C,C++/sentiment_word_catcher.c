#include <stdio.h>
#include <string.h>

char* positiveWords[] = {"good", "great", "excellent", "happy", "joyful"};
char* negativeWords[] = {"bad", "worst", "terrible", "sad", "angry"};

char* categorizeSentence(char *sentence) {
    int posCount = 0, negCount = 0;
    for(int i = 0; i < sizeof(positiveWords) / sizeof(char*); i++) {
        if(strstr(sentence, positiveWords[i]) != NULL) {
            posCount++;
        }
    }
    for(int j = 0; j < sizeof(negativeWords) / sizeof(char*); j++) {
        if(strstr(sentence, negativeWords[j]) != NULL) {
            negCount++;
        }
    }
    if(posCount > negCount) {
        return "Positive";
    } else if(negCount > posCount) {
        return "Negative";
    } else {
        return "Neutral";
    }
}

int main() {
    char sentence[256];
    printf("Enter a sentence: ");
    fgets(sentence, 256, stdin);
    printf("The sentence is categorized as: %s\n", categorizeSentence(sentence));
    return 0;
}