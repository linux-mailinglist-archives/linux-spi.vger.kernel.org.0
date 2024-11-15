Return-Path: <linux-spi+bounces-5703-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E3F9CDFC6
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03C9283923
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857891BE226;
	Fri, 15 Nov 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="PFvfaJ3x"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EB1B85EC;
	Fri, 15 Nov 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676993; cv=none; b=e5Vi0UmvC74Zc8hE1G1FdaDy7piICLpmHSctWgL8O62oXUJPGn61dRjivHiSAzbYJRPFlpaaeS56BOVBkqU/do1PoRtSoCbHQ8IcYbXM87ralK6f6cT2Y9Nu7pT0cm8XQqVnS2/MLfCznJTSnV1r60tKxV7d3fFc3MhEf2hCDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676993; c=relaxed/simple;
	bh=aXmW/SlFuMTBx0uvUSkbp6nYdFZtT3GvPmQoFTxirQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=to8O+AatVIu4rKtTbdX+McyCjGNcCcF+llWx9JPZqlW2fuQet0A2ITAytDWTquUW58gGueXgJzUbPQnI0KD37X7mKpvQ5UBrqS+xHo7qgJ0ebgG3GFGKym19rH+VVhiE2SHyfE91qlghQYXWjUyvUcC90I6Sg9ZMK1FDX2jCfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=PFvfaJ3x; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A63A9A03F3;
	Fri, 15 Nov 2024 14:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=t7g3cSkvm0PW3SmedMT5JjoODC5Qn
	0jSLN8FBVFZMrc=; b=PFvfaJ3xeTl6gtIjREgawA/1osfrZCQzzu6svm3jRurrp
	fwjOC+fWaTEmfeTKdVclPoqCPVufqzunplLFZ4QiOx8IcgMHpY0IBVnGkWHs1IcP
	yWoQlZOno4gyYnQDE8epR1eLCjd7bk2DTu1QT4pYk0IqFBuWua5kxgyU+UpaHQq3
	XdspBRA9GWnACidej7QHU6DaMLDWLsmi9CMPN4AX3EPNY4dnnLdmgxcNrMnlcBSZ
	767l3vjFFtU2rkkM1ts7d7vJxzzPeCfPmObI7Z3kwfjgta/rMI/TxK77G2HBHEGJ
	06tzFbkF9Z342iSRqe5RsSoZkdeuzOQIw+Shtf2uGIkaRybarLertzJncph+Tisb
	lGvV1ZcL+cAo52Pj32xePQR1tkaSQZtPPYIMJMzj71De/LYh6TVveEikCy+rNsJj
	sn/1kM7YfmK4r1YMXMCyXiDz+s7lUSMy11Gq05o8A1lnxKqqH9izS5PtSf+EzXvl
	Ms6+FaVz+yiZA5qAnFZxytF82ozZNXc9Xvh0WXImhlW/84ClrkGfofOnDm/IpAls
	xk4idtz+FFTchHwTCibhcYyW29glXBWh2t7+PvD/2e3XiUwwmTPRsNXYl9paXpkb
	vkd+EDgBdtHVnSUtWkTy9FFQCTGgia1xnZ49jtIamnd6VtD6RUSB21LGisa4XY=
Message-ID: <32a5c58c-f318-4c02-ae76-421b9cca0875@prolan.hu>
Date: Fri, 15 Nov 2024 14:23:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support
 newer SoC families
To: <Hari.PrasathGE@microchip.com>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <Varshini.Rajendran@microchip.com>,
	<alexandre.belloni@bootlin.com>, <broonie@kernel.org>,
	<claudiu.beznea@tuxon.dev>, <Nicolas.Ferre@microchip.com>,
	<Patrice.Vilchez@microchip.com>, <Cristian.Birsan@microchip.com>
References: <20241030084445.2438750-1-csokas.bence@prolan.hu>
 <7cc95e52-7509-44eb-8e30-d518283e7d87@linaro.org>
 <2b310b54-c215-40fa-b6d4-81faf75a8c9e@prolan.hu>
 <20241104-vanilla-operating-de19b033f0a8@thorsis.com>
 <ad585127-9e3c-414a-84c2-c4ea3e6d3c7d@prolan.hu>
 <78f38031-1723-4474-9bea-1c23918a75f6@microchip.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <78f38031-1723-4474-9bea-1c23918a75f6@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855617C6B

Hi,

On 2024. 11. 05. 8:47, Hari.PrasathGE@microchip.com wrote:
> Hello Bence,
> 
> On 11/4/24 6:26 PM, Csókás Bence wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> the content is safe
>>
>> Hi!
>>
>> On 2024. 11. 04. 13:48, Alexander Dahl wrote:
>>> It would actually be better if vendor would bring their stuff
>>> upstream, so there's no need for a vendor kernel.  Did you talk to
>>> Microchip about their upstreaming efforts?  What was the answer?
>>>
>>> Greets
>>> Alex
>>
>> Agreed. Though in this case, the original patch *was* submitted by
>> Microchip (by Tudor, originally) for upstream inclusion, but it was not
>> merged. Hence this forward-port.
>> Link:
>> https://lore.kernel.org/linux-spi/20211214133404.121739-1-tudor.ambarus@microchip.com/
> 
> 
> Thanks for your patch. We are planning to revive this work at the
> earliest. While I don't have specific timeline for this, we at Microchip
> are fully aware of this gap and doing everything we could to keep the
> delta between the upstream kernel and vendor kernel as minimal as possible.
> 
> We will discuss internally and provide you the feedback. Thanks again
> for your efforts.
> 
> Regards,
> Hari

Did you reach a conclusion internally regarding whether to support this 
patch? Since then, I opened a ticket with Microchip, but haven't got a 
response yet. I have also been in face-to-face contact with some of the 
engineers from the Rousset office, and they have expressed their 
support, and even the possibility of lending us a SAMA7G5 to test with. 
So really, all I'm waiting for is this patch to be merged, and then I 
can submit the SAMA7G5 parts, at worst as an RFC, if we don't get the 
real hardware in time.

Bence


