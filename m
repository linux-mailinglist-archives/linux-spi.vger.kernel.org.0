Return-Path: <linux-spi+bounces-9448-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF483B270DE
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FA87A9702
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196A125B1FF;
	Thu, 14 Aug 2025 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fr6mFjpj"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF751F1302
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207270; cv=none; b=sVYayJHpWrlgLDA0ZGijCp3oX+mVDMV2O5UPMuE+Bp/waV3D20ON8Wux+ILtr9OZfVDqP8W1kXjiNhuwUijKw0w5IP3970c4d6/Ogl5r0uERZPGwKwXux+7cVvGtrPpFv50fXf3fk/WK8D5HPtnuQkE9AA37a98uspPF9JctsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207270; c=relaxed/simple;
	bh=tgBYTFxojyYhsq3L2znxGzpSLso4z44wOo0YEEteNIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGgoi19cpeTDfTxLLbz5ROtSCmqWqMkbzvkg+5Hki/KGvhOvSO0Q9Zh1pmwiMTwYTTng0Vby1aSfDFSLlLqJtWGk9VXfi0mTR6nox0rvG/eec5O0XqZrFu0srDlyHRZ42D8wwo/fhib6+MBIjcB9QnD9WrS2uW/+6t/6/nShBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fr6mFjpj; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f5982e9-6f62-4bc8-87d3-a2d18a6d6aba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755207264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KWT4TAq5U72A4q56Qgy9kGseEvaQixIPL2uXHQI/oM=;
	b=Fr6mFjpj0KV+uh3aiH9HAqKAlSPZOlwXishJpVVd1cTQXNyOQa67Twq0S2ulAar7E2O44V
	gQtzamKyEOoO8bqY0BedT+nEUvA9F5gRiSbvwZG7Dj09q2yXcBHa7I4SUG1qU6yJoCSd8Y
	AGOahdt81af1c/MSHglx468niDM+Uuc=
Date: Thu, 14 Aug 2025 17:34:15 -0400
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <1a87f436-317b-40e0-a655-cd82f969f22e@baylibre.com>
 <5b02293b-9c86-441b-9344-2d0263eb1659@linux.dev>
 <5bbdddaf-4ff1-4cff-a933-143160896717@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <5bbdddaf-4ff1-4cff-a933-143160896717@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/14/25 17:17, David Lechner wrote:
> On 8/14/25 4:15 PM, Sean Anderson wrote:
>> On 8/14/25 16:55, David Lechner wrote:
>>> On 6/16/25 5:00 PM, Sean Anderson wrote:
>>>> From: David Lechner <dlechner@baylibre.com>
>>>>
>>>> Add a spi-buses property to the spi-peripheral-props binding to allow
>>>> specifying the SPI bus or buses that a peripheral is connected to in
>>>> cases where the SPI controller has more than one physical SPI bus.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>> ---
>>>>
>>> FYI, Mark's filters won't pick up `dt-bindings: spi:`, we need to change
>>> the subject line to `spi: dt-bindings:` on the next revision.
>>>
>> 
>> Sounds like he should fix his filter then.
>> 
>> --Sean
> 
> No, this is a documented expectation for contributors. [1] says that SPI and
> a few other subsystems want the subsystem first in the subject.
> 
> [1]: https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html

Hm, this is new to me...

--Sean


