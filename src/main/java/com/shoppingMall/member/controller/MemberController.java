package com.shoppingMall.member.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.member.vo.MemberVO;

public interface MemberController {

	public String loginForm(HttpServletRequest request, HttpServletResponse response,Model model) throws Exception;
	public ModelAndView login(@ModelAttribute("membervo") MemberVO membervo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView signUp(@ModelAttribute("membervo") MemberVO membervo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String idCheck(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView showInfo(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String pwCheck(@ModelAttribute("membervo") MemberVO membervo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateMyInfo(@RequestParam Map<String, String> info, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String signOut(HttpSession session, HttpServletResponse response)throws Exception;
}
