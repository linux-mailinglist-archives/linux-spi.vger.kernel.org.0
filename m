Return-Path: <linux-spi+bounces-9153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465BDB0D103
	for <lists+linux-spi@lfdr.de>; Tue, 22 Jul 2025 06:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714E91619FB
	for <lists+linux-spi@lfdr.de>; Tue, 22 Jul 2025 04:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF821DF247;
	Tue, 22 Jul 2025 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcg7UJCW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316131581F8;
	Tue, 22 Jul 2025 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160296; cv=none; b=hvb3MFYpWNYdBLZOEB8wlbomY7CC49+FlBb+T+x74Mjf+GlYyHbZU5P2TiqL+TJsfOutDRcyTv+YsPpFbtftfHVMgypBImtbbJqZ2jAm10k+9mUOBonCPpqptJECsLOLqbLYpWJagsODGRDUMyx6UTpOjaseS7dsb8f/gSaloa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160296; c=relaxed/simple;
	bh=6F5Za1FdmxKsTDVtryfn1tdiv9tDrOCpIXBGPPonZiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWkbBJZnnJ7Gm0NeomipSO+Uj6LRf3dljz+6ISs1YIgVwSVL6uPBM6QkYPvZMdZgBvdoeCwgXyzmNcN3F2xHeEcxSOB5n8eBYDRMu8mues3czMBn98OMoqyvX54RNhF9CH6SkFfLJfPh+BTjTgjQaLDAnknd7IV48kLV1jVkGe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qcg7UJCW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3220c39cffso4982530a12.0;
        Mon, 21 Jul 2025 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753160293; x=1753765093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hQqfu6KV2LEedciSC1FzGWW9xz4Dazd2sXJ7SsnkNfk=;
        b=Qcg7UJCWq2myLqwyKhxsVU0PsXMJFMUdMcXw9vRn8beNYMw45Uy+oNK1qP1QEeTe1x
         xk3OHkuViEaS+etuB5UUGfLrtLlJiBbBytjJVqQbNO9dle7XEiIurexw1odLeXohZFY4
         kvXZVhneYVKFwVukOfMWnDDjQIzXrv2ISp+dWt/iDW0HnxJZUkkrJvxdYYNDffhoth93
         JM/Ex9T13qsUwPBrs9+Kg0KE/arG3CQ8gzXq6iRvnVeDo8zm/VmveqDClEs1DDwoBCR3
         wm4Uh8cnc2pBj+T7JAdo7YY9vMXcEUHaOes+LHp+8jdfjQMiZ8kJaN9BFa7Pg+mPPfXb
         8iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753160293; x=1753765093;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQqfu6KV2LEedciSC1FzGWW9xz4Dazd2sXJ7SsnkNfk=;
        b=WE/wM9QoZFv1EgW9s/tJvFIHJmcL69khjkpe6DskGBRAXwACq3mCqnqwMFIfUfvHHU
         1KDQoS+ih134RMQxiu3HZJIuKBiaLFqXjEib/RrIeeQjIN+frbeueVlIXxcbSH+oKe0L
         1LKIMd9GCDQOsE/pWZ+NmbZoxrJJnzHWmpD/nfd4Bc1xgQbwqwnKvFT0msy5aKtoeDZT
         AVDwSxEQ+8lFUBkb7QuozeB+ou7i4K7N+mtll312Egw978VqN3tL38CM9ik7Hs1UFyHk
         wVhyG0ekan4NPjBenwOnLkAxY2B3Cg0dZmmrQY0er9DRHA1UzyR3fq27zw+XqCoCmtDJ
         5SIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHwY8enFvIuf71DGmoEYA9DoA5g46/QfM05omMB9HPLP62zyMbbzjmrD7v9ZaOb+v6i2bCJAwpS9X7@vger.kernel.org, AJvYcCXw/l9Ir+9osVjKWpqwsWoqDXuuBFEl6w8zqcJOwflJnXgHTxVdC9EZ16gFWNNFGaAlFNps3zULZhpR@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7q7aS37iRDIj99/qKqgvtOpQguT3sIg1vIrpw2hTEmpNH6cx
	1cZBWhMjpeBc/JJQ6aMpuKbApV0NLeYm+x9X+pPx1PGiCE1mwa1sFEf5
X-Gm-Gg: ASbGncv09L+KdN5UOj7vtwNpznahR04bKFU2g0r/P9ghoJ2RDnWmPqeSHCl19z7cFbX
	QatVaUXEoBiEnnblkEvwIzVmZ403KUUrEHkPcPiFlc54ydPlhD8i6FbWJ1j9Ad7ZoErlETIED/r
	5JLXYbJ6IpvQsKaWRzL32YgxCikC6L8J2yOylsCPRftfg6GfdaiBG4k06pug7YVA6UP77c4835d
	yN5BfmFoDhtrzN9KWE//Kq8zL+zBk15vOcQ+Dp2NpLkQBMQRkAG1gX9csXgx4ai/nmNYrpA0QDh
	+aqd4b8lkvv8NqAHg8msMczuZTtnmy9bEtuHvoGpR4dkv0miWmnYf3vvTUo4YrV9sq8GWdfCqjN
	ch9491jE+SfSb3+ikDXm83aFM+pF5YbxQIH3Bty7Q4O/zafhWx6uQnkeOfdQU9Ctkc89UzuY=
X-Google-Smtp-Source: AGHT+IFONxPppaW3ozIBQzjr6I8fgJ+phfZt+V8YLrEQddIILmr1qCkBYP+C9eg364XGludvSH4+bw==
X-Received: by 2002:a17:90b:184d:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-31c9f3c6068mr34563581a91.12.1753160293400;
        Mon, 21 Jul 2025 21:58:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f44970sm7172415a91.39.2025.07.21.21.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 21:58:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2e9c96c6-6dfb-4232-a9ab-a3e78b718fc2@roeck-us.net>
Date: Mon, 21 Jul 2025 21:58:10 -0700
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v1 0/3] spidev: introduce trivial abb sensor
 device
To: hs@denx.de, Krzysztof Kozlowski <krzk@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrei Lalaev <andrey.lalaev@gmail.com>,
 Chanh Nguyen <chanh@os.amperecomputing.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Grant Peltier <grantpeltier93@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <8a8106ea-83d3-e02a-9ae7-ea4a66e4c248@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/25 21:05, Heiko Schocher wrote:
> Hello Krzysztof,
> 
> On 21.07.25 18:24, Krzysztof Kozlowski wrote:
>> On 21/07/2025 17:56, Mark Brown wrote:
>>> On Sat, 19 Jul 2025 08:33:51 +0200, Heiko Schocher wrote:
>>>> This series introduces the changes needed for trivial spi
>>>> based sensors from ABB, currently operated from userspace.
>>>>
>>>> The last patch adds the spidevices to the DTS files, already
>>>> in mainline.
>>>>
>>>> make dtbs_check showed no errors/warnings for the dts files
>>>>
>>>> [...]
>>>
>>> Applied to
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>>>
>>> Thanks!
>>>
>>> [1/3] dt-bindings: trivial-devices: Document ABB sensors
>>>        commit: aad2f87cbcab56b322109d26d7b11842a09df91f
>>> [2/3] spi: spidev: Add an entry for the ABB spi sensors
>>>        commit: d60f7cab7c04944a79af16caa43c141e780a59c6
>>>
>>
>>
>> That's unexpected, Mark. Patches received two objections/comments and I
>> don't think discussion was resolved.
>>
>> ABB is huge company, probably making hundreds or more of sensors. The
>> patchset basically claims that all of them work with spidev. It does not
>> providing any model names or details, so it seems really incomplete to
>> call them trivial devices.
> 
> I do not know how many different sensors they have, nor if that department can
> speak for the whole company...
> 
> What I have as information is:
> https://lore.kernel.org/linux-spi/2477dc64-92a0-9dc9-d168-56646d0d796e@denx.de/
> 
> and I get no more information about them currently. May I should
> add some sort of trivial into compatible name? Something like
> 
> "abb,spi-trivial-sensor"
> or
> "abb,spidev-trivial-sensor"
> 
> which makes it clearer, that only ABB trivial sensor, controlled through spidev
> driver, is connected here?
> 

FWIW, I always thought that devicetree is not supposed to contain such generic
information. Is it even appropriate to list something like this in devicetree
in the first place ?

If so, what prevents anyone from submitting hundreds of
"<company>,spidev-trivial-<device-type>" entries, using the same line of argument ?

Guenter


