Return-Path: <linux-spi+bounces-11162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8FC4F542
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A18034D43C
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654B83A1CF3;
	Tue, 11 Nov 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnYvEmD+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F843730D3;
	Tue, 11 Nov 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883663; cv=none; b=lgTnXVHlG4JxaAVMB4nSuUCL9xcZkxpxjmrgyQGLiCTPhjLqzVRNmS78JG7cYl/TrjhVeoedSdtI62P/Y5ceReJcCB0N326YiPcsQTzuB12VrtP1HiCLxAWT6iSIt9ACLadyh0G2JivoDyAvXhnhK/8CcfvmupMfycDPrASHK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883663; c=relaxed/simple;
	bh=KMhmGUMyDqW0GIqJM0l/jfnu1hESBUqDFKlVQ8RqkCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJY5VFNBrHd584aX/yNla8+v3bi2DKJByEC+hlIUV4nc66TW4ZAmBpeLjfFIC3/JzKZUwNskfoOlOsKWB+xx226XUY2hDKtehFI30SyjQmUbxgVaSJRgE1leGdpx+0NWM4doRNHzLVqHpP/8CW3mMeYyYybL/24m4e0s8WZjaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnYvEmD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624BFC4CEFB;
	Tue, 11 Nov 2025 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762883661;
	bh=KMhmGUMyDqW0GIqJM0l/jfnu1hESBUqDFKlVQ8RqkCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnYvEmD+yYVmOmVTiL2EhQev90J3ezKIzru1Xivm1s24kLEuyX8qWysXnq+y4N8+i
	 Hx2pNrWeVX3ZcEQLHZ7eiCaRmAnvwCBWgsMogahLtaL7R3Pu/qsSQfVMTk5xmUqDs4
	 7c/5nOjujJWDZqoK67NlixHK6CGTcbv7ffqRw6xlJ0gno28T4jDd2h75mqWFcEwHgv
	 V6N/+5RcZ088g11yeC2Q4N5wieoC/a5yuCpsnCtV2jgVer2zY+qGGEG6WtiizCQDRV
	 JbyKqXjwV7ubta3u9wiGD30T197curlcNOlZ30S0KYF2U3gP/HRDjB1KWCi6qWuk6v
	 RPr1YZ8uxfNZQ==
Date: Tue, 11 Nov 2025 17:54:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Riccardo Mereu Linux Kernel <r.mereu.kernel@arduino.cc>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, broonie@kernel.org, linux@roeck-us.net,
	Jonathan.Cameron@huawei.com, wenswang@yeah.net,
	naresh.solanki@9elements.com, michal.simek@amd.com,
	nuno.sa@analog.com, chou.cosmo@gmail.com, grantpeltier93@gmail.com,
	eajames@linux.ibm.com, farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Riccardo Mereu <r.mereu@arduino.cc>,
	Martino Facchin <m.facchin@arduino.cc>
Subject: Re: [PATCH 2/5] drivers: spi: spidev: add compatible for arduino spi
 mcu interface
Message-ID: <20251111-aviation-distaste-f05c125e44e1@spud>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-3-r.mereu@arduino.cc>
 <84f0ed2f-bf51-4dd5-93f1-f26e077a2549@kernel.org>
 <CAKA1JhYTC5p_7Zj9b7g1YKZhjH0=tnnJkdW1rWv39L-SF-SDoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A1NPLRkP8HU4DvMZ"
Content-Disposition: inline
In-Reply-To: <CAKA1JhYTC5p_7Zj9b7g1YKZhjH0=tnnJkdW1rWv39L-SF-SDoA@mail.gmail.com>


--A1NPLRkP8HU4DvMZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 02:33:09PM +0100, Riccardo Mereu Linux Kernel wrote:
> On Fri, Nov 7, 2025 at 8:13=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> >
> > > ---
> > >  drivers/spi/spidev.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> > > index 5300c942a2a4..f0dd516c2083 100644
> > > --- a/drivers/spi/spidev.c
> > > +++ b/drivers/spi/spidev.c
> > > @@ -704,6 +704,7 @@ static const struct class spidev_class =3D {
> > >   */
> > >  static const struct spi_device_id spidev_spi_ids[] =3D {
> > >       { .name =3D /* abb */ "spi-sensor" },
> > > +     { .name =3D /* arduino */ "mcu" },
> > >       { .name =3D /* cisco */ "spi-petra" },
> > >       { .name =3D /* dh */ "dhcom-board" },
> > >       { .name =3D /* elgin */ "jg10309-01" },
> > > @@ -737,6 +738,7 @@ static int spidev_of_check(struct device *dev)
> > >
> > >  static const struct of_device_id spidev_dt_ids[] =3D {
> > >       { .compatible =3D "abb,spi-sensor", .data =3D &spidev_of_check =
},
> > > +     { .compatible =3D "arduino,mcu", .data =3D &spidev_of_check },
> >
> > That's way too generic, IMO. First, I am not aware of Arduino boards
> > mounted on top of regular development boards, so basically you are not
> > describing actual hardware setup but what could be potentially plugged
> > into box with Linux... and then it is like saying "you can plug
> > anything" because MCU covers everything, like calling it "Raspberry
> > Pi-clone".
>=20
> This is used to describe one of the interfaces between the
> microcontroller and the microprocessor on the Arduino UnoQ board.
> Since this could be used in other layouts in the future, we thought to
> keep it generic enough to reuse it.

If it is generic enough to reuse in the future, you can have a fallback
compatible. If it isn't used again with the exact same interface,
congrats you have avoided confusing compatible naming!

> If this isn't possible, do you have any suggestions?

arduino,unoq-mcu?

Then in the future if the duoq board comes along you can do

compatible =3D "arduino,duoq-mcu", "arduino,unoq-mcu";

btw, thanks for actually introducing a compatible for this, and not
pretending that you have rohm dac that doesn't even exist like a lot of
people :)

Cheers,
Conor.

--A1NPLRkP8HU4DvMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRN4RwAKCRB4tDGHoIJi
0sgFAPwMpqTFQNIsly8DNq+PWcUv6XQvFuGbkzYjnbUNZqX/sAEAw33MY6C2qYiC
OwkIqZJNDYBHjg1Y/yfz0Dag2EyxFgA=
=bGLP
-----END PGP SIGNATURE-----

--A1NPLRkP8HU4DvMZ--

