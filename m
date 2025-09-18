Return-Path: <linux-spi+bounces-10119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1603B84E89
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 15:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B711C25CC9
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAED21B905;
	Thu, 18 Sep 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="LIhU+3w6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192A1925BC
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203488; cv=none; b=qpAouNM+X2F/BsHEoQPp7QhJn9fWgNaH6ufnK/WgxYt5UjxUufv/xXFqqicr/gqxS/VpfpO/s8dJIEOiicQwyCbD16/2xdVuju2f7WKj1la+7cQacr4yvD/Np9/tYR2HgrGSlq20IAq71oi/Ed1bWB5bupKqqcgBPqIeBkRx3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203488; c=relaxed/simple;
	bh=Fvc5zCFgxQNXp10SMLlcISau9kDno376afrlmJIocKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF1GLSPr6QcYl10eU2xKobi9A76isNns2Gxkh4MfoSDz676bj+7sggz4MIAjEQuIpwDgZmVOu9KXQtrQEJU6Cx47p6ahC7TdeveF/z2z+1S7wpQZUSbbaAbE+X2K2zCfrNwCf/u1X+KM94QS681nV1Z4KrIVMjdnkW4Ygz4xb0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=LIhU+3w6; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-889b846c314so26225139f.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758203486; x=1758808286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vM4y9eRdzyomlugDECoWGADI8eAEH9U89ng3nFm0pbU=;
        b=LIhU+3w6v2hoojCIH5HBJFdAXvT1im8s5B1KesqPJt7jUVhM4YAddlUYYuoqSJnE2B
         iqXMvebmhDN6itw07ilBGh8bdMgQzT2CYMc0ZQU42pdkNd/hmJ72j7l2G24qvBfx/1Hl
         gbAc73Qt8JaF/XuNURxubv013Ru6mVFRJ4mgOEpWh2hasNOb7WbdmZ424u2rdjoct8aQ
         mV8g6JB1Wm76kjhXX+20InOdDGRsFDymwek8m854+0cwBwrP3iwZmTgb5SLO3FC4yZ5C
         B75rouOO9Nb+R6/L30Uhasqc7qoDF/tsU4K0b0f+h1rwvoR5zvOvYgJMq+faYlLqrwQo
         FFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203486; x=1758808286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vM4y9eRdzyomlugDECoWGADI8eAEH9U89ng3nFm0pbU=;
        b=cDDRiFCzxrT+EZlUmw50J7OhcVfhwi56/geKdzAfY3rx3+lL6Lngo5LAS0e4AWJg1e
         Nm/Q9zL6zM9HRKlGUX3K0IPYgQdYXVjylpPSBHq33j8PYnGHTvp7hOQtr+9DZfSdos3U
         RjKQMvVjdFxVcPxyDHasVtr0J8wWizlQoZJwCnUCUbBbEBFsiZNLHBzEQwlaz4702FdG
         PC4VGsrj5W+mNjQVB8yNdEQA6R1dE0fOgh3YSaioc49m8n4OAGR+1oDq2+VmxI46+i9a
         YS1/CCgiHVCWNRl4hcIeLt5ncx+0QqweVJwYJDOWM/tpKjHSGnN+jVS3Pb9Jprw2Uosv
         +CyA==
X-Forwarded-Encrypted: i=1; AJvYcCV2I7v6/U7v1CUzDRXYfQH7X++czeTH8wHMb0sUBAI9wFAMtVN78hQjjyG9cLgdEMags1nnJebefFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrlval+bdCoCmpahGCmn/vScCJg806I1e7EZZKxrtMJuGjFss
	S1ggS18z9bimmGfo+djxov/GrOsMHnLtg+GZyIwuFir7Dk5csr0Jw0dpSxLnsMdokFc=
X-Gm-Gg: ASbGnct1nzhar88LsUp5PQfBFQw4CoEJwqy3NVrKzRVsLtFGJpkO/nlnz8Lp5BTZhtR
	B8o2vpL9A8rRyE5sD5snnFHLaj1Q5VvO54OGmNSIcQRrHIVkS12/2oH5swTbWjS2QeVja5UUt7L
	CGcnDmnzOzUs4yOI9agr2hXV8j7deYkcg/mkWKtvMB5AaMfagjAmxOPLAZ4I5HacJwH1NPEbd4q
	khJjx5Oqp4lU5DyrFOoXv+d2cbm12jIuxXWBJrw7eBn6UG/IKM5aI28/tUkDQ3G0hEkocrk8NZP
	PsqClkO3tZ/k8h3/iqj7RA7dqTllssFg7cSmDPI6SFfyYKyT1Ik9ZVrb6SEf+02NDsr+iysaYt0
	mKQwRwQCVy17e5eSDNZGimywgsz8O3r/kUWFSwPkEtQM5VJTTogbn0NgjVLF4R4vEalirtwuVPq
	ftNy2DCATxUwgOF2in
X-Google-Smtp-Source: AGHT+IHGLUiTqtzLxz7lFW1lX9Y3PBwmaxFa80wh+wM2x5l9w0PsCrOK+nmIqYNhug9aW0T3WfX/Vg==
X-Received: by 2002:a05:6602:3413:b0:887:55f8:5dea with SMTP id ca18e2360f4ac-89d296b6ed1mr938651239f.14.1758203486168;
        Thu, 18 Sep 2025 06:51:26 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a484d05729sm81694739f.28.2025.09.18.06.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:51:25 -0700 (PDT)
Message-ID: <5956e320-7cbb-4d9a-95a7-720cfa6b9654@riscstar.com>
Date: Thu, 18 Sep 2025 08:51:24 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: dts: spacemit: define a SPI controller node
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-4-elder@riscstar.com>
 <20250918133209-GYB1273705@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918133209-GYB1273705@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 8:32 AM, Yixun Lan wrote:
> Hi Alex,
> 
> On 17:07 Wed 17 Sep     , Alex Elder wrote:
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
>>   .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++++++
>>   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
>>   arch/riscv/boot/dts/spacemit/k1.dtsi          | 19 ++++++++++++++++++
>>   3 files changed, 45 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> index 6013be2585428..380d475d2f3f3 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> @@ -44,6 +44,12 @@ &pdma {
>>   	status = "okay";
>>   };
>>   
>> +&spi3 {
> ..
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&ssp3_0_cfg>;
> Can you swap the order of these two pinctrl properties?
> Yes, we currently have some inconsistency in tree, I plan to fix during next cycle

Sure, I'll do that.

>> +	status = "okay";
>> +};
>> +
>>   &uart0 {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&uart0_2_cfg>;
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> index 3810557374228..16c953eca2aaa 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> @@ -28,4 +28,24 @@ pwm14-1-pins {
>>   			drive-strength = <32>;
>>   		};
>>   	};
>> +
>> +	ssp3_0_cfg: ssp3-0-cfg {
>> +		ssp3-0-no-pull-pins {
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
>> index 66b33a9110ccd..a826cc1ac83d5 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -834,6 +834,25 @@ storage-bus {
>>   			#size-cells = <2>;
>>   			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
>>   
>> +			spi3: spi@d401c000 {
>> +				compatible = "spacemit,k1-spi";
>> +				reg = <0x0 0xd401c000 0x0 0x30>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				clocks = <&syscon_apbc CLK_SSP3>,
>> +					 <&syscon_apbc CLK_SSP3_BUS>;
> ..
>> +				clock-names = "core",
>> +					      "bus";
> can you simply put them together in one line? it's kind of tedious to split..

Sure I can do that.  I've seen it both ways.

>> +				resets = <&syscon_apbc RESET_SSP3>;
>> +				interrupts-extended = <&plic 55>;
> why use interrupts-extended?

Because it specifies both the controller and interrupt number
explicitly.  Why *not* use interrupts-extended?

>> +				spacemit,k1-ssp-id = <3>;
>> +				dmas = <&pdma 20>,
>> +				       <&pdma 19>;
> .. em, so the SPI will use pdma, then probably you should also adjust Kconfig to
> select PDMA driver?

You're right.  Thanks for catching that.

					-Alex

> 
>> +				dma-names = "rx",
>> +					    "tx";
>> +				status = "disabled";
>> +			};
>> +
>>   			emmc: mmc@d4281000 {
>>   				compatible = "spacemit,k1-sdhci";
>>   				reg = <0x0 0xd4281000 0x0 0x200>;
>> -- 
>> 2.48.1
>>
>>
> 


