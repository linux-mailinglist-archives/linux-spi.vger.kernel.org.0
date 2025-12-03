Return-Path: <linux-spi+bounces-11751-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330BDC9F3EE
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 15:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4EA3A35E8
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20DE2D63F8;
	Wed,  3 Dec 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqed4hwi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B825FA10;
	Wed,  3 Dec 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764771136; cv=none; b=laN6PCUAzE1Qysb2JlqKoylislQQXARee13PD3YvJtIVoQNWgnlsAgY/Rq1dvnq/I+envpVxOmCjyfYF4h/xxEI75xpT2VMMjhacoOQQErGCaQzLLThU2/nIBCxnjP35XCha1LVxlnz6+QDwDhSITLkEdNmF6Ogoqs3pkcYXIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764771136; c=relaxed/simple;
	bh=smbaWDGg/XgShh3qJ1kJgBiM9HCBn2o9QjOA/nMQgHA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ea0UmrsRIoQYEON07MJi0cbCuMDimLlOLwejDmmm+HKZffxXN8ewWkl/5AGs5KttjLJEGzeYaA/vpI75scoM15mtpmkJSHpNlOfYln8NmfFK3gqKO08D3qEXlmcsny2b0u2H1k2vOmDl31udVEUjYUOJItaa+Orl+vI2HOipqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqed4hwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0173C4CEF5;
	Wed,  3 Dec 2025 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764771136;
	bh=smbaWDGg/XgShh3qJ1kJgBiM9HCBn2o9QjOA/nMQgHA=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=sqed4hwiCoFNaVTddXS0Qs7ceF/63n7aHJob0t6Y95d271Z+o6SF8Ttg/KZ02HLts
	 SiEnV9cgctW2gz+IGkWqoLx6cp4XDjCBSb0b6YB+7drw3s/+7UGYYQxVnaPjWoMrAI
	 ohZOQSzJ6pIixCgAD3YHjsXj1XSv4tUgJNoFd52MiuN4AVM3z6RuiSVy66iPZ5/efa
	 VmRgAu0hG6pyWOyYNSC2lvn9edlrvyGkDUDpYXH36QS1meks8SZ+vuuCIe+CL2Pyr1
	 4mhgIanOKcPJGHjhEbvbQsxa/8aDtx8XMrFkLU4CkGeD+Wsk2AzaOjI52YyqL/7SvU
	 ZwHNED+xh2rCg==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6941430842e239d7e819f952f573a6859b1df98f21af7b294888dab18d54;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 03 Dec 2025 15:12:11 +0100
Message-Id: <DEON5LMMZLWG.21BQCPB0YE904@kernel.org>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
Cc: "Santhosh Kumar K" <s-k6@ti.com>, "Pratyush Yadav"
 <pratyush@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
 <broonie@kernel.org>, <tudor.ambarus@linaro.org>, <p-mantena@ti.com>,
 <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <a-dutta@ti.com>, <u-kumar1@ti.com>,
 <praneeth@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
X-Mailer: aerc 0.20.0
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
 <mafs0ikf74fja.fsf@kernel.org>
 <fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
 <DEOH4AUI33SQ.DGKJ4W258658@kernel.org> <87jyz3ao8b.fsf@bootlin.com>
In-Reply-To: <87jyz3ao8b.fsf@bootlin.com>

--6941430842e239d7e819f952f573a6859b1df98f21af7b294888dab18d54
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Dec 3, 2025 at 10:50 AM CET, Miquel Raynal wrote:
>
>>>> I think we should start with the requirement to have the pattern flash=
ed
>>>> already and figure out how SPI NOR or SPI NAND can discover that
>>>> (perhaps via NVMEM?).
>>
>> But we should also keep in mind that certain flashes might return
>> tuning data during the dummy cycles. I.e. the PHY might probably be
>> tuned on each read and there is no need for any pre-programmed
>> pattern.
>>
>> I'm not saying it should be implemented, but the current
>> implementation should be that flexible that it will be easy to add
>> that later.
>
> Conceptually, yes, but in practice, I know no controller capable of
> using just a few cycles every transfer to calibrate themselves
> automatically and reaching such an optimized speed state as the cadence
> controller is capable of ATM.

Then have a look at the flexspi controller. I.e. look at the LS1028A
reference manual "18.5.15.1 Data Learning with Flash providing
preamble bit".  The sequence is a follows:

<CMD> <ADDR> <MODE> <DUMMY> <LEARN> <READ>

There's an example with the learning pattern as short as 8 bit, or
- I guess - 8 clock cycles.

> Despite the end result being close, I would still consider this other
> way to optimize the I/Os somewhat orthogonal. If someone has some
> knowledge to share about the training patterns sent during the dummy
> cycles, I am all ears though.

There's also a short chapter about the training. Basically, it will
just compare the read bits with a predefined value (which is max
32 bit long) of 16 different clock phases. Which one is chosen is
not answered though (ideally it should be the one at the center of
all matching clock phases).

Now how good that tuning actually is, I don't know. But the
procedure sounds sane. I'm also not sure whether this (any?) tuning
will account for different I/O trace lengths of if it is assumed
that they have to be trace length matched for multi IO flashes.

-michael

--6941430842e239d7e819f952f573a6859b1df98f21af7b294888dab18d54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaTBFPBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gFxAGA345hIX5hVf+9gNV8VQGZ/W8e18oDeiPO
ouutCQKJYiK9yVJt7BxAwxMeRd06U7AmAYDZ6LvqZBAFmTXZ0Laz9hafCPqdLrsF
bGpFhMoP+zwdx97ipbv3m1PmbCS/nvLEEbQ=
=0tUN
-----END PGP SIGNATURE-----

--6941430842e239d7e819f952f573a6859b1df98f21af7b294888dab18d54--

