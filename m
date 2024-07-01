Return-Path: <linux-spi+bounces-3701-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E53A91DB81
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 11:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29636283B75
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69358824B1;
	Mon,  1 Jul 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+QxtkZR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12CA35;
	Mon,  1 Jul 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826411; cv=none; b=DLaOHTHlqQA0JkBWwJgVEeH/tUMhY0Pvjw05tRCuJx89i5p6ZQlMob0O+LO9wCvNMXTc6SGxBgzt8zXMon3YM8vMgouMp8p4pMpHb7CGBw+H/2nPSIcVriXBFR0OA6FEO1PABrVdrgvZNTYCYkGc9ryoeJdDMFV1vJOtza2g0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826411; c=relaxed/simple;
	bh=T7OwNpTVJdPd4FTNMLYtYpQmz6nnOJiH4DAvs8geivc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxmN2icWl6Fwk5+Mip1MTNNA1wFFRbO+Nq8qFp0NVOrk7/rZY4/fGQtBkVybed6BG1PTaqBRRNMETiGzygArmfhhhyLR6wUDSUbS6NOTHJgfvbKYfcx+/1nK0uxND2Bgav1X+8eK/n9ZZrPtH+Tl3Og4oXyxOscoAdxw/1QPLEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+QxtkZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DBDC116B1;
	Mon,  1 Jul 2024 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719826410;
	bh=T7OwNpTVJdPd4FTNMLYtYpQmz6nnOJiH4DAvs8geivc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+QxtkZRPVCQxmQJ11CacOMN/RX4fdzwnaM+PQube9n2Hb7RsEtQeYlXarbdv69Ws
	 y8fiY0KPrf9i3CLJKPhOXXiwsrwc77JoVmZCo5KgZcgtPhqqVupOQG9lrALar27XUh
	 WSEybY5EVZIvYj/i1GNLDCTy3oEQEHWhr7RWeITNOUP/JV39JI8muWlFiWwvPFrVQy
	 hJctoRxVY8F6Jfn9u+GM3E7xEyvajYwHtZ31p3T3d+f7SGXnuPpGfzmoGSbJ2zw1lR
	 D2rkn9f4360dP+F4OTlrN/4C5JDjMK0zyvH2u/OFCVfhYR8tRWaaXv1/fNXkB8lhm6
	 u4Vimnk+1w4oA==
Date: Mon, 1 Jul 2024 10:33:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: kanakshilledar111@protonmail.com, Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] arch: riscv: thead: implement basic spi
Message-ID: <20240701-unsnap-unhitched-a84476a719cd@spud>
References: <20240630063845.116307-1-kanakshilledar@gmail.com>
 <20240630-generous-carnation-c534f5d84a8a@spud>
 <CAGLn_=vG09C49goRkbygZdYch8H1c_kw3p7ar9NGOrgpd0_MiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2qMr9rpUpN31Eec"
Content-Disposition: inline
In-Reply-To: <CAGLn_=vG09C49goRkbygZdYch8H1c_kw3p7ar9NGOrgpd0_MiA@mail.gmail.com>


--J2qMr9rpUpN31Eec
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 02:43:46PM +0530, Kanak Shilledar wrote:
> On Sun, Jun 30, 2024 at 7:22=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Sun, Jun 30, 2024 at 12:08:20PM +0530, Kanak Shilledar wrote:
> > > implemented basic spi support for TH1520 SoC.
> > > created a fixed clock and a simple spi0 node.
> > > updated the matching binding to include thead,th1520-spi as compatibl=
e.
> > > added a spidev device in devicetree which will utilise the spi0 node.
> > > this is usually reserved for a SPI NOR flash which is left unpopulated
> > > underneath the carrier board. I performed a SPI self loop test using
> > > tools/spi/spidev_test.c and tried sending `\xDE\xAD\xBE\xEF` and veri=
fied
> > > it is being received correctly. i updated the of_device_id struct in
> > > drivers/spi/spi-dw-mmio.c to include "thead,th1520-spi" as the compat=
ible.
> > > this patch also adds basic spi support on beaglev ahead which shares =
the
> > > same TH1520 SoC. i have only tested on LicheePi 4A.
> > >
> > > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > > ---
> > >  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml |  4 ++++
> > >  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
> > >  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
> > >  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 10 ++++++++++
> > >  arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++=
++
> > >  drivers/spi/spi-dw-mmio.c                        |  1 +
> >
> > This needs to be 3 different patches - one for the binding, one for the
> > driver and a final one for the dts files.
>=20
> I will convert this into a patch set of 3 patch as you suggested.
>=20
> > > +
> > > +&spi0 {
> > > +     status =3D "okay";
> > > +     spidev@0 {
> >
> > "spidev" is not a type of device, the nodename should match the type.
> >
> > > +             compatible =3D "rohm,dh2228fv";
> > > +             reg =3D <0>;
> > > +             spi-max-frequency =3D <500000>;
> > > +     };
> > > +};
> >
> > I'll put money on you not having a dh2228fv on this board. Document what
> > you actually have on it please, not what allows you to probe the spidev
> > driver in linux.
>=20
> Yes, you are right! Actually as per the vendor's kernel it should be a
> "spi-nor" device from winbond.
> I changed it to spidev for testing purposes. Shall I just leave it
> with status =3D "okay" or add the node for
> that spi-nor flash?

If it isn't on the board, it shouldn't be in the devicetree. Please add
the actual device that is here instead. If there's a board with nothing
connected, then please don't add anything.

Thanks,
Conor.

--J2qMr9rpUpN31Eec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoJ35QAKCRB4tDGHoIJi
0j8KAP9LwCJp3Y34VPmBSkqu5OK4PNlV/u7zd7GesQ6X3g9IfAD4vxPkDRFgIr0I
//mB3acpuMdI2ele2BVcXagmZcbKCg==
=EgMk
-----END PGP SIGNATURE-----

--J2qMr9rpUpN31Eec--

