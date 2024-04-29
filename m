Return-Path: <linux-spi+bounces-2581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1E48B548D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4391F280BEE
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C92575A;
	Mon, 29 Apr 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPvYVg0l"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF039241E7;
	Mon, 29 Apr 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384251; cv=none; b=h9fpn7L5+UbYykWaEqhbgz+0t8FqFnY2+/LXZ0l4mzieAo/9y2U2U+XAofCF8dnTcZd6aTB3EjWzXB2ySZ8pDk14HTPaO1wkTXmiYNt0d9ffDb9Ufay9eEDSni7iQgeLGOrDKW0uf32IoSPrKiI8HCDnccfAvDvulO8uATgpR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384251; c=relaxed/simple;
	bh=E5xY7/XNBnk4rwXxqmhcINZCCCynbLhDFY/tnllWA+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKv9naFvEO5LPdTxMJub1sJYPJ/II8gLRMw9ow+VE0KBta9Tv8Puc3ieL39x6/dd3gpMNJ07gfo4YPEGEm4niogA02Y/QYRC5zQDrjZ2FROVB7wpx6UBX8h/Nsbrwxk/vJdniE6sPUIVNF/No7g5b/jiazF2Y+tk4nksaZVY9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPvYVg0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D140AC113CD;
	Mon, 29 Apr 2024 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714384251;
	bh=E5xY7/XNBnk4rwXxqmhcINZCCCynbLhDFY/tnllWA+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPvYVg0lXSdPFARtPt7nEIZ4kGKYOsyXFwE52QuaOh6Ie8tlfeqoC6Jq6UMro8p/B
	 yXvoWiHOlu31sWjhNtis0P8I1GuEreok5+Ud5MKUAOYWoiFJx3QjrNzmR7Db7Sq2k5
	 D/Y/YP3CMQCl2q/VVi9oRy5vwb46AIM+kiV6ZYkMBxxCCkTgb6JlUuUE+W/Dj6v0EO
	 Tt62LbYjSJ5htkGLOQSasor0K8dv9yOsKsI/uWRGqWzJKYnzanM113HFPtQ50/STkx
	 jEkV5hmxgQNeMtBTdDYnIqMAG0rNQbl+Ch317Fezb3El/JyWm7PeDgEGhst0i9/dUv
	 KNkFtfAarpmVg==
Date: Mon, 29 Apr 2024 11:50:47 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v5 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <Zi9tdz_VvhqIHnQI@lore-desk>
References: <cover.1714377864.git.lorenzo@kernel.org>
 <6c9db20505b01a66807995374f2af475a23ce5b2.1714377864.git.lorenzo@kernel.org>
 <CAHp75Vc0=bKk+D9ULPhfbVkgHpRTST_niNBYo4Jri_71XQa+dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FJ8W5D6xOH+ziJQT"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc0=bKk+D9ULPhfbVkgHpRTST_niNBYo4Jri_71XQa+dg@mail.gmail.com>


--FJ8W5D6xOH+ziJQT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Apr 29, 2024 at 11:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel=
=2Eorg> wrote:
> >
> > Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> > found on Airoha ARM SoCs.
>=20
> FWIW,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20
> ...
>=20
> > +static void airoha_snand_cleanup(struct spi_device *spi)
> > +{
> > +       struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);
>=20
> > +       struct airoha_snand_ctrl *as_ctrl;
> > +
> > +       as_ctrl =3D spi_controller_get_devdata(spi->controller);
>=20
> You may do it on one line above (the same way as for as_dev).
> Ditto for other similar cases around.

It was to avoid going beyond 79 columns, I do not have a strong opinion abo=
ut
it.

>=20
> > +       dma_unmap_single(as_ctrl->dev, as_dev->dma_addr,
> > +                        as_dev->buf_len, DMA_BIDIRECTIONAL);
> > +       spi_set_ctldata(spi, NULL);
> > +}
>=20
> ...
>=20
> > +static const struct of_device_id airoha_snand_ids[] =3D {
> > +       { .compatible   =3D "airoha,en7581-snand" },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, airoha_snand_ids);
>=20
> No need to keep this block here, the first user is below the ->probe().

ack, I will fix it.

Regards,
Lorenzo

>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--FJ8W5D6xOH+ziJQT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZi9tdwAKCRA6cBh0uS2t
rKfNAP9I4jcnIaZQ5k30M1Gx9lo6B2yz4xYNsUPlCzB0Unqg8wEAgGIvWEECoWIX
lLIqu/Q2/8SNBk9W4i/3JIRvXdxIVwM=
=M4qH
-----END PGP SIGNATURE-----

--FJ8W5D6xOH+ziJQT--

