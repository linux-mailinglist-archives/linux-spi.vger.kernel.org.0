Return-Path: <linux-spi+bounces-8362-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 410A1ACC4C0
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jun 2025 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849CA7A636E
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jun 2025 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54822B8B5;
	Tue,  3 Jun 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7bNRXUC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7122B8A9
	for <linux-spi@vger.kernel.org>; Tue,  3 Jun 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948211; cv=none; b=JHOtx8zWZHQLRpEqyDvwRyu2PXPSn97RM10dt1G0zukTDXweN2vPgjsub+OTb5DmCPpE2gEYQXjmu7NZMcg9auFIIKL79gZN9I1g/vHEIeEgnhOJCsS3U5vgN/UpKsIrwFv8gqDbOm/C5U22obopF9DLBWH12lPojHxUo2hNxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948211; c=relaxed/simple;
	bh=JQBKBvxbo8qdmgbBRpt4bGFN7/J+DjHIJIJPh4ZJ7vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDI23DsRNZKD81sMp4mylJabZyI1aK2pruDenJW/pCB7MOzFM4UPQaBL+V41oA59YyR/yqfnwtZcavKJRiPQKkzo6mG0cjyobB/eFMhgGPM+BV6fZOoTmXu09n1a0Yg0ldTLJywJ7zOqdN838j79frDgVhggxaRlewQrimIEtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7bNRXUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFD5C4CEEF;
	Tue,  3 Jun 2025 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748948210;
	bh=JQBKBvxbo8qdmgbBRpt4bGFN7/J+DjHIJIJPh4ZJ7vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7bNRXUCkvObKp/A4B3izhHGJHjvRsF0eDuIokaOgYDcYVidJK/uB/MNXzJta0cyp
	 s309y//MmW5RrlIrPOsl4SlxvF7ZPJ0o2VnB9s7FiTKSy0663FdLwbGDO8giuf2bcS
	 VRC9k2ieU5dJIwPaZ6Xm03kddSjtKwkWIFlef3VdtJ3Etwb8Zjaw4kIlv5PQkRbHUA
	 iUMTaAntrMEY8pBUMHvosq7GPaS0+hhbCPHB7TGZGSPNfeuUhf5DjHqD8E832GaTaK
	 HAcH4+kkyrYPlfY2gF37rml9xhRogtACny5qXIg9/476/B39uAc3McN5uw34eW83jB
	 XaqUtLL1OiyDw==
Date: Tue, 3 Jun 2025 11:56:47 +0100
From: Mark Brown <broonie@kernel.org>
To: khairul.anuar.romli@altera.com
Cc: "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	Khairul Anuar Romli <khairulanuar.romli@altera.com>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Message-ID: <20a64c7d-fd5a-4e19-86f3-c0f450f1e332@sirena.org.uk>
References: <20250603002402.11024-1-khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EDyINtb0Bv8NY0W+"
Content-Disposition: inline
In-Reply-To: <20250603002402.11024-1-khairul.anuar.romli@altera.com>
X-Cookie: Avec!


--EDyINtb0Bv8NY0W+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 08:24:02AM +0800, khairul.anuar.romli@altera.com wr=
ote:

> +	bool			runtime_pm;

What's this intended to do?

> @@ -1958,10 +1959,11 @@ static int cqspi_probe(struct platform_device *pd=
ev)
>  			goto probe_setup_failed;
>  	}
> =20
> -	ret =3D devm_pm_runtime_enable(dev);
> -	if (ret) {
> -		if (cqspi->rx_chan)
> -			dma_release_channel(cqspi->rx_chan);
> +	if (!cqspi->runtime_pm)
> +		pm_runtime_enable(dev);
> +

This is probe so everything is newly allocated and runtime_pm is
guaranteed to be false.

> -	clk_disable_unprepare(cqspi->clk);
> +	if (pm_runtime_get_sync(&pdev->dev) >=3D 0)
> +		clk_disable(cqspi->clk);
> =20
>  	if (cqspi->is_jh7110)
>  		cqspi_jh7110_disable_clk(pdev, cqspi);
> =20
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	cqspi->runtime_pm =3D false;
>  }

This is the remove() function so the driver data structure is about to
be freed and will never be referenced again.

--EDyINtb0Bv8NY0W+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg+1O4ACgkQJNaLcl1U
h9BZhQf+JxLOQeGEIVVWVvRRyLmua1xOZ1+1wo1ZRJlujwy9TySJd/lHImo7jdH4
pYKCy1iTHFw5Ui0uFSvpgHfz1Cgfg6PJdm+AwJe7/zqrMKXoARzWCZNOz5t2sFP2
0qY7L2TmFqRfxnVONzJlmyf1B34shEpyJU7PEcBvp0MmEhm8Dfoc7P7arxLzdmQB
4ROqMD8W9085P7Bm57pgrmoT6WSEbr8wFGS01pCyRIcbmAK/Gx7kXqUfoLjJKdt9
Ru5u/PkWYcHACVA7xNdtvQRYuQ4zx4m6LA1jrUtCDaQYj7kAp5eEFZirjA5Tb8cn
Nozkw5TGsYqD4EQOhxRk3/iotFu3eQ==
=XHV/
-----END PGP SIGNATURE-----

--EDyINtb0Bv8NY0W+--

