Return-Path: <linux-spi+bounces-11872-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF51CB80BC
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 07:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94394303B18F
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD882FF673;
	Fri, 12 Dec 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWMLc14P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B55156661;
	Fri, 12 Dec 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521842; cv=none; b=fN8J8vAl44HPQe/ZPd0zEIek+2L6WWQGPK+pjU7I2RCuIlE0V5+QAdiaBvt/vOWROTJPuIxw3sBgYw6kWpBHi1DumW2MBTaRVWllG48T9CITgICOehyCnyDDrntJ13eAQdzC06W74X7oqBK4NWWdjjakgWkoxMuItClPjepBqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521842; c=relaxed/simple;
	bh=e+MiJjN9a6sAfk9AMDYgD4I4/4JmEFBVhrEgh4XGhGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCh7TQ7eCXcjOkTV8Di1pfvazT/YZzDiHi4mshMkXgRJWUJjWDKLeprfxkgLjzKPIcFSH+fm+1FhOGPcmWRgi2fCHtPHjHQcFL8RNiggk+nY3c2sRJ7WfhHlKQl2fOp42tMY5XYiMNxd7GXJXZoNt9p22HmVW5v63z5ys6uT/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWMLc14P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76EBC4CEF1;
	Fri, 12 Dec 2025 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765521842;
	bh=e+MiJjN9a6sAfk9AMDYgD4I4/4JmEFBVhrEgh4XGhGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uWMLc14PciX8mXrHs82QrqP34IaObOqq+aKTipWQSV7wNSDT/8DT0HEFfpqCYc6o+
	 FghlNvz/5vBncLTKwZvZkKqW58D8uLEtI0InvIJ+0heEF99xFgX8RgChWr4DfY5IT6
	 6AjWz4w8OoIcr0cnQrWMR36W/WteRf4Mll+UrzQnLo5HXeC/n24wSyBa8UgA548jev
	 0/kAQ6rCC8AvcvQYMuuZRgNHTPMAQ4klrIr5inf0qxiiunXi3zUVa9VOONlJN4BlN2
	 +sNG28hRnCse7lOUDSOGwaUHUFimUGp3ui2xP+Td908Ehom58SXAbpjwJXGsyhIji3
	 kx++7krXh0anw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,
  <richard@nod.at>,  <vigneshr@ti.com>,  <broonie@kernel.org>,
  <tudor.ambarus@linaro.org>,  <mwalle@kernel.org>,  <p-mantena@ti.com>,
  <linux-spi@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <a-dutta@ti.com>,  <u-kumar1@ti.com>,
  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <87v7io9c23.fsf@bootlin.com> (Miquel Raynal's message of "Wed, 03
	Dec 2025 09:58:28 +0100")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
	<cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <87qzunt4n4.fsf@bootlin.com>
	<ea19bc64-a775-4309-8f3b-ce9dd8ac02ee@ti.com> <87ecqcakjo.fsf@bootlin.com>
	<mafs0ms4j4fuz.fsf@kernel.org>
	<cf87ced7-aa66-4b15-98e5-92cb76737073@ti.com> <87v7io9c23.fsf@bootlin.com>
Date: Fri, 12 Dec 2025 15:43:56 +0900
Message-ID: <86tsxw6vyr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 03 2025, Miquel Raynal wrote:

>> Just to summarize, fallback logic during probe:
>>    - If the controller reports a tuning failure, the spi-mem client may
>> either retry tuning with the next-best (max-1) operation
>
> There is no such "next-best" variant once in ODDR mode unfortunately. We
> will have to return an error indicating that PHY calibration needs to
> happen again and just retry without it.
>
> As to when/if we shall perform it again, this is a delicate topic. Being
> conservative might imply just disabling the feature and no longer using
> it from a SPI controller perspective until SPI NAND/NOR calls for
> calibration again, but it is unclear to me when this should
> happen. Maybe we could trigger a background job with a low priority for
> that. But don't bother implementing this in the first place. Just make
> it work, make it fit in the current subsystems, just KISS. We can figure
> this out in a second time, especially since failures are not supposed to
> happen very often.
>
>> or fallback to
>> the non-PHY, slower operation and adjust the dummy cycles accordingly to
>> use the optimal non-PHY variant.
>
> Why adjusting the dummy cycles? I am not aware of a different number of
> cycles with and without PHY mode. It should be identical, no? The
> difference lays in the frequency we use, not the fact that PHY is
> active. And once we've decided a configuration, we can always handle
> slower frequencies, at the cost of a few 100kiB/s maybe. So I would not
> see this as a concern.
>
>> And yes, for now the priority is to have a robust probe-time tuning flow
>> before addressing any runtime tuning concerns.
>
> Yes.
>
>>>> But once we solve this, comes a similar problem on the write side. How
>>>> do we know if a write will or did fail because of a temperature change?
>>>> What may be the heuristics to fallback in this case?
>>> Santhosh, do you have any numbers on write performance improvements? I
>>> am curious if it is even worth the effort.
>>
>> There's no real performance gain for SPI NOR, but SPI NAND shows notable
>> improvement wrt. page size.

Yeah, that is what I was thinking. I have mostly worked with NOR flashes
and with those writes are so slow that the transmission time is pretty
much noise.

>>
>> Write performance numbers from AM62A SK with W35N01JW OSPI NAND:
>>
>>    - without PHY: 6 MB/s
>>    - with PHY: 9.2 MB/s

Nice!

>
> Eager to see this in SPI NAND (only) then!

I suppose we should have a generic mechanism in SPI MEM, and then only
NAND would use it?

-- 
Regards,
Pratyush Yadav

