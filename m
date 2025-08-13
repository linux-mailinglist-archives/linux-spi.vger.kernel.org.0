Return-Path: <linux-spi+bounces-9401-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19940B25480
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 22:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A1B1C82211
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FBA2C1598;
	Wed, 13 Aug 2025 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVVdArbw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D883279DB7;
	Wed, 13 Aug 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116772; cv=none; b=Std901Y4OPSRCM2MLktK9LN7l4nAfh8+/cUEQOCVcsRLJ4Z1eBJx3kmq3O6oskG5Xf/w3TlhkpDPDGAwuTuXCzfqW0R2KTA+4u4uDqnOazu6ao9bwMjEhkRvma4Sq9e5AiU1xmLQer6zoHhTY564ZeK3Bae6IrRly80yBuCO/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116772; c=relaxed/simple;
	bh=ZvdX09wJY4AtaHH7PJqDx5iUZlrZup188ldJOJfxmq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLq0wcazLhohPjOdLcUbI0p8Cx8N6I3G2DPHMFtXT7QMxwWVTf1tWlkOmUFQzvgrbSALsv0nAinMMTdzG1LULnEMgw0HLQTdYxwuGZYlai6FZz8VnLjUJ9rKqAjhQpxdUbteAnZR9Vmf/ka5vCF/OsgH7UbhanCZrI/tY2Oi5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVVdArbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0CAC4CEEB;
	Wed, 13 Aug 2025 20:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755116771;
	bh=ZvdX09wJY4AtaHH7PJqDx5iUZlrZup188ldJOJfxmq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVVdArbwWk5bR1aJCb+7CvS6zZU1DxBh48HyhLTJtH/LaEjzHscNNotUYjlIzp2+G
	 DJw8zz35xFWnCAHyCsg6fqixWFUstdfB1bdw04AzniszC5CdS1qT/1H7JrRkxhmjBs
	 ANjKIRcfTMPIum34tyN4mPq8G61taAlhtb/uS9satT1AT5n9PJbN9xelqGWXoHBVWf
	 P0hHUH/I34k2ufHgdPy1XX5s1pAhS7ffIsuxuvM2bOHnyMFWYJbvmH5xAtyqqCGmMo
	 XNRiKNjM9ASOw/V1dvDCIFFVNZvaN747HOm8CnJvuCVHka9qBR2lyxrSKfi5XMmOUG
	 qWXxFYMzaDfIQ==
Date: Wed, 13 Aug 2025 21:26:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	tudor.ambarus@linaro.org, pratyush@kernel.org, mwalle@kernel.org,
	p-mantena@ti.com, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	a-dutta@ti.com, u-kumar1@ti.com, praneeth@ti.com
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
Message-ID: <6c35baad-a332-4b0a-96ca-1cdb3840ad94@sirena.org.uk>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mmZIKx6gFDPoRpc4"
Content-Disposition: inline
In-Reply-To: <20250811193219.731851-2-s-k6@ti.com>
X-Cookie: Turn the other cheek.


--mmZIKx6gFDPoRpc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 01:02:10AM +0530, Santhosh Kumar K wrote:
> From: Pratyush Yadav <pratyush@kernel.org>
>=20
> Some controllers like the Cadence OSPI controller need to perform a
> tuning sequence to operate at high data rates. Tuning is needs to happen
> once the device is switched to appropriate mode (say 8S-8S-8S or
> 8D-8D-8D). Add a hook that spi-mem client devices can call in order to tu=
ne
> the controller to operate in a given mode and data rate.
>=20
> This is somewhat similar to eMMC/SD tuning for higher speed modes like
> HS200, but there isn't a standard specification around the same though.

Should we have something that blocks these tuning required modes without
the appropriate tuning, and/or allows discovery of which modes require
this tuning?  This all feels very landmineish - client drivers just have
to know when tuning is required.

--mmZIKx6gFDPoRpc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmic9N0ACgkQJNaLcl1U
h9Aiqwf/Vw8eFxn/K8yK04nsuHsfQ4PO9rCdzoEwZDqZtu2pEScOTW/DICKZXBMU
fd+M8RbnaDN/yFplMeMV7VHTsUMaCr3l7iuiy86PXmCvG7BY3LWWIwiFhBgbxtXn
Gwwhsybuh11DeZLM9Ekfiw7BlgJ10DuNxRbMZaS/am4tx23WDsSeivILzJJjkgo3
daj27PmjDX2zaTt7Tj/htGNINjG+MHlAfjPWaIscccJzvdKxKpMSrfpyuxl9Zuu9
qTyAfUBqHGsL0+IUHRJd4RzwoRAYKPEq5xNqtp1b5eE27tGs+ESloRWh3r/dSB8o
n2ZIJpyYr9Lb9mlDTBT821tp0xRztQ==
=AZ6f
-----END PGP SIGNATURE-----

--mmZIKx6gFDPoRpc4--

