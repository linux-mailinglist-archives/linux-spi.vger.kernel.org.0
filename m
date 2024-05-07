Return-Path: <linux-spi+bounces-2762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8DE8BE6DE
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511501F24131
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839E3160865;
	Tue,  7 May 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWR7EFJm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595051607B3;
	Tue,  7 May 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094226; cv=none; b=LgJJ7WtVByYp85xVpGa/R/0jib5+zrn8pMjVL/4bXOYbkuw3ARbf6c6lUmLt/ix+lyIwdm892rb+A2Zu/TxEEbfSlZVEs4CZg0AwKfwi/7lWXslBMLOvWi2Qb550qIAe5mJ5QGdDXcqzAc34NT9DH8QB1s0RS/UKPLx9fFa/JXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094226; c=relaxed/simple;
	bh=MbmDftGVEcl1tzW7ssue2yk77QxgL041vPBYpsaVx04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYAIDHmJOHJSB9xmwP4tv6B45KyFt67zA+kdEUV7aipXQPx0W+mgBW5NhayZ613qqH1Nd1/z4cS0kxqWjGEDcl/5h/EPd5LBnGvMBcFpPi5Wv+YkxEpk71Bl5HrE0HyPlo/Hp1zfLz1yIuQAh8kBA9mQS3p40CrjCNpH1mra4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWR7EFJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE65C2BBFC;
	Tue,  7 May 2024 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094225;
	bh=MbmDftGVEcl1tzW7ssue2yk77QxgL041vPBYpsaVx04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWR7EFJmjgl1nmydz+VLZ/DgMNPCZP0AnMzt1Imu3UrYRfgIYuQ68QCcnYctBBoxB
	 q+3C57QRYmGJmsQB/GARWfTjNSG7vDxQfB4pMbfr98A33HhEvCsVuN1odMHx0Rvf7O
	 6VbXRRN0SJALQNIeBo+Phz9uKsR4mDmurlLfmpXnsr9WGa2qRdXWrmFc4AMnD3g3o+
	 CSVcEUSpr0FLnsP6Knm6t2894IuPl/QxIVvx5FJNLNVLV/loiyHvJRP4f/x3MyHYyr
	 ZKluGVNOxQ5ws1axRdCQige4rw0KB14+fyKAexhwoFGehAG3ns4DSF9It/P7MiyRPR
	 irHKV+ZNLeyBg==
Date: Tue, 7 May 2024 17:03:42 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in AIROHA SPI SNFI DRIVER
Message-ID: <ZjpCzj0rd0yhy_9o@lore-desk>
References: <20240507141449.177538-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QhsBNwH5vosXnXpm"
Content-Disposition: inline
In-Reply-To: <20240507141449.177538-1-lukas.bulwahn@redhat.com>


--QhsBNwH5vosXnXpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 07, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>=20
> Commit a403997c1201 ("spi: airoha: add SPI-NAND Flash controller driver")
> adds a new section AIROHA SPI SNFI DRIVER referring to the file
> spi-airoha.c. The commit however adds the file spi-airoha-snfi.c.
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about=
 a
> broken reference.
>=20
> Repair this file entry in the AIROHA SPI SNFI DRIVER section.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca79616a4836..2fe4506f9fe8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -689,7 +689,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated fo=
r non-subscribers)
>  L:	linux-spi@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> -F:	drivers/spi/spi-airoha.c
> +F:	drivers/spi/spi-airoha-snfi.c
> =20
>  AIRSPY MEDIA DRIVER
>  L:	linux-media@vger.kernel.org
> --=20
> 2.44.0
>=20

--QhsBNwH5vosXnXpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZjpCzgAKCRA6cBh0uS2t
rLJCAQD13z4TKLQftjJXpU4GxKidV6Thf4FprqUZgpvWaz+PagD/ZpcAx2Xh75wu
GeUTm6LcNsRlW6KBEUApMvLJVpBKWQ0=
=89Vk
-----END PGP SIGNATURE-----

--QhsBNwH5vosXnXpm--

