Return-Path: <linux-spi+bounces-7141-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF3A60448
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F104019C284C
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D3B1F868C;
	Thu, 13 Mar 2025 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e64LBVlY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17791F8672
	for <linux-spi@vger.kernel.org>; Thu, 13 Mar 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904880; cv=none; b=gUUd3WsdoXGKoizIOrwquWECeL6EeG5RO31FwKkzyumFnhq4zWg4QlJpWWaVNg3DSDv4ulkKGKVYm7CW6pxQKH4gkRMtyO56IAnUTurY1loYPRMoZEbJoLCablWQP1LLbHcOGpWFu4YVjgKD/Rc3u4vUvIvAmq3N+gze1xeHOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904880; c=relaxed/simple;
	bh=6RwwkHmdGoLVN/PfCoi7y3N9L+cMBx5Qov8w7P5m2U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMBP/r5AIiQSHocTb7zaTQyOoF/yQ8OBHphNCR/JMN2xPiEEwZGr9BMGYnf2hFJeRskZzyWztEnu4eKOGuqZ7EmwxdlETSbLZXE35fMpK/o75d/e2xha5TwLDcNO9iF0Ulkln2s1yDaTaOakm4BewdSw05ZOImTKy2nsUl72u/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e64LBVlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A549C4CEDD;
	Thu, 13 Mar 2025 22:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741904879;
	bh=6RwwkHmdGoLVN/PfCoi7y3N9L+cMBx5Qov8w7P5m2U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e64LBVlYys+pxwCUzmNcxQ/gLQaNVd2Q84LovYPXYV7s1IEgc2xnXrBWu3S4GBW/C
	 73gNYBD7KMTp+9oj4lXIzKCusWKVToZJKUV6HaKXg64VErUho2H0rEno3lD6+4GwRS
	 8EoK2DMsBTk3gTpbxAWSVI3zm4c+wbc394uL7PEi1dhwNVahXRO5QLh/8dOdI3G0jF
	 SKy4xkiS0CRClw7quxEloh+USkMSpAiw1DTsLhaZlTvEJ0y0pfUlBG63hwqYHGlLEU
	 iH0H60N3dhFu//wPrctBveUet6nccUua9BTPl4Z4nY1TyQX5RUDiJIUNzfUr+0PSCU
	 DGW6/p+hj+jDA==
Date: Thu, 13 Mar 2025 22:27:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: Introduce a default ->exec_op() debug log
Message-ID: <ce648080-2964-40d2-a2a7-cafcb6592cd1@sirena.org.uk>
References: <20250305201140.2513431-1-miquel.raynal@bootlin.com>
 <a073191e-afab-484e-9659-66b957301db1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ECiJ96NhrvPZjXLD"
Content-Disposition: inline
In-Reply-To: <a073191e-afab-484e-9659-66b957301db1@linaro.org>
X-Cookie: A beer delayed is a beer denied.


--ECiJ96NhrvPZjXLD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:05:39AM +0000, Tudor Ambarus wrote:
> On 3/5/25 8:11 PM, Miquel Raynal wrote:

> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -377,6 +377,17 @@ int spi_mem_exec_op(struct spi_mem *mem, const str=
uct spi_mem_op *op)
> >  	/* Make sure the operation frequency is correct before going futher */
> >  	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
> > =20
> > +	dev_dbg(&mem->spi->dev, "[cmd: 0x%02x][%dB addr: %#8llx][%dB dummy][%=
4dB data %s] %d%c-%d%c-%d%c-%d%c @ %uHz\n",

> Isn't this too "chatty", especially on page program ops? I wouldn't be
> surprised if the prints introduce timings that change controller's
> behavior. How about using dev_vdbg?

That, or covert to trace_printk() or even better a trace event - with a
trace event you get really fine grained control and extremely low
overhead.

--ECiJ96NhrvPZjXLD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfTW+oACgkQJNaLcl1U
h9DmFgf8CAQjBsT26zFqjATsL1yUuYG5KpE5rSCbPOz7lsut6U0aSlWOe7BxwpAY
hRniNYuzot2vM+glrgJPxiKHOL2dXb+af8L5cBGDYfTLWmEUPCeGJ/cCt9I4t4vD
/Nd5lYDqxcVf+HVyi1vtnJxK5OXGJHae+mp5jXsdSE83YJ8MiFd1yKmu+G7M0yUM
VL6PpEfZHBvGJC2EJ+XyKALKMa3cRSWT/pEni0V/lJQrcAglocTN4hgPGSUXUUm8
YpQu1DnbHZrUxidvBh/wV5jleCVH19x94dWtiYaz/1WoWqBqvmrfzWfqhIgSeS5q
KJ2E5EuGtKIL1GpuYHWIwSWw3KKhdw==
=hxID
-----END PGP SIGNATURE-----

--ECiJ96NhrvPZjXLD--

