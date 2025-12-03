Return-Path: <linux-spi+bounces-11736-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABA2C9E53A
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 09:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8C33A25DB
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B372C21FC;
	Wed,  3 Dec 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sel8Ga0j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4D1E8826
	for <linux-spi@vger.kernel.org>; Wed,  3 Dec 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752320; cv=none; b=OMEkSsco/JDfVDBzfjudk2iGqPUAz/0QuKFwpvXH7Nd0cymwTwX/aKVAxxoJNk3MMc6KvE2/og93loC0WDkbWIFfGQxmenlpHea4WC0RUA6oy4WpHHLKnNKid3AMIHJhXkw72hAo35JrViL9+/roAbsEpbhnfT74jIMpPwGbPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752320; c=relaxed/simple;
	bh=oGsRKgrYJGAVSKZ/ovoFDXGg2Ro3i22NQSPWupS8f84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y4SSu5O8xvQo3v2oT4sBjXtdUGobmD4WMEiuQ3eTYU66rfG4O3HpeWvVGyB+1vaE6T3oODu6LhsEsMcHxaEIxeNYX288qqg7TmnzsxF3Yeqjyn2i9xGccenYVvOpqdunB2MA7cU6YYS8GMCZotN9hUCFGAP/BiPIHH+xUuu3ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sel8Ga0j; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 224D8C13573;
	Wed,  3 Dec 2025 08:58:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69E8560706;
	Wed,  3 Dec 2025 08:58:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B6CD11920028;
	Wed,  3 Dec 2025 09:58:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764752314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=46tD3zsoJ4hX5zvhzFuvsgVMFq9fE/0WHdvp1aoe7Eg=;
	b=Sel8Ga0jVQVhgT3EqCe5q36TTTI9aH9UaDfHKXlQy1W1weC3Zd7H0qELeXsqyUmXnSTcgI
	K1KFD1E9seeGqoK8vkMFQoXUk69HU45ufqDaC7QmCjJzrmAzxFj9A5YR8r+O40l0Ot57n/
	sEcoGcye5gnzetrs/7W+WhjiKOdTat0nCe1dyGhZO5v1bAGBSssZY92gCiTzHicxIIrMPS
	HvhG7pNrc1gshBrpk7vM4my8KlPLl/os+GNABX1ozthdEbv19qjaEM1WXl694K60oARiLa
	yWo7FjeWXQL8IQmIOGAfmaWhdVSt9dC/yNCaMRV6KHMQcWketmSAn2InwjDi0w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  <richard@nod.at>,
  <vigneshr@ti.com>,  <broonie@kernel.org>,  <tudor.ambarus@linaro.org>,
  <mwalle@kernel.org>,  <p-mantena@ti.com>,  <linux-spi@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <a-dutta@ti.com>,  <u-kumar1@ti.com>,  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <cf87ced7-aa66-4b15-98e5-92cb76737073@ti.com> (Santhosh Kumar
	K.'s message of "Wed, 3 Dec 2025 13:32:16 +0530")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
	<cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
	<87qzunt4n4.fsf@bootlin.com>
	<ea19bc64-a775-4309-8f3b-ce9dd8ac02ee@ti.com>
	<87ecqcakjo.fsf@bootlin.com> <mafs0ms4j4fuz.fsf@kernel.org>
	<cf87ced7-aa66-4b15-98e5-92cb76737073@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Dec 2025 09:58:28 +0100
Message-ID: <87v7io9c23.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

> Just to summarize, fallback logic during probe:
>    - If the controller reports a tuning failure, the spi-mem client may
> either retry tuning with the next-best (max-1) operation

There is no such "next-best" variant once in ODDR mode unfortunately. We
will have to return an error indicating that PHY calibration needs to
happen again and just retry without it.

As to when/if we shall perform it again, this is a delicate topic. Being
conservative might imply just disabling the feature and no longer using
it from a SPI controller perspective until SPI NAND/NOR calls for
calibration again, but it is unclear to me when this should
happen. Maybe we could trigger a background job with a low priority for
that. But don't bother implementing this in the first place. Just make
it work, make it fit in the current subsystems, just KISS. We can figure
this out in a second time, especially since failures are not supposed to
happen very often.

> or fallback to
> the non-PHY, slower operation and adjust the dummy cycles accordingly to
> use the optimal non-PHY variant.

Why adjusting the dummy cycles? I am not aware of a different number of
cycles with and without PHY mode. It should be identical, no? The
difference lays in the frequency we use, not the fact that PHY is
active. And once we've decided a configuration, we can always handle
slower frequencies, at the cost of a few 100kiB/s maybe. So I would not
see this as a concern.

> And yes, for now the priority is to have a robust probe-time tuning flow
> before addressing any runtime tuning concerns.

Yes.

>>> But once we solve this, comes a similar problem on the write side. How
>>> do we know if a write will or did fail because of a temperature change?
>>> What may be the heuristics to fallback in this case?
>> Santhosh, do you have any numbers on write performance improvements? I
>> am curious if it is even worth the effort.
>
> There's no real performance gain for SPI NOR, but SPI NAND shows notable
> improvement wrt. page size.
>
> Write performance numbers from AM62A SK with W35N01JW OSPI NAND:
>
>    - without PHY: 6 MB/s
>    - with PHY: 9.2 MB/s

Eager to see this in SPI NAND (only) then!

Thanks,
Miqu=C3=A8l

