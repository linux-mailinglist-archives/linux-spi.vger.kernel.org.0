Return-Path: <linux-spi+bounces-7278-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0A7A6BEDA
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96A7188371C
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55838214A98;
	Fri, 21 Mar 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxewWAmH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C701E98ED;
	Fri, 21 Mar 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572553; cv=none; b=ZwbqLjQKb5rR3npnmd1J2viw47GKGZq/awBYGrVyrMZ/hV/UBibQUW7fbdyFZMjCQ5RWuj7UxzemSbiSC2PZDsC8tN5BpuL4q+VGUTJ43Ttpn01pgrTQKs4j8MveQE9ClpRnhoOPbU23KTyAqXrE6rMQ9BQv/VIKDjEVovnn+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572553; c=relaxed/simple;
	bh=2SlFIB8v0xefZ/EJZpkooXcHOHALtHcJ5QRFslS5Zfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeFu3+zZkaUmt6lw78G7mmk/GiG0o1hQS0wZvfQ6e+PMKbr2rB6tuRhvoy2wihvZcqwub47LmCTJgiJlS4AajOBttUI3SMpA1FP/p3eqInc4OcOb0jswUUa0UKRLKffrGvir9SSkR/iHz5GgZ1Ih4EnlXk1y6kFEEDXltKXzLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxewWAmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A928C4CEE3;
	Fri, 21 Mar 2025 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742572552;
	bh=2SlFIB8v0xefZ/EJZpkooXcHOHALtHcJ5QRFslS5Zfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxewWAmH0ZjQcibQXJV1yMRt/EXAhC+spAiVZxQVODy5XHNBiFzVc4XSggVY7rl6q
	 KRrQbIUB1lVJZZVKOUPiP3/IvAdzeVUGXPUoecpnsx3nrC5hhGHZ5+aByMBkmSYL5h
	 bUe+3/C9AaggBne38+kE3xFDAj7rt8AnFB3E2J1La6mIJrt/j62KWG17DwzuvNmGg1
	 Rzs8vASVZ45bXzph5iHkFkIw260Vb1oWiJit40fdqTm/BGp6Lkbt1S/9gg5e57k6wq
	 sySgZEJUMUZAeRCQIDLO9KmqVXoGytU2lV/wov7bODxxYwoDGiNNApX+fgww7wPcOJ
	 2cJuOsAIEmLdA==
Date: Fri, 21 Mar 2025 15:55:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>
Cc: Kevin Hao <haokexin@gmail.com>, linux-spi@vger.kernel.org,
	Volker Haspel <volker.haspel@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: fsl-qspi: Explicitly unregister SPI host in
 remove()
Message-ID: <Z92MBTs_K-6Eiyv_@finisterre.sirena.org.uk>
References: <20250321-spi-v1-0-b9939baa64b6@gmail.com>
 <20250321-spi-v1-2-b9939baa64b6@gmail.com>
 <20250321152307.wzjmouuoypkukoqk@cozumel>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xRXT/26yeaN5ujJS"
Content-Disposition: inline
In-Reply-To: <20250321152307.wzjmouuoypkukoqk@cozumel>
X-Cookie: Well begun is half done.


--xRXT/26yeaN5ujJS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:23:07AM -0500, Han Xu wrote:
> On 25/03/21 08:40PM, Kevin Hao wrote:

> > Since the host is already disabled inside the remove(), any pending IO
> > from child devices can easily corrupt the kernel.

=2E..

> > To fix this, explicitly call spi_unregister_controller() in the
> > remove() callback. This ensures that all child devices are properly
> > removed before the host is disabled.

> If you explicitly remove the child devices, such as=20
> cd /sys/bus/spi/drivers/spi-nor
> echo spi0.0 > unbind
> then unbind the fsl-quadspi driver, the kernel panic does not occur.

> Not sure if it should be the responsibility of the fsl-quadspi driver to =
handle
> this, IMO it is a common issue with all SPI drivers.

This is a bug in the driver, it needs to be able to continue supporting
child devices until it is unregistered.  This means that either the
unregistration needs to be manual or any disabling also needs to be done
via devm.

>=20
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 8fcb830a00f0 ("spi: spi-fsl-qspi: use devm_spi_register_controll=
er")
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  drivers/spi/spi-fsl-qspi.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> > index efd87f44c63a5b12b76538aa459ca8eb203b9dcd..4767d2085510c2f231476ba=
75e46f83271c4c645 100644
> > --- a/drivers/spi/spi-fsl-qspi.c
> > +++ b/drivers/spi/spi-fsl-qspi.c
> > @@ -272,6 +272,7 @@ struct fsl_qspi {
> >         struct device *dev;
> >         int selected;
> >         u32 memmap_phy;
> > +       struct spi_controller *host;
> >  };
> >=20
> >  static inline int needs_swap_endian(struct fsl_qspi *q)
> > @@ -862,6 +863,7 @@ static int fsl_qspi_probe(struct platform_device *p=
dev)
> >=20
> >         q =3D spi_controller_get_devdata(ctlr);
> >         q->dev =3D dev;
> > +       q->host =3D ctlr;
> >         q->devtype_data =3D of_device_get_match_data(dev);
> >         if (!q->devtype_data) {
> >                 ret =3D -ENODEV;
> > @@ -934,7 +936,7 @@ static int fsl_qspi_probe(struct platform_device *p=
dev)
> >=20
> >         ctlr->dev.of_node =3D np;
> >=20
> > -       ret =3D devm_spi_register_controller(dev, ctlr);
> > +       ret =3D spi_register_controller(ctlr);
> >         if (ret)
> >                 goto err_destroy_mutex;
> >=20
> > @@ -957,6 +959,8 @@ static void fsl_qspi_remove(struct platform_device =
*pdev)
> >  {
> >         struct fsl_qspi *q =3D platform_get_drvdata(pdev);
> >=20
> > +       spi_unregister_controller(q->host);
> > +
> >         /* disable the hardware */
> >         qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
> >         qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
> >=20
> > --
> > 2.48.1
> >=20

--xRXT/26yeaN5ujJS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfdjAQACgkQJNaLcl1U
h9ANJQf/SfjkNYuNlRmpIy2WD3/HHjEf+0t7RVtwZCDf2DNuQnfc6XU85+h9JlVl
YYOFNpwvJgH7E4o/2V5V9ffGzTf3aiRpH9OZkYRYLEHFaPjwm6GVb8jgaNQbE687
XkAwyjvG1NAfp3wcV5gdXPW8899jaQusw9dtbB9sBEuO3WNG1RR3+JR+iOW/iaMN
2ffJHk7NzuXiIe5YVosk1pl7gpPy/WErR+X8qRO+XHgWXx6fqDdJVCb1EqgkTjRE
vqleBsNfbaHRaazZmH1mBmyjgQsMo0PqzlFghw7NYKwefr6c2Z+akTlp8QuLfSka
FhkVDzdRbp7sb58HNPch+KwYL51ZGA==
=v6b3
-----END PGP SIGNATURE-----

--xRXT/26yeaN5ujJS--

