Return-Path: <linux-spi+bounces-10229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF3B94908
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 08:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC951900FA2
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC822ACEB;
	Tue, 23 Sep 2025 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="lhVitvDP"
X-Original-To: linux-spi@vger.kernel.org
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357230E0FC;
	Tue, 23 Sep 2025 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609167; cv=pass; b=D+W/gvu/lP/kpRQHOjuMK/kg7rpj3bUoeAKDs5m+IniRRgBOh7W9gYIZA0tbpbnX2kDtlkE6WRs2lWLfl465XkQnx9XUQDeBNrfiTu2YPx6PdM86Ln4uXB+FTRcqfuGjahx5Jroe7eAfGcgJLgSoMQwbhBsJXaclYbarrYokkco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609167; c=relaxed/simple;
	bh=aei6C0VWiguh1PBF0Du2KdAXrweEg8INkXyjAyDsHaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D33WH8r71jHcFM71A/bnAIQe2Vimq0IcEC83vsfQIK/DJBLi6S1vF9ovjnHJu/IQhXpjbrAFjb/hw542w5tkXfPqN9dQ07MI07cjCYcdbs3ZfbXdLgrqgUiC+A/zAppCbbmNY2eJBOtv50LS4GakyAWVgc87oY9TU44qKX71nLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=lhVitvDP; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1758609104; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jyyQ4VyqYABbZiCkF/HdPD7D7w0rxpDQ/JZZEjz43JXuBVVcE5qdzpMfnLdJ4nhOsaU0+kMSh1yCVILeO48DHntz5RpE+1DGTUclfc1CulRH8tRBDFTDuDH2Yx5AsD64bCv+O9d3FdRSvp13bkSO7STumxN2gpAhK9KuS0KuuNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758609104; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kX0WMRIAiTlqH4/0kQPSeJfGukw8qs11oITboMapl7U=; 
	b=QolxLydcbootGKpejpHChM+hYoa2wrP5p2XzreJ85OhZ1nh3YgwMb00D/1wOjQCq9jAy1diZ0GeQkeGqskVaOhlxb0+o3pNXLghs9uKzr8XSbReDn72FT2rwBmF1kjqOpFY38+erNiM5T0WMu+ebStYFIso0TZslX19Hp6l+VM8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758609104;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kX0WMRIAiTlqH4/0kQPSeJfGukw8qs11oITboMapl7U=;
	b=lhVitvDPy9iTCKcGQL10bEW7RbrPWMPzwZm42zlvmidkeRnG8otydOlsA3bGf+1/
	R3lBHauN/Dk+BRPBLU93bFcXWuEPBzY8PZO+4SKnFWKvf1n7L9c7OgYAeL5OJVZzlYJ
	nhwOXTwaKDNJo6g3l8hW2s3+pumo9CSMJJSlTkoc=
Received: by mx.zohomail.com with SMTPS id 1758609101123227.34763562314959;
	Mon, 22 Sep 2025 23:31:41 -0700 (PDT)
Message-ID: <a9054501-03ce-4db2-a753-81741c6237b6@pigmoral.tech>
Date: Tue, 23 Sep 2025 14:31:31 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Yixun Lan <dlan@gentoo.org>, Alex Elder <elder@riscstar.com>
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
From: Junhui Liu <junhui.liu@pigmoral.tech>
In-Reply-To: <ED4C67FD136DEB19+aNINJJVYbNnT87va@LT-Guozexi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Troy,

On 9/23/25 10:59 AM, Troy Mitchell wrote:
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
>
> If it’s an index, should it start from 0 or 1?
> The starting point seems inconsistent across pwm/spi/uart.
> If it’s supposed to be the function number,
> then the spi and pwm parts look incorrect.
>
> Could you clarify this? Yixun.

I think the second number represents the index of the pin group available
for this device.

Take pwm14 as an example: according to the manual, the first pin group
(index 0) available for pwm14 is GPIO6 with function 3, while the second
group (index 1) is GPIO44 with function 4.

>                  - Troy

-- 
Best regards,
Junhui Liu


