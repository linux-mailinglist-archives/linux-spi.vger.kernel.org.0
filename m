Return-Path: <linux-spi+bounces-11988-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD85FCC85B9
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 134B93019BC5
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF1362154;
	Wed, 17 Dec 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkfyormI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6E362133
	for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984189; cv=none; b=B9MQKI/MWcmVVcfSmf/kt+N/rkbKaSyh5hOfx3YRAirohJ8IkOd77dmckICBjyBCPQ1N2xUghlXUkYIWQhpYCo9QwOaep4t7ktNw8IYzo2YykGyZ9NTHnbqxwJjf4J/+8ubvDgI8xKBjyMDITUEzsMvaC9qVoNq+bQ8N27mbsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984189; c=relaxed/simple;
	bh=6FtIgWzhG4H478GuifMJD7OISTfw+RtajUUUI+7ws5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu00P6xHwQyHg4VChhAfICf7MTWD3t5omEQ7coIuBGOrDwR/4bbe4SfAe1kAw7RPusxDjQOUXFGOf8bbPCCLM/Uz1LT4bjWtpWA9CpdhaDPmHHTMhE1OLBnLz+/ODzoL3Zv6ghnOmE5SAUduxUf+6JwpDsKuuh+baMuQ4/6azm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkfyormI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99209C4CEF5;
	Wed, 17 Dec 2025 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765984188;
	bh=6FtIgWzhG4H478GuifMJD7OISTfw+RtajUUUI+7ws5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkfyormIr+NBiwfq1bd4BhDlNdk23ZV36Am3pdY5KeY9jOowLZObclyxR66GS7r/s
	 3b2uOxeirySIPKCHM0+mptBZZV49HS6cwvquqHeXe4gfv9V3kU7skNqdFmkgTP7oyf
	 8UVIgWPgQ2B7ljviAVmnYBUa5crQPWyYFr9sODL/J6/rge5pKFf4iT9qfDFP+JWR1h
	 yN+9LFEkN0WGKeVgUhtxtlOZlHzJUsp8S+Jz0mG/yFF9gaScumPyLzV7Bj6+Yc7/9x
	 t7zigp3VG4OTb2MqWFWwIp2bJInQb4VKN0Gxz27J77lGiR8DI00jNOT4X/OL/oeqxE
	 MGwCuhHLiGlLw==
Date: Wed, 17 Dec 2025 15:09:44 +0000
From: Mark Brown <broonie@kernel.org>
To: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"nm@ti.com" <nm@ti.com>, "afd@ti.com" <afd@ti.com>
Subject: Re: [BUG][RT][ti-j72xx] spi: cadence-quadspi: boot failed with
 rtmutex deadlock detected
Message-ID: <8bc899ad-9fd8-428c-8c56-97e56e8e45b9@sirena.org.uk>
References: <CO6PR11MB558695EFB87C578370014430CDABA@CO6PR11MB5586.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yRDzFvO9bnkRCfas"
Content-Disposition: inline
In-Reply-To: <CO6PR11MB558695EFB87C578370014430CDABA@CO6PR11MB5586.namprd11.prod.outlook.com>
X-Cookie: Big book, big bore.


--yRDzFvO9bnkRCfas
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 08:21:19AM +0000, He, Guocai (CN) wrote:

> Kernel:
>   v6.1/standard/preempt-rt/ti-sdk-6.1/ti-j7xxx
>   (based on Linux v6.1.159 PREEMPT_RT)

v6.1 is pretty old.

> It is ok at da3c5173c55f=EF=BC=8Cbut it is bad at 7083c6620486.
> I revert the commit(2c914aac952) which merged from stable release,  it al=
so ok at 18db8c7f20a6.
> Maybe it is a compatibility issue between v6.1/standard/preempt-rt/ti-sdk=
-6.1/ti-j7xxx and the stable release.

> if this is an known issue ?=20

This isn't something I've heard about before, and there are no fixes for
that commit in -next.  It's entirely plausible that whatever issue this
is also exists in mainline, looking at the patch it's likely there were
problems before this with the locking just not happening properly at all.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--yRDzFvO9bnkRCfas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCx7gACgkQJNaLcl1U
h9D/hQgAgro0Aid5Slst3JqgkZKn1ROB9habf2ZJLRBBjig3cHyD75+ZnICgHD9T
9imbrWd4S3lXKpDhLVywRIpqeK3oT+c6aYwV+cgeKO/nA9AgjAi+jI4MSfLieAUV
dbfaS1lodkwql+xR7NlYeE/Im4tOH0YdeBOP8UXjIMawT75wqR/fSVB0ospHHTXU
j+MooUOnUxBW5+ttXze5MSiGSva94LbPUctoh5XWOKWS/pzXYaTBAtqxLQMU3n4R
QAOVmj0w7Tr/o32Tfa74EjsYdUZIWgQbLGTq8WQZxx1+Fm23Z08Vxh6nIo39LCI1
pq9zvLbQN0mKffIS9QeN70kXl8+yZw==
=1MRQ
-----END PGP SIGNATURE-----

--yRDzFvO9bnkRCfas--

