Return-Path: <linux-spi+bounces-10241-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45873B95DFC
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 14:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECC7188C581
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840FF322DC1;
	Tue, 23 Sep 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="0+rg1kBp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185B322C9C
	for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631779; cv=none; b=qx1GbfT6DE78q6kfBeNjlRPBa7/F04Vr8Yi9l1FoZVbUCUXxESwdOpHxEIdMCKXHXhFF/V/zldPWHxsLJ2D5OCuPs+mUfwqo5gaUu70i0J+yxbpSi9DLI094J2Bflwd0awFRK17i0/MLzJN0Cn4Z/OnOFRQY8IKWEGNm/ElzERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631779; c=relaxed/simple;
	bh=2uX98Zc/lh21ANJqrjffGwf/v9w/8F5ahBMBEj5Ebds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOO3nlZyBxjssLKSYWc2uBB/ijPcf2gNidkHJSMmo6P9O+nJpBCXywElQJhN/WDocJl6y+a9uELUcQYjNlghVm4xicBQ9wGI3MNVCw6u5+AYVX8pB+C4m7T/qldHbafyYk4hhDNCrM14Iz0YeEKtLLraLLMQXKHmQh1lRUWqVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=0+rg1kBp; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8a936b682b3so333589939f.3
        for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758631777; x=1759236577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBPJgYIx7v6+v01N0CRR0tlRD9SDBXZtLGM0u4Al3EM=;
        b=0+rg1kBpX28qVOannEBlkZE+6aBH7j7G51dgXFVT4LnXuaTPcypAS1MPFVbaxymjCf
         Mhd6WQKCr8jUAt6vfMOcWJ2YwTbt3KrM9d2Ce5QM9yP3iXqnVzXDVk38x4BN+GRMfOTW
         Y76UWiNMJ+gRc20seL+PHIzHu8KwhJ3A60dDEKCITNuA0ZS5Jv8Au66dOkUJ6wK1DUq1
         5hx+bil9Ohxm30AClLNMDFYigyle/WX3TGwwDBG3nMIwd1dxoP3QlIE97lmIf5B+EMu2
         OsR/s8lhtrLlWaRuT+4MvmoQxpDqc8b32Cmw58tCdLBq8V4e/cdCfE5f3fC9BdolF5rp
         ieVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631777; x=1759236577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBPJgYIx7v6+v01N0CRR0tlRD9SDBXZtLGM0u4Al3EM=;
        b=EcfQTOhCqsiKUgg2DUQcCyJnl9269L4tqxMRYeiMaZQJ3IQsXh83dqGaAGBn91IBTO
         JDmMzlRPbc0M/S/hJabMZwpjOH4LA8hkbpMv73P80wNGBlauQtfYPI8HxkdSiHgHCCxc
         wywMTeuC+KrGVPDgHq3k/a/jrNO86rfBT2HfwBgPUVUaqdbcV7HbyXT8nb4i2P99iOAy
         0qFyiVnfZaqZwqNvpJK7/Yl2W/OKrtcly7Ov7/zL1MoXQe7ZctmduFXLLa+S5vZHkXNU
         f33oc4ISLy4najJjrMN+v632zN/W6qarlqF6IfNCY5p4FHtEsJwtBf8zjhik/HtCSLQt
         54HA==
X-Forwarded-Encrypted: i=1; AJvYcCUIF5VrUKBjiJUlw9S0kcgr19RT01XPCTkB592QvGXgq8cVpjjcbfoLPUvJ3oINMCtFWpS4kWlz/kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywrYyp/ijQX7qmpod2WAYZKTtRL/nDznrtZNVOt5Gm3IvEBnEH
	WJLpINTk9vqPfcIuAZMYi0t78AT8lRL1sw6JF4WdulEuuA7TjAnbG59PGeLxtmgvVeCwRXS/HPl
	xGoq4
X-Gm-Gg: ASbGnculz8VGF5PAGLSbtHpzvgHC5hUmw1Rolsa6MhsN0/f5NH20TzefYdoARM76WLe
	in8AG9AMuVjUKM6VfZX18AG0P8gfyctc8v8bm/x1bJtZOnz0E4A6b80tzcugSriL7UG0NmwNfV+
	vv9Bp9bkC3F4kWPRNrlpRZjRvaWtHb255G41+Bq0NHLKoOFXtkWwQilI7MkqMgsfey2X49YY2eB
	M5Qvlp/3WjstDgZVSDd1f0289PZ+uXGAzPeduRF6PAbYEM3KcDDgXBS0Mx2SbuqXp/t1cLQiOx2
	6reIJDVHBy8Zgdgwxd3C8Iv9r7fHEViIeMrR6YzEF6QeXjoSRTR9Fr8sOxy6+LP2HK+Q/T054Dh
	EKCSLgZ9MMEH7tNH2+jZFOBn/qvAbuFMXjXe8QQgj7aGmRryAuqHYRbhVy4KL7A==
X-Google-Smtp-Source: AGHT+IHYa5DWzxweqTSWrCllRHx+UhSsxFOlpmwhlInRnbMBAW55bHyqIh4dQEHaUgu4d93X0h+kNg==
X-Received: by 2002:a5d:93c1:0:b0:884:1e28:904e with SMTP id ca18e2360f4ac-8e1d1a12e35mr361506139f.12.1758631776567;
        Tue, 23 Sep 2025 05:49:36 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-556f74174cfsm3556602173.57.2025.09.23.05.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:49:35 -0700 (PDT)
Message-ID: <1aa28123-cfa4-415a-9d1b-4d9edd62489b@riscstar.com>
Date: Tue, 23 Sep 2025 07:49:34 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-4-elder@riscstar.com>
 <20250923001930-GYB1303776@gentoo.org>
 <ED4C67FD136DEB19+aNINJJVYbNnT87va@LT-Guozexi>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <ED4C67FD136DEB19+aNINJJVYbNnT87va@LT-Guozexi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/25 9:59 PM, Troy Mitchell wrote:
> On Tue, Sep 23, 2025 at 08:19:30AM +0800, Yixun Lan wrote:
>> Hi Alex,
>>
>> On 11:17 Mon 22 Sep     , Alex Elder wrote:
>>> Define a node for the fourth SoC SPI controller (number 3) on
>>> the SpacemiT K1 SoC.
>>>
>>> Enable it on the Banana Pi BPI-F3 board, which exposes this feature
>>> via its GPIO block:
>>>    GPIO PIN 19:  MOSI
>>>    GPIO PIN 21:  MISO
>>>    GPIO PIN 23:  SCLK
>>>    GPIO PIN 24:  SS (inverted)

Note that the pin numbers I'm mentioning above are the numbers
(1-26) on the 26-pin GPIO header on the BPI-F3 board.

>>>
>>> Define pincontrol configurations for the pins as used on that board.
>>>
>>> (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
>>>
>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>> ---
>>> v3: - Moved the SPI controller into the dma-bus memory region
>>>
>>>   .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
>>>   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
>>>   arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++++++++++++
>>>   3 files changed, 43 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>>> index 2aaaff77831e1..d9d865fbe320e 100644
>>> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>>> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>>> @@ -14,6 +14,7 @@ aliases {
>>>   		ethernet0 = &eth0;
>>>   		ethernet1 = &eth1;
>>>   		serial0 = &uart0;
>>> +		spi3 = &spi3;
>>>   	};
>>>   
>>>   	chosen {
>>> @@ -92,6 +93,12 @@ &pdma {
>>>   	status = "okay";
>>>   };
>>>   
>>> +&spi3 {
>>> +	pinctrl-0 = <&ssp3_0_cfg>;
>>> +	pinctrl-names = "default";
>>> +	status = "okay";
>>> +};
>>> +
>>>   &uart0 {
>>>   	pinctrl-names = "default";
>>>   	pinctrl-0 = <&uart0_2_cfg>;
>>> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>>> index aff19c86d5ff3..205c201a3005c 100644
>>> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>>> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>>> @@ -76,4 +76,24 @@ pwm14-1-pins {
>>>   			drive-strength = <32>;
>>>   		};
>>>   	};
>>> +
>>> +	ssp3_0_cfg: ssp3-0-cfg {
>> ..
>>> +		ssp3-0-no-pull-pins {
>> I'd prefer not to enforce "pull" info inside the name, you can't embed
>> all property info, besides, what's if you want to change/override later?
>>
>> how about just name it as ssp3-0-defaul-pins or simply ssp3-0-pins?
> uart: uart0_2_cfg and function is 2.
> pwm: pwm14_1_cfg and function is 4
> spi: ssp3_0_cfg and function is 2
> 
> I’m a bit confused about the meaning of the second number here.
> Is it intended to be an index, or the function number?

It is an index, and it seems arbitrary but it is based on the
order in which they occur in a spreadsheet that defines a set
of possible pin configurations.

For example, SPI3 lists 2 possible pin combinations:
SCLK	GPIO[75] function 2	GPIO[59] function 2
FRM	GPIO[76] function 2	GPIO[60] function 2
TXD	GPIO[77] function 2	GPIO[61] function 2
RXD	GPIO[78] function 2	GPIO[62] function 2

> If it’s an index, should it start from 0 or 1?

It starts with 0.

> The starting point seems inconsistent across pwm/spi/uart.
> If it’s supposed to be the function number,
> then the spi and pwm parts look incorrect.

The first one (index 0) shows up earlier (lower line number) in
the spreadsheet, even though the GPIO numbers used are higher
than those in the second one.  They're grouped, and the first
one is in GPIO group 2 and the second is in GPIO group 5.

					-Alex

> Could you clarify this? Yixun.
> 
>                  - Troy
>>
>>> +			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
>>> +				 <K1_PADCONF(77, 2)>,	/* MOSI  */
>>> +				 <K1_PADCONF(78, 2)>;	/* MISO */
>>> +
>>> +			bias-disable;
>>> +			drive-strength = <19>;
>>> +			power-source = <3300>;
>>> +		};
>>> +
>>> +		ssp3-0-frm-pins {
>>> +			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
>>> +
>>> +			bias-pull-up = <0>;
>>> +			drive-strength = <19>;
>>> +			power-source = <3300>;
>>> +		};
>>> +	};
>>>   };
>>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
>>> index 6cdcd80a7c83b..eb8a14dd72ea4 100644
>>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>>> @@ -797,6 +797,22 @@ uart9: serial@d4017800 {
>>>   				status = "disabled";
>>>   			};
>>>   
>>> +			spi3: spi@d401c000 {
>>> +				compatible = "spacemit,k1-spi";
>>> +				reg = <0x0 0xd401c000 0x0 0x30>;
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +				clocks = <&syscon_apbc CLK_SSP3>,
>>> +					 <&syscon_apbc CLK_SSP3_BUS>;
>>> +				clock-names = "core", "bus";
>>> +				resets = <&syscon_apbc RESET_SSP3>;
>>> +				interrupts = <55>;
>> ..
>>> +				dmas = <&pdma 20>,
>>> +				       <&pdma 19>;
>> can we also squash the dmas into one line? but, do split if there are too many..
>>
>> yes, it's simply a style change that I'd like to keep them consistent at DT level,
>> besides you might also want to adjust dt-binding examples to align with them here..
>>
>> thanks
>>
>>> +				dma-names = "rx", "tx";
>>> +				status = "disabled";
>>> +			};
>>> +
>>>   			/* sec_uart1: 0xf0612000, not available from Linux */
>>>   		};
>>>   
>>> -- 
>>> 2.48.1
>>>
>>>
>>
>> -- 
>> Yixun Lan (dlan)
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


