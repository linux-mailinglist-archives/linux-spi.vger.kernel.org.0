Return-Path: <linux-spi+bounces-7316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F7A7170F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 14:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCF71890018
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCD41DE3DE;
	Wed, 26 Mar 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRh4OKmc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8B1C701C;
	Wed, 26 Mar 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994270; cv=none; b=tHQQr9pg49wPtO1mg8RdY7Zn6QxBIvUdUjdF4iK8tmciiMukdzIQwAPRWARyOZCCrzqdzbHeXWdt+oGzhVmeN9ZdpNN1/DKA8UY255W1lbuA4M/bYTiab8iFIUymFA43KdqK/6ujOqjgf8yT/beHC9BGs18T64dv4y6q/eRGAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994270; c=relaxed/simple;
	bh=KDANuWDZlRVtR6lwucYZCGj0Psq7ZuBgCEMzfQRPj8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK2mSKTdrk2StgMPSsA2UBno7Kh1ro++83AqTi2dhaUY0UV1+p8Pmqwgv9kkbUa2oCqnSpG7G5frUDKVDZ6i77Mr+NdeKBXJEjIqip3vfAnIokY0ZqhBAq26wWpf1PF/CsnT6A5wxS8yDadWHlfGDqgE/NoOmmUDIPM4CDp/Hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRh4OKmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A12C4CEE2;
	Wed, 26 Mar 2025 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742994270;
	bh=KDANuWDZlRVtR6lwucYZCGj0Psq7ZuBgCEMzfQRPj8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRh4OKmctbtFdVLYbdRm+XzAtVN4zENUm+iHGX4Jn4Y9XLM9+QctbzlZkwUuMjB7j
	 d5hEev0amv694c4xTzeQXaZMRaI6HZQTxJOdddkyrvjpmsyRSrDfbPI4++IEnCB1zM
	 UWc8yNaytz+5ZreTtZM7kz8LOApt3g0SGKSnNarV0/DzKK5pkJezRemzItKFUjvwmO
	 a6Qs/q76n3k7va4WK9vkVa4hfhO8Ok/KDa3GLC8mUu2oHPs5Ow7iB3FdnCENNsgW0G
	 QuwC/6BeCCOJEfi3KxmuqjFwYTlS4KAYtuHJMoPa1mwc2ONTGXZUvLOMfb4RRHkRTr
	 6UHBG/zHXmBYw==
Date: Wed, 26 Mar 2025 13:04:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
Message-ID: <40db39ef-7ef3-4720-9c85-ccfe1c11c299@sirena.org.uk>
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qd8pf4HPEhmM3qAr"
Content-Disposition: inline
In-Reply-To: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
X-Cookie: To err is humor.


--qd8pf4HPEhmM3qAr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 02:09:54PM +0530, Mukesh Kumar Savaliya wrote:

> This change introduces a new field `dtr_mode` in the `spi_transfer`
> structure. The `dtr_mode` field allows protocol drivers to indicate if
> Double Transfer Rate (DTR) mode is supported for a given transfer. When
> `dtr_mode` is set to true, the SPI controller will use DTR mode
> otherwise, it will default to single transfer mode.

> The QSPI controller driver uses this flag and configures single or double
> transfer rate using the controller register.

We should have a flag in the controller indicating if it supports this,
and code in the core which returns an error if a driver attempts to use
it when the controller doesn't support it.

--qd8pf4HPEhmM3qAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfj+1kACgkQJNaLcl1U
h9DJQAf/YJ+ojB+devzgPrAXauOe46juaTWouRZEJJh1yRZj/wGvASS+XzaM+7Op
1JnoQDosb0Ig8+MfNIzVInw19R1kRjiDL9ZdybDp5U3phlna86Wqdns+Q93qS3Uk
HfJptnAFS9VsJhguL7sZ3Ki7okwteN4r9/SAvr2y6Ag1TOugrtR0DvFW0HBTR29Y
Ljjd72DDZXOFDk7EiRorjE/Afl1gGUiAzNPbYoub0n/5DNk9Z/QolKCNBFINZKfM
xfZOpYpGH5BAbrRjE5AT6VihV4k+2MzJfHFPcr1+sOD78xv1D+l55I1tU8UBR18Y
M3Q7mVyxyM+fQhLJ+Vy9mDa5b8Errw==
=eDGt
-----END PGP SIGNATURE-----

--qd8pf4HPEhmM3qAr--

