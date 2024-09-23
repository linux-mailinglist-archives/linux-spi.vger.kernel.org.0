Return-Path: <linux-spi+bounces-4924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0274E97E671
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597B51F214E3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BA2B9DD;
	Mon, 23 Sep 2024 07:24:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D5D529;
	Mon, 23 Sep 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076252; cv=none; b=YRLlsi4WZbV9XCt9nTA7vYk07G7dQMhB0cRXNX43sUdyJIaokXFEiMUDq95G1EWwNz6CiF9W/DNhLhQIP7472EKFPOZcJ5OQS5P+yjyxPBzcVr26PKeqhuDd9iMvGfBPylNKqOoypBhXYrkFc8ZbM3CjrLFgZCYEfeWLb7pAPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076252; c=relaxed/simple;
	bh=J+gXBU4oM5p8X1MMHrOd5w8x8gnG4wWNFQ4hggpXm8g=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=eOCuDKoQrVApk9RlpLUcNuDb0j3Xql7nxOsngaWtkcm+dD+NkTSYiNP9/QhFdeSGTU4ejF/tf6aF4AMpAt6K29CbsA1AZ4mMTTDS7sHkD+LgkYmVD7f/bYj35X7L9w/1zw7uamrPpuORR1/5owDkEffj6y9Ps0HBCgT+4jSCqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 4C90C4CF;
	Mon, 23 Sep 2024 09:18:02 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Sep 2024 09:18:01 +0200
Message-Id: <D4DHAZ1MIJV2.1G810GI4K5DVV@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "AlvinZhou"
 <alvinzhou.tw@gmail.com>, <linux-mtd@lists.infradead.org>,
 <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>, <broonie@kernel.org>
Subject: Re: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal
 flash
Cc: <chengminglin@mxic.com.tw>, <leoyu@mxic.com.tw>, "AlvinZhou"
 <alvinzhou@mxic.com.tw>, "JaimeLiao" <jaimeliao@mxic.com.tw>, "Bough Chen"
 <haibo.chen@nxp.com>
X-Mailer: aerc 0.16.0
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-7-alvinzhou.tw@gmail.com>
 <97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>
In-Reply-To: <97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>

Hi,

> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[]=
 =3D {
> >  		.name =3D "mx25l3255e",
> >  		.size =3D SZ_4M,
> >  		.no_sfdp_flags =3D SECT_4K,
> > -	}
> > +	},
> > +	/* Need the manufacturer fixups, Keep this last */
> > +	{ .id =3D SNOR_ID(0xc2) }
> >  };
> > =20
>
> Could you please elaborate why you need just the manufacturer id here? I
> would have expected to see a specific flash entry instead.

I can't find the thread anymore as this is going on for forever, but
that was my suggestion. That's a catch all to have the manufacturer
fixup applied for any macronix flashes instead of having to list
each flash id here.

-michael

