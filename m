Return-Path: <linux-spi+bounces-6006-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F49ECEF0
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 15:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A3B284F1A
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC570804;
	Wed, 11 Dec 2024 14:46:24 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEC24635E;
	Wed, 11 Dec 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928384; cv=none; b=ot8/qXguAx7gqm1BHd1ZsA8fsR6hzDY7UDnocDkd0TGmceJUiAy7NZtENBh/0FR6i/TQYVEbV8C0cTzP28dDa2n3FsEn/+LpyeZHNaCRXJzLHZ8OStVPQaEtM4LycSnlBtG8fsFOuZ1BiqL9gtqDE4YVPgs7Mi5jErgasEi4qXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928384; c=relaxed/simple;
	bh=4432CzuyDb6GCvPf5YdoDyqv6F9aCZqCiwvjkQV3948=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ7c3aZaricSVQMvoon20WP8UWjelgD1yEqmwGJG2xlLUgp2nBQfdYRdLa0Injaq4GBvK8ntBf7IxSsoZ4X3beut02HQNG7c4EBKABRTVQsg55l4Ub3dFYk3K2A6sOm6dzda4iTSiWJrCTDI4IsnG2pPzo3ffqk0h9LnDYxa+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tLNyf-001umu-2P;
	Wed, 11 Dec 2024 15:46:13 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tLNyf-00000000e7P-0cFt;
	Wed, 11 Dec 2024 15:46:13 +0100
Date: Wed, 11 Dec 2024 15:46:13 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Christian Eggers <ceggers@arri.de>, linux-spi@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <sqsslcr7fsgqi7fvjpy5xnarhlm76atvatczkzwpn37e7gnsu6@tuy7an7t4gdg>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <5708326.ZASKD2KPVS@n9w6sw14>
 <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
 <2675613.fDdHjke4Dd@n9w6sw14>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rtocwkfoomwx67gv"
Content-Disposition: inline
In-Reply-To: <2675613.fDdHjke4Dd@n9w6sw14>


--rtocwkfoomwx67gv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

Hi Christian, hi SPI people,

we are debating the SPI mode setting for the microchip ksz8795 and ksz9477
and possibly others. Since the commit
8c4599f49841dd663402ec52325dc2233add1d32 the SPI mode gets fixed to mode=C2=
=A03
in the code. But at least my ksz8795 works also with mode=C2=A00 and shows =
better
initialization behaviour with mode=C2=A00.

The big question is: can both chips work with both modes? Should this
setting stay in code or moved to the device tree?

https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS0000=
2419D.pdf
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocum=
ents/DataSheets/KSZ8795CLX-Data-Sheet-DS00002112.pdf

Christian Eggers schrieb am Mi 11. Dez, 14:04 (+0100):
> On Wednesday, 11 December 2024, 13:23:38 CET, J=C3=B6rg Sommer wrote:
> > Christian Eggers schrieb am Mi 11. Dez, 11:18 (+0100):
>=20
> > I think for 8795 these are optional. At me, it works with 0 and 3.
> Hmm, I understood that setting SPI mode to 3 (by my patch) is the
> root of your problem? If you revert my patch and set spi-cpol + spi-cpha
> in you device tree, the result should be more or less the same.

Yes, that's right. When I set spi-cpol + spi-cpha in the DT (or with your
patch) I get the message =E2=80=9Cksz8795-switch spi0.1: invalid family id:=
 0=E2=80=9D.
Without it, I don't get this message and the switch works fine.

> If you think that your problem is related to the reset timing,

Not really. My impression is more that =E2=80=9Cthe first read after mode s=
witch
always fails.=E2=80=9D

=46rom my other mail:

[    1.712545] ksz8795-switch spi0.1: Switching SPI mode from 0 to spi-cpha=
,spi-cpol
[    1.851109] ksz8795-switch spi0.1: invalid family id: 0

a gap of 140ms.

With two reads immediately after the spi_setup:

[    1.569835] ksz8795-switch spi0.1: Switching SPI mode from 0 to spi-cpha=
,spi-cpol
[    1.570641] ksz8795-switch spi0.1: ksz8795_spi_probe:84: ksz_read16(REG_=
CHIP_ID0, 0) =3D 0
[    1.571420] ksz8795-switch spi0.1: ksz8795_spi_probe:90: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    1.701375] ksz8795-switch spi0.1: Switching SPI mode from 3 to spi-cpha=
,spi-cpol
[    1.702191] ksz8795-switch spi0.1: ksz8795_spi_probe:84: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    1.702928] ksz8795-switch spi0.1: ksz8795_spi_probe:90: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0

Maybe the chip needs this read to detect the SPI mode. And if this first
read is the chip detection the initialization fails.

> > > On Thursday, 19 November 2020 07:48:01 -0600, Rob Hering wrote:
> > > > On Wed, Nov 18, 2020 at 09:30:02PM +0100, Christian Eggers wrote:
> > > ...
> > > > > +        ksz9477: switch@0 {
> > > > > +            compatible =3D "microchip,ksz9477";
> > > > > +            reg =3D <0>;
> > > > > +            reset-gpios =3D <&gpio5 0 GPIO_ACTIVE_LOW>;
> > > > > +
> > > > > +            spi-max-frequency =3D <44000000>;
> > > > > +            spi-cpha;
> > > > > +            spi-cpol;
> > > >=20
> > > > Are these 2 optional or required? Being optional is rare as most
> > > > devices support 1 mode, but not unheard of. In general, you shouldn=
't
> > > > need them as the driver should know how to configure the mode if th=
e h/w
> > > > is fixed.
> > > ...
> > >=20
> > > It seems that I considered the h/w as "fixed". The pre-existing devic=
e tree
> > > bindings and the diagrams on page 53 suggested that SPI mode 3 is the=
 only
> > > valid option. Particularly the idle state of the "SCL" signal is high=
 here:
> > >=20
> > > https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-=
DS00002419D.pdf
> > >=20
> > > But the text description on page 52 says something different:
> > > > SCL is expected to stay low when SPI operation is idle.=20
> > >=20
> > > Especially the timing diagrams on page 206 look more like SPI mode 0.
> > >=20
> > > So it is possible that my patch was wrong (due to inconsistent descri=
ption
> > > on the data sheet / pre existing device tree binding). As I already m=
entioned,
> > > I did this only due to the DT conversion, I actually don't use SPI on=
 such
> > > devices myself.
> > >=20
> > > N.B. Which KSZ device do you actually use (I didn't find this in you =
previous
> > > mails)?
> >=20
> > I'm using KSZ8795.
>=20
> I should better read the subject line ...
>=20
> Summary:
> - The timing diagrams of KSZ8795CLX and KSZ9563 implies that SPI mode 0 i=
s correct
> - The functional descriptions in the datasheets look more like SPI mode 3=
, but this
>   is not authoritative.
> - Maybe that the KSZ devices can work with both modes.

Or maybe not all ksz8 behave the same? Should we revert the behaviour and
leave it up to the device tree to decide?


J=C3=B6rg

--=20
Prof. in der Mathematikvorlesung zu einem vergessenen =CF=86 in der
Gleichung: =E2=80=9EKlein=E2=80=90=CF=86 macht auch Mist.=E2=80=9C

--rtocwkfoomwx67gv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1mlswAKCRB9LJoj0a6j
dbD1AP9Wq46TEqExVUJnS1+2ZP6WTDTbj0Vieya7xYaFUd7llgEApGgcuJ0i41K9
zlKzN9/JfyuIs6D6KNI0W9SO4S+lTsg=
=Y+Hv
-----END PGP SIGNATURE-----

--rtocwkfoomwx67gv--

