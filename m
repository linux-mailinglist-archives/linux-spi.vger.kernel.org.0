Return-Path: <linux-spi+bounces-6228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D7EA02618
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 14:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A783A2A09
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDEC1DC9BC;
	Mon,  6 Jan 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOEv7qR8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101227726;
	Mon,  6 Jan 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168663; cv=none; b=en5t2b/Iu5ajNvfRVlgCFwvtZKnaQgneElrWxzhEhTNdzW5g81tG2jQPLWUnuFKmcvzjMRtKisWvqgJ1suz0PmKUDRGaNU3Fh7qEOr/3tPxWeFRVnteirVhI+cF9DI2nw3uabYWjise0zFjvsRz2EBWCB4aTh2QwW0pF+f9n6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168663; c=relaxed/simple;
	bh=7aq44VGDkBCQNqvBHv+dpF0hplN9cWjxpayf1j0Safo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdeiNXem/IKb7WNJOU3s8z+Xgu607fgudwRNh8MBAtI7y2mmPYitX5BemONFdbcIFKnW/OHdxsXKSnGC33hnz09TELyGhMLRz/whgEC/Gk/iOVQk/ix86s1i8FX17x/hH90BtucL4QzkL2nRTg2rq+hb5TBLnxQot/J0Dbmpp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOEv7qR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAE7C4CED2;
	Mon,  6 Jan 2025 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736168663;
	bh=7aq44VGDkBCQNqvBHv+dpF0hplN9cWjxpayf1j0Safo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOEv7qR8uGZusH6hLthd86fl5A0EzdYxMhSWIW6ZjJBVNRzwD85+9iIH1CfdCj7D0
	 v9iOY/a1csYDiRF7dm4M7kEbNaoZ1N262ER+GDPd2ryDvOkRMUg5uMGNzEXWjahBvU
	 k8+9XOs+asMnbRdWg1LQb4SLSg2G/8y6JpLHxzGKQnhAURidJkqDScG6E6240vHW4M
	 xsWLH/ccrmOIACkuGGZctEgiT205o8j2YBGj10tMXJo6uz+REv/tpd9XKkc7arMd+r
	 7pjXEs3PrrQWr3rzzqrXiF99LqReRu0Ics8BWpOc42/buXC9b7Zt69TNjca1hUTZcn
	 nihcH437wmi5w==
Date: Mon, 6 Jan 2025 13:04:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, skomatineni@nvidia.com,
	ldewangan@nvidia.com, linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH V1 6/6] spi: tegra210-quad: Introduce native DMA support
Message-ID: <5c374b9b-3963-406d-bc60-a3ef2de01772@sirena.org.uk>
References: <20250103060407.1064107-1-va@nvidia.com>
 <20250103060407.1064107-7-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oo7BGKmutRFo5nuK"
Content-Disposition: inline
In-Reply-To: <20250103060407.1064107-7-va@nvidia.com>
X-Cookie: Do not pick the flowers.


--oo7BGKmutRFo5nuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2025 at 06:04:07AM +0000, Vishwaroop A wrote:

> Change-Id: Icf3ef4767947cef67821c092ecd9ea6bccb2a4e4

Please don't include internal only things like change IDs in upstream
submissions.

--oo7BGKmutRFo5nuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmd71NEACgkQJNaLcl1U
h9A70Af/csKipaIUiuHJ0DPPWAlredvZI077owOEtD+aHfilRog7JjsAf2gP8VjA
+4Vla2CR6vwD9hrNCT4c0d7So4n81mHCRZeobvXTznkc0LQzqggIay/EtyPBQbgx
yTdR70ywCJYQf+e4NVfoR3GE10C+ExSwtkfs+jB0qtl5kcTBEsQ/HsVOfvIo9ZCf
yojopa336VzFX+53asOjMmRN+e/5e6mpg1CCREzYhKtJuAJfZx3TiScELIp1CRAO
Mm5nWw1n4k2YEeFYw1ZdhQ7ZaFH7ah+UXDHlaeIkqJuVX87ZeNpUzb7o9HASyxYw
c/BAZUaN9EqH10T9Nj9eHUFpuVIEeg==
=kYOY
-----END PGP SIGNATURE-----

--oo7BGKmutRFo5nuK--

