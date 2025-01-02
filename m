Return-Path: <linux-spi+bounces-6205-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696F89FF86B
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2025 11:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF6160D80
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2025 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B51A8F71;
	Thu,  2 Jan 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X1hbv+CW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D917C68
	for <linux-spi@vger.kernel.org>; Thu,  2 Jan 2025 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735815142; cv=none; b=Tzmoxi24IvgwQgv8nip/1E5lKsfuB0tZE0lK9+bhgz35UkAK85PinhJ2qDMXbvAksp8Y3caOQNR8tdwyh4pmaiUfL/1163L9gX5zNSY4xM/zLAKKjBNzfEQCQW3GYwhSMc3DklGXpaTNolEXG+O+Lonbx02tqY2L9kV957Zjl28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735815142; c=relaxed/simple;
	bh=mMF/3PAWbT4cwYrfbRt7SNtYsxbQwYPfM12nGDJoqPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVPgrXJ4jhVo7BByNo9jAPI+LpxgjMuDJ67+gIDLl1wJJKT1VHlEbi6mVN4D5Y4Ca1MLkEAODTQXBHZKWE6PNcN2daSTnProMA7UvAK+fE+rpCAzLNqlz+VbyWFDMqgRjN8jJFYdVEUb1pchLXsAO+0LCz1d//mVzO/js8fJypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X1hbv+CW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e06af753so5712575f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 02 Jan 2025 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735815139; x=1736419939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ze9LqpjCGSWa0yPDrI54f/7UaaRjSHcJ6CR6aCivtOE=;
        b=X1hbv+CW1mIXR5inMbIRSMeXu/iV+kika7xeuUAOOc8Pkj93e35QOzK2BTqlo9rkB2
         RzdHFjnLfrc+iu2Fnh95De/rfhyxa+S2od0M4ya4jmKc+3yOnguowXtB7ze/BfM7isYa
         1Pea5NJgMQSJfZs/yE/VahCSiqq1qRkPGZmaoaaEM3go+p0yh9aamPbIQDfpHJ2VN6lx
         3qeHQowwLBkOlN/2rmEVHPOtblNIoI3zN3Y0obd8TjBN5F8adYUPZoxLBJGjbzkOlXRH
         5eHJ6o8lkPYKCuK2NXcoXSm1ajMVv2XlO8+FxA7Hhd7eZKr+jGxO6f1drnVJWpW9+RKu
         73eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735815139; x=1736419939;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ze9LqpjCGSWa0yPDrI54f/7UaaRjSHcJ6CR6aCivtOE=;
        b=Scuqlwk5+C/6y7v9ifnrtx7KUZOlGb5pLuHxNEAgcNJnIFeIPT0s2kIsXECUYQTnjB
         FQhaya9S4fwPZY88uHngKiWL40ccq1OoGG7xPlCZ1B75aV6ufRYNW7ClLrvb80DANrMB
         qlQGr11Ejw8EqUELt/tUtNyMvsxhzgsaS/JEOd1sR42wblxNjI8cmH7w8lbcn+8trH9e
         zjgI+8R2kHIsie+JS8NRDKHKr9bjlcxIiz9ekWCS4hoMjHTUoKpJAsteS1VdjB5xPCOI
         yVL0EHLU6HqDdJOKX50+EflFm85PsjDk17z3XD950xiIOiVICZJcIJP3sh9KqrTzbCTI
         AV/A==
X-Forwarded-Encrypted: i=1; AJvYcCW/NltwUUQS82zLG948yvoPA/5XHBPzXfIq18L2KGCa9V9Rg15VXwvR8pg/ncPUYzlMTD6JCNAnlK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRuBNLEV8HwnEq08OOl8MQD46c65S0f+9ssaqg7xhqIRzUHsG
	tHkKjVWyc4MJBssD+VMN0n4zAXOJDyxYejBnpBsaLfzws2uJqE4QrMmeXMTuRjk=
X-Gm-Gg: ASbGncsRE0Zw834NDu2L8MJov8JdaAuA4wOrAYbi3+0ziOeFUbstUJ0+91uq0v2RLEc
	rUeaTC4KZ0BDd+5gVKiahCmcAVkNUwZqPxuoyrPE9oXUxKL26w79IKkXHyL97LCEVBqxVo5N/lu
	r3sZUMJh9HvSJHSzpTzSUwOhnbmk+peIw56oEJHobMnld+RLxCRIzEJA72ZPReUerLDn4JZy9cv
	Veg7Nv4ogzw47usGQrGJLPkXLvMUpSW/i3sE+Tw8AYN6v2YhlmI/ujgVn5Gd9dtYA==
X-Google-Smtp-Source: AGHT+IEAXmh4Jm/fooPniPUd+cP6NsbK2SR6lviu3UydjCwVbdG5V5GA3GQCHI+v0JTIHRvlmZHUzQ==
X-Received: by 2002:adf:ab0a:0:b0:38a:50fa:d582 with SMTP id ffacd0b85a97d-38a50faf3cemr11500112f8f.59.1735815139109;
        Thu, 02 Jan 2025 02:52:19 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b295sm490098515e9.33.2025.01.02.02.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 02:52:18 -0800 (PST)
Message-ID: <70aab1bc-1427-44ed-b516-843429d0bdfa@tuxon.dev>
Date: Thu, 2 Jan 2025 12:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] ARM: dts: microchip: add sama7d65 SoC DT
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <cover.1734723585.git.Ryan.Wanner@microchip.com>
 <3f63aebc4b31da1b631ce7e6d76aa0046deeda6a.1734723585.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <3f63aebc4b31da1b631ce7e6d76aa0046deeda6a.1734723585.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 20.12.2024 23:07, Ryan.Wanner@microchip.com wrote:
> +		pioa: pinctrl@e0014000 {
> +			compatible = "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl";

Please also update the documentation with the fallback.

> +			reg = <0xe0014000 0x800>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +


