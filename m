Return-Path: <linux-spi+bounces-9631-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB92B327AC
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B95E56582F
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1A23909F;
	Sat, 23 Aug 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPgTCDfF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9221576E;
	Sat, 23 Aug 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938185; cv=none; b=J4EFNIrJiAqyhtq/HQbCKQdwXGAkxpxdaybuNnyn3WWUp47J6DRwWUYVTLyMhJQJhWzbdm4jfpgFV7BYOTuzrGl8n95aYIpE4MKJTTlC3dMKxg3CP4hRUv4jfhjgMKyQK8KfcEX7Nwbq6qhEazcTN+8e2RSP49UvwUL0FrQKgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938185; c=relaxed/simple;
	bh=9HXgfwsXlpHGuE4MNNyqKCJCXrlDF0GP047HKDxcEJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYaCshBMLy5NWLbu7r3tR5cOwT8kPJovBBvLDQrq7viR1RruJBx+NfuZuUyGDkov3f2lLBWG2qp+gBrzpkwcgVIHQFgAP4X9RT632rHkSb+BxaBXFWQnVkO6JmIzpFbAvfiai9pVMqJ4jElPY5V5+pmDVXvrInMgvlnokZ0kRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPgTCDfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5661BC4CEE7;
	Sat, 23 Aug 2025 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755938184;
	bh=9HXgfwsXlpHGuE4MNNyqKCJCXrlDF0GP047HKDxcEJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPgTCDfFlfFyx/PiB1QzQKBlavWtGGDch+zyjkzeztX3onwKjHYSxZTiS5AoI1svs
	 R1nARjQtYYAzrnTAIZGXlli987Qzi2Yd3EBW6B/Jro0gWM11ZpO0yR++Z4/0EFtFb8
	 LMrybYiucqExh5Ff5VlSmHlLSE5H3M29bkY3gCtKGrFV8/m4IT3YdKpXtx55RQzgIU
	 /Z08CMRa1HVDcufEVrkpNKOOn62koeSgbRdKRFeOoBH2MQLiyiSLENoOymL0BmZ3cG
	 z/B9puxop6U6Xvv/Y6aAmzZ6ubfSkqKcEpPX8tb32OvL7yb6cwt1UnME8Hg7GWVJGp
	 YSC3nQOxx4W3g==
Date: Sat, 23 Aug 2025 10:36:20 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/13] spi: airoha: fix reading/writing of flashes
 with more than one plane per lun
Message-ID: <aKl9hOx2hcZUfg-k@lore-rh-laptop>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823001626.3641935-8-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LN76RXLjGbIEDXVw"
Content-Disposition: inline
In-Reply-To: <20250823001626.3641935-8-mikhail.kshevetskiy@iopsys.eu>


--LN76RXLjGbIEDXVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Reading UBI on the flash with more than one plane per lun will lead to
> the following error:
>=20
> ubi0: default fastmap WL pool size: 50
> ubi0: attaching mtd2
> ubi0 error: ubi_add_to_av: two LEBs with same sequence number 403
> eraseblock attaching information dump:
>         ec       1
>         pnum     538
>         lnum     0
>         scrub    0
>         sqnum    403
> Volume identifier header dump:
>         magic     55424921
>         version   1
>         vol_type  1
>         copy_flag 0
>         compat    0
>         vol_id    1
>         lnum      0
>         data_size 0
>         used_ebs  0
>         data_pad  0
>         sqnum     403
>         hdr_crc   c8418a31
> Volume identifier header hexdump:
> 00000000: 55 42 49 21 01 01 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00  UBI!............................
> 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 93 00 00 00 00 00 =
00 00 00 00 00 00 00 c8 41 8a 31  .............................A.1
> ubi0 error: ubi_attach_mtd_dev: failed to attach mtd2, error -22
> UBI error: cannot attach mtd2
> UBI error: cannot initialize UBI, error -22
> UBI init error 22
>=20
> looking to spi_mem_no_dirmap_read() code we'll see:
>=20
> 	static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
> 					      u64 offs, size_t len, void *buf)
> 	{
> 		struct spi_mem_op op =3D desc->info.op_tmpl;
> 		int ret;
>=20
> // --- see here ---
> 		op.addr.val =3D desc->info.offset + offs;
> //-----------------
> 		op.data.buf.in =3D buf;
> 		op.data.nbytes =3D len;
> 		ret =3D spi_mem_adjust_op_size(desc->mem, &op);
> 		if (ret)
> 		return ret;
>=20
> 		ret =3D spi_mem_exec_op(desc->mem, &op);
> 		if (ret)
> 			return ret;
>=20
> 		return op.data.nbytes;
> 	}
>=20
> The similar happens for spi_mem_no_dirmap_write(). Thus spi read address =
should
> take in the account the desc->info.offset.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Missing Fixes tag.

Regards,
Lorenzo

> ---
>  drivers/spi/spi-airoha-snfi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> index 3431a9c84679..df2d3d717c00 100644
> --- a/drivers/spi/spi-airoha-snfi.c
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -727,8 +727,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_me=
m_dirmap_desc *desc,
>  	if (err)
>  		goto error_dma_unmap;
> =20
> -	/* set read addr */
> -	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
> +	/* set read addr: zero page offset + descriptor read offset */
> +	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
> +			   desc->info.offset);
>  	if (err)
>  		goto error_dma_unmap;
> =20
> @@ -872,7 +873,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_m=
em_dirmap_desc *desc,
>  	if (err)
>  		goto error_dma_unmap;
> =20
> -	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
> +	/* set write addr: zero page offset + descriptor write offset */
> +	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
> +			   desc->info.offset);
>  	if (err)
>  		goto error_dma_unmap;
> =20
> --=20
> 2.50.1
>=20

--LN76RXLjGbIEDXVw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKl9ggAKCRA6cBh0uS2t
rNEzAP9Qd8XxGGaG44w/Yv1yxymd6mE+vW15GyHs8Zjiv/dEsAD6AvgUJ/iXlYAj
4sbGzifvI0iy8Pslf9mIRvj9KGVXcws=
=Ju9w
-----END PGP SIGNATURE-----

--LN76RXLjGbIEDXVw--

