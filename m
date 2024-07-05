Return-Path: <linux-spi+bounces-3756-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20692835A
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 10:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD6E1F247C3
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65F13C3F9;
	Fri,  5 Jul 2024 08:01:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA113B5B9
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166495; cv=none; b=uvaN0cAtsAP5/9AWW/bPBNqql5MVRlNS5y+Fy9FYXFpmY+QnwcfPViiz9HiqM+wr5I1PphTc2V7GDiUN0CxDJY1aAg/LUis15zCydN7+ApqV4jrgaLPrTQyw6XBQq40D2jpTjhhNSVViq87ccf/7zX8qNYyJY7jCNimqK/H1vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166495; c=relaxed/simple;
	bh=N19zfTC7t9jI7s/JygfHbPjFkXgNtL5gwQ8EcozKBuw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f5VWw+1nasGDO3UEFqzP6I5gE9RGxp/C87FDW5W0Y4oMihxCmkK0GkmcEIRMyLVYO35wIfyrGuranIy7ueL+e5h6mVbJGXncSBm/Mv3qHXUeYu/1LDtbx9DJRL64gVsRghs1awMHvSRDze0yvxbI0QAjhE9FwiS0HTkN8Rtfv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c3ba:e01c:f6c8:df75])
	by laurent.telenet-ops.be with bizsmtp
	id jk1B2C01H36r8Me01k1BWn; Fri, 05 Jul 2024 10:01:25 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sPdsV-001F3R-DT;
	Fri, 05 Jul 2024 10:01:11 +0200
Date: Fri, 5 Jul 2024 10:01:11 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Walle <mwalle@kernel.org>
cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, 
    Mark Brown <broonie@kernel.org>, Vaishnav M A <vaishnav@beagleboard.org>, 
    Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
    Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
    Tero Kristo <kristo@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
    jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
    linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
In-Reply-To: <D2AZ0QKTPY3B.1I48GLI90XD0P@kernel.org>
Message-ID: <5b2cd46e-8a51-f145-8876-55b12a6d62d1@linux-m68k.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org> <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org> <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com> <D2AZ0QKTPY3B.1I48GLI90XD0P@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Michael,

On Thu, 27 Jun 2024, Michael Walle wrote:
> On Thu Jun 27, 2024 at 7:07 PM CEST, Andrew Davis wrote:
>>> +	mikrobus_boards {
>>> +		thermo_click: thermo-click {
>>> +			compatible = "maxim,max31855k", "mikrobus-spi";
>>
>> I might be missing something, but your solution cannot possibly be
>> to list every click board that could be connected (all 1500+ of them)
>> to every mikroBUS connector on every device's DT file..
>>
>> Each click board should have a single DTSO overlay file to describe the
>> click board, one per click board total. And then that overlay should
>> apply cleanly to any device that has a mikroBUS interface.
>>
>> Which means you have not completely solved the fundamental problem of
>> abstracting the mikroBUS connector in DT. Each of these click device child
>> nodes has to be under the parent connector node. Which means a phandle
>> to the parent node, which is not generically named. For instance
>> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
>> the click board's overlay would look like this:
>>
>> /dts-v1/;
>> /plugin/;
>>
>> &mikrobus0 {

Let's use just "&mikrobus" instead...

>> 	status = "okay";
>>
>> 	mikrobus_board {
>> 		thermo-click {
>> 			compatible = "maxim,max31855k", "mikrobus-spi";
>> 			spi-max-frequency = <1000000>;
>> 			pinctrl-apply = "spi_default";
>> 		};
>> 	};
>> };
>
> If there should only be one DT overlay per click board, how would
> you apply that to to different connectors?

You teach fdtoverlay[*] to translate anchors, e.g.

     fdtoverlay -i base.dtb -o final.dtb \
 	       -t mikrobus=mikrobus0 click1.dtbo \
 	       -t mikrobus=mikrobus1 click2.dtbo

I believe the Raspberry Pi people already have something like that.

The mikrobus node handles all other translations (e.g. mapping from
Mikrobus pins to GPIO numbers), so you do not have to handle these
explicitly when adding an overlay.

[*] And anything else that handles overlays (U-Boot, out-of-tree
     OF_CONFIGFS, ...)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

