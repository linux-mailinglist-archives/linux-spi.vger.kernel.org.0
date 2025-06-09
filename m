Return-Path: <linux-spi+bounces-8416-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634FFAD2840
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 22:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496093B0CF4
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43600221F25;
	Mon,  9 Jun 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXrSKn0R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B88221DB0;
	Mon,  9 Jun 2025 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502794; cv=none; b=qX8s2ebIk96FNg+VDFTPKMuapnyGE7hOM1VrtCmndwJA+LhsG4dGQKmm2TVoaAl7lJUltmvC8RDEFIVqyZi15jnOGmb9Q2QZgfeHTNG3qYfdj9XIi02uksysqz+tfc8ZqB3sqCAGCrc13uQM/g1SI5NVzbw/9aiycE9UUu/ACTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502794; c=relaxed/simple;
	bh=HhXZSXZLO35D8QWVJipm9tjH8I5ZsK+s/Vom8tBqYsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAZ3273ntZFO69XCLzlbx/r941005/uToXPDGwWZ0+yY1BAUL/fRBTgMyyKPIfu28sT58J3kYCNUjr7YzFAHElBqxjMkGWgxkLTxKnd3k1esAbZrG5D28etAv+RVrW/fOoiCCZhVZaw1/pE3lU9yrgS/2tT9EYizhoyohaQ23NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXrSKn0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C55C4CEEF;
	Mon,  9 Jun 2025 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749502793;
	bh=HhXZSXZLO35D8QWVJipm9tjH8I5ZsK+s/Vom8tBqYsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXrSKn0RfMilXSK7MqCdv1wBNOsHj3hBqL+GK7n/7Cb5KtdmbdoeMgmJD4sdp+qo0
	 Ttms6ih4CkosKE6N3TdUAKfNWRRX5EyxTcQ4QLP+Ew5dDtEDCgyAwWIQN47j5BQdMA
	 ritEYYFO3C8JP8nZPxAZxztc1AnH5LTXAOdvnez4hn3WQp7RhukRUjv/+gkCuwt9ar
	 86cWme37MjfXkRmuPoDfqeZ2UeaerLWOUuEi+TfgEA8ka7vDSqwWk1Wd0JGc29DS9k
	 MIVLoIhHRbmaw9bwbC+ec2RPmur3nIzA60BwyVIgM7Ad1okVZ4/iSul/zhp3NsnjbR
	 3/DV+e4pH970w==
Date: Mon, 9 Jun 2025 21:59:46 +0100
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
Subject: Re: [PATCH v6 1/3] spi: spi-nxp-fspi: check return value of
 devm_mutex_init()
Message-ID: <7afc214a-affd-4a99-8528-c58c31fbcc59@sirena.org.uk>
References: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
 <20250609-must_check-devm_mutex_init-v6-1-9540d5df9704@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z+sgE4AtUlEKe0OU"
Content-Disposition: inline
In-Reply-To: <20250609-must_check-devm_mutex_init-v6-1-9540d5df9704@weissschuh.net>
X-Cookie: Restaurant package, not for resale.


--z+sgE4AtUlEKe0OU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 10:38:37PM +0200, Thomas Wei=DFschuh wrote:
> Even if it's not critical, the avoidance of checking the error code
> from devm_mutex_init() call today diminishes the point of using devm
> variant of it. Tomorrow it may even leak something.

I don't understand the comment about leaking here?  We might end up with
an unitialised mutex but how would we leak anything?

--z+sgE4AtUlEKe0OU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhHS0IACgkQJNaLcl1U
h9AvMQf/ZkJYeAwrUQ4F4rCGjAWVy17mDms38DGjaQ0Yq/1UKgmweOqRHNTFlHeQ
6UzQmRlWPrCfneewFmNi5AZJHLuf70gLYLtpnI18yoyyNv0hlGbPtpKVDExJR653
rU6OyzZgpntN4D6wyVZs1MStJdv/YECV8XCs0S25lgKvXFNhSuLzWCfO0QHGzHqz
RTLDs1STaeK5rJltaHSBESQ9lj9ho0mD3zQKZKwPwcfPU+GuCYHVkLjvxoL0+J7D
rbXVb+DRr8HStEPn3ZmrmlRbiPwopUTdTw5sfAWK7xTvx1kYeyGUR1kjEEw4u4A9
V8eG2ZFRaMNmxKTRgtlRWkU95uSHIA==
=t0MM
-----END PGP SIGNATURE-----

--z+sgE4AtUlEKe0OU--

