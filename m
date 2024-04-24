Return-Path: <linux-spi+bounces-2492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132278B0CBF
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42A81F219C3
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9D815E809;
	Wed, 24 Apr 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k84crXgk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CC15E802;
	Wed, 24 Apr 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969486; cv=none; b=QY/3hm3N3vnDHOGiqqHtzZZK3ASieGSV3uixxpk4UL501J/NrE8RZi9zLHE/Q0h0MIQkOXn3QILs013lqgEYSkXsuZFn4/ry8iNX2GZXf5ZN2kzpc9sdD7LDwtdL5IgMg6btRDR5LxO4YnOPPEQt+FJ5YjMYQHPsD+pkVUE7fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969486; c=relaxed/simple;
	bh=unw30XBcP+yo/4XQdedsYzC3CosP/sGpCtqgeHeUPKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INlDniFFZKUGFYD/jEB59Ey7OLy+J4Nr1BLL41EPUFpR91v2of7bYc0GJ0u6GKARG0p4izKWAbQQHrFoCn4b+wv5sR56HXpzbYtieloqsU+Oc2B7BbYiqwsyBNgiCqPDECIHR3L27Do4xNJ+yBSdHJeeil6Vc1zAGb5yFX++l84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k84crXgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2DEC113CD;
	Wed, 24 Apr 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969485;
	bh=unw30XBcP+yo/4XQdedsYzC3CosP/sGpCtqgeHeUPKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k84crXgkiHJ8utgOVxnb6effLWOQN/89JT7R1HOuKj3+267Vsu3pjQk9Ow0mJQD1n
	 59lmHacf95DKd5iM3jFFnQw/QiTPqhgmZcuCueQIFgtziZUuf3nukC6GvhF37jr9+7
	 Pg3wEXbClaZsKLmXKwOc9w7JY30IsVNh/S0/up9/fBh6TwLsOenD4/H6tAhS3/qjHG
	 IVBbiNMCUjNw14H++AiDXxqXJw1CjOdd0TfvUL+uA9PEYntEAbbstO+Kw9QZjBKYHX
	 k6N2U3AXc+0o+Rg6JAaOI/N1xg6w+PNG6igyc3oLKs3TgQ3Xy8IgyyJs8kJ89QiNAn
	 6/rDATaqYz6tQ==
Date: Wed, 24 Apr 2024 16:38:02 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <ZikZSkxKh0OYCjqY@lore-desk>
References: <cover.1713866770.git.lorenzo@kernel.org>
 <497dc9dad823fcd1403ed62ba164dd7d70f31f90.1713866770.git.lorenzo@kernel.org>
 <ZihJfcmjoJZwLofz@surfacebook.localdomain>
 <ZijZwXCHbaSEyAQL@lore-desk>
 <CAHp75Vdf9_-KDLkm2jmkpM=pw=U4nnwYf4dKn8xg=N+DpFYXTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4U3+WsMGnukPqCb"
Content-Disposition: inline
In-Reply-To: <CAHp75Vdf9_-KDLkm2jmkpM=pw=U4nnwYf4dKn8xg=N+DpFYXTQ@mail.gmail.com>


--o4U3+WsMGnukPqCb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Apr 24, 2024 at 1:07=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
> > > Tue, Apr 23, 2024 at 12:16:37PM +0200, Lorenzo Bianconi kirjoitti:
>=20
> ...
>=20
> > > > +   /* addr part */
> > > > +   for (i =3D 0; i < op->addr.nbytes; i++) {
> > > > +           u8 cmd =3D opcode =3D=3D SPI_NAND_OP_GET_FEATURE ? 0x11=
 : 0x8;
> > > > +
> > > > +           data =3D op->addr.val >> ((op->addr.nbytes - i - 1) * 8=
);
> > >
> > > Seems like you wanted to have always the same endianess and hence can=
 be done
> > > outside the loop via cpu_to_xxx()?
> >
> > sorry, I did not get what you mean here, data value relies on the loop
> > iteration.
>=20
>   u8 byte_stream[8];
>   u8 cmd;
>=20
>   cmd =3D ...;
>=20
>   // find what suits your case(s)
>   put_unaligned_be64(op->addr.val, byte_stream);
>   for-loop {
>      err =3D _write_data();
>      ...
>   }

ack, I will fix it in v4.

Rregards,
Lorenzo

>=20
>=20
> > > > +           err =3D airoha_snand_write_data(as_ctrl, cmd, &data,
> > > > +                                         sizeof(data));
> > > > +           if (err)
> > > > +                   return err;
> > > > +   }
>=20
> ...
>=20
> > > Why not utilising cleanup.h? (__free(), no_free_ptr(), etc)
> >
> > I guess we can just allocate as_dev and as_dev->txrx_buf with devm_kzal=
loc()
> > here, agree?
>=20
> If this is a solely part of ->probe() stage, yes.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--o4U3+WsMGnukPqCb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZikZSgAKCRA6cBh0uS2t
rGU2AQDvbdXTZ+P+0LBWXD8icCgFhTk0QUDrZ/0gXTrvN2W8+QEAkkcFdBJ4/6RQ
rccGnh3Wf0RGprTGjIa+gGbG09ffwgg=
=2aL4
-----END PGP SIGNATURE-----

--o4U3+WsMGnukPqCb--

