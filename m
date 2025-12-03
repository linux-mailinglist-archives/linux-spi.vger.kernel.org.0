Return-Path: <linux-spi+bounces-11744-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E2C9E78F
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 10:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91B134E17E8
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326692DCF4C;
	Wed,  3 Dec 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us8DYBBq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040662DCC1F;
	Wed,  3 Dec 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754108; cv=none; b=Uvz9LBc+w9NxWhcAtszJYcpuM4FI3c+WyuQ7abRQmZ3p+pZbol2+owgyCxPH0d8AEJPTLRb87oberDOfBGcFxJ2JX93fd6zqEdcZJkCyZbcuQdzeJBB1ZDbmpABoKRG4F6KOwLo7rRIBeRX9gVH07tYbClbs4tL4/F8rbDpKfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754108; c=relaxed/simple;
	bh=CWwFvw0Ffo2c4SWNjCrscOW5AF3wytpuiv8wECQFXXo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=se2/VTKyoBxiLBWu6SfzNyay3JLF87XCle6+hSVk7u5Ol8GkTPEh9Plq9Y+aBkPIJOeoGPh3Wmhfhit3mHbkr7saEHBh10NMarKtYvKiWIQMtU43TsezFuIXqhbDsYvG3Q40T8aGH+1PTJ6twNlzFmI/NSa6wYpAh/wozcZdXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us8DYBBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31120C4CEFB;
	Wed,  3 Dec 2025 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764754107;
	bh=CWwFvw0Ffo2c4SWNjCrscOW5AF3wytpuiv8wECQFXXo=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=Us8DYBBqBn/iiXU5PwRtkZeejmyIM/m3n+0dZodnPyiMWMtBt27yMGF/mgQ6y/WlV
	 sJtcDHpsEb/35OVAi5+SqJg8bnOKtL742LX4mibxe7pwzp5jwQZiWLjpBdI0l6zi3z
	 SCfhcWRwJgAEeZud7RbsYprTBbfZERkedNWBkilosWketm2Q2ZsJRWV8RJfqWnSkh+
	 XbCSEiICnnSjA0sg1Jp7GMANT5hj2AAK7M0dAXjuDEAkjNItayxlv6HWMyzeqftPyh
	 Wi/Cx8NpaF2LlaJU1rK3LiNgbjYRBs4ZTM+KSXEwMZgwkM9dEJr/zOAZmOqGSntYu3
	 vJBv6KnjYELlw==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b185b73c10f6ea43f717c58427e829611395f63eeecd3f3edebaeb91c380;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 03 Dec 2025 10:28:23 +0100
Message-Id: <DEOH4AUI33SQ.DGKJ4W258658@kernel.org>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>, <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
 <p-mantena@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <a-dutta@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Santhosh Kumar K" <s-k6@ti.com>, "Pratyush Yadav" <pratyush@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
 <mafs0ikf74fja.fsf@kernel.org>
 <fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
In-Reply-To: <fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>

--b185b73c10f6ea43f717c58427e829611395f63eeecd3f3edebaeb91c380
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

>> I think we should start with the requirement to have the pattern flashed
>> already and figure out how SPI NOR or SPI NAND can discover that
>> (perhaps via NVMEM?).

But we should also keep in mind that certain flashes might return
tuning data during the dummy cycles. I.e. the PHY might probably be
tuned on each read and there is no need for any pre-programmed
pattern.

I'm not saying it should be implemented, but the current
implementation should be that flexible that it will be easy to add
that later.

> For SPI NOR, we do not have an equivalent "write-to-cache" possible, so
> we still require a pre-flashed pattern region. At the moment this is
> provided via a dedicated "phypattern" partition, and its offset is
> obtained through the of_get_* APIs.
>
> Regarding ways to locate the partition:
>
> 1. Using NVMEM:
>     a. Exposing the phypattern partition as an NVMEM cell and issuing an
>        NVMEM read during tuning does not work reliably, because NVMEM
>        ends up calling into the MTD read path and we cannot control which
>        read_op variant is used for the read.
>
>     b. Advertising the partition as an NVMEM cell and using NVMEM only
>        to fetch the offset is not possible either. NVMEM abstracts the
>        private data, including partition offsets, so we can't retrieve
>        the offset as well.

You can probably extend the NVMEM API in some way - or switching the
read_op on the fly.

> 2. Using of_get_* APIs:
>        Using the standard OF helpers to locate the phypattern partition
>        and retrieve its offset is both reliable and straighforward, and
>        is the approach currently implemented in v2.

I don't like that hardcoded partition name which is basically
becoming an ABI then.

At least we'd need some kind of phandle to the partition inside the
controller node (and get the ACK from the DT maintainers).

>> I think SFDP is quite nice for this, but IIRC for spi-candence-quadspi,
>> that was not a viable option due to some reasons. If you can now make it
>> work with SFDP, then that would be even better, since we don't have to
>> deal with the pain of pre-flashing.
>
> The current tuning flow requires a specific stress pattern to ensure
> robustness, and the SFDP data aren't good enough for it.

Yes that is also what I can remember from the flexspi controller on
the NXP SoCs. IIRC they need a very specific sequence of ones and
zeros.

-michael

--b185b73c10f6ea43f717c58427e829611395f63eeecd3f3edebaeb91c380
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaTACtxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gPwQGA3pVjRWYMCqc1eSB5eDPLLYDqKikeOb0D
6np2eeX62CQweG6ungvmImgtjSg3Y5mxAYCFL7pAL6wxpRjpzQIFH28XO9Eb/kx2
LqOuvkazj3BekP0SXOaztI8CsQR2zRpeTqg=
=W84c
-----END PGP SIGNATURE-----

--b185b73c10f6ea43f717c58427e829611395f63eeecd3f3edebaeb91c380--

