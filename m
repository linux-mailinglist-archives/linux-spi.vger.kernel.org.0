Return-Path: <linux-spi+bounces-4875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241397C7F9
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 12:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A0F1C22E6F
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CADE17624D;
	Thu, 19 Sep 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqq8egoF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD23C0C
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741934; cv=none; b=k1EBMjHX8PJflWxKBfKukycSnBW+GOqjgdUZ7hTn8voTS0Tea0Bu1HE0kgWUXSXV+wvjVf3slEO34bnE2gn4T0IHIm0eOQhpHqNrI4s7LboO+gKei/uXOEqkSGS90na8gZ0neRX3YEbCYBj6R7OSQCxln1eplwcEgNGfrJt0l3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741934; c=relaxed/simple;
	bh=cINsdAeX2wd+6DjbdFlgUGNXrQOFd79goA4zmhQnrOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLme7DCQsBW9ER01eqcCp2iNU4hcXSHcmVQpfsZFbzRqiZP02KdTZTbaVGzDWKkS6eahaOqUDpyHxt8RyofHoiwAYVEPn6/Mue5DojIQXDDzTqEbDc/OLKaBigC4L5rfyXegS1qsAExdY6weiW/m9hs9AglhaZ0w4m/fNuS3aso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqq8egoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2C7C4CEC4;
	Thu, 19 Sep 2024 10:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726741933;
	bh=cINsdAeX2wd+6DjbdFlgUGNXrQOFd79goA4zmhQnrOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pqq8egoF1RQYK5SHVWYhlDroTlTYH/lmdJD3F9G87xAIjbxYhIpGpxLkS2yxQKADy
	 x+A5TNnylrAoFcyBdtjK37anpox9ipIxSy3ffYtRkXkXJ4zjMOAA8XuUVmotgfUagB
	 pU9DvUXnVx2+fsoS2WEHgO0Y8Nnr1mvw8r8QPbaI66kPaHvQcu2SrfZI1gdpMeR9ji
	 B/LfBO1VSvyhi3zK1kQ0bA6Vqi/pyECYtx3NSeTyzhhlNbdLuCX//YicF78ct1qPBx
	 nju7q1YFfsjkqO6COCaPpbAXfcWiRoADWEwZ8c2uJQO4PiwX6UQEmuWC7DsBM2XRX1
	 lqWR5jzAdYRFA==
Date: Thu, 19 Sep 2024 12:32:10 +0200
From: Mark Brown <broonie@kernel.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Lubart, Vitaly" <vitaly.lubart@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v6 01/12] spi: add driver for intel graphics on-die spi
 device
Message-ID: <Zuv9qsWJQhx7rbhJ@finisterre.sirena.org.uk>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-2-alexander.usyskin@intel.com>
 <ZurWk_eXSQndgA4Y@finisterre.sirena.org.uk>
 <PH7PR11MB76057D2326D436CA9749A113E5632@PH7PR11MB7605.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CCJYsXcQoNaCVfNV"
Content-Disposition: inline
In-Reply-To: <PH7PR11MB76057D2326D436CA9749A113E5632@PH7PR11MB7605.namprd11.prod.outlook.com>
X-Cookie: Editing is a rewording activity.


--CCJYsXcQoNaCVfNV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 09:54:24AM +0000, Winkler, Tomas wrote:
> > On Mon, Sep 16, 2024 at 04:49:17PM +0300, Alexander Usyskin wrote:

> > > @@ -0,0 +1,142 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright(c) 2019-2024, Intel Corporation. All rights reserved.
> > > + */

> > Please make the entire comment a C++ one so things look more intentiona=
l.

> This is how it is required by Linux spdx checker,=20

There is no incompatibility between SPDX and what I'm asking for...

> > > +	size =3D sizeof(*spi) + sizeof(spi->regions[0]) * nregions;
> > > +	spi =3D kzalloc(size, GFP_KERNEL);

> > Use at least array_size().

> Regions is not fixed size array, it will not work.

Yes, that's the wrong helper - there is a relevent one though which I'm
not remembering right now.

> > > +	kref_init(&spi->refcnt);

> > This refcount feels more complex than just freeing in the error and rel=
ease
> > paths, it's not a common pattern for drivers.

> What are you suggesting

Just do normal open coded allocations, the reference counting is just
obscure.

> > > +		if (ispi->regions[i].name) {
> > > +			name_size =3D strlen(dev_name(&aux_dev->dev)) +
> > > +				    strlen(ispi->regions[i].name) + 2; /* for
> > point */
> > > +			name =3D kzalloc(name_size, GFP_KERNEL);
> > > +			if (!name)
> > > +				continue;
> > > +			snprintf(name, name_size, "%s.%s",
> > > +				 dev_name(&aux_dev->dev), ispi-
> > >regions[i].name);

> > kasprintf().

> As I understand kasprintf allocates memory, this is not required here.

There is a kzalloc() in the above code block?

> > > +static void intel_dg_spi_remove(struct auxiliary_device *aux_dev) {
> > > +	struct intel_dg_spi *spi =3D dev_get_drvdata(&aux_dev->dev);

> > > +	if (!spi)
> > > +		return;

> > > +	dev_set_drvdata(&aux_dev->dev, NULL);

> > If the above is doing anything there's a problem...
o
> It makes sure the data is set to NULL.

Which is needed because...?

--CCJYsXcQoNaCVfNV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbr/acACgkQJNaLcl1U
h9CSzAf+O39bfj0K/flXJcQwjtGkXRBJywptExVFO/BSw7eCd+E7ja3sS597/N0Q
FLPOM5SwiX5dP9c8eWjwcuT1KK3vdNBv6A4VLSgcW+rgxbNGJ7Or+t7zBulmxaaL
zIuaRf211Ta7ZBBRQgofXu9u4grYwwEQlPvgcSBOSCVMguN/ZsCHuWugdvW5tNZi
Z3VMdGJjg4fdcaqNRI5Z5/Tw+apP60ikUrzX06rUTSd5wgV4Zr9W2e21JnvYSiZU
TKwUFvmykNfTiIWuTmFpJoR0NpxsWBQMuHXbjjUmk4FcR4PjJBynyb5Mw2p+/ya7
LRBAYCWm4rKjMhrkZFr9PeG5KTP5mQ==
=JDWv
-----END PGP SIGNATURE-----

--CCJYsXcQoNaCVfNV--

