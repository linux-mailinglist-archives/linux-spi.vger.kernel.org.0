Return-Path: <linux-spi+bounces-4336-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64613960963
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 13:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8A4B21121
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D60A1A0732;
	Tue, 27 Aug 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx89GuTc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4F1A071C;
	Tue, 27 Aug 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759871; cv=none; b=etvoE9h9E76WHr3kHi4IXxhL+xUtqiA5gTmNBu7U62/pFyKKPEGzmdWapa8M1FodOcEmZT5sxZqM5wv0BwXIxaRaACuR7yf8vFS597D8Il2JMWvkip34UV3BOrM10OF4JyCeoOrTed3a3CR+uRjO74iRbpMPxkKo8+DovzrtIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759871; c=relaxed/simple;
	bh=CYc5VELAzAhXfQWr5pJETL/meW5/Mhe4vpHIk/kG5Fc=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=rulZzoLYD9gJ58qxaY2h78j609ngXcduMJGs+FjV6TMs7m/AlNgEEGq70B/svMlce+BtXkImBS2XLQQsHXK0Lj+v1X/M3WmVR1eQqGGUYk5QIB2UuBT6RXHaKsxObS+oOGO99nUF33upTfYRDxT9wDinEcltv3QsghfV9gG0DCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx89GuTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DAFC61060;
	Tue, 27 Aug 2024 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724759871;
	bh=CYc5VELAzAhXfQWr5pJETL/meW5/Mhe4vpHIk/kG5Fc=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=Bx89GuTcDUlXC5ydTlMXLzKMFStTU3OGz/xCU4WqBbgTSEqMpNcjTTSmgTd/mk4QG
	 PVfyuiWZGHRxZlnj9x/ttsraIZ+s1+MlvNRV3K6NNNlJMgnknQbdbdagHQy3Z0vmBq
	 Qn4EBb/qjxu8/UcQQo9Xfmi/0o+JkOgsD+eTEeCY7gBfofh5NQrBu3Wq7ibUp0FT/x
	 YRyIzY6TjBuO923cFr5tImmQKhnWb0ysCpDqLiPH3AbIAPinpwvslWurU9FjpOt7VV
	 kyRDb9LLLdMwDjG12zNckQrY5/jhXFuRPVPRdPsWQsHjYu931fGbfXrPwEzhVKzQNV
	 ZDmbQqaebostg==
Content-Type: multipart/signed;
 boundary=cd9088e86bbd2ff47209cffbdbcf0cdc176a5d2737869e3e822db09cb6b3;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 27 Aug 2024 13:57:46 +0200
Message-Id: <D3QOCGDROG5A.361R73U5376FE@kernel.org>
Cc: <yogeshgaur.83@gmail.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Yan Zhen" <yanzhen@vivo.com>, <han.xu@nxp.com>, <haibo.chen@nxp.com>,
 <broonie@kernel.org>
Subject: Re: [PATCH v1] spi: nxp-fspi: Use min macro
X-Mailer: aerc 0.16.0
References: <20240827085739.3817877-1-yanzhen@vivo.com>
In-Reply-To: <20240827085739.3817877-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

--cd9088e86bbd2ff47209cffbdbcf0cdc176a5d2737869e3e822db09cb6b3
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Aug 27, 2024 at 10:57 AM CEST, Yan Zhen wrote:
> When the original file is guaranteed to contain the minmax.h header file
> and compile correctly, using the real macro is usually=20
> more intuitive and readable.

The subject doesn't match what you're doing here. Also, shouldn't
one use max_t()?

-michael

>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 88397f712a3b..fda902aa5815 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -756,8 +756,7 @@ static int nxp_fspi_read_ahb(struct nxp_fspi *f, cons=
t struct spi_mem_op *op)
>  			iounmap(f->ahb_addr);
> =20
>  		f->memmap_start =3D start;
> -		f->memmap_len =3D len > NXP_FSPI_MIN_IOMAP ?
> -				len : NXP_FSPI_MIN_IOMAP;
> +		f->memmap_len =3D max(len, NXP_FSPI_MIN_IOMAP);
> =20
>  		f->ahb_addr =3D ioremap(f->memmap_phy + f->memmap_start,
>  					 f->memmap_len);


--cd9088e86bbd2ff47209cffbdbcf0cdc176a5d2737869e3e822db09cb6b3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZs2/OxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hfEgGAsb5PJxkUzax2SgeJkjshmtpMRRh/jJsy
rqJX6PFamFExSeA5u8p2PlIFWeEjdR59AX9h0letX229cmVb/qUOe1Sgf8Lo23Vc
SJCFaf97YzB+Od/GQHWgCfUbw7IHvWwlmCI=
=pDAh
-----END PGP SIGNATURE-----

--cd9088e86bbd2ff47209cffbdbcf0cdc176a5d2737869e3e822db09cb6b3--

