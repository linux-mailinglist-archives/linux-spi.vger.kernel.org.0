Return-Path: <linux-spi+bounces-10155-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06442B86FF5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 23:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACF33B6BE2
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49FF2BE02B;
	Thu, 18 Sep 2025 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRhZVO+v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD22857F9;
	Thu, 18 Sep 2025 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229445; cv=none; b=ZGML2uNS+IRqa+CMhbrSUZr2zp9f9t/g6MzOcRUMhZu/OH+Cc1ryzTQj+9i4ZYhFxR4uGkTX/vVQMyV3I47RXJFl8V79Bv3N4qWe3FxyvlG+ZEeZ9Nz2UXjQzo2LHt1467F1mjKcEgN33njuH7OPhyJ7LrihVijlhNu+l2zW6N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229445; c=relaxed/simple;
	bh=pNpcSL9WFG/dfCK8Ux+dUJneofiCTUBlKDdEWDy6x0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dad+Mpr8AffmpMxlSZGB59uqYAbAzUDUQ6jNWaT9fxU2q0nTyB7RNtD3wDf5FSWoZgTP5DRXXhNtfOSRwXz9vGdAaVVstfj14C55AT/+y52ghFhVqJ7QZj4hkjssZoDf04SwWjXNXi1Prl11nGmf7DMLjHrH1VSB2AR7W6enK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRhZVO+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEAFC4CEE7;
	Thu, 18 Sep 2025 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229445;
	bh=pNpcSL9WFG/dfCK8Ux+dUJneofiCTUBlKDdEWDy6x0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRhZVO+vcwmGXhCry6oiRXlURjGYtfw4fMPfne7z1yxjUFyxvl0j52tR08yKLOJAW
	 dOijzPhLd/tZPUzGy8Xb6/aGhLeS8RwFk9Or4+jYrBLo1za/QNKH4z654YNp0xte0d
	 lXmpB1kE8aOKLVpjLuI2y1apXnEarTr4ncFmjFr3vZ2O7IIbjceeDWnwYSuHaq4qeD
	 iFLpYZcjaQEmu/KzxOy39LGSYo5Ww3MgRbI8bPpoomAq1nlEZtWbXqgLpOiPApyX+E
	 AGwA2ICVA70+mcHlzNSiKce4m1EMyCmSAzAOTg2YXkAGqHs1yTz4p9TdhZ6HWmQhua
	 2Ex7R7Kq/HRvQ==
Date: Thu, 18 Sep 2025 22:03:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	virtualization@lists.linux-foundation.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v10 0/3] Virtio SPI Linux driver
Message-ID: <2b128530-ed43-49e9-a9bc-2736a2d13da2@sirena.org.uk>
References: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ql5mcInMSvUHTFGF"
Content-Disposition: inline
In-Reply-To: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
X-Cookie: Victory uber allies!


--ql5mcInMSvUHTFGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2025 at 05:23:45PM +0800, Haixu Cui wrote:
> This is the 10th version of the virtio SPI Linux driver patch series which is
> intended to be compliant with the upcoming virtio specification
> version 1.4. The specification can be found in repository:
> https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

Does anyone have any thoughts on this?  It feels like we're mostly ready
here.

--ql5mcInMSvUHTFGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjMc78ACgkQJNaLcl1U
h9AoFgf8CxaSKWRQTF2EIc8YZmt6WWiIcgEkmLizccfnEBPfQUDBpvLhSPVaBd4+
VjpFlnBb6Yy8CiIIGKL0pU5M+5bO8oFY+jMr/OGLe+MR9ZvEJ1FrZ0/cQ8Ib4XIB
a5uMJKDNfhj68a5LIiY+kYEoZb8R2vSRegaEUisnMF336eGvCKMMXNPMREwXMMlY
16VZ0u/0LvCXqHg3/hbMq21ifDS9OYwMdswOgdyQsYbosvNI/D40Tx8UUGRUEcT7
FFqY1JU9FqNCDdFnOpDcDqG3ztm17xD9dGzwS+IXquFgP6CeA+TgwpFBCKbrmJDY
rTW+PGucJ4kFLHaqZhOkT+veSzPt+g==
=a5Fe
-----END PGP SIGNATURE-----

--ql5mcInMSvUHTFGF--

