Return-Path: <linux-spi+bounces-3362-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF18690263F
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B51F21688
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E29B13E3EB;
	Mon, 10 Jun 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWlBJeyW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7031DFF7;
	Mon, 10 Jun 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035425; cv=none; b=W++EGgAWXfsDcRm23wcksP9dbDELlyIgr1ejGojgbRoRXNRdqvLGwjdCb1buDx2kLPSodWp76pg0Eb44MtFZJ+9AKrXuGMTqEPLZP7VDDu6yFdQbF4MJwSBYQjxVFl0VwIvAyjwWitlrb0H3lnor6lcrGcihilb+2IR14jHm3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035425; c=relaxed/simple;
	bh=V9fIEFBlHACQSU+XdBBetn3CjXbSlvURx9sdZBrEgxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFpmCbqjgRsivc2/aAtHz9NpiHpehpd2gCzgP01ezEd0DuLGpHrul5H9FaoTYxfmxIwDWN60/opZ/jSI5TmzNMmjTYABhXPCOFD8ixVeA1CJhQLdDNbQn+IMsK3Hhypuvr1RoLJ+cYMJ/1gWXz1fvRkIznl4OaA/9dpccQGB76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWlBJeyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66198C32786;
	Mon, 10 Jun 2024 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718035425;
	bh=V9fIEFBlHACQSU+XdBBetn3CjXbSlvURx9sdZBrEgxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWlBJeyWsdb0rLnTNGJssv0sPX4kkqjZxnewEOeCxpnhWsrsfvAurWHJ4KLS9Vm+g
	 RGwpBFGvBzK3SUC8hriMi/z+oQaPC8q/5mQcbFqvmAB6kOkfKQg7U09I5oIRbM6w42
	 KrxWGrfcd6ap4DgwsHByzzKud6jBaEkAgKMfS8U2qGa3hGiKBkNpr3IuS8zhv2I8sg
	 hUF11Uh/tDhcvksy4HZqBTj6dzX246cXCp7A4is5W9qIUYfaU9FioF1NfncjPNwVrs
	 WD735ntYQWf1ChdFdLjrdhvm+OY8TedswiqezpcktPQq8AStHtwvvvmzbzNgpRRwQH
	 /IAl87viVttYA==
Date: Mon, 10 Jun 2024 17:03:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v8 2/4] spi: cadence: Add Marvell xSPI IP overlay changes
Message-ID: <Zmcj3fZ4DF8r_qf0@finisterre.sirena.org.uk>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-3-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RkdGdrXXm7o+ukvS"
Content-Disposition: inline
In-Reply-To: <20240607151831.3858304-3-wsadowski@marvell.com>
X-Cookie: Your love life will be... interesting.


--RkdGdrXXm7o+ukvS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 08:18:29AM -0700, Witold Sadowski wrote:
> This commit adds support for the basic v2 Marvell overlay block. Key
> features included are:
>     - Clock configuration
>     - PHY configuration
>     - Interrupt configuration (enabling)

This feels like it could usefully be split up so these three bits are
separate, and there appear to be other changes buried in here as well.
I can't tell what changes either the PHY or interrupt configuration
might be referencing.

> @@ -295,6 +450,10 @@ static void cdns_xspi_set_interrupts(struct cdns_xsp=
i_dev *cdns_xspi,
>  				     bool enabled)
>  {
>  	u32 intr_enable;
> +	u32 irq_status;
> +
> +	irq_status =3D readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
> +	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
> =20
>  	intr_enable =3D readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
>  	if (enabled)

This seems like a separate change which applies to everything, not just
Marvell versions of the IP, and should be split out and explained.

> @@ -319,6 +478,9 @@ static int cdns_xspi_controller_init(struct cdns_xspi=
_dev *cdns_xspi)
>  		return -EIO;
>  	}
> =20
> +	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
> +	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
> +

This wasn't clearly mentioned in the changelog and is again being done
unconditionally for all instances of the IP, probably best to split out
and explain.

> +static void mrvl_ioreadq(void __iomem  *addr, void *buf, int len)
> +{
> +	int i =3D 0;
> +	int rcount =3D len / 8;
> +	int rcount_nf =3D len % 8;
> +	uint64_t tmp;
> +	uint64_t *buf64 =3D (uint64_t *)buf;

Any need to cast away from void * indicates a problem.

> @@ -337,13 +563,11 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_=
dev *cdns_xspi)
> =20
>  	switch (sdma_dir) {
>  	case CDNS_XSPI_SDMA_DIR_READ:
> -		ioread8_rep(cdns_xspi->sdmabase,
> -			    cdns_xspi->in_buffer, sdma_size);
> +		cdns_xspi_sdma_memread(cdns_xspi, sdma_size);
>  		break;

It's feeling like it might make sense to have an ops structure rather
than sprinkling checks for the Marvell overlay everywhere.

--RkdGdrXXm7o+ukvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZnI9wACgkQJNaLcl1U
h9CzPgf+JyAR7k5ZPBd12HbSQXaHdbPWE/6SchRs/BN0GDlC5Csl6a5+ZQ6BCE5h
1JHRAs1RKu57n2zZCs+xR9+tuj9jWg3kfMMHBpH6azUIcYhkw7P16YShyHhckFo+
M1fbuFMAg9z3r8QuwXiMWM5vqlU2YgL1CscbdJXbT74DIfugc8OwIlcqo9qiPgFp
6UsO1/Tsdcqj//0DDldViIDt3pyPNRZYAO8DbJ2PHOaADiM1wyDC1TYto00yJfwV
QTV1CPRsd8qWZtICX39LkHoNj4WSye8GsaSocu8ncgNS4rL4ik4GxBohG+fViMMz
pbRU8JPrCzezMdbFkluhWugrV66aIw==
=MVb7
-----END PGP SIGNATURE-----

--RkdGdrXXm7o+ukvS--

