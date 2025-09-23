Return-Path: <linux-spi+bounces-10240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E950DB95DF6
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 14:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CE07A72D1
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACB322744;
	Tue, 23 Sep 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="d+7ZPkiB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2A323F54
	for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631775; cv=none; b=PA/ciXn9G36iHBh4tAS3EanuMGljBpN9omE3aVKdZep+yf/mfMC4gagoqt9biu6CLhpOY4B3LPJb3kZeDm/LvQGmBl9WFyLNuVTuHW6PpomxvTL/zlh1ItTGIWABXftT0/JA3gkfY3bzRTW5SdyEQQdov6ZS3U1mqzTw/ctr/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631775; c=relaxed/simple;
	bh=Ei+PU69PWQYEnmv17igHh8EAMnD/1dEdiAdwbRSfJ3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQwgtRryG4vnY0cZNDKIaIc/xO+cxz0rTej+v4g3XGBz93mUd9EbSIX1X/1UhD5A2JppmjP1kZIJzChFN7yNFtoP4hdpVtBRFY9KKauH8psqX+tJbaeiRBPzC47iBVSDcWgA59tvOAGikvlA2eiS9+tMe9QgTBG+UzvyUKcGD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=d+7ZPkiB; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8a72cb31fabso46428239f.1
        for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758631771; x=1759236571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=waPoQEusBLXFr5L4eEB+vbwGGd0bLGE9s1F+Tc6/eDg=;
        b=d+7ZPkiBMZt4vQZbpfPvVZPE5LZxBjcYXQV6SzfvQRQ4iJMqlzBsq2HWVNGrhbMQEN
         olY7KTvoS9aNqDzzDvchQOjiGR41bmBVMxKN74R0p63aVBIsPyXL57SJhZ8qrQUzotED
         zdI+cZZqHxPm3TSsHhyqKcMHtxi/863Y+IdWzjXeVAa15U3usDkLuhUqOOO6cGzQsFJI
         u7ZsT0eOnf3IwVBGLkFVX240b+/eT2rFb2Du29tYxtw+B5pC4QezjyE0EYJweJGhMbs8
         LrFKemVz8/LQEBQSGlZqnUs0gQRGRTfX6pIaPmuQOC8ykYeqkQKButXIjCf9uXrSR6tx
         Pu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631771; x=1759236571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waPoQEusBLXFr5L4eEB+vbwGGd0bLGE9s1F+Tc6/eDg=;
        b=WvyM3eWLSNmCDGfLKzATGAevvQ+mhPbiTOSMN2OkLsi41LYPOW/rdxDS2pRVicMOS0
         gzwV+Yn64KKJxQaP/gDk7sOUujDgVpBHKJZFJO4IrHRrTpUd+XcBdq4XegSxt51iW2H5
         ns0TJ6gRMlZ9sTs64oy0UfUKY4mM0pMPgciCCCf/vP7A3SmRjAn3SA8t7xPiSSoQB88v
         mLpMkPBVNe275ULO0gL/h8Kv7Hjd+kkIVWegg9/2dH+x6yHlOLo9w/gdcTqoffHGvPuv
         aM4muT2wgd573nGqh674K3vrFnsvZAudElTm0qqX596dApUPgaR3pU8XUm7kghveDld5
         9TDw==
X-Forwarded-Encrypted: i=1; AJvYcCUP7A8o2/+mmSelvSgWWjAMl4kbm5H+SG7QcnZ/q/Ws4FF6r+pptW2W7/KU4brBL/cXfWBJ+8WGrQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnOMD1cAR89fp7jcP3+OP7MPd7DRhrrjZ95AB8sHVpsadHe1M
	33/xql+UxlpXu8HnxsTlkhw1xnwRsar474zA5koCl81IoQW2PtkMjniVZct8lOMzhU5XtCqpzZ2
	P2aQ7
X-Gm-Gg: ASbGncsJ35xJvkRHts+7iVulPJm0vy/e87EhTtCQt0/kbjkKR12LNo7YE6NWVliTdFf
	DkrMA1APLaijZWbcY6Mp95YV+qPuopa4yu+4jwsyVfmEptrKLqyQ6rhUebwTAdwbog0p4MtS5pM
	oO7CriUq14TQoBZzRlxngghUrgiFmmyoXvJ4hdX2d5tKSryUb2sKwBnkHHnQFmVrOBrmgcGruha
	Qd6RhSgm4F6NSR586ptsAZs8EIhAX1OMFG/JhbjLKjqw1da2SB3GsbkD0qWrTAkkMLnOG409hVO
	1OroisK8aUpLX2aeUnFxqzcgCdUqVjmPsNJrfg2sbFcSqvH2SbL47ZyA1gwC4hbtdHJTkDHQ1W8
	hhmztqA6j/v++qkNA3FlNKMZXQk/ruJc0MFCb9D9h0w7OmPARzQzDA0LKpWnLyg==
X-Google-Smtp-Source: AGHT+IGpn78bpHsCcVyT6ZTPrazok3rGvE1esop28BxCS5HsGV4C6tLow/zSSA+i8GZpHEaTZ2FBYA==
X-Received: by 2002:a05:6e02:480a:b0:424:4bc:4b33 with SMTP id e9e14a558f8ab-4258229353amr31444535ab.1.1758631771380;
        Tue, 23 Sep 2025 05:49:31 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-556f74174cfsm3556602173.57.2025.09.23.05.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:49:31 -0700 (PDT)
Message-ID: <83c5e504-facb-47a8-a9ba-f85097416484@riscstar.com>
Date: Tue, 23 Sep 2025 07:49:30 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-4-elder@riscstar.com>
 <20250923001930-GYB1303776@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250923001930-GYB1303776@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 7:19 PM, Yixun Lan wrote:
> Hi Alex,
> 
> On 11:17 Mon 22 Sep     , Alex Elder wrote:
>> Define a node for the fourth SoC SPI controller (number 3) on
>> the SpacemiT K1 SoC.
>>
>> Enable it on the Banana Pi BPI-F3 board, which exposes this feature
>> via its GPIO block:
>>    GPIO PIN 19:  MOSI
>>    GPIO PIN 21:  MISO
>>    GPIO PIN 23:  SCLK
>>    GPIO PIN 24:  SS (inverted)
>>
>> Define pincontrol configurations for the pins as used on that board.
>>
>> (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v3: - Moved the SPI controller into the dma-bus memory region
>>
>>   .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
>>   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
>>   arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++++++++++++
>>   3 files changed, 43 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> index 2aaaff77831e1..d9d865fbe320e 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> @@ -14,6 +14,7 @@ aliases {
>>   		ethernet0 = &eth0;
>>   		ethernet1 = &eth1;
>>   		serial0 = &uart0;
>> +		spi3 = &spi3;
>>   	};
>>   
>>   	chosen {
>> @@ -92,6 +93,12 @@ &pdma {
>>   	status = "okay";
>>   };
>>   
>> +&spi3 {
>> +	pinctrl-0 = <&ssp3_0_cfg>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};
>> +
>>   &uart0 {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&uart0_2_cfg>;
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> index aff19c86d5ff3..205c201a3005c 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> @@ -76,4 +76,24 @@ pwm14-1-pins {
>>   			drive-strength = <32>;
>>   		};
>>   	};
>> +
>> +	ssp3_0_cfg: ssp3-0-cfg {
> ..
>> +		ssp3-0-no-pull-pins {
> I'd prefer not to enforce "pull" info inside the name, you can't embed
> all property info, besides, what's if you want to change/override later?
> 
> how about just name it as ssp3-0-defaul-pins or simply ssp3-0-pins?

I should have looked more closely at this before I sent it out
for review; sorry about that.

Yes I agree with you, ssp-0-pins and ssp3-0-frm-pins would be
better.

> 
>> +			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
>> +				 <K1_PADCONF(77, 2)>,	/* MOSI  */
>> +				 <K1_PADCONF(78, 2)>;	/* MISO */
>> +
>> +			bias-disable;
>> +			drive-strength = <19>;
>> +			power-source = <3300>;
>> +		};
>> +
>> +		ssp3-0-frm-pins {
>> +			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
>> +
>> +			bias-pull-up = <0>;
>> +			drive-strength = <19>;
>> +			power-source = <3300>;
>> +		};
>> +	};
>>   };
>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> index 6cdcd80a7c83b..eb8a14dd72ea4 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -797,6 +797,22 @@ uart9: serial@d4017800 {
>>   				status = "disabled";
>>   			};
>>   
>> +			spi3: spi@d401c000 {
>> +				compatible = "spacemit,k1-spi";
>> +				reg = <0x0 0xd401c000 0x0 0x30>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				clocks = <&syscon_apbc CLK_SSP3>,
>> +					 <&syscon_apbc CLK_SSP3_BUS>;
>> +				clock-names = "core", "bus";
>> +				resets = <&syscon_apbc RESET_SSP3>;
>> +				interrupts = <55>;
> ..
>> +				dmas = <&pdma 20>,
>> +				       <&pdma 19>;
> can we also squash the dmas into one line? but, do split if there are too many..
> 
> yes, it's simply a style change that I'd like to keep them consistent at DT level,
> besides you might also want to adjust dt-binding examples to align with them here..

Yes I'll do that.  Thanks for the review.

					-Alex

> thanks
> 
>> +				dma-names = "rx", "tx";
>> +				status = "disabled";
>> +			};
>> +
>>   			/* sec_uart1: 0xf0612000, not available from Linux */
>>   		};
>>   
>> -- 
>> 2.48.1
>>
>>
> 


