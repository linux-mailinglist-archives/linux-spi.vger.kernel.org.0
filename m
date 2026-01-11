Return-Path: <linux-spi+bounces-12280-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F1D0F0C2
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 118B3302E174
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BB33F8CF;
	Sun, 11 Jan 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="A5h3J93L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919B338900
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140344; cv=none; b=YnSLd+eHLrz8LQKY47AOW4ydIB8xsm+2kTD+Epr0ui1KepS4Gl5caa9N1Q7Ag2MfNeRek7Zpo01/bId8XMdjUDiZ1MO9e9lFt7okWlYQqE7qbwt6rI2bOaf/eiApubpF+cU2/uJGoU8uqreL+ZmCYdE2Nns57mxUNmDSRtYyM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140344; c=relaxed/simple;
	bh=La7kZA2oSwRqBuL7cT5ghruILrR4PN0GG8fEmUQohxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvtP5cEU6nDnTLkc7ZkPl0NLcMJFNJ3gOlKR31ad2YZkhBfHdbWNNhnjTFlPct8b22oIIE+BTLm4k273Bv1MmXP/9GP35EKLDULO02bBMXppuTHmHRylIq7mjds/+guwxF00aCaTcYUQ48f0s4hedHiaW6MehKiQXN0InF1KH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=A5h3J93L; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8010b8f078so925387566b.0
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140340; x=1768745140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXunsOKck5NLaqPP1pj13fhYNQN15zYs+l2jwEoFO8U=;
        b=A5h3J93LIBKbImOKSk/PuMD1cA9Z5C6EZEowbXbuQQWRqoIAibYcsoDlQw3TBJfR+T
         u0BiOjCEJXktgpsZjOdLv3j4NKLAL6vWzf02hINhGw9gtNLdyMqKWd3DOyEcZSvo3jYX
         8ZK4HrP0vXDrFAoG6NVNSCZ3YaSVLqWlNr0VD2t95cLlw4Jh61dPCSWNeQ6oulesS2tN
         wj79fRG7ILgJ3A7li2jIzTbZtZZjrXs2jKlLHtMo0WNwEe++CfnFmumACmX2K4HiMsrY
         hZYR2bZ1STtKcGYBa3SuMqw2+bwsgdTMBUMyBFpULbdi1sES9VrFIvs1UBE/wqWbzzwP
         APAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140340; x=1768745140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXunsOKck5NLaqPP1pj13fhYNQN15zYs+l2jwEoFO8U=;
        b=BX23U1tcsUxGOvzpHYxC6O5a0iMymqCS2NglettT/SDRnJV17fDFY8L3/NZ8pZ8wXW
         ue/q3NHFhIYvAoWu4RWCfa3GdFnUGPfJtSXm6w6hi/mTi7t/El6ceYzb8SIam1vD3Um8
         yyXAK25BsMm8LJxuLV5gJ/JA7xJsR6dVtIOUwdD8QZX3ttCJGDAbBtSZNSqbfyxibN0m
         +XHVixqZOiMniBPW2Igi2zt8BpzLvJlXikA7J5ibUPbPirUOemoeFHlQuQ3lfb5BOxhG
         Va7vBm36ttN/NYKaJfBrbuimY7UPrcIglpSnvLue1MrPKA0D4vFx+2xmuntFvcaqEkkU
         /zOg==
X-Forwarded-Encrypted: i=1; AJvYcCUdCighvhH2gtQ+jlxTng8Kfrbkt/zaCCwFqm7T7VMaxoKwrafTM07SLDP5t+0QJ90lOYXzxsEtJO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWUTnKRQu7dul6JzriQ1BpVNRENZTSkMf5RqMdFbRW2tvsTxY
	nGp8DetZQbiE/aM40ENdmLPjRqksPxI4rvwwiX5J6hgvJcsO8E2/Tard15mzeJS4FAA=
X-Gm-Gg: AY/fxX5zArbBXHbYuuFn0Vk6iCZzpOmUXJ7HboMLjgwMqeNM0A/K4wag6B7SRx1jnt3
	cyDNCUCY50tUCrQde27QWRxkkZcK+5ovTGa1qAdeKCBTjksMKrFNo8asmnmDG1NHkdvOjnFJjlu
	5QIlAaVDAPRXMY7GjB+2H2a7xNCljHzpZwPHLUastQ4eEknZzXXop4fwydohxGqyiIBlwtDOPU5
	k3sGRfHHTuBsS6INl6dbYx6MDbmgWACKMau9S53Vtx5x8OzjX3PVLhNF+1kyp4YiWkA8ygD+1Zb
	wH/RNl+4nVRPEFM76pNxVgTdPqMFPMqMN0VOcRIlTxmgAsiZPc8ahMhn6q5ETNSuikw9EiajLx/
	HJwGbTMnm4BFqbp8E6YFyH5Opr9X/4tbaLbyPMgsW/fWJt72XKKRLBg9pFkeuaeY7SHRAq5Ug30
	nrxnJYobAk8T+90spb/YqzjPZhNNbrYVAcTw==
X-Google-Smtp-Source: AGHT+IGAomJOik8MqjiZHm7eirNShLlujIRGUrfTNhxgz3sez9ZGd+euk5Raj7DyHYRFF75x4SXADw==
X-Received: by 2002:a17:907:3fa1:b0:b87:908:9aca with SMTP id a640c23a62f3a-b870908b37bmr200612566b.9.1768140340256;
        Sun, 11 Jan 2026 06:05:40 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f1e95273sm439916866b.62.2026.01.11.06.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:05:39 -0800 (PST)
Message-ID: <05184245-9767-45ef-a4a6-d221f90fd20b@tuxon.dev>
Date: Sun, 11 Jan 2026 16:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] arm64: dts: microchip: add LAN969x support
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-14-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-14-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Add support for Microchip LAN969x switch SoC series by adding the SoC DTSI.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

