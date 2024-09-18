Return-Path: <linux-spi+bounces-4857-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA1E97BD28
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19FD285041
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516118952B;
	Wed, 18 Sep 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr881fBs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C21EEFC
	for <linux-spi@vger.kernel.org>; Wed, 18 Sep 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666729; cv=none; b=btxTQRoO1d5nginMr7zI+XRwQuMSfyEEJqmZeRVTXLa90haO7AxNxoHXSglvPAzT1XcXpXTL2t7RObExV3hHbRRJeSY9EBplS68ODaMUXNKIfO0hmS/77kf2COHrxm3eZADxBqd5iMAcP1nzPkl2MtmScXXww9DfAG0Zfs7LZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666729; c=relaxed/simple;
	bh=yRPq43EYLk/2EzyDM6tG0c8iqpX450B91OXwoyOimAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHNs9TaqgRtnzHvjm1/H9X4NWvEizpj4cGXsVXOT2PYsQ7LBD2wLDD7/OF5kCV1QAZPax9EgxldwYBc9a25b1xfEAserlkKq7KIv3derY240tf7Tu1mkZe1EV9v42EDojfOKEkeOBVVPndseHoeN/uXVmVd2ROLTalC0P1pDti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr881fBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49985C4CEC3;
	Wed, 18 Sep 2024 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726666729;
	bh=yRPq43EYLk/2EzyDM6tG0c8iqpX450B91OXwoyOimAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sr881fBs+dGrmaBALleXBYM+IUQ9mG5hugrO//ONmJXr4DUIShArn1NXHSbUP5AIn
	 uQpfwbInbK3PvcGjrGts+InBaRSv+dsjJ3kOSStZKmRRyCPi4TGjCr1A8PgMSPWS27
	 LgQ5D8hiKFSXj7s/1noF4MbJ1q67H/K5roJE0vw5Of2+1N4wBXgEhEaM+hKGXGFNwR
	 kGbr25WPzBuXBsi+oYCVYUQzQtvvecFgHLPmPyeEgQCcDKRHNrCGnUPEgPIkRjdLD0
	 AGj7Oe+7k5UCzUKAr1Elfep6IJsmMyyx3Wm+a5gIW0/FbqaTm8akh8ah+vGruMQvDw
	 k30EeF6xvYdug==
Date: Wed, 18 Sep 2024 15:38:43 +0200
From: Mark Brown <broonie@kernel.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-spi@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v6 04/12] spi: intel-dg: spi register with mtd
Message-ID: <ZurX4xcy7TK45Omq@finisterre.sirena.org.uk>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-5-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOpsQOSM3Yla4fmU"
Content-Disposition: inline
In-Reply-To: <20240916134928.3654054-5-alexander.usyskin@intel.com>
X-Cookie: Editing is a rewording activity.


--BOpsQOSM3Yla4fmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 04:49:20PM +0300, Alexander Usyskin wrote:

> From: Tomas Winkler <tomas.winkler@intel.com>
>=20
> Register the on-die spi device with the mtd subsystem.
> Refcount spi object on _get and _put mtd callbacks.

This is a MTD driver, it should be in drivers/mtd.

> +static int intel_dg_spi_erase(struct mtd_info *mtd, struct erase_info *i=
nfo)
> +{
> +	return 0;
> +}
> +
> +static int intel_dg_spi_read(struct mtd_info *mtd, loff_t from, size_t l=
en,
> +			     size_t *retlen, u_char *buf)
> +{
> +	return 0;
> +}
> +
> +static int intel_dg_spi_write(struct mtd_info *mtd, loff_t to, size_t le=
n,
> +			      size_t *retlen, const u_char *buf)
> +{
> +	return 0;
> +}

If these functions can legitimately be empty they should be removed.

--BOpsQOSM3Yla4fmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbq1+MACgkQJNaLcl1U
h9Ayagf9GPGo4W57/efjC84ILvNOGI01XOT5VcydyCnDW7yLFbLVZx4itXNHOQdo
FxDfbUojjK/z4006rT0QARLDtVZASgEy27GwNRwNvbVCFHghZbjx4YA8PWuj0dFx
QuN1M0gGrzkXlDIjdKfv521VwYjzvcxjGFKjFJu3qP10UkhL57dS/0Do/Wpdxy0I
lTPf0CiK9k4qKoLBRMnQQl3Zu31EtVI2fIHd9K+2ZAiWodDEW+RlO/v/ScCLd8jT
otJ2YUe+jBVaUZrMVhZxazYCOGAhhGXIfY5HRe5KyKFaDaVBUvjKFtgREomKPh8y
dyFiKCPztQSgFSPjfD8lr5D+5Usd9A==
=lK/X
-----END PGP SIGNATURE-----

--BOpsQOSM3Yla4fmU--

