package com.example.springai.prompt.impl;

import org.springframework.stereotype.Component;

@Component
public class Chatbot implements com.example.springai.prompt.Chatbot {
  @Override
  public String buildPrompt(String input, String question) {
    return "You are a helpful and intelligent assistant.\n"
        + "You are given basic information about a user, including their user_id and a list of keywords representing their interests.\n"
        + "Your job is to answer any questions about this user as best as you can, based only on the given keywords.\n"
        + "Important:\n"
        + "- Do not make assumptions beyond the provided data.\n"
        + "- Keep the original language and remove duplicates.\n"
        + "- if keywords is [] or null, return 'Dont know about this user because there is no data'.\n"
        + "Here is the user information:\n"
        + input
        + "\n\nNow, based on the above data, answer the following question:\n"
        + question;
  }
}
