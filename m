Return-Path: <linux-spi+bounces-4876-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3016497C808
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 12:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D815E1F27BF8
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ADF198E99;
	Thu, 19 Sep 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5VXr1wj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255E3C0C
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742061; cv=none; b=SIaPwix8Vzwb/leT7m2O7d+nlAv0o6K+YSDvTkZzyRWRJwZLGknLRK5rCFH7EPu+qYDtX6u94qEUnkbW9FkQefFBXTg/6GB+Z0jWCH8G119T7PQmtuzQvNmew2axvAC+dcPTYc/Y+vX31jh9fwIoAemYI5oeVNadQI4fG+ePD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742061; c=relaxed/simple;
	bh=trYvMAs/Gw/lBCc+f0IDoClnkLEb0Xc1bSVKX8cCUrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY9P9sryfVjvS+gP+gZNxyOcRGJPlTIn2nh0HH4mRV6XOzdd/89GMqD9XBNa5wRJv/dfMZU/dWHeUs+SQZeTBJ9UWs6wkk30sD7VJjEtdKSKcCq31TsNEM7hopjhL7jgr222+bRIpCmMhTWE17UNMfEnoDsPn8BbdHPwL1j1Q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5VXr1wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E183C4CEC4;
	Thu, 19 Sep 2024 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726742060;
	bh=trYvMAs/Gw/lBCc+f0IDoClnkLEb0Xc1bSVKX8cCUrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5VXr1wjp45AUjMmUnN5AkGkcGRlD37Gin3198e0//oOK/zuj2wvrhP7YfKf/kqL4
	 mAwPZ0MCnwQfoqpv0n4VbDK1L8mzN0uy9F6GP4R8Jo6NKDFzEwW4atH0v7DuPyhDJI
	 e3uBWUvnonvJMbVrQfkrDA2JFoiATR+bOFcyxapyBZtor7T2QuOqlKg/CQczFjODa2
	 e0RhJKDwiUgk6Rhb6n4lovtVDtIaTTYCz5/YTQZi5+/CCh0TqEn+GOa/J/WDRbdX8w
	 BIFEEUUrtKrFU3lukrfqHu9GbSXqlWf088ZKFAnXuXLaperLJ2MvVWLWzrozWPVcvX
	 yjQXFzTm+Ff/w==
Date: Thu, 19 Sep 2024 12:34:17 +0200
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
Subject: Re: [PATCH v6 02/12] spi: intel-dg: implement region enumeration
Message-ID: <Zuv-KTq6WP-7E34Z@finisterre.sirena.org.uk>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-3-alexander.usyskin@intel.com>
 <ZurXI2g00duqMUjo@finisterre.sirena.org.uk>
 <PH7PR11MB7605BC90FB95AC2CE807C86FE5632@PH7PR11MB7605.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PCQlvpyTA31roP2W"
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7605BC90FB95AC2CE807C86FE5632@PH7PR11MB7605.namprd11.prod.outlook.com>
X-Cookie: Editing is a rewording activity.


--PCQlvpyTA31roP2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 09:55:54AM +0000, Winkler, Tomas wrote:
> > On Mon, Sep 16, 2024 at 04:49:18PM +0300, Alexander Usyskin wrote:

> > > In intel-dg spi, there is no access to the spi controller, the
> > > information is extracted from the descriptor region.

> > Which information?  I can't tell what this patch is supposed to do; as =
with the
> > first patch this shouldn't be standalone.

> The patch series was built for review, it adds functionality on top of ea=
ch other.=20

That's not worked out well here - like I say I can't tell what the patch
is supposed to be doing.  What information is supposed to be read here,
why?

> > > +static inline u32 spi_error(struct intel_dg_spi *spi) {

> > > +static inline u32 spi_read32(struct intel_dg_spi *spi, u32 address) {

> > At least these names are too generic, please use driver specific prefix=
es.

> Can be done but those functions are local to the driver not part of the A=
PI.

Sure, the issue is that a core API with the same name could reasonably
be added at which point it'll collide with the driver internals.

--PCQlvpyTA31roP2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbr/igACgkQJNaLcl1U
h9DHLgf+OJ2VWjM3IHaziCQB7VGoBxWzadl4NtdIeLwKT1ypB1ixWiVDyiFlW40H
6vzrQr5PIb04/fUq0ucrwHJrKyQVDn1gEnLRsQR97FfAbOQwsZdcr/W78UnJ8Y76
UuII4bmKE8spbwRIr40BCKaE1GEZppG0hmGy9OMgIcHvauOgwY4tnbVA8uJhVWpj
75lCT/hkIjPV+pjra/+Ktnyykt+ZeJQ0xw3lQ8mQwXNPSaaNwRu+n6xZLSWPxhQc
lDluEthqamN8IctoxNzHBdYsXcAVHCpjydFwUUq+ywmK44UdoRN8Q3coAxqm8VE7
eyUHNuLL+bd6WJqbhzp+M31pazKHQw==
=CHq4
-----END PGP SIGNATURE-----

--PCQlvpyTA31roP2W--

