Return-Path: <linux-spi+bounces-8426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C434AD3548
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 13:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B011885AAD
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE9217657;
	Tue, 10 Jun 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq4G5RF7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E33184F;
	Tue, 10 Jun 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555979; cv=none; b=bIKoZ+klkCKGBfGHdOG9SmDapdEhM9x1OZ3IMaF7OerqUuxf2turYY7eR31YJx6NQ9rupQFBZ5jesPnxLQjIrgTVz2orQJUq8Cr4z3UmDg/Xw35Sf6fxYcVwtL/W2Q41Cs1vqzZPTzaAFChinPJUq48tiiBYbqvvVzRAercGjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555979; c=relaxed/simple;
	bh=YibikXW00JUDmSUtGKV75M+LUkgeqXyZelMhzVfCmDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZMrOX/7p91AH5vZef6aWa2VzOe/j4/tzF4CKzqGwWrCc25xw33zlMlfEojJEeHXeC22u1UQYrVkOT0spw0V/BsgmGk2WubMVl31ntA783ShZl/bZiH1JRaMKfOFe0tanhPnZt1cypRNYVWKdHmC+gRQGPRjs49ozUtMg6Qdtlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq4G5RF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28407C4CEED;
	Tue, 10 Jun 2025 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749555978;
	bh=YibikXW00JUDmSUtGKV75M+LUkgeqXyZelMhzVfCmDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dq4G5RF7Eu+/4EdP/i+nSGo4QP47NeIsw0NQT77QTHds0si3J2dpCd9ZiDwMrVjMr
	 JgIYC/IycMwYHphJSCMv8/9lgst1D9qKNByLJoeIwzE+gX4BcgvS9wpSqVpdJ0M5Sz
	 tpYYyyJ2QxaVkQa/69wRCDTps5J2SGRiHCg00N7lw8zbsbMdQgBiCUEcVmC1Pf7ZDo
	 BQXUspMcWpT7UZMdWJykQTIy1cCKxNSTyJU00aRnbT9wjTYzy10NYaXTyCOM4yLQA/
	 qC0zXvB84Ir6m9+t3zWXysAlvZLhtaNL00AtkiHuX0zzh4gxwdCESOGSFUYTjDQ4ZY
	 FMBo7ixuE//7g==
Date: Tue, 10 Jun 2025 12:46:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/3] spi: spi-nxp-fspi: check return value of
 devm_mutex_init()
Message-ID: <d8d1ee94-ee95-461f-a5d8-040bb2a1cfee@sirena.org.uk>
References: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
 <20250609-must_check-devm_mutex_init-v6-1-9540d5df9704@weissschuh.net>
 <7afc214a-affd-4a99-8528-c58c31fbcc59@sirena.org.uk>
 <aEgBkROmEV2df4rA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlddIJtm5jpvAAgD"
Content-Disposition: inline
In-Reply-To: <aEgBkROmEV2df4rA@smile.fi.intel.com>
X-Cookie: When in doubt, follow your heart.


--qlddIJtm5jpvAAgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 10, 2025 at 12:57:37PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 09, 2025 at 09:59:46PM +0100, Mark Brown wrote:

> > I don't understand the comment about leaking here?  We might end up with
> > an unitialised mutex but how would we leak anything?

> In case if the mutex_init() allocates something that needs to be freed
> (in the future).

I don't see how checking the return value impacts that?  The management
via devm is still there either way.

--qlddIJtm5jpvAAgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhIGwMACgkQJNaLcl1U
h9DndAf+IDszF0KDE41cdqFp7QzU28ehipRQZ/2ImAVdikU6XvsSlqXgulFgPanN
lfk3V9B/9okKYjokFS+cc2d40vlbrE0UMsceGwnQfySoVqrdD62K43POtx1Jgo8/
qMKE5FwtNzZnq6dkuy3bLDH/8I+v2jhWs1mozB+euPHs6F1AgpREbYeIBhv6h0d2
Bd6o+qXpvuoxVEOmOS0cABcxvSHl+Tg6gZk7rM6VJKSEaxPlznwnJ+tJdK2Fv8WU
QOtRl595cqKywMdRyWTuQcdI3iS8mTIu7twIl0Wm/+S1TleZqZZb3trTsTyzfSRr
R3GugZLFMOZU8mXSwRxZltFqDKKMfg==
=POCg
-----END PGP SIGNATURE-----

--qlddIJtm5jpvAAgD--

