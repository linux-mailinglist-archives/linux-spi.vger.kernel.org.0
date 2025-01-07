Return-Path: <linux-spi+bounces-6237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B6A0340B
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 01:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DCA162EC9
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86226AEC;
	Tue,  7 Jan 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA2d4256"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45628691;
	Tue,  7 Jan 2025 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209870; cv=none; b=L/+sPmhUCX1hsTMX384OQBc/y6LMHIlHcBqODGcMTQ8IocufQjWhs4elYaNW6A0QGz3W7Y3nTWeloKk0ecvTAznJrgA5wr3focoaUU483LE3Zd9Jz4vF1AYeWB0lmAYSQvQn50er+ZchRflkU3i8dZs9Sus/1SU+jEvj3WQsrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209870; c=relaxed/simple;
	bh=SHfW5fyQnsmaHFVn7BkPlpsP4nzQ8xdy+QhdGX+cakw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGXZ+BTy658WrqRPjA1/Lpvv8F873AvG5YtwzNptrsM9cAjVUE9dBXM+fZIMPnBF4oN6RL8gctf5V4z01w3r4RFUfTLgARDEsuziGFj/etsy6FfAKvJL+BIQPdkWK4ScY28bpKf6vLMU1BkSgnicPxmDp37bBfD/1byFmrTB8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA2d4256; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e0e224cbso7446964f8f.2;
        Mon, 06 Jan 2025 16:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736209866; x=1736814666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13VUHaFiuc4bXuLa2863YA1rYhMMosunQcKMEn7ZyfQ=;
        b=IA2d4256Q0C5c4t6vKeIT9I9qu5t5L+LTkqtfKX1W7z9/Akl247tflxb2FE3e1Ech/
         dkgIYonDN/UU+hdAItMuoUturYvaFf9SZhN1jr/uVAMRGX4covbbNcdvWq4UGq5//9Xa
         Hjje2X4LXf0hNktDf+5f/5jK1GQzMqlfm43Zy7aWjAivwgdwXwv4K8wmnIPO7B+S3qxt
         +EFbHfBpNJv4F0FBm9z8+qpJeW6Od7ZXNfEVrybqN9Oux+SV2CQEccVC4LMTuMt5hy5L
         vnyewjKwceUattdjYRDFxPkMP0aciYRawoesXTE+vo+jeqtVy1JwADD0Df7sxKJaya/J
         PrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736209866; x=1736814666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13VUHaFiuc4bXuLa2863YA1rYhMMosunQcKMEn7ZyfQ=;
        b=V6OcDIvFR35l2oaGRf86+jDZayIGX8ZUXOjsCGlAtpLHH6tqqQwNvS8jmMfcjAt/x6
         2tXsMxX0R6WAKsSEr6XB78EgcgtdG4drQssNtw8+I/PRmWHt6F0Mer8rfZagvysYy06B
         0jn82Y/WYb+HP8WoASncRD1ewlL4gMFWnvF07bsQ0u5Cyb1ABWkRNv3zwLeih014CCNQ
         KagKVVIq1tr3xlRHomO333yaWNAD72/1/u0kMyKRR5v2YWYlIMp0wVtUaNhKxMzvEzOC
         KkFNBrT1u7a2Adeb+ertUNGUmYTVy8xWnkUrgsL9rFU7eoMzPkroSHfAy3JSAQwtbUUG
         FGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2cJNvSyX8VrA6LKxH8mtVD0Fg/uyW3ECzFgEMW24XZUN9XRDWpfAKQ8m5PsoAUlatywRpzdLRuQI=@vger.kernel.org, AJvYcCUXPbKrQ69wBE+N+sbbn4r9NRlr907CNQxoxZJGNHBaOO2qUu3HRPh/UEuxNjr7CWZWw2oHEIYm@vger.kernel.org, AJvYcCUXuHks+LHijPNesFPLJ8SIl4xk5YW4QOW++C0EkdTP5E5DYU4KP0zZFDwH69fa7g9krsxlIDHzTnXE@vger.kernel.org, AJvYcCW5RD5jHtIBqLVJ0lcQhRYvLov5CINNHnZvQD+HpSeUN7y0suyI+6l+tq9i/a9C74otPjQl4+lDTNJk@vger.kernel.org, AJvYcCWYYLsIaLXwKQ385NJKdRxcQRu4cRNcLdGUjkhY2oMd5AWGvDI098LzCEYOR+HlJ3TPIHArJ1TKs+tkbjXX@vger.kernel.org, AJvYcCWcdkTqyWkR3IH89b8LRfFwC6vWtQB91CTTMuV3A6YvD2sLROMSbumsWEOYYlxa6X3wrDQ1iLccEV1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkBNr8SaNA2NTl/jw+Da9rrcbk/zYI///NXSr+fVj4d42p7HP
	hWze6BBinOLUK2IZjwwBdT1ajPvQmsw28QVM0S0pgpZgx2ZAbFnE
X-Gm-Gg: ASbGncsn6HkZU/Uxwr/8ldpy9KN0P8htE0uQ7Kbqo7B1RQQwFIQLC4QdxeDRyThSZRM
	/YAav/Auo584jNaVNaFI8BqVEqpigu186nddZ1ruX7qKLDdt2imxy6r/5eZe5zhr4JNuiXGs2t6
	fJHWU5wbGJkQ/Q4NWVSpghzK2i7hvbYVdEQRQkk/EKxQP+PHmYru54Vs2IG5ATEstHkN0JZRzQK
	Y+aCnK/8YV0eUvHqvmdL5YojDoY5/akDDt7AQG6lyntgQEtK27lqyLIPFq534RQ9iozzOViYXoK
	WxMFNoMZZe5lKz5qODzkQZbedQ==
X-Google-Smtp-Source: AGHT+IEjONcU9x6JlzHrNOCRfapdijI2K0K3jjBIXQvsC6vlMArfJXHA/sc0RSHKNgKkvauw85ENXQ==
X-Received: by 2002:a5d:6da1:0:b0:386:4a0c:fe17 with SMTP id ffacd0b85a97d-38a2220039fmr49166964f8f.27.1736209865801;
        Mon, 06 Jan 2025 16:31:05 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8471dcsm49320901f8f.48.2025.01.06.16.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 16:31:05 -0800 (PST)
Message-ID: <810af0b9-aa21-4f11-9708-92c870615cc8@gmail.com>
Date: Tue, 7 Jan 2025 01:31:02 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
To: Mark Brown <broonie@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-spi@vger.kernel.org
References: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
 <eec9caa0-0029-4774-842e-af1d1290ad97@sirena.org.uk>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <eec9caa0-0029-4774-842e-af1d1290ad97@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/01/2025 à 14:08, Mark Brown a écrit :
> On Sun, Dec 29, 2024 at 12:32:39AM +0100, Raphael Gallais-Pou wrote:
>> Prevent the use of macros, and rely instead on kernel configuration for
>> power management.
>>
>> This series makes the same change over six different drivers:
>> usb-st-dwc3, sdhci-st, st-spi-fsm, ahci_st, sti-dwmac, spi-st.
> 
> Is there any actual interaction between these changes?  In general you
> shouldn't combine patches for multiple subsystems into a single series
> unless there's some dependency or other interaction since it just
> complicates management of the patches.

Hi,

No, there isn't apart from the fact that those are stm32 drivers. As 
Miquel also stated a few days ago, is was wrong for me to sent all of 
this in a whole serie. I will just resend them separately as a v2, 
taking into account Miquel's review[1] and the kernel robot.

Regards,
Raphaël


[1] https://lore.kernel.org/lkml/877c7ha77n.fsf@bootlin.com/

