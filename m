Return-Path: <linux-spi+bounces-4494-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9459596718F
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3EF1F22894
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB517E01C;
	Sat, 31 Aug 2024 12:28:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC817E01B
	for <linux-spi@vger.kernel.org>; Sat, 31 Aug 2024 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725107289; cv=none; b=ZVdlYjpQlG9B5/PLTg/2nzb0DcZbc/yzMmUuZOQI1tFwwdPVT+piBVMWjLjX08EfvYsVa2Y3Ojn+T39zZLVQXwsU3/RiqwjFN/osb+HL4Q4FuG0Pu0YhD+F83J44U4RuQZo3mxg2QZcgvCTf1JyT+AkHRZ4DvT0/vYfg2ErUd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725107289; c=relaxed/simple;
	bh=pvC/rc4EGrb8mtS6EIahOyR7G9lc3uRyb0Bj3Pl+MIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=j741jVoKIKE4ee0kr4a5S097+RaCqNz07JKlJ6J+1XMxWyFul+X3A5q0JdtOYJAGC/0/wV+5xzVYCuplO60FmhdCuHvrE9XOiNRnP900wtOSGbUEoMgq2MAbPlm6E47xjAHEXqbjwuZXTdZd98KUPADvf8UvRZYiWA5BwBR1pe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-bIz0EuKoNPmEz4bY-gpZwA-1; Sat, 31 Aug 2024 13:28:03 +0100
X-MC-Unique: bIz0EuKoNPmEz4bY-gpZwA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 31 Aug
 2024 13:27:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 31 Aug 2024 13:27:19 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yan Zhen' <yanzhen@vivo.com>, "han.xu@nxp.com" <han.xu@nxp.com>,
	"haibo.chen@nxp.com" <haibo.chen@nxp.com>, "broonie@kernel.org"
	<broonie@kernel.org>
CC: "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v2] spi: nxp-fspi: Use max macro
Thread-Topic: [PATCH v2] spi: nxp-fspi: Use max macro
Thread-Index: AQHa+IMHZV0HYMLLd0icFMuKBcoi+rJBUF+Q
Date: Sat, 31 Aug 2024 12:27:19 +0000
Message-ID: <1ac834f698524ef8bce28a4a1024a3a7@AcuMS.aculab.com>
References: <20240827131203.3918516-1-yanzhen@vivo.com>
In-Reply-To: <20240827131203.3918516-1-yanzhen@vivo.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Yan Zhen
> Sent: 27 August 2024 14:12
>=20
> When the original file is guaranteed to contain the minmax.h header file
> and compile correctly, using the real macro is usually
> more intuitive and readable.
>=20
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>=20
> Changes in v2:
> - Rewrite the subject.
> - Using max_t() instead of max().
>=20
>  drivers/spi/spi-nxp-fspi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 88397f712a3b..fda902aa5815 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -756,8 +756,7 @@ static int nxp_fspi_read_ahb(struct nxp_fspi *f, cons=
t struct spi_mem_op *op)
>  =09=09=09iounmap(f->ahb_addr);
>=20
>  =09=09f->memmap_start =3D start;
> -=09=09f->memmap_len =3D len > NXP_FSPI_MIN_IOMAP ?
> -=09=09=09=09len : NXP_FSPI_MIN_IOMAP;
> +=09=09f->memmap_len =3D max_t(u32, len, NXP_FSPI_MIN_IOMAP);
>=20

This shouldn't be max_t().
That is equivalent to:
=09=09(u32)len > (u32)NXP_FSPI_MIN_IOMAP ? (u32)len) : (u32)NXP_FSPI_MIN_IO=
MAP;
Which you'd never write and has the obvious fubar that is 'len' is 64bit
and greater that 2^32 the wrong thing happens.

=09David

>  =09=09f->ahb_addr =3D ioremap(f->memmap_phy + f->memmap_start,
>  =09=09=09=09=09 f->memmap_len);
> --
> 2.34.1
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


