Return-Path: <linux-spi+bounces-2554-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733A8B3CA3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 18:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F42289D7F
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FBA155726;
	Fri, 26 Apr 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWXjn+TS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFD15358A;
	Fri, 26 Apr 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148357; cv=none; b=C17XyOL2+hViGSoZyXTjyQmJgVhsfflcxyYfdtU5w43HSgw/Ju+f4uQQfHn/7i/ZnbIuN07RPUP2qZdwJzz2tbscez8RMnk3apt8ocWYIzqjPnQBxzVqpUo8KaKq6iSMN+CR0VI7KFeYdfKfRjUgaj1tT9qdM4vaRbLyoSzhUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148357; c=relaxed/simple;
	bh=DHuoJm0eBZR9q50qciAmM9YlONSJlsoA+mOZEcCTj/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ9k6d6lZExMbMqBnqoUjrwLaWO8HnAREMRcy4BrVPovC2tI6i4WHux9W6ggw/dxr5WSI9gyAS4VDQp3ybbpPk5BXpJyYRTFnnHDMr83KoJmNGdQz4Mk+v6zGnMA+l/I8epyDSJuvzRVAHEfiYu1C4gRHlgIDnqBi4Xoh4gTWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWXjn+TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986D7C113CD;
	Fri, 26 Apr 2024 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714148357;
	bh=DHuoJm0eBZR9q50qciAmM9YlONSJlsoA+mOZEcCTj/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWXjn+TSpDKyZjwX/zY5TvCtVCTlNBlrcUdVPGTSM1NYNxauM7Bo6Bvyvnhb8283x
	 lHluR1EOZSHXQyCkJZnQu0T4fq2FnBKVj/iNEHMU25VUIbBy0LKt6vPdtHLDn8zV0i
	 6CVgZWGt90d9JLip6Now60Cz2H+Au1n6vn3leP7DNuFeM0ODsGlxdWk8VDYF/PevvH
	 vMI5Ohcuvh4kUkZ6P/hSJWwBSgS2S6YoxNjNTtrhp/TnuqRhxD+ejy+0rc/8VqnRq6
	 nbd75YBEx7NeyqbvFQWuJ4n56jmdP1H8/nxwn4LPVw1+Z+CKEWXhQCbwXUfAwIErTs
	 R8TWqg6RgogYw==
Date: Fri, 26 Apr 2024 18:19:13 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <ZivUAZ2SKRJsESKF@lore-desk>
References: <cover.1714119615.git.lorenzo@kernel.org>
 <2047e9c8372b51dc263178a12e194b8826f1abe7.1714119615.git.lorenzo@kernel.org>
 <CAHp75Vd5VSMNy-bYQmcmRA47uTn567QiKmvDJGEkRUgVCk5PAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LykAaqEnqTHChxLF"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd5VSMNy-bYQmcmRA47uTn567QiKmvDJGEkRUgVCk5PAQ@mail.gmail.com>


--LykAaqEnqTHChxLF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Apr 26, 2024 at 11:31=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel=
=2Eorg> wrote:
> >
> > Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> > found on Airoha ARM SoCs.
>=20
> ...
>=20
> > +#include <asm-generic/unaligned.h>
>=20
> No driver should include asm-generic, basically 99.9% of the kernel
> code must not do that. I.o.w. asm-generic is very special.
>=20

ack we can use <asm/unaligned.h> instead

> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
>=20
> + delay.h
>=20
> > +#include <linux/device.h>
> > +#include <linux/dma-mapping.h>
>=20
> + errno.h
>=20
> > +#include <linux/types.h>
>=20
> Can you make it ordered (I noticed this after a while)?
>=20
> + limits.h
>=20
> > +#include <linux/math.h>
>=20
> + minmax.h
>=20
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/sizes.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/spi/spi-mem.h>
>=20
> + types.h
>=20
> Also note, we usually place headers from more generic to less, hence
> linux/* followed by asm/* and not vice versa.

ack, I will fix it.

>=20
> ...
>=20
> > +struct airoha_snand_dev {
> > +       size_t buf_len;
> > +
> > +       u8 *txrx_buf;
> > +       dma_addr_t dma_addr;
> > +
> > +       u64 cur_page_num;
> > +       bool data_need_update;
> > +};
>=20
> ...
>=20
> > +               /* quad io / quad out */
>=20
> io --> in ?

ack, I will fix it.

>=20
> ...
>=20
> > +               /* dual io / dual out */
>=20
> Ditto.
>=20
> ...
>=20
> > +       case SPI_MEM_DATA_OUT:
> > +               /* check dummy cycle first */
> > +               if (op->dummy.nbytes)
> > +                       return false;
> > +
> > +               /* program load quad out */
> > +               if (op->addr.buswidth =3D=3D 1 && op->data.buswidth =3D=
=3D 4)
> > +                       return true;
> > +
> > +               /* standard spi */
> > +               if (op->addr.buswidth =3D=3D 1 && op->data.buswidth =3D=
=3D 1)
> > +                       return true;
>=20
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return false;
>=20
> Why not return false directly from the default case?

it is because we still need the 'return false' at the end of routine for the
other cases due to SPI_MEM_DATA_IN and SPI_MEM_DATA_OUT.

>=20
> ...
>=20
> > +               op->data.nbytes =3D min_t(size_t, op->data.nbytes, 160 =
- len);
>=20
> You probably wanted clamp(). It's discouraged to use min_t() for unsigned=
 types.

do you mean doing something like:

op->data.nbytes =3D clamp(op->data.nbytes, op->data.nbytes, 160 - len);

maybe an 'if' condition is more readable, what do you think?

>=20
> ...
>=20
> > +       err =3D regmap_read_poll_timeout(as_ctrl->regmap_nfi, REG_SPI_N=
FI_INTR,
> > +                                      val, (val & SPI_NFI_AHB_DONE), 0,
> > +                                      USEC_PER_SEC);
>=20
> Perhaps
>   1 * USEC_PER_SEC
> ?
>=20
> Easy to read plain numbers like this to get the idea "this is 1 SEC
> timeout". Also editors highlight plain integers with a different
> colour.
>=20
> ...
>=20
> > +       /* addr part */
> > +       cmd =3D opcode =3D=3D SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
> > +       put_unaligned_be64(op->addr.val, data);
>=20
> > +       for (i =3D 0; i < op->addr.nbytes; i++) {
> > +               err =3D airoha_snand_write_data(as_ctrl, cmd,
> > +                                             &data[8 - op->addr.nbytes=
 + i],
>=20
> Now you can update a for loop to make this prettier, right?
>=20
> > +                                             sizeof(data[0]));
> > +               if (err)
> > +                       return err;
> > +       }
>=20
>        for (i =3D 8 - op->addr.nbytes; i < 8; i++) {
>                err =3D airoha_snand_write_data(as_ctrl, cmd, &data[i],
>                                              sizeof(data[0]));
>                ...
>        }
>=20
> Note, 8 can be replaced by sizeof() / ARRAY_SIZE() but I'm not insisting.

ack, I agree. I will fix it.

>=20
> ...
>=20
> > +       devm_kfree(as_ctrl->dev, as_dev->txrx_buf);
> > +       devm_kfree(as_ctrl->dev, as_dev);
>=20
> Why?! Using devm_*free() explicitly hints about either
> misunderstanding of devm concept, or object's lifetime.

ack, I agree, we can get rid of them.

>=20
> ...
>=20
> > +       spi_set_ctldata(spi, NULL);
>=20
> Seems there is no consensus on NULLifying this (when, if even needed),
> but it's fine.
>=20
> ...
>=20
> > +       base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>=20
> How is 'res' being used exactly?

right, we can pass NULL here to devm_platform_get_and_ioremap_resource()

>=20
> > +       if (IS_ERR(base))
> > +               return PTR_ERR(base);
>=20
> ...
>=20
> > +       base =3D devm_platform_get_and_ioremap_resource(pdev, 1, &res);
>=20
> Ditto.
>=20
> > +       if (IS_ERR(base))
> > +               return PTR_ERR(base);
>=20
>=20
> ...
>=20
> > +       ctrl->dev.of_node =3D dev->of_node;
>=20
> Use device_set_node() instead.
> You might need dev_fwnode() from property.h.

ack, I will fix it.

Regards,
Lorenzo

>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--LykAaqEnqTHChxLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZivUAQAKCRA6cBh0uS2t
rICzAP9ek0ugGc+6vVGU6OUSIHPYCmrh6Xsx0GriI+27vMdKUgD+Jp6uEr6BzhCc
wxkmky2hnY+tUvxFF8G59BVhuCrLDAY=
=blsC
-----END PGP SIGNATURE-----

--LykAaqEnqTHChxLF--

