Return-Path: <linux-spi+bounces-3868-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E893932278
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEDD1F231BF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA9249ED;
	Tue, 16 Jul 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iGLG3FIj"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7554C74;
	Tue, 16 Jul 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120991; cv=none; b=bl4pybGzy3ZT8rf8ypqoHY/bmJj+TIXUwY0iUbZfhB5PEBjQDrXUDA3F6QEP/Ow8NRfwf03n/nUvwRk9Ju5wAM9xYlKlgrkL2PZsB1F/fT+OxU1WQF7qxJIpJOSB07V5mLZngG0HHgUyIK836mb1nClSoHFQ42FYD4EGOZYcwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120991; c=relaxed/simple;
	bh=3ieAoPKRveRs7kahBOXvbKadm9r7qWcBZNkkhIbV4kQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk+8ltPafRg/soQgX7YRjz9aOyUDnjEkefb3f6D8OWOquiJrnYRC7m28mqSvCatdnJCezwvBfHrt1UFkOKhVAtTeLC8TS+cB/zpLceKRMWfEe7ee5B19n1yZz3cxxpCr3sBfopFc/mpyGRikRVD/F25tFgFumQQ6kfnS8NhHvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iGLG3FIj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721120989; x=1752656989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ieAoPKRveRs7kahBOXvbKadm9r7qWcBZNkkhIbV4kQ=;
  b=iGLG3FIjrMtghi3X6D5UqgIXskmZpNQwZ0QYU/NsziVp8qnclPjCIpE/
   zfY2wKVaXsWxfM4xcDJyr0C2+O1DUd7QAxbi3fJySaeXHgiijU2GUGSfy
   eg0nS0UmOy8vd9MMPyTnrAEMNB+33ZNaaJwu7o4PCNuUqNdG5445WgRBq
   Pvsas2xOSXNF8DA40gjj+lxY5ztql8nw8kNbxyt0bcFma5NSuZgssgPiE
   drCDBiCuvsvynUZxnWT1aRhur/Krd0kGJiAv91F4jjSgrbn0lpxcUEmBs
   lDpx5fFwrLWvb0MvfgJs1nv9DEHb93q3knHBmXleH5XZLOT7wUMBxaqKb
   g==;
X-CSE-ConnectionGUID: eBnu20vsR2SmZnSyEPMB2Q==
X-CSE-MsgGUID: yzzyoGJoSqiiuAmDZ8pomA==
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="asc'?scan'208";a="29263502"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2024 02:09:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jul 2024 02:09:33 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jul 2024 02:09:32 -0700
Date: Tue, 16 Jul 2024 10:09:09 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>
CC: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] spi: spidev: add "generic-spidev" for compatible string
Message-ID: <20240716-stuck-saggy-0638f8f0af4e@wendy>
References: <20240714202303.164-1-egyszeregy@freemail.hu>
 <31758947-5570-4b20-94e5-52ea77f4f4e3@sirena.org.uk>
 <8d18306c-8d36-4e59-bc1f-0fc83dd40ca4@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Was0fRQbt8tb8PIi"
Content-Disposition: inline
In-Reply-To: <8d18306c-8d36-4e59-bc1f-0fc83dd40ca4@freemail.hu>

--Was0fRQbt8tb8PIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 09:41:08AM +0200, Sz=C5=91ke Benjamin wrote:
> 2024. 07. 15. 16:10 keltez=C3=A9ssel, Mark Brown =C3=ADrta:
> > On Sun, Jul 14, 2024 at 10:23:03PM +0200, egyszeregy@freemail.hu wrote:
> > > From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> > >=20
> > > Spidev is a not an ASIC, IC or Sensor specific driver.
> > > It is better to use a simple and generic compatible
> > > string instead of many dummy vendor/product names
> > > which are all just fake.
> >=20
> > > Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> > > ---
> > >   drivers/spi/spidev.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> >=20
> > No, as previously and repeatedly discussed the DT describes the
> > hardware, not the software that happens to be used to control that
> > hardware.
> >=20
> > You also need to document any new bindings.
>=20
> If DT describes the hardware, yes this is why need a generic compatible
> string for SPIdev driver. SPIdev driver is a typical driver for boards wh=
ich
> have just header pin for SPI connection and it is not defined what IC/Sen=
sor
> will be connected on it later.

What is preventing you using, for example, overlays to describe what
devices are being connected to your board?

> In normally if a developer start to use an IC/Sensor which has not yet any
> driver in Linux he/she should start to make it in a regular way and not
> hardcoding these fake compatible strings inside spidev.c and use it for
> longterm.

As I understand it the process would be:
- document the actual device you have
- add that compatible to spidev.c
- work on a driver in userspace
- drop the compatible from spidev.c and create a specific driver

The hardware at all points in time remains identical, and so the
description of it does not change depending on what driver the OS
happens to use.

Of course a developer could just develop a specific driver for the
hardware from the beginning, and not ever add its compatible to the
spidev driver.

> By the way, please send some reference link about the rules what you say =
for
> DT

For instance checkpatch will complain about your change:
WARNING: DT compatible string "generic-spidev" appears un-documented -- che=
ck ./Documentation/devicetree/bindings/
#35: FILE: drivers/spi/spidev.c:732:
+	{ .compatible =3D "generic-spidev", .data =3D &spidev_of_check },


> and please send the link for SPIdev binding documents, i can not find it,
> but you point on it all the time.

There is no binding for "spidev" because it is not a real device. The
devices currently bound to by the driver should be documented in various
locations.

> devicetree@vger.kernel.org
> Please start a normal discussion about it with devicetree maintainers who
> can decided it real what need in this driver code for compatible strings.

I do not understand what you are saying here. Are you telling Mark to
have a conversation with the devicetree maintainers?

> I
> do not think it is a good idea to append these list for +100 fake devices=
 in
> the future because you say this is the rules for it.

What do you mean "+100 fake devices"? Surely the things being appended
to this list would be real devices that do not have a driver right now?

You keep talking about lots of fake compatibles, but actually
"generic-spidev" is the fake, and the specific compatibles for
different sensors etc are the real ones!

A wee bit confused,
Conor.

--Was0fRQbt8tb8PIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpY4qQAKCRB4tDGHoIJi
0qWEAQD3OKqlCIYRAL+FaoY49aqySH0f9I6G22TAsrA7BhaOhAEA6n+52hfA9lik
hZY2T0ZcPvsXihmoepNWRI5xrtPcEg0=
=SpFJ
-----END PGP SIGNATURE-----

--Was0fRQbt8tb8PIi--

