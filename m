Return-Path: <linux-spi+bounces-3725-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB392549B
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 09:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CE6282E9C
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B149F13666D;
	Wed,  3 Jul 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e3rcjBZ6"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD6131BDD;
	Wed,  3 Jul 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991766; cv=none; b=mcuKVhRF/Hfhr0f/AGTD3Vxq7PIrTd97BQCtBXG3RSrtceeZ7UyukX7KN4pRGqt8xxgIq/hV2i8D18i24atbGAdkvKKpJLSaxMC0AoKpsorrfIoZoR/jLHED/HF0QlSwV5GZSO3md+WOH7y+M/mN+wvnO5yENIg03jB4doidavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991766; c=relaxed/simple;
	bh=XH8pzdAoHuWv8DznMXqsk1aeuJ++vg5q3W+27mPM9vo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhYLq2IJZ+rw7F0CscT801yiUHMBG8kaVLBCHH2znS7bhu4vkutT5YCUh0yz0vrgPiGNfV/KFsL4HmYNsWSHpzG3ZY0WYbLg2rGgX+Ne9G7ng4hARMxioteilNk69k5PEgm9LFYjGT2v+U/qArjMBTKixm+Xk/fQpS+YjOaFvUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e3rcjBZ6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719991764; x=1751527764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XH8pzdAoHuWv8DznMXqsk1aeuJ++vg5q3W+27mPM9vo=;
  b=e3rcjBZ6w1YCQadfPHuEgtKs9dThgtIuBbIMQEcRE7c57rwkAhQXJ0fT
   ZqI5igh+PVw0FzZGL9MvCRXuplnbdwbp9jf1PMh3ntc2f5dauAB/gg0wi
   jEP1SITvoBIxu6TJXYe9BOtHfQDC2TPXtu5rJIhLEltBMLlqbGwMXyzBD
   A+MUZEdW3WDsNJ1jEk+MgdLBQTd8myE4ZIUQNDHJajXLq5EtIo6lVkNV/
   ig0llmZw2jOM6Bqjv8FCUb7pKOQeWHlCTCywHQwYAbXjRDaVT5P0A14OR
   p1GuQyR4/dfksh1oyWx32c4sQa90SKOmrxst0Gvuy8MTcUAlf+6Oji3x0
   A==;
X-CSE-ConnectionGUID: feGJv0yDT+igZZ1QI9ykeA==
X-CSE-MsgGUID: ChZ+M0e1TT+Kc9XQeYII1A==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="asc'?scan'208";a="28765840"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 00:29:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 00:29:00 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 3 Jul 2024 00:28:57 -0700
Date: Wed, 3 Jul 2024 08:28:36 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Serge Semin <fancer.lancer@gmail.com>
CC: Samuel Holland <samuel.holland@sifive.com>, Kanak Shilledar
	<kanakshilledar@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh@kernel.org>, Jisheng Zhang
	<jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] spi: dw-mmio: update dw_spi_mmio_of_match struct
 with thead
Message-ID: <20240703-garbage-explicit-bd95f8deb716@wendy>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-4-kanakshilledar@gmail.com>
 <f8604c68-8866-447b-a874-562bdad1df79@sifive.com>
 <23gvjkszxvf6zehiqetjfmtf67nlpnnfmhgx234jnxwrtmbdpr@4yv64sz2kpcs>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wONVh+6L225rrd86"
Content-Disposition: inline
In-Reply-To: <23gvjkszxvf6zehiqetjfmtf67nlpnnfmhgx234jnxwrtmbdpr@4yv64sz2kpcs>

--wONVh+6L225rrd86
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 09:57:20PM +0300, Serge Semin wrote:
> Hi folks
>=20
> On Mon, Jul 01, 2024 at 08:17:29AM -0500, Samuel Holland wrote:
> > Hi Kanak,
> >=20
> > On 2024-07-01 7:13 AM, Kanak Shilledar wrote:
> > > updated the struct of_device_id dw_spi_mmio_of_match to include
> > > the updated compatible value for TH1520 SoC ("thead,th1520-spi")
> > > to initialize with dw_spi_pssi_init().
> > >=20
> > > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Separated from a single patch file.
> > > ---
> > >  drivers/spi/spi-dw-mmio.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > > index 819907e332c4..39e3d46ebf5d 100644
> > > --- a/drivers/spi/spi-dw-mmio.c
> > > +++ b/drivers/spi/spi-dw-mmio.c
> > > @@ -419,6 +419,7 @@ static const struct of_device_id dw_spi_mmio_of_m=
atch[] =3D {
> > >  	{ .compatible =3D "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> > >  	{ .compatible =3D "canaan,k210-spi", dw_spi_canaan_k210_init},
> > >  	{ .compatible =3D "amd,pensando-elba-spi", .data =3D dw_spi_elba_in=
it},
> > > +	{ .compatible =3D "thead,th1520-spi", .data =3D dw_spi_pssi_init},
> >=20
> > Your binding requires snps,dw-apb-ssi as a fallback compatible string, =
which is
> > already supported by this driver and uses the same match data. So you d=
on't need
> > this patch; its only effect is to make the kernel larger.
>=20
> Agree with Samuel comment. Indeed there is no point in adding the
> vendor-specific device-name supported in the driver if the fallback
> compatible works as-is.

FWIW, Mark picked up the binding alone so I think there's nothing for
Kanak to do here & the driver patch should just be forgotten about :)

> >From that perspective we shouldn't have merged in the patch adding the
> Renesas RZN1 SPI device name support, since the generic fallback
> compatible works for it. On the contrary the Microsemi Ocelot/Jaguar2
> SoC SPI DT-bindings shouldn't have been defined with the generic
> fallback compatible since should the device be bound via the generic
> name it won't work as expected.
>=20
> Although, it's better to hear out what Rob, Conor or Krzysztof think
> about this.

I agree with what you've written. If the fallback works identically, then
the specific compatible shouldn't be added here. And if the fallback
will cause the device to misbehave (or not behave at all), then it
should not have been added.
I'm not sure if the Microsemi stuff is in the "won't work {,properly}"
camp or in the "will work in a limited fashion" camp. The latter would
be suitable for a fallback, the former not.

Cheers,
Conor.


--wONVh+6L225rrd86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoT9owAKCRB4tDGHoIJi
0jYGAP9sjC9GgGM9qE1ZoqzHHiaERajD3hAFoKB9OYEHsOFtxQEAl1g8BT7QyaMo
nMrjiPXoOmUwVmAt6fFAiWSAim+W7ws=
=Z2Ad
-----END PGP SIGNATURE-----

--wONVh+6L225rrd86--

