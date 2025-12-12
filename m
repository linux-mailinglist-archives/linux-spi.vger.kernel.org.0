Return-Path: <linux-spi+bounces-11870-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9E9CB8000
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 07:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6686F300A6CA
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC16222580;
	Fri, 12 Dec 2025 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIDy9x1n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358E42A82;
	Fri, 12 Dec 2025 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519473; cv=none; b=Z+hghZ6hmNA5sWdYXhEiVOyYm4pSAYpAaIUWze0CxLnFf4hfBzkAPK29VJ7FkwBrZiwaGsRYvhhbnYUOgePwybWVSfqRmwBZJEkTPy28Xkv18MVsNe5COtpoUzYiIO12Dv1MKJQ0gB9LQe1vlVNJEnHGoupau5cx4DTMJMG41jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519473; c=relaxed/simple;
	bh=uBearAujaMcBjunA8JWS7rMsKebRWb/wH2rpPK/5zwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7gXRntQoy5GXvjKVAbQIQttEbtwFgj+iJgVN3sCZsgJvUCvHNcF0U6GdWWOx1prhR8hgZfXcCY4T9KdKtJm0EH7HeeYEGj5OvmZURmn3prUIFdwL6qkagq19KYBiPYdk8/LpxRq83336+rqT/K8jd7c2/XEvmBmRdFsESG3Zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIDy9x1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64190C4CEF1;
	Fri, 12 Dec 2025 06:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765519472;
	bh=uBearAujaMcBjunA8JWS7rMsKebRWb/wH2rpPK/5zwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIDy9x1ny4sqq4aszuGeHR1Q6feXRYgePZP6AT0EAoMLkOpi116EjaoTNAkevWb1j
	 +jg+bsROknQFbc3xMbXi9uRa/07xniUquacZkoPFl7SB/he6zdgiHQy0iXsLZWkxyD
	 gMvIoT9WTADFb6QjXpsf2HDylRs8FAfpLhP6NMCYcwx0LcNks4vgBEo2X+XiuLTivA
	 aRLAZQTUpIx6vsrNsXiRtRqoW1+KIvfcNJSzl+RRKo3HHTABCp3y3kZgiOE0zoUA0E
	 a3ycBT2mwMZrQPlvpfItOtdaS5Qp5CqptajYkAoHsUf1AP7j5IOnvTQgZuwkyi5nj+
	 WcohCU71Ch4Qg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BD3E41AC52A9; Fri, 12 Dec 2025 06:04:29 +0000 (GMT)
Date: Fri, 12 Dec 2025 15:04:29 +0900
From: Mark Brown <broonie@kernel.org>
To: "Dutta, Anurag" <a-dutta@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Gujulan Elango, Hari Prasath" <gehariprasath@ti.com>,
	"Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <aTuwbc_2jilukc79@sirena.co.uk>
References: <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
 <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
 <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
 <f804d7a7-4ffb-4d2a-bbaf-ca0a076a11ab@sirena.org.uk>
 <5525272e-7220-4352-bb08-ac66631108e0@ti.com>
 <cf8e7003-ebca-4817-8350-f29332d75fab@ti.com>
 <aTf6RRAveRdVnWQZ@sirena.co.uk>
 <1542ee8a-620b-4349-92fb-ab1f6c5b5eab@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxCf9/4byz5GQjK0"
Content-Disposition: inline
In-Reply-To: <1542ee8a-620b-4349-92fb-ab1f6c5b5eab@ti.com>
X-Cookie: It's clever, but is it art?


--pxCf9/4byz5GQjK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 12, 2025 at 10:04:47AM +0530, Dutta, Anurag wrote:
> On 09-12-2025 16:00, Mark Brown wrote:

Quoting seems messed up here - your whole mail is quoted.

> > I think we want this, possibly using pm_runtime_force_resume() instead
> > (not 100% sure on that one, glancing at the documentation there might be
> > issues though it feels like the intent of what we're doing here).  Can
> > you send a patch please?

> > Hi Mark
> > If we use pm_runtime_force_resume(), then for CONFIG_PM_SLEEP, it will work.
> > But, in case of !CONFIG_PM_SLEEP, pm_runtime_force_resume() returns -ENXIO,
> > because of which :

Huh, hadn't noticed an interaction with PM_SLEEP.  My thinking was
partly that this is convenient since it lets you know if runtime PM
isn't enabled and you need to unwind the clocks separately.  But I don't
super mind so long as we've got something that works.

> > Let me send a patch with pm_runtime_get_sync(). If changes are required,
> > please let me know.

Yes, please.

--pxCf9/4byz5GQjK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmk7sGkACgkQJNaLcl1U
h9B7CQf+O6pIEP5y1qvcEQJgAI/5Zw/V1apTLbaLvpfeNl4vgH8T04+YIn1z3TIp
wibPMw4nMpwvVBCBnmkvsUx4BouedHV/pytULCskr0cyYWJBOxPeZI+gKrwrkBKw
tdRb5bZPXyOAek1baTeUfVg45px0V4yAHGX8gv96mzbiYOS5RlWLIJQaVmCQ1kry
62IeixdN9J7EEJGFh2fz0czWYHFAi1v/pL5o0fahekUSkSs9OQAygNU7N+KdoKro
hq0uz2wT/9qseRUevmPFENjkVxkCq2NyZozV7nuMEJeh8ADFF4bsd0rxONn8hwCi
jEQvtrVDlSSnfLPTUjxDdV+EVmYSoQ==
=C4Sd
-----END PGP SIGNATURE-----

--pxCf9/4byz5GQjK0--

