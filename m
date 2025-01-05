Return-Path: <linux-spi+bounces-6221-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814BCA01A9C
	for <lists+linux-spi@lfdr.de>; Sun,  5 Jan 2025 17:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEE618840AC
	for <lists+linux-spi@lfdr.de>; Sun,  5 Jan 2025 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515617E0;
	Sun,  5 Jan 2025 16:34:03 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FEE13E02E;
	Sun,  5 Jan 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094843; cv=none; b=SZSknIBjtdG3RJcRMF/sg5YZ14tKE8zZ+iSDC+YUwlqqmkQYfvbSS/qmzNlfgN2P0aGv4M8LweB8tuw75hjbqu61cnkDaDrV0N6X0ux8Cz7351xk+dU98EwtR4gqEnb1ACVUQV4BQM1ip4BLYqaYk2M/L4UkCKEawdJi5RQd6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094843; c=relaxed/simple;
	bh=X7S7w5d8Xj9Gkc2aEIoyRs4XroetJuG1Dlmzka8QpzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJls8I1DQi5t7UZi4GcXjzwTXTD06Lmf8KoxpoNmQyGO4RzYKYLA+3nLpnmI5oUZuwajPM5lyr3Xrnr0LbCPtJ2xEhQauUyxGRZVElLSa4mZkORnfBYGECiB26Is+lKcfrKZEoXvZBCv4QdHe8nx+HLrZ2l/9Zj1kz91yIVSCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tUTZL-00AVXA-20;
	Sun, 05 Jan 2025 17:33:39 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tUTZK-000000005q5-3yUj;
	Sun, 05 Jan 2025 17:33:38 +0100
Date: Sun, 5 Jan 2025 17:33:38 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Christian Eggers <ceggers@arri.de>, Jakub Kicinski <kuba@kernel.org>, 
	Tristram Ha <tristram.ha@microchip.com>, Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
	Woojung Huh <Woojung.Huh@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-spi@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <cnmv4ahgyblej7aoknhhb3xyvb67j7t24tug7uoxxtl5s4pjy3@wd3copbtdiec>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <5708326.ZASKD2KPVS@n9w6sw14>
 <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
 <2675613.fDdHjke4Dd@n9w6sw14>
 <sqsslcr7fsgqi7fvjpy5xnarhlm76atvatczkzwpn37e7gnsu6@tuy7an7t4gdg>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mlcml75me3tp3nto"
Content-Disposition: inline
In-Reply-To: <sqsslcr7fsgqi7fvjpy5xnarhlm76atvatczkzwpn37e7gnsu6@tuy7an7t4gdg>


--mlcml75me3tp3nto
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

Hi everyone,

I've added you to the list of recipients, because you where somehow involved
in changes of the KSZ-SPI switch code.

We are debating the SPI mode setting for the microchip ksz8795 and ksz9477
and possibly others. Since the commit
8c4599f49841dd663402ec52325dc2233add1d32 the SPI mode gets fixed to mode=C2=
=A03
in the code. But at least my ksz8795 works also with mode=C2=A00 and shows =
better
initialization behaviour with mode=C2=A00.

The big question is: can both (or all ksz) chips work with both modes?
Should this setting stay in code or moved to the device tree?

The specs are here, but I found no evidence about the supported/recommended
SPI modes:

https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS0000=
2419D.pdf
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocum=
ents/DataSheets/KSZ8795CLX-Data-Sheet-DS00002112.pdf

The commit 8c4599f498 was a result of the conversion of device trees where
already the question about the SPI mode was raised:

https://lore.kernel.org/netdev/20201119134801.GB3149565@bogus/

> > +            spi-cpha;
> > +            spi-cpol;
>
> Are these 2 optional or required? Being optional is rare as most
> devices support 1 mode, but not unheard of. In general, you shouldn't
> need them as the driver should know how to configure the mode if the h/w
> is fixed.

My observation is that the ksz8795 supports mode 0 and mode 3, but it seems
the first read with mode 3 always fails (read value for e.g. chip ID is 0)
which causes the initialization of the chip to fail. Removing the code in
ksz_spi.c:88,+5 or modifying it to use mode 0 gives me a working ksz chip
and I can happily mount the NFS root filesystem.

Can someone at microchip acknowledge that both SPI modes are supported by
the ksz8795 or all chips? Who would be able to test patches?

Thanks in advance.


Here is the last part of the discussion started at
https://lore.kernel.org/netdev/cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfw=
s4aa3z@2o4njdkw3r5i/T/

J=C3=B6rg Sommer schrieb am Mi 11. Dez, 15:46 (+0100):
> Christian Eggers schrieb am Mi 11. Dez, 14:04 (+0100):
> > On Wednesday, 11 December 2024, 13:23:38 CET, J=C3=B6rg Sommer wrote:
> > > Christian Eggers schrieb am Mi 11. Dez, 11:18 (+0100):
> >=20
> > > I think for 8795 these are optional. At me, it works with 0 and 3.
> > Hmm, I understood that setting SPI mode to 3 (by my patch) is the
> > root of your problem? If you revert my patch and set spi-cpol + spi-cpha
> > in you device tree, the result should be more or less the same.
>=20
> Yes, that's right. When I set spi-cpol + spi-cpha in the DT (or with your
> patch) I get the message =E2=80=9Cksz8795-switch spi0.1: invalid family i=
d: 0=E2=80=9D.
> Without it, I don't get this message and the switch works fine.
>=20
> > If you think that your problem is related to the reset timing,
>=20
> Not really. My impression is more that =E2=80=9Cthe first read after mode=
 switch
> always fails.=E2=80=9D
>=20
> From my other mail:
>=20
> [    1.712545] ksz8795-switch spi0.1: Switching SPI mode from 0 to spi-cp=
ha,spi-cpol
> [    1.851109] ksz8795-switch spi0.1: invalid family id: 0
>=20
> a gap of 140ms.
>=20
> With two reads immediately after the spi_setup:
>=20
> [    1.569835] ksz8795-switch spi0.1: Switching SPI mode from 0 to spi-cp=
ha,spi-cpol
> [    1.570641] ksz8795-switch spi0.1: ksz8795_spi_probe:84: ksz_read16(RE=
G_CHIP_ID0, 0) =3D 0
> [    1.571420] ksz8795-switch spi0.1: ksz8795_spi_probe:90: ksz_read16(RE=
G_CHIP_ID0, 34705) =3D 0
> [    1.701375] ksz8795-switch spi0.1: Switching SPI mode from 3 to spi-cp=
ha,spi-cpol
> [    1.702191] ksz8795-switch spi0.1: ksz8795_spi_probe:84: ksz_read16(RE=
G_CHIP_ID0, 34705) =3D 0
> [    1.702928] ksz8795-switch spi0.1: ksz8795_spi_probe:90: ksz_read16(RE=
G_CHIP_ID0, 34705) =3D 0
>=20
> Maybe the chip needs this read to detect the SPI mode. And if this first
> read is the chip detection the initialization fails.
>=20
> > > > On Thursday, 19 November 2020 07:48:01 -0600, Rob Hering wrote:
> > > > > On Wed, Nov 18, 2020 at 09:30:02PM +0100, Christian Eggers wrote:
> > > > ...
> > > > > > +        ksz9477: switch@0 {
> > > > > > +            compatible =3D "microchip,ksz9477";
> > > > > > +            reg =3D <0>;
> > > > > > +            reset-gpios =3D <&gpio5 0 GPIO_ACTIVE_LOW>;
> > > > > > +
> > > > > > +            spi-max-frequency =3D <44000000>;
> > > > > > +            spi-cpha;
> > > > > > +            spi-cpol;
> > > > >=20
> > > > > Are these 2 optional or required? Being optional is rare as most
> > > > > devices support 1 mode, but not unheard of. In general, you shoul=
dn't
> > > > > need them as the driver should know how to configure the mode if =
the h/w
> > > > > is fixed.
> > > > ...
> > > >=20
> > > > It seems that I considered the h/w as "fixed". The pre-existing dev=
ice tree
> > > > bindings and the diagrams on page 53 suggested that SPI mode 3 is t=
he only
> > > > valid option. Particularly the idle state of the "SCL" signal is hi=
gh here:
> > > >=20
> > > > https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Shee=
t-DS00002419D.pdf
> > > >=20
> > > > But the text description on page 52 says something different:
> > > > > SCL is expected to stay low when SPI operation is idle.=20
> > > >=20
> > > > Especially the timing diagrams on page 206 look more like SPI mode =
0.
> > > >=20
> > > > So it is possible that my patch was wrong (due to inconsistent desc=
ription
> > > > on the data sheet / pre existing device tree binding). As I already=
 mentioned,
> > > > I did this only due to the DT conversion, I actually don't use SPI =
on such
> > > > devices myself.
> > > >=20
> > > > N.B. Which KSZ device do you actually use (I didn't find this in yo=
u previous
> > > > mails)?
> > >=20
> > > I'm using KSZ8795.
> >=20
> > I should better read the subject line ...
> >=20
> > Summary:
> > - The timing diagrams of KSZ8795CLX and KSZ9563 implies that SPI mode 0=
 is correct
> > - The functional descriptions in the datasheets look more like SPI mode=
 3, but this
> >   is not authoritative.
> > - Maybe that the KSZ devices can work with both modes.
>=20
> Or maybe not all ksz8 behave the same? Should we revert the behaviour and
> leave it up to the device tree to decide?



--=20
Damit das M=C3=B6gliche entsteht, mu=C3=9F immer wieder das Unm=C3=B6gliche=
 versucht
werden.                                       (Hermann Hesse)

--mlcml75me3tp3nto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ3q0YQAKCRB9LJoj0a6j
deVpAQCqfKdtPmR8Iofwg5h64SRnrvxV9PAORERQguRWpjhuQgD6AmO3Q4pLS8OR
dX7Lkj1OGA4w6qBsKvzmOK1RSfb67to=
=ngeH
-----END PGP SIGNATURE-----

--mlcml75me3tp3nto--

