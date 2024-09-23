Return-Path: <linux-spi+bounces-4933-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103A97EBB3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113611F21AED
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1696197A7F;
	Mon, 23 Sep 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sst8rmym"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE419755E
	for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095774; cv=none; b=EMss5T2uunXQnVQ8G64nGKYWkBsInqlQwlnL061y7IYSSygvGQss7GuRPRqvdlCxRbKqSFjHIodZTw713GUxmeFRV85mIB8hxllmPgnWzrOtboAgRrIQ/4qsHKHdaj8jzaS5ULIkS/kMh0IXc0eTFDG7QAFOurZSyUT/V+/96jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095774; c=relaxed/simple;
	bh=RN6cjzHoWo7KzeRWo61xbecp6Jcoh0ocYmVzmQxu00s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtSHv3gQaCgmCT843DDyqm0tq6z0zQbfwaETkYUX1c5wvou5ju5D43yd+97IB9vZ8T6GLMyMcUwTNUlB7zgTfSKrzuA3INp+/zbt+BaMkfozQy6r9+RcOpT5Q8SapstVBSWb/ut3tCrJcs8+PK/qUoxa/D8EPsiJGsxf+tGl4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sst8rmym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287D7C4CEC4;
	Mon, 23 Sep 2024 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727095774;
	bh=RN6cjzHoWo7KzeRWo61xbecp6Jcoh0ocYmVzmQxu00s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sst8rmym1KIpZMVpE922IY6DCc92c9SKEyh32z3FChhDrHzEjbGGx5ElG0aFTEoKO
	 aWxoys4vBUlsffvSINxEFrvXvAKlReionrFgc77eCTtR5kF13ybMuo7ISnDKUblHUa
	 YN8ZTvhQ+iySyZ8vd53HuK5YSKqMz/Ac2hHw1CDduijlWruv5UlEaXa1PtgQtkgnyn
	 xiFwLzEUI39EZSdaCeVJzRnJ8C4UuFlDos15YCBbzHgt3u0o6S/1RsrmU9i32MrK/9
	 AtT9PnO4qEhUk9K/SnB2vk0u33aX8TSv310RMdQ+IPxbjmJLQ98qDdTk0buLqGDzRp
	 C9T9J3TTfcb3Q==
Date: Mon, 23 Sep 2024 14:49:27 +0200
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
Message-ID: <ZvFj1zyzSYmbNwmH@finisterre.sirena.org.uk>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-2-alexander.usyskin@intel.com>
 <ZurWk_eXSQndgA4Y@finisterre.sirena.org.uk>
 <PH7PR11MB76057D2326D436CA9749A113E5632@PH7PR11MB7605.namprd11.prod.outlook.com>
 <Zuv9qsWJQhx7rbhJ@finisterre.sirena.org.uk>
 <PH7PR11MB760505A11C7A41DAB0359184E56D2@PH7PR11MB7605.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6k/Yl5pMjIb7rFw2"
Content-Disposition: inline
In-Reply-To: <PH7PR11MB760505A11C7A41DAB0359184E56D2@PH7PR11MB7605.namprd11.prod.outlook.com>
X-Cookie: Editing is a rewording activity.


--6k/Yl5pMjIb7rFw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 01:00:52PM +0000, Winkler, Tomas wrote:
> > On Thu, Sep 19, 2024 at 09:54:24AM +0000, Winkler, Tomas wrote:
> > > > On Mon, Sep 16, 2024 at 04:49:17PM +0300, Alexander Usyskin wrote:

> > Just do normal open coded allocations, the reference counting is just
> > obscure.

> The kref here is for reason so we don't need to hunt the close open, I fr=
ankly don't understand
> what is wrong with it,=20

It's locking/refcounting stuff that looks nothing like any other SPI
controller driver.  Even if it works it's obviously fragile since the
driver does surprising things which break assumptions that will be made
by people not looking at this specific driver, and causes people to have
to spend more effort figuring out what you're doing.  If there is any
benefit to doing this then open coding it in one specific driver is
clearly not the right place to do it.

> > > > > +static void intel_dg_spi_remove(struct auxiliary_device *aux_dev=
) {
> > > > > +	struct intel_dg_spi *spi =3D dev_get_drvdata(&aux_dev->dev);

> > > > > +	if (!spi)
> > > > > +		return;

> > > > > +	dev_set_drvdata(&aux_dev->dev, NULL);

> > > > If the above is doing anything there's a problem...
> > o
> > > It makes sure the data is set to NULL.

> > Which is needed because...?

> This is a boilerplate part, the content is consequent patches.=20

Which would come back to the issues created by the random splitting of
the series were it not for the fact that if anything tries to look at
the driver data of a removed device it's buggy, the reference is gone
and the device may have been deallocated and it's certainly freed from
the perspective of this user.  Notice how other drivers don't do this.
The driver core will also overwrite the driver data of released
devices...

At a high level a lot of the issues with this series is that both in
terms of how it's been sent and what it's doing there's a bunch of
things that look nothing like how we normally handle things.  At best
this means that problems are being solved at the wrong level, but it's
hard to see that this is the case.

--6k/Yl5pMjIb7rFw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbxY9AACgkQJNaLcl1U
h9BFsAf/ehMj/p+H4ADxV87IKVdY07z0di6q7euT4MTbH/WOB6XOKpN1Oj1FHsSB
v1VhH+buYMk50UT6BKOTtL3naCweQGxZPGrbmwj8ny1ge1MGVMNyZDKuAIZciO+O
M7fqs6fzTHSsxO97j7Rtw8FponO3u3rifubo1K2+zNiPfhqdJo2B+L5AcLkFbpyn
ysP7QDcEC1Nljp5BwYr2iVPynGEHHU8ZI2Ql+F504yOcYLOAJZAm38FJogVct1x9
z2kTT2na9/or4xAvarDW/4OnALdrV+Zrmq4wvQ5BqimyDz3UciBgIfxzyGxj7CUy
1c5xIQ9lVIVLndjsAzj6oKcPNTBmqA==
=OAaN
-----END PGP SIGNATURE-----

--6k/Yl5pMjIb7rFw2--

