Return-Path: <linux-spi+bounces-8630-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DD5ADDBF9
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 21:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBC7A209A
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1324521771A;
	Tue, 17 Jun 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDm18xTi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F118F54;
	Tue, 17 Jun 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186947; cv=none; b=lFIVjXioyChV+cSVRJ0XHB5FoduSfjmIDS3v80tN0Fv5Sz09qPz6Djej1+bZL5MSzucR0izOzX7HU+jacRlRYIgLlgUKf6ouQgj/0x64q0DlAjsAIkejpgwgxtrglIVeIdjVr08sVRDiXMhH+V3mi6Z9iFiP7EEdX57EyP3HBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186947; c=relaxed/simple;
	bh=R6HIk76NDv1XIk8WybWPXOJkOb7X10okP0rTRuTfkpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFGYvj3lG4JkzUBPRjSFPK7y0rikhlkmfx/Z/W6Jf+ai++QGbrJxbyZC1OD/IqYCxda0AxBab0DfkXZTMeYN+DcL9LRAXEP29jqUUMO7XuRgcy/vmRbTcguAAP/qOLFBlhYCBmD1/LWw//vKqbp8i66FTwb46hrYyRUv6tGN9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDm18xTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF65C4CEE3;
	Tue, 17 Jun 2025 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750186946;
	bh=R6HIk76NDv1XIk8WybWPXOJkOb7X10okP0rTRuTfkpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDm18xTimWFNcL6/ygxtCwBlM3/uGMreMhF1zB5bMe9APb0AYy5tNaEwj0equh764
	 Scq3LzjJqQMbyq/pf21x489pq7Tm7oMsPF/chSxt2AYdVx2xQJbNsaKPYMv9nKNRJn
	 jmaKMs4yXIK+huPjVlvCVCL06cKGuRN1krg+LhASZfYcZT7H9Ii4y4VbziJE0fRrao
	 oIhktH72tb2nYFn++hUb2FbF7R6+G5JBI7PQHnOIpvFq2WgU9lwsCFYSvAl3Wu3z85
	 TEEYxkhXdkfttsJ6QSFbgJQ8cU8/YbDA1Qjf6s20TIubW3OSZ9eS/idVfw7xsWxkEt
	 6ChK1MQmWuzfg==
Date: Tue, 17 Jun 2025 20:02:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 1/3] spi: spi-nxp-fspi: check return value of
 devm_mutex_init()
Message-ID: <41c9baef-5c86-41ff-8a95-0cac18d8d558@sirena.org.uk>
References: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>
 <20250617-must_check-devm_mutex_init-v7-1-d9e449f4d224@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eZcz5BBWoAZIa4y4"
Content-Disposition: inline
In-Reply-To: <20250617-must_check-devm_mutex_init-v7-1-d9e449f4d224@weissschuh.net>
X-Cookie: It is your destiny.


--eZcz5BBWoAZIa4y4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 07:08:12PM +0200, Thomas Wei=DFschuh wrote:
> devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=3Dy the mutex will =
be
> marked as unusable and trigger errors on usage.
>=20
> Add the missed check.

Reviewed-by: Mark Brown <broonie@kernel.org>

--eZcz5BBWoAZIa4y4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhRu7sACgkQJNaLcl1U
h9Djzgf7BjmyCihz/P6gU0L4P94mhmO5dgXIPIxPiwFT3Mpl2kAzQWGYY6JeN8T2
dH4XWEPagzh09mHdcCiV6HhFRgMFs2d3ELDE/gxgzjEEK5WNFI6rgQxvf8MENvgm
bSTkSPPZlcxn8TJyvr3kbPtU0roSEwrXkRUJIXwKnWPORqGxlTSfOP2LLNLF5klh
kvQMcwJ8S+Q/QuRoEJanrPAzIDvyl7PZZfSoqH+ZLEP4opBExbtUFQRsEJ8qNByd
dSejPKSktzkN3cEOFw5JeN9aLDCrEIX/0u5ImnTO7LfqKJG4T1ieV7dRBamnO6M5
nJp2GTTvmdeA0DS6IE3sJKn0OLrlzQ==
=iZ19
-----END PGP SIGNATURE-----

--eZcz5BBWoAZIa4y4--

