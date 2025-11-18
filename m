Return-Path: <linux-spi+bounces-11274-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4AEC69A61
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 14:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 777073840BF
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D83563F2;
	Tue, 18 Nov 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naSJ79qd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717635580A;
	Tue, 18 Nov 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473337; cv=none; b=sKud1RTBmphN/xah3O0cz/9TjdnkNDNuBDSA0K3rQ9jad283PjFM3O/xj0S8jlv4tOe/KKl2ZuhZglQ0MlzttW6f+ZGOhauE/g9Lw3dDDcasB9nW9amVkn/lX/nadLln0/J66LaQUpdAYbw1/g1iDgq+SHEC5mqXkZmVTspoGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473337; c=relaxed/simple;
	bh=2B3RBOSE7CmxmQYzvtH+hFm8q9HZRTVj8NG7RykYiWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXXxtrjfSbVE06PWU1zeu+3Ol62Px/ryiiedXRp1kzSwUDOsmkfpbiJAsC43gGLcVxfHJpbJAUcd9KHMBLBFmJZkc8mtr/t+Fi23D/32nq1mY+Jp4VBHStwz1tEl8eGZXV8yCJTM57ABxKIWI8QcmydQ1BOEeQvNpcwU7fKhVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naSJ79qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A79C2BCB5;
	Tue, 18 Nov 2025 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763473336;
	bh=2B3RBOSE7CmxmQYzvtH+hFm8q9HZRTVj8NG7RykYiWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=naSJ79qdLKjk294duczCbiAbSE5o9fUwqTO8UYXwo2bOwQKNMoO7O7kNJiOqBEuTP
	 oXc6bw0WRc5esLsVaF0JZ+aAHaroxNByPNGlCpDw2gesNZlo9BBvi36cE2lr3vVzsR
	 IiwqI4P/kYSlXW8q8216N1O/Ad2L8mZDxP9EFxZlpfjaphsYoQHxsh9os8WOrTbYe+
	 Qgl/xkr8mH8p+YtPg2hbOERFsX0jxQjuJdrVKMVWjKypCXzz5L6zBb3BUVSzDGte+q
	 CU+/SViotc4kRI/oA1gODPmdSKfFu+aGFn59auP1BJuE1pVhavuIlUTMdFze1DjOKd
	 q/huUdixl/jHg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Santhosh Kumar K <s-k6@ti.com>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <broonie@kernel.org>,  <tudor.ambarus@linaro.org>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,  <p-mantena@ti.com>,
  <linux-spi@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <a-dutta@ti.com>,  <u-kumar1@ti.com>,
  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <87ecqcakjo.fsf@bootlin.com> (Miquel Raynal's message of "Wed, 05
	Nov 2025 10:35:55 +0100")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
	<cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <87qzunt4n4.fsf@bootlin.com>
	<ea19bc64-a775-4309-8f3b-ce9dd8ac02ee@ti.com> <87ecqcakjo.fsf@bootlin.com>
Date: Tue, 18 Nov 2025 14:42:12 +0100
Message-ID: <mafs0ms4j4fuz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05 2025, Miquel Raynal wrote:

> Hello Santhosh,
>
>>>>     - On tuning failure, retry by re-running spi_mem_needs_tuning() wi=
th
>>>> the second best set of ops (max throughput - 1)
>>> I would like to challenge this need. Can the same calibration fail if
>>> attempted multiple times (eg. because of the heat?) If yes, then we need
>>> a fallback indeed. Otherwise, I'd be in favor of just failing the
>>> probe. Calibration is an opt-in -> users must allow a higher frequency
>>> than they use to in order to enable the feature?
>>
>> It's possible the same calibration will fail intermittently for
>> different reasons (temperature changes, as you mentioned). If tuning
>> fails, the driver should fallback to the non-PHY frequency so the flash
>> continues operating with slower reads/writes rather than failing the
>> probe (availability should be prioritized, right?).
>
> Agreed, if the tuning may fail we must fallback in this case. However
> there is another situation that must be handled in this case: once
> tuning is done and we want to use PHY-optimized paths, we must fallback
> to more basic/slower reads if for some external reason, they start
> failing, right?

How would you even detect that your tuning is out-of-date because of
temperature changes? You would need some sort of on-flash ECC to detect
that. I think many of the flashes that support DDR reads at high
frequencies also have ECC, but AFAIK the SPI NOR core does not support
it.

Anyway, I think we should limit the scope of the problem. Let's first
start with the expectation that the tuning supports the whole operation
range of the device. This was true at least for the spi-cadence-quadspi
tuning that I worked on when I was at TI. The tuning parameters had
enough margin to ensure it worked for the device's whole temperature
range.

If there is a tuning algorithm that can't do that, then we can extend
the core to either do ECC or perhaps let temperature sensors signal the
need for re-calibration.

But for now I think it is easiest to just ignore the problem and focus
on the other ones like how to get the calibration pattern and how to do
the tuning.

>
> The obvious choice in this case would be to let this error handling to
> the controller driver. Re-using the same operation at a lower speed
> would be suboptimal, because the fastest operation at a high speed might
> not be the most efficient at slower speeds due to the number of dummy
> cycles needed,. But I believe this is negligible based on the fact that
> we already are in degraded mode at that stage.
>
> However, this may conflict with:
> - read retries
> - continuous reads (?)
>
> So in practice the fallback might be needed on the SPI NAND/NOR side
> (this can be further discussed).
>
> But once we solve this, comes a similar problem on the write side. How
> do we know if a write will or did fail because of a temperature change?
> What may be the heuristics to fallback in this case?

Santhosh, do you have any numbers on write performance improvements? I
am curious if it is even worth the effort.

>
> Thanks,
> Miqu=C3=A8l

--=20
Regards,
Pratyush Yadav

