Return-Path: <linux-spi+bounces-2859-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67598C71C3
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 08:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7384F282400
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5B28DD1;
	Thu, 16 May 2024 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p0LJDtuV"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C618635;
	Thu, 16 May 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715842650; cv=none; b=uGjxvQx0wnUEwHHODsr6QbeCBc08FXbffpuKIcA/GaWYa5MstDRVlg/mjIL+tqYBQ43eoD/1AloqTAETJN43oErfdOM6tfIn1hzAensQ2uBcaH2OLy2YFFmTcbb0wNLlPkX7YxlHwtMmk+62xeSmh8GKhQCa7twlSH4khMRf9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715842650; c=relaxed/simple;
	bh=6IjZadEQJIHv5tk4TwGJe6gpZ6evHRuOZzcAlcgqyk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY43erfnUZGkQRl6yfqceBu6A2Im+9KcUMZBBUkCryeC3S2ovwyb2/iDd1DYUPp7/PuGE/pwkaJxkAkM/ak8ykwqA/KdmFU8CoVzjhMOAKJaPczeLxlyra+NxsBq+J2m9ItzJnkU0dBs/nel9H7fHRLOxvFmlv/U2CchWsRN710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p0LJDtuV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715842648; x=1747378648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6IjZadEQJIHv5tk4TwGJe6gpZ6evHRuOZzcAlcgqyk4=;
  b=p0LJDtuVNwwpeiwCLxUHPDE/K/aflfKnpZ3nj9jem7NwYNocUI5ps2Lt
   1fwScxiXsvfbLZ3bD33YNcC8KlYYFoTTs1j3c7eVlOsUSYzcJXvIENWfa
   XD3BYh0gtLEhPVjniU3Cp5ac1fn+pVTYrD9Ru3qnlL0ZyrdA1vR6dj4vx
   yelrdZUPhPXXt82zIMRZcylJ2D8spxsQBT38ddxbSUxwPQsyzRqk3cBMb
   Y8bakWJUOo+Eg8UrPc//i8YMFnm2b7ngMw2vXjVAWl6AirVNWYrZyWx4z
   Xq04Eiy7RZ4HnabTckEcsQ565ezL+bG8eZJmeSOi3T5dCO0ayf2E1Z2fn
   g==;
X-CSE-ConnectionGUID: muChaTU1T4yrMkfn1JCFOg==
X-CSE-MsgGUID: OTNc74XwSLi6GypTtBzPMw==
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="asc'?scan'208";a="192313660"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2024 23:57:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 23:56:56 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 23:56:53 -0700
Date: Thu, 16 May 2024 07:56:39 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Kanak Shilledar <kanakshilledar@gmail.com>
CC: Conor Dooley <conor@kernel.org>, <wahrenst@gmx.net>, Kanak Shilledar
	<kanakshilledar111@protonmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
	<rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-rpi-kernel@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: spi: brcm,bcm2835-spi: convert to
 dtschema
Message-ID: <20240516-encourage-bouncing-77e9c14c9887@wendy>
References: <20240514070051.2959-1-kanakshilledar111@protonmail.com>
 <20240514-sitting-ritzy-498d35eb5ac8@spud>
 <CAGLn_=vRDj_A2VpqQ6eT3OX6AgCfesA1KzJh+6djyF6MhAgEvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0nhWKHEN5fKFMQ8b"
Content-Disposition: inline
In-Reply-To: <CAGLn_=vRDj_A2VpqQ6eT3OX6AgCfesA1KzJh+6djyF6MhAgEvw@mail.gmail.com>

--0nhWKHEN5fKFMQ8b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:00:29PM +0530, Kanak Shilledar wrote:
> On Tue, May 14, 2024 at 11:44=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Tue, May 14, 2024 at 12:30:47PM +0530, Kanak Shilledar wrote:
> >
> > > Changes in v3:
> > > - Updated DCO email address
> >
> > I was really hoping you'd tell me why you'd not used the same email
> > address, rather than just sending another version. My ulterior motive is
> > that I wrote the section in email-clients.rst saying that protonmail had
> > WKD issues with kernel.org accounts but apparently proton added a
> > workaround and have yet to be sent an email that confirmed that the
> > workaround fixed things. (I'm not sure that the WKD issues ever applied
> > as there's no GPG key posted for conor+dt@kernel.org, only
> > conor@kernel.org).
>=20
> Oh, I am primarily using protonmail and I am aware that there are some
> issues with protonmail and kernel.org so for that reason I am sending my
> patches via @gmail.com address. I was trying out some things with
> gmail and proton so had changed my signing email address to @gmail.com
> apart from sending emails I have no motive on using gmail.com account.
> Also I am adding my protonmail account in the `CC`.
> Hope this helps.
> If this is not the intended route then I will change it and stick
> to one email address.

I don't care what email you use for stuff, that's your business. I just
want to know if we can remove the section from the docs that says not to
use proton. Maybe you could send me an off-list email to
conor@kernel.org from your proton account, so I can see if it ends up
getting encrypted? That'd be helpful if you could.

> > The patch is fine IMO though, so
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Do I need to roll out another version with this reviewed by flag?

No, Mark should be able to pick that up. There's usually no need to
resend patches solely pick up tags, that's the maintainer's
responsibility. If you're resending for any other reason, then yes, pick
up tags.

Cheers,
Conor.

--0nhWKHEN5fKFMQ8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkWuJwAKCRB4tDGHoIJi
0gN/AQCnEN4vuOOsE6DO4QFtsxZtw+1x1mtb49PyKpWtqtPQ8QD/RhI9DwfjF5Tp
CnTBU0ZQV31OVZpr1OkYHZWVykwLGwM=
=uPOG
-----END PGP SIGNATURE-----

--0nhWKHEN5fKFMQ8b--

