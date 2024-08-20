Return-Path: <linux-spi+bounces-4260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557E958CD5
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C101C20FD5
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119CC196D9D;
	Tue, 20 Aug 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKxgbDMY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1D40870;
	Tue, 20 Aug 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173892; cv=none; b=N6nanV33D8SLv0cRyzP6SXqXJ+5Z/Z3EyGUromtdUrsDZOFcWIVY5oK5HbHUR2geH0y9UZ0oRFAkjA+twrHIupsnr+jfVO4VmT/J2t7etI0yDugid+0Jnaz8pQnmpAZl1srOHi2YdwoAfMc+U7tU2UQo7DH1qN3E90IVE7zustY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173892; c=relaxed/simple;
	bh=Au4hUTJTbCkKhr2LcUkV/0HjRXHSnr2Ik0R6LASt558=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6KQkfVB7T+69J96KXwRyEp9zf32iTrRJRUCSTpGKrD4p/KfuBXXvCrI0IwWuB3XAwiJoooOjp6FA+OQxff9A6nQvmGqE+nmvjOVrfMGXjepkrULaV9nPEUAps4L5x+iz1lstPrvgWjh+YHCTEdJ6NX4w2XZFKiE4Xa5Lq4RrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKxgbDMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8700DC4AF0C;
	Tue, 20 Aug 2024 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724173890;
	bh=Au4hUTJTbCkKhr2LcUkV/0HjRXHSnr2Ik0R6LASt558=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKxgbDMYZvHenHNuhV2sHVslcSPWiP+KbNqCQGz1lsLW+nQYDMv9pYwd8GZnIVYBk
	 Ei22cJTQrDpYJMWmwDn4/EV/x970SsPl8PGYlwcAuwcfruNNLsm+xiAoBsWnCAvTkz
	 yGUIqehoI/aEdZvCku0Y9wtJAt/TytOLs2oYKGKR3Xu8BK0Ry9w2Ph5KiyFt4xXdSq
	 9dQhbAeZcxjJfrvN00KyQQK+BVq5R4QrIAd0tnM0lCq5t8vfEdW9zcjvS7yEqIXnYC
	 BV+cO9vCdLO2cchZn2O7rJE1y14le64EBtzO2s3JheCsx9VZQz2dnnbwJIFX6CPU9r
	 H60NZs2UuOcFQ==
Date: Tue, 20 Aug 2024 18:11:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Revert "spi: ppc4xx: handle
 irq_of_parse_and_map() errors"
Message-ID: <f00bd6e2-19f1-45dd-8899-0f178196079e@sirena.org.uk>
References: <20240819195029.2388397-1-andriy.shevchenko@linux.intel.com>
 <f71823fb-4b9a-430a-92cc-0b9df446ce3f@sirena.org.uk>
 <ZsTH2cTcWQG9ltub@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w13DfFbMqo5gdab4"
Content-Disposition: inline
In-Reply-To: <ZsTH2cTcWQG9ltub@smile.fi.intel.com>
X-Cookie: You are false data.


--w13DfFbMqo5gdab4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2024 at 07:44:09PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 20, 2024 at 12:20:30PM +0100, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.
> > Look at what existing commits in the area you're changing are doing and
> > make sure your subject lines visually resemble what they're doing.
> > There's no need to resubmit to fix this alone.

> This is a pure and clean revert, not sure if we need to hide that fact.

This is not an issue with the word "revert", it is an issue with the
formatting of the subject line.

--w13DfFbMqo5gdab4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbEzj0ACgkQJNaLcl1U
h9CNFgf/TRGJNzvLsK5GRz/0EI+BuYg7LOZ+N+kfNMBQa7V/xCnUeAll5X8ti4tQ
XIxCARwLLarAEgxBMLeRqqLHSwfGjQIKd5nZGk6rkqLM535PV2IyJ5yP3gJb8TpT
WlvpJT8+mP4zjj6Ilu/baZ9zV3EZSwesppJL3Vk6DiRRmGoHcvKXkMVSMuRDWcTw
747OvCfIQbxh2o3YtzS5RamPtfF4LpaqISMRGT9js6w/+/lu9TTf27vaoT1NJkfx
w0u7buTWSbNI8zm92w3hYuF9+PPXhaYpfLRVi+VUv5Fz7StpE6MjxOnPZ34gXBSf
An3JzLmfOZz3ZXkQ9264T6k/HtE6aA==
=jmIJ
-----END PGP SIGNATURE-----

--w13DfFbMqo5gdab4--

