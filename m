Return-Path: <linux-spi+bounces-5293-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817319AB43A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BAF28512A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BC51BC078;
	Tue, 22 Oct 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc9i7BsK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0D1BC067;
	Tue, 22 Oct 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615161; cv=none; b=QRdRTBlPF3ldohpy0LtbqzpkjwPTgTXTICna8XZvdzuM0t/D8NYihPCEhm3ZwLM835koQv4qU2QtdZtaj6LFDhnaWrmvkIzJrCgPW8jV6Zr2TjI/OeuO8ls8AgVobaPk703Wokrww2tQpi39swdTyaS9Q899HtJ/29Qe+edpusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615161; c=relaxed/simple;
	bh=Bg16sVs+saKq7TsP84v0KZu00YD98S7+gFpODRt+Z6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSsfLu43EWzVxGXxlQsEXMAzXl6bK5X43H7c4bSqeudR6ufn0fHQgf7dpYkkv1vjFlJBaWeybR7sr786ugTC/qTawJnZ+fniQ0rr0xTxo/YRtH5SOr5SvW5KI9MfJjjv980DKTL4at+2Ur2PYQspnGbuM6bt8c2/oV3P2BXWdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc9i7BsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E44DC4CEC3;
	Tue, 22 Oct 2024 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615161;
	bh=Bg16sVs+saKq7TsP84v0KZu00YD98S7+gFpODRt+Z6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dc9i7BsK/ryhwWNhwk59NHgbw7OF4Tp8xi2W7/JfKXNtn5m78fPiGGcLu3/fhqggj
	 uYoZ5l+sMykMrGh6Np8LT7euLwMkZKh7ofnuPWRxd014mIJS6JuCj77T2/IH25qDFf
	 94dvbI/r+d2wIJBnnXvicqQgebGxBzilbkTGj5VjHJwbxaSAY+DsoBnRemr7Fx9X3j
	 McVVhDeYjt0qHh8sdbBG8Tx6pqo1KSN/h3tyuxmB5LiLqOHdGMxFH1Er95sCY/zqaF
	 QtRo94Vn9HwxzLMLPRn8mKeVhvTgihrrS4AIfCQSuY204EwRFgxCOEON+xPOoH68oD
	 FQnNd83FbVikQ==
Date: Tue, 22 Oct 2024 17:39:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Dhruva Gole <d-gole@ti.com>, Yoshitaka Ikeda <ikeda@nskint.co.jp>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@pengutronix.de,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Subject: Re: [REGRESSION] spi: cadence-quadspi: STIG mode results in timeouts
 for Micron MT25QL01 flash
Message-ID: <1127989f-3175-49c0-9611-e30194b04018@sirena.org.uk>
References: <c2cdfba1-afcc-4a77-8890-7da49c4b73c2@pengutronix.de>
 <43b6b750-3f7d-437f-a62e-ab2dba06827a@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d9hsVPxY3QJhX2wh"
Content-Disposition: inline
In-Reply-To: <43b6b750-3f7d-437f-a62e-ab2dba06827a@leemhuis.info>
X-Cookie: Surprise due today.  Also the rent.


--d9hsVPxY3QJhX2wh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2024 at 11:58:07AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:

> The culprit afaics was merged for v6.3-rc1. Makes me wonder: would
> reverting this now even an option to fix this in mainline, or would this
> just lead to a regression for someone else?

Given the description of the original commit I'd expect so.  My guess
would be that this is either tuning of the lengths involved or a quirk
that's needed to disable STIG on some devices.

--d9hsVPxY3QJhX2wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcX1TIACgkQJNaLcl1U
h9CsXgf/bBXt4IFeAskPVOcT61kB5L+hdPjs32QQw3/Kw7c0PG0Rt+MplzQm6H8r
cV6YYhk0qlRmIOmwC8Z24KkTgxO/gPjZvf3pVTWQrUauvWhgQQcjmi119pps4BdT
prqj1mWkcfmPy5dizf7zPFlwyJk9nhUhsjUDVcZesH+iMQmBTDPsfhJv9/PacDgM
g+J+lat0vUs5AV+J8muKhs4h++ReEbcWETy0CXeTfOv8OsaaG0tdG4AZ5Vt5ie6+
jsvb5wZl51sMvr5+LwmqxcULh3jso6XrN2r9369JcCbwT0XgYDFRENEs/4eFWe7e
v2OQYkmJ3dFo8xgd0lyTv2sCOza0vg==
=Wvbg
-----END PGP SIGNATURE-----

--d9hsVPxY3QJhX2wh--

