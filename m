Return-Path: <linux-spi+bounces-3767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7433928C5E
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2F21F22636
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2921684A1;
	Fri,  5 Jul 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VPRVRd2O"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3ED22083;
	Fri,  5 Jul 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197282; cv=none; b=NycsE1j5me8oyn5N1/eFl+y/Cq2H+//VMNg3mKaJcBffpwuWdyj7rEOC0TCttA0pzoIM+c3iSw08hx7SRIWZWHn0IkQsmkV+C1XagPR5lfINFs4T6gdga8BUAEyxkEDv4Z5+oW8mYdzIelsEZnA4rnVn3Scvk4Yxd06osVare4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197282; c=relaxed/simple;
	bh=4RxVKpu7aLmNuCfUq7vwPdBqh7m8Xjan9uzVGMAMblg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cewzEXWgk1dy6Kl9DcEB1iFXc0f2K4LM+NJ5vUctcsJ7nL6zfL+9CppRzoqp2fXtur2FN278WsE9T1DX5LoNG0od5SOzh8UYuizEUCzqJHBf5YomTC4OMStEHIuL60NIY2YXnLGq4MmkdePtEbvk2GzAX2MMPnAkJg34btEtUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VPRVRd2O; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465GYGWS001066;
	Fri, 5 Jul 2024 11:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720197256;
	bh=7+MmV/AK8xd7ornr1O1boj8x2ZOEG1OgD7+3rx0WBvw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VPRVRd2Orwe1QVlKfndwfJXqrfg3VIHYD3xqJBgoEL32CsuuqwwvtdVP1wt/eu9lp
	 VM7PI+iGfTojK3ogCpW3gpQdPONUQ+Q6qZQSHuS1kUplInk3OhHK0mGGMHb5jK1CiI
	 9SZIxtOjrzkZRpQEkPsN2pYhF7bA0hY6ASWF04VU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465GYGjw129475
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 11:34:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 11:34:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 11:34:15 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465GYEiY090112;
	Fri, 5 Jul 2024 11:34:14 -0500
Message-ID: <ca2d7d4b-c22d-4d14-a216-8c19073e4189@ti.com>
Date: Fri, 5 Jul 2024 11:34:14 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Walle
	<mwalle@kernel.org>
CC: Ayush Singh <ayush@beagleboard.org>, Mark Brown <broonie@kernel.org>,
        Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        <jkridner@beagleboard.org>, <robertcnelson@beagleboard.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
 <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>
 <D2AZ0QKTPY3B.1I48GLI90XD0P@kernel.org>
 <5b2cd46e-8a51-f145-8876-55b12a6d62d1@linux-m68k.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <5b2cd46e-8a51-f145-8876-55b12a6d62d1@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 7/5/24 3:01 AM, Geert Uytterhoeven wrote:
>      Hi Michael,
> 
> On Thu, 27 Jun 2024, Michael Walle wrote:
>> On Thu Jun 27, 2024 at 7:07 PM CEST, Andrew Davis wrote:
>>>> +    mikrobus_boards {
>>>> +        thermo_click: thermo-click {
>>>> +            compatible = "maxim,max31855k", "mikrobus-spi";
>>>
>>> I might be missing something, but your solution cannot possibly be
>>> to list every click board that could be connected (all 1500+ of them)
>>> to every mikroBUS connector on every device's DT file..
>>>
>>> Each click board should have a single DTSO overlay file to describe the
>>> click board, one per click board total. And then that overlay should
>>> apply cleanly to any device that has a mikroBUS interface.
>>>
>>> Which means you have not completely solved the fundamental problem of
>>> abstracting the mikroBUS connector in DT. Each of these click device child
>>> nodes has to be under the parent connector node. Which means a phandle
>>> to the parent node, which is not generically named. For instance
>>> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
>>> the click board's overlay would look like this:
>>>
>>> /dts-v1/;
>>> /plugin/;
>>>
>>> &mikrobus0 {
> 
> Let's use just "&mikrobus" instead...
> 
>>>     status = "okay";
>>>
>>>     mikrobus_board {
>>>         thermo-click {
>>>             compatible = "maxim,max31855k", "mikrobus-spi";
>>>             spi-max-frequency = <1000000>;
>>>             pinctrl-apply = "spi_default";
>>>         };
>>>     };
>>> };
>>
>> If there should only be one DT overlay per click board, how would
>> you apply that to to different connectors?
> 
> You teach fdtoverlay[*] to translate anchors, e.g.
> 
>      fdtoverlay -i base.dtb -o final.dtb \
>             -t mikrobus=mikrobus0 click1.dtbo \
>             -t mikrobus=mikrobus1 click2.dtbo
> 

This basic idea is where I started also, the result is we end
up needing a huge number of "anchor" points. And they would
also be board specific. So we would want to store all these
anchor points in a file, and what better file than another
DT file.

Putting all the translations in a DT file to allow the DT overlay
to become generic is the core idea of this series[0] (looks like
you already found it, linking for other following along).

And as you note, the symbol table trick allows us to do this
without teaching fdtoverlay anything new, so it should work
as-is today for any project already supporting overlays.

> I believe the Raspberry Pi people already have something like that.
> 
> The mikrobus node handles all other translations (e.g. mapping from
> Mikrobus pins to GPIO numbers), so you do not have to handle these
> explicitly when adding an overlay.

This part seems to still be an open item. For pinmux we can name
the pinmux nodes such that their phandles are resolved on overlay
application. For Pin number/name to GPIO number we have "gpio-names",
and the names can also be generic. But for Interrupts and a couple
others, we are still missing a good way to provide a generic mapping
from pin name to number.

Andrew

[0] https://lore.kernel.org/linux-arm-kernel/20240702164403.29067-1-afd@ti.com/

> 
> [*] And anything else that handles overlays (U-Boot, out-of-tree
>      OF_CONFIGFS, ...)
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

