Return-Path: <linux-spi+bounces-6253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED33A04C18
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 23:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201543A547A
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 22:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E361D5AAC;
	Tue,  7 Jan 2025 22:14:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35519F101;
	Tue,  7 Jan 2025 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288089; cv=none; b=DXPPAI9vEcHg2Nh5KR7WBMUwRiXd5L+ig1b1OvQ6tMhp9X2DdXFiVRVthrjZdw/7YJkAlqnPAPy6rfOticPglHTmVZTFAJntyd8+3g4l/+wJz7famj8/jLB5623WPN/4oeA0bF1j4UiMQcXNXQo5H/itFnQBgX8MTvZLrurx5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288089; c=relaxed/simple;
	bh=kY/GwtXCvIGdX7JcRch8/sUfqVuHTA4hV8dR3yYxHc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK2TjYn3IvW6fJ6bOwPBZ66J6KpNt0stzhhH14DrcXKqDWmVUdx7LkjyZ60dx+IEDHGi49xFsDp9TUiEnpfYL3CZ8fqJm5AfPOG7c1xYr3DI5v5zPtBuQC/rS7qbU/8ESjI/WOSngYNqVuen4NqvU+1KKThkUKulJrY6cpqKLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tVHqG-00BG8Y-1P;
	Tue, 07 Jan 2025 23:14:28 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tVHqF-00000000a7H-37Vx;
	Tue, 07 Jan 2025 23:14:27 +0100
Date: Tue, 7 Jan 2025 23:14:27 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Cc: Christian Eggers <ceggers@arri.de>, Jakub Kicinski <kuba@kernel.org>, 
	Tristram Ha <tristram.ha@microchip.com>, Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
	linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <3z5dtqwwxhx6ogtztlsdwvlbxmt5ujbj7pme2delou7mqsnsll@esfwyr2glzyn>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <5708326.ZASKD2KPVS@n9w6sw14>
 <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
 <2675613.fDdHjke4Dd@n9w6sw14>
 <sqsslcr7fsgqi7fvjpy5xnarhlm76atvatczkzwpn37e7gnsu6@tuy7an7t4gdg>
 <cnmv4ahgyblej7aoknhhb3xyvb67j7t24tug7uoxxtl5s4pjy3@wd3copbtdiec>
 <f26f526c-cb43-4170-8dd4-b7cf6c0d1d5d@lunn.ch>
 <3e7264a5-aea7-44f1-8a37-2b8cf48b710c@cern.ch>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sn7fv2gcor7y3z6p"
Content-Disposition: inline
In-Reply-To: <3e7264a5-aea7-44f1-8a37-2b8cf48b710c@cern.ch>


--sn7fv2gcor7y3z6p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

Pieter Van Trappen schrieb am Mo 06. Jan, 14:38 (+0100):
> On 05/01/2025 18:08, Andrew Lunn wrote:
> > On Sun, Jan 05, 2025 at 05:33:38PM +0100, J=C3=B6rg Sommer wrote:
> > > Hi everyone,
> > >=20
> > > I've added you to the list of recipients, because you where somehow i=
nvolved
> > > in changes of the KSZ-SPI switch code.
> > >=20
> > > We are debating the SPI mode setting for the microchip ksz8795 and ks=
z9477
> > > and possibly others. Since the commit
> > > 8c4599f49841dd663402ec52325dc2233add1d32 the SPI mode gets fixed to m=
ode=C2=A03
> > > in the code. But at least my ksz8795 works also with mode=C2=A00 and =
shows better
> > > initialization behaviour with mode=C2=A00.
> > >=20
> > > The big question is: can both (or all ksz) chips work with both modes?
> > > Should this setting stay in code or moved to the device tree?
> > >=20
> > > The specs are here, but I found no evidence about the supported/recom=
mended
> > > SPI modes:
> > >=20
> > > https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-=
DS00002419D.pdf
>=20
> From this KSZ9563 datasheet it is quite clear from Figure 6-9 that it
> requires mode 0, for KSZ8794 (which I have and can test) Figure 7-8 [1] a=
lso
> indicates mode 0. Note however that older KSZ8794 datasheets (revision
> DS00002134A from 2016, can upload if needed) rather indicate a mode 3, wh=
ich
> is a hint to me that indeed both modes were once supported. Appendix A fr=
om
> [1] states that in 2021 the SPI Timing images and parameters have been
> updated. No further information there but your experience and the datashe=
et
> update seem to indicate mode 0 has better support.

The ksz8795 spec [2] says on page=C2=A053, table=C2=A04-3, register=C2=A011=
, bit=C2=A00 =E2=80=9CTrigger
on the rising edge of SPI clock (for higher speed SPI)=E2=80=9D. The rising=
 edge
should mean SPI mode 0. So mode 0 should be recommended for higher speed.

[2] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductD=
ocuments/DataSheets/KSZ8795CLX-Data-Sheet-DS00002112.pdf

> My SPI peripheral (and KSZ8 driver) is configured for mode 3 I see but the
> frequency is set to 10 MHz while the max is 50 MHz. From experience with
> other SPI devices I know that with higher frequencies the timing paramete=
rs
> (setup and hold times, mode) become more important, what frequency do you
> have configured J=C3=B6rg? I'm asking because I don't experience the issu=
e you
> have.
>=20
> [1]
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/DataSheets/KSZ8794CNX-Data-Sheet-DS00002134.pdf

I am using 25MHz which is the maximum for the ksz8795; see [2] page 11,
table 2-1, pin 67; page 27, sec "3.5.1.1 SPI Client Serial Bus
Configuration"

I've tried 10MHz with the code in place that switches to SPI mode=C2=A03, b=
ut I
still get:

[    2.078732] ksz8795-switch spi0.1: invalid family id: 0
[    2.078808] ksz8795-switch: probe of spi0.1 failed with error -22

I think the main problem is that the chip needs a read access to
detect/adjust itself to the new mode. If this is the read for the chip id,
this fails.


I'm in favour of removing the code, and leave it up to the devicetree to
make the decision. Maybe add a note to micrel-ks8995.txt that spi-cpha and
spi-cpol are possible.

diff --git drivers/net/dsa/microchip/ksz_spi.c drivers/net/dsa/microchip/ks=
z_spi.c
index 108a958dc356..046f2a7d1e08 100644
--- drivers/net/dsa/microchip/ksz_spi.c
+++ drivers/net/dsa/microchip/ksz_spi.c
@@ -85,12 +85,6 @@ static int ksz_spi_probe(struct spi_device *spi)
        if (spi->dev.platform_data)
                dev->pdata =3D spi->dev.platform_data;
=20
-       /* setup spi */
-       spi->mode =3D SPI_MODE_3;
-       ret =3D spi_setup(spi);
-       if (ret)
-               return ret;
-
        dev->irq =3D spi->irq;
=20
        ret =3D ksz_switch_register(dev);


Regards, J=C3=B6rg

--=20
=C2=BBDas ist wie mit allen L=C3=B6schfunktionen im Internet: Du kannst Dir=
 nur
sichern seien, dass es auf Deinem Rechner verschwunden ist. An alle
anderen ist es eine Bitte.=C2=AB

--sn7fv2gcor7y3z6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ32nQgAKCRB9LJoj0a6j
dSdxAQChanvpJFQQHFlGkNRAieh+PRfPyxtRijCHOA4kD9d4+AD+LYImVUAPohd+
YRK+rtwwc0VqYG0rIs88O42NyZz65PE=
=VdUe
-----END PGP SIGNATURE-----

--sn7fv2gcor7y3z6p--

