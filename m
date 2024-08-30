Return-Path: <linux-spi+bounces-4487-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C48966A1F
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 21:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E401F213CF
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE341BD50E;
	Fri, 30 Aug 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2IrimDP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0A14AD38;
	Fri, 30 Aug 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047872; cv=none; b=uy1SzW0W9/xq26gC0AJuQDtOON2f1hPv+sJQtVA3mix4qc3G0zphJi1iJi6c0rj8a5DZ+ZmT3fyoOsA0b6n4P6svUAdSgRp+sL5mJySbHrTw/RRiN3UQ1+KDMoMVd5XPRARzJ5jwxQlFFHZOim4mzEydC/JvHtar452DRqKcQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047872; c=relaxed/simple;
	bh=79Qx0AIZA/CJgt/9DGfTFyD8iHFQ5xSQnWfd2+XkQPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUZOwfNOBSiZDRWZFDrXWV9opewKFaJn+xv44j608b5BITqCakmKpRi2Acsihr450A1FFS3+gbYQQOze1VboJBfAGkVBmuA0bMcTwNc7t31Fasr6TAly0mDCxe8df2ni7zBaSvddM8GDFbAsQ1ofoOf4OCj9fw/PjFJ0qqYZwDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2IrimDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F2AC4CEC6;
	Fri, 30 Aug 2024 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725047871;
	bh=79Qx0AIZA/CJgt/9DGfTFyD8iHFQ5xSQnWfd2+XkQPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2IrimDPlgB5pTgTjK5DCwY3k6FXgj/aF4UgGX7UuV7uJIv41/l8AVnJmTv7vLxxt
	 f+Stg7uzwNyGo6AbMqL13SfBA8b/PSXKofY4tePuMwa8dz4bjWrIxTZ8kNeAJ2wKKP
	 nwTi7cGXz5xOgPRmdvqq7wZrWlBlf68PdwY6O82r2ps6rxtjOvnK+MFo8azxL+q5WI
	 a7Jy4WwXZRxviCpzHnu7oBEwfafpNAQe9tBvgoFG+Q50CyXqBWE6nAz8WCeRnpz0Dy
	 IlsEObIRxxU1tfhmMmP463SO8LxlLMIm4a6Z7ZmaOAppDFNToYguyvHUf3Z7mWdjNM
	 h47g85SIUZvUA==
Date: Fri, 30 Aug 2024 20:57:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yang Ruibin <11162571@vivo.com>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
Message-ID: <0a906ee9-7b28-45e4-be67-ab3b6c5f89b1@sirena.org.uk>
References: <20240829033511.1917015-1-11162571@vivo.com>
 <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0vDO+Jy2433LYmJO"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
X-Cookie: for ARTIFICIAL FLAVORING!!


--0vDO+Jy2433LYmJO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:55:06AM +0200, Geert Uytterhoeven wrote:
> On Thu, Aug 29, 2024 at 5:35=E2=80=AFAM Yang Ruibin <11162571@vivo.com> w=
rote:

> > -       if (ret)
> > +       if (ret) {
> > +               pci_dev_put(dma_dev);

> dma_dev is still uninitialized at this point.

I'm a bit concerned that this isn't picked up by an allmodconfig with
the -Werror...  I'm currently using GCC 12 for that.

--0vDO+Jy2433LYmJO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbSJDoACgkQJNaLcl1U
h9A3EAf+NBtStIahtcVYTH/RxBW+YUhbhWY90JiaIAKD4jI8nLSYlxG4SQWOROpI
fjcWkjKDI/DUqHTxYB9mu9QTDYZRNMDyFlAW/1WbS/ezz8VJIE5EM6FXzBi3cFB2
Iz5+AzTtW7F9vbQ39ybXa5RC417k0CFFnFfSm4r1MoHJytcwa493/WkfywIlcVqx
r47rDgLrvosGCZMLoJMzqyi+S3wyRokfPvRy/CvGfoJ8v5aMLRvS/fMR3aVodvBL
fuGuq996E3YJ5NXXzCQ8b9jt9XflZo5pWckqJlUwY8M1VgzbCeL/Qw6xtbLmW4PT
fn3Nqp5rP6/Amp1T0AADiOF7/6FAWA==
=DyDU
-----END PGP SIGNATURE-----

--0vDO+Jy2433LYmJO--

