Return-Path: <linux-spi+bounces-6258-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C5A0581C
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2025 11:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7EE1886A3F
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2025 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DED1F76CD;
	Wed,  8 Jan 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="JyNJPPs3"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28EC1A76BC;
	Wed,  8 Jan 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331981; cv=none; b=tpe4//BqoIiPUG2p4cqMZGTGlTwDiJnGTBWlDMta6PnvzjmnpHGW0MnRhuHLYT+jW2Nl/TNdtSPBPccPWwWEadEPeEBNTBb9UaROzbuZqoFEIX3uHo+dIniUnQ2J4qXvew/GTpX/pSVDXMAdDIrU8+hLuN+Avm7uCIJE9BqAC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331981; c=relaxed/simple;
	bh=chijzTtaQDYSe59Qk/cEIUSToILH++h6HTHM/pUexJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qMXMQlruZHMK7rQlNl215KbZkuEoxOgkick+7eQDkN6FPnn85ZbfQdLRtxz4zVq9Q0muy7aLf9ET2Mt1SP+eZ3qfGGymKafzuF+BquXgJZmJNwXFby9kNHEX+lxtRyHIDJuZ6C/US2WCoJWxZGcHEuZURo6PqHXK5xl9lchtqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=JyNJPPs3; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1CD3BA06F4;
	Wed,  8 Jan 2025 11:26:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=5k6M2RuQIS/K7VktQVPX
	xrJUmMz72+TB1VtxOat357I=; b=JyNJPPs3zEuh0sZ8darPvT07MFmECxotMthI
	6qQY48cXktxSc03R5ghM43yaPX2TUhz0Buxqaqwv2P7FYUGj9mWCeOcGdPReYbYW
	g76qpLBmygMY7DzhKqwNvz9Qd/jNQNIIkB2aGpRbRpGONHMixFgEraWzA/Yx2FYp
	9JGez52O8UcMCVEA4ReyrR38L9ASldD1RtpUklYNo6DOny52tRJTVXt2MYtDWOh6
	9SAeZT+DfJqSRLVqf2aRCI0JNIniwFJRcfeEoIra8QpXpJgN+YxekPuKBwnaU+Gc
	/l75p6iXCtgvTUhnHqqxlpMX5VmMvmu7MSle5wGpcPj7YGD9EmDV2fuFvZaXme+8
	gjJi11Bd5gDQtAh1USjp0q1TmBbGfRkqhCI+XBD0RQB7aBhvb5mi2vvHNQZscK4N
	rR31rfdAvZezqtWW70lj8YEm57NSVRX4mjDRLbmWtV1i3DGc+uNOTMID4r0GvdCo
	3ubOmCL8eTnpncSPOhwcUJFuLxXl2S5hrRz4pWd+f0+vm2qbUdCVJbRz9XlhAGhX
	Siy3uaYOiwS+XuDkhNZqAHYo6N6hudF87/vjMVeVSh573/uV/8AlSC0A2E98fWPt
	jJbQIzuXFXN5WK0tUkDzt9uYEP1GStzT1kioGCOWZ2LwT7t7Zaf8B7YnJ/X71hJk
	ZVDGqZU=
Message-ID: <192e97dd-698a-4434-bd32-c1181ec85ba3@prolan.hu>
Date: Wed, 8 Jan 2025 11:26:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] gpio: 74HC595 / 74x164 shift register improvements
To: Bartosz Golaszewski <brgl@bgdev.pl>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?J=2E_Neusch=C3=A4fer?=
	<j.ne@posteo.net>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	<linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-spi
	<linux-spi@vger.kernel.org>
References: <20241224-gpio74-v2-0-bbcf14183191@posteo.net>
 <173593634037.257292.1488097273042214180.b4-ty@linaro.org>
 <CAMuHMdUqvTrSsiGuJ=VvNqsQm4eQs9rNTU8VBg+FzHJZxRnXow@mail.gmail.com>
 <CAMRc=McAm3A1movK-8q67UbKuPb8FQzVwD_me7Q6x-gei2PA_A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAMRc=McAm3A1movK-8q67UbKuPb8FQzVwD_me7Q6x-gei2PA_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852657267

Hi all,

On 2025. 01. 06. 21:16, Bartosz Golaszewski wrote:
> On Mon, Jan 6, 2025 at 10:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Do we really need to document and add driver support for all variants?
>> I can easily come up with a list of tens or perhaps even hundreds
>> of xx74yy595z parts that are all compatible, as far as software is
>> concerned.  As SPI was invented by Motorola, the original part is
>> probably named MC74595 or MC74LS595 (yes, ON Semiconductor bought the
>> logic division of Motorola).

I second this, no point of having a new compatible which is a guaranteed 
1:1 equivalent of an already existing one. Especially true if the only 
change was that a different company bought the IP. By the same logic, I 
could start to sumbit patches to change all `fsl,` compatible-s to 
`nxp,`; `atmel,`, `maxim,`, `smsc,` etc. to `microchip,`; `ralink,` to 
`mediatek,` and so on. There would be no end.

>> Perhaps we need a separate vendor prefix for the 74xx-series[1]?

I don't think that is the case. Rather, we should document that the 
existing binding/compatible should be used for all such simple cases (it 
is called _compatible_ for a reason, after all, and not 
`exact-part-number`).

>> The xx-prefix and z-suffix don't matter; the yy-infix for semiconductor
>> technology rarely matters (there are a few exceptions, though, mostly
>> pinout, which doesn't matter for software).
>>
> 
> I missed the fact that Rob actually responded to patch 1/3 with a
> similar suggestion (fallback, instead of a full compatible).
> 
> I can drop this series from my queue if it needs more rework.

I think you can keep 3/3 (the one commenting the use of `latch` as CS). 
The rest can be replaced by another commit commenting on what it means 
to be `fairchild,74hc595`:

* tri-state output
* 8-bit output
* OE pin (or latch or whatever it happens to be called in their chosen 
manufacturer's datasheet)
* SRCLR does not seem to be used by the driver, so we can probably skip 
that...

And telling people NOT to add a new compatible if their part satisfies 
these.

Bence


