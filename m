Return-Path: <linux-spi+bounces-9253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F44B17C31
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 06:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9611C2337D
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 04:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABB21922F6;
	Fri,  1 Aug 2025 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gz+Z5D+i"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FB26ACB;
	Fri,  1 Aug 2025 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754023545; cv=none; b=SA5WSvwTQkuU/FtKrxXpwR+OzUm+jod1LqNKougyN1TJUfLd38jGvPN8LvDOxUmuiX/ehFn0dgKOnXQib+XHo41PEZrf80CDDs8SNDk4ctxh+O3wOd3+5XWb9F7jWl1jFo8516qRRJr6t52yjhtYQ2j7x1yVqDBZUxnSTUU/moc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754023545; c=relaxed/simple;
	bh=f0kSnytsj68XbFg2s9F9w28FfWo8pGYjLeMe3biLdCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJmyRLV6we9q8PCPriRwvZJfqOyh9ueWFgKlspU54PzfmGGlZHCpKVuLaeMiWejwJni4ZlBb0LE7hxCm1RzM1DqqOYOsFsgVw1bopxyQe2/3rHV/6XjnI2lHhL4oUmL2qhnk2hi6IuCC0TB4au7LLVw67ksKAcPXhdImH0tcY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gz+Z5D+i; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F28EA1038C126;
	Fri,  1 Aug 2025 06:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1754023534;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cazfz037LmHclW8XHXBHFZq0vEjND40W4TWSxFvy07E=;
	b=gz+Z5D+i9YMV7qtc9jV2wB6l2n5mM6a5kkQ8N5Nrm4TkChr51IhcMCajFKXKFKQIDQsjt4
	ShW3SLCe9XFh86uBmcTWkbHL2WbZATD/fRJZArT33UNgyIIrrdu4BBXN/LgGL0EgOfgJKe
	kpEJ1HUwHN3gjuI/8WQAdhOM6WfrmJD3mlm/T+2Wss+jq3N+L3LfjcIxIipHcGxUU/MI2m
	r1YZkcuFOuap5h6DZ3ytvYUiNMClLZyFlPKjbZO5LgT7qxUlivfIemKy9HNtBkvFhAx3cc
	0IBrCFR61MfOwW9lvrYnv978S00+JLzejurw223yvP9RyOXsg3NBCeigGls2Sw==
Message-ID: <0c6dcc6f-e09c-266d-f65a-12d18244a2c6@denx.de>
Date: Fri, 1 Aug 2025 06:45:48 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: (subset) [PATCH v1 0/3] spidev: introduce trivial abb sensor
 device
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrei Lalaev <andrey.lalaev@gmail.com>,
 Chanh Nguyen <chanh@os.amperecomputing.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Grant Peltier <grantpeltier93@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20250719063355.73111-1-hs@denx.de>
 <175311337130.327079.7374455187420344577.b4-ty@kernel.org>
 <d677ecd9-42d6-43fe-8fe1-a5afd4d270e2@kernel.org>
 <8a8106ea-83d3-e02a-9ae7-ea4a66e4c248@denx.de>
 <2e9c96c6-6dfb-4232-a9ab-a3e78b718fc2@roeck-us.net>
 <20250722112013.0000597e@huawei.com>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250722112013.0000597e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Jonathan,

On 22.07.25 12:20, Jonathan Cameron wrote:
> On Mon, 21 Jul 2025 21:58:10 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 7/21/25 21:05, Heiko Schocher wrote:
>>> Hello Krzysztof,
>>>
>>> On 21.07.25 18:24, Krzysztof Kozlowski wrote:
>>>> On 21/07/2025 17:56, Mark Brown wrote:
>>>>> On Sat, 19 Jul 2025 08:33:51 +0200, Heiko Schocher wrote:
>>>>>> This series introduces the changes needed for trivial spi
>>>>>> based sensors from ABB, currently operated from userspace.
>>>>>>
>>>>>> The last patch adds the spidevices to the DTS files, already
>>>>>> in mainline.
>>>>>>
>>>>>> make dtbs_check showed no errors/warnings for the dts files
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Applied to
>>>>>
>>>>>      https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>>>>>
>>>>> Thanks!
>>>>>
>>>>> [1/3] dt-bindings: trivial-devices: Document ABB sensors
>>>>>         commit: aad2f87cbcab56b322109d26d7b11842a09df91f
>>>>> [2/3] spi: spidev: Add an entry for the ABB spi sensors
>>>>>         commit: d60f7cab7c04944a79af16caa43c141e780a59c6
>>>>>   
>>>>
>>>>
>>>> That's unexpected, Mark. Patches received two objections/comments and I
>>>> don't think discussion was resolved.
>>>>
>>>> ABB is huge company, probably making hundreds or more of sensors. The
>>>> patchset basically claims that all of them work with spidev. It does not
>>>> providing any model names or details, so it seems really incomplete to
>>>> call them trivial devices.
>>>
>>> I do not know how many different sensors they have, nor if that department can
>>> speak for the whole company...
>>>
>>> What I have as information is:
>>> https://lore.kernel.org/linux-spi/2477dc64-92a0-9dc9-d168-56646d0d796e@denx.de/
>>>
>>> and I get no more information about them currently. May I should
>>> add some sort of trivial into compatible name? Something like
>>>
>>> "abb,spi-trivial-sensor"
>>> or
>>> "abb,spidev-trivial-sensor"
>>>
>>> which makes it clearer, that only ABB trivial sensor, controlled through spidev
>>> driver, is connected here?
>>>    
>>
>> FWIW, I always thought that devicetree is not supposed to contain such generic
>> information. Is it even appropriate to list something like this in devicetree
>> in the first place ?
>>
>> If so, what prevents anyone from submitting hundreds of
>> "<company>,spidev-trivial-<device-type>" entries, using the same line of argument ?
> 
> Agreed.  These should have separate compatibles based on what any OS etc
> might want to bind to them.  Just because their model in Linux is spidev etc
> that shouldn't mean a generic ID is appropriate.
> 
> Can we at least have some examples to motivate the discussion?

I am sorry, I get no more information about the sensors... even I do
not know the count of variants. What I can say is, that this sensors
measure gases, and are only used "internal" on the aristainetos3 carriers.

So a proposal would be:

# ABB gas sensor on aristainetos3 carriers
compatible "abb,aristainetos-gas-sensor"

bye,
Heiko
> Jonathan
> 
>>
>> Guenter
>>

-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

