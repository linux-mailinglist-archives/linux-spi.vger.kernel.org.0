Return-Path: <linux-spi+bounces-11803-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49724CA946F
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 21:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A2D3120105
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F972253E4;
	Fri,  5 Dec 2025 20:36:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26D2DF146
	for <linux-spi@vger.kernel.org>; Fri,  5 Dec 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764966982; cv=none; b=J4IJpwX3uoMBKy03frSfvecQtKh9hIN04QyAGWY40BZASTkzdI10OBLdZrNv3iMvUELXASXVL8m9nl1O9GeqANJpRq8HbOe61bPjIIA7VS4NeJ2Lh5sA47jxtIOpTkt/XafmhrTmO3dd3KaXqTV106nH7gBA5EG/x8meXon5ifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764966982; c=relaxed/simple;
	bh=VeOaZdkfKx/JkEpEeZiYTDaI9ZBnPx0g8uqP6LecDdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc7Kuwu2RsSABZDFHHyEkZ4p7MGCDqt8yIzZvzPtER99cy0+z0m2L5f5AdyfqxxPsCZ6TJfFQvfVS10QJBUEcRkgIUt1sKVTVxwrT0cd+eY4qaJc4xgh7Z1y4DUKoxzjx2WiLkD9GqTaHeAJihkgZWAQqSYqCLRL5bgIuzk1TtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vRcX9-0002Tf-Q9; Fri, 05 Dec 2025 21:36:07 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vRcX8-004BG4-2d;
	Fri, 05 Dec 2025 21:36:06 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 19EAF4B0195;
	Fri, 05 Dec 2025 20:36:04 +0000 (UTC)
Date: Fri, 5 Dec 2025 21:36:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Clark Wang <xiaoning.wang@nxp.com>
Cc: Dhruva Gole <d-gole@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	kernel@pengutronix.de
Subject: Re: RE: [PATCH] spi: lpspi: disable lpspi module irq in DMA mode
Message-ID: <20251205-abstract-acrid-markhor-f49e81-mkl@pengutronix.de>
References: <20230505063557.3962220-1-xiaoning.wang@nxp.com>
 <0608e366-1b0e-d387-569a-9ed123bc4d69@ti.com>
 <DB7PR04MB5098E2E44D74474BF98F8620F3729@DB7PR04MB5098.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pdisdenfygihiq46"
Content-Disposition: inline
In-Reply-To: <DB7PR04MB5098E2E44D74474BF98F8620F3729@DB7PR04MB5098.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--pdisdenfygihiq46
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH] spi: lpspi: disable lpspi module irq in DMA mode
MIME-Version: 1.0

On 05.05.2023 09:40:43, Clark Wang wrote:
> > >   	if (ret < 0)
> > >   		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
> > > +	else
> > > +		/*
> > > +		 * disable LPSPI module IRQ when enable DMA mode successfully,
> > > +		 * to prevent the unexpected LPSPI module IRQ events.
> > > +		 */
> > > +		disable_irq(irq);
> >
> > Just wondering, have you actually seen any unexpected LPSPI module IRQ
> > events? If this was causing issues earlier then maybe add a fixes tag?
>
> Yes, I have observed this issue.
>
> The reason for this problem is that some older platforms

Can you elaborate which platforms are affected by this issue?

> are designed to combine LPSPI interrupt and LPSPI DMA channel
> interrupt into one shared interrupt number because the IRQ interrupt
> number is not enough.

You say that on these platforms the LPSPI interrupt and the LPSPI DMA
interrupt are combined into the same IRQ number, right?

How does the DMA work at all, if you disabled the shared IRQ number?

I'm asking because this breaks 24 bit per word mode, where DMA is not
used, so the driver falls back to PIO. And PIO doesn't work, as IRQs are
disabled.

> When the problem occurs, we can observe that if the interrupt comes
> too many times and too quickly, it will trigger the IRQ in the LPSPI
> driver while DMA is still processing the previous DMA request(through
> the shared dma channel interrupt), resulting in data messing.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pdisdenfygihiq46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkzQi4ACgkQDHRl3/mQ
kZxWxQf+KooGOGjtkO1DjXMLPizkCJsqajOcib8wwbxwJ5qRMLQvTDTv/4pMSl32
ZLj24dcO7a27tYf9J6lSXhHfX71pX2ZfA9EpD5grRGQzOSz6ofQxPcflh1BZ+QP4
juQzKD4J5VXPmnDR3e78/Jt8PFyFV0H4yFxUC3vdW4PIZ592Q3CrDOQERfSap8FC
Ajd1r7QXgwsWJpNo04XR0btc2YQQSNbovlXKUDoq1ixbTZARTrCYB7c6hj8je+Dz
l1jFVMnB3tOk1SRPt1qJZel7RF7p4d5kYJ/RQJF4VU2IvreXVw9DNfzjnrkFAs/L
uHp+zgqpor0+TZ+rSvOVl6gEgJQD6w==
=9xTI
-----END PGP SIGNATURE-----

--pdisdenfygihiq46--

