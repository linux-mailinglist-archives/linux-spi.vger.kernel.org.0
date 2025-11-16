Return-Path: <linux-spi+bounces-11247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE5C61DC6
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 22:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E74784E1A3F
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 21:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312862550CA;
	Sun, 16 Nov 2025 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILn1eG2G"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFC29CF5;
	Sun, 16 Nov 2025 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763329677; cv=none; b=qibV8ullU6aKjVEmFxQ1MCwtnviQT14+6E+M3CZplvsB+NqPGBm0a9tQCDC/K8ABJORQl2CF/3EQIAW0i6KJJeCDpfP94sLp7fXKBqvb3BeDsl74OJcGIMRqynkl10e3SdlQt2uPUztO8KCtavZd9gw+JZlaaO0NccAkIO2LVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763329677; c=relaxed/simple;
	bh=pWYF/le3Qm/HubEQE1Ds+oFzfoE/9PrQTt+2HHhwDxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOsuXV0s5bvwU4/dk9RYmm9xqrpzIkuEqK5AASTf8BZnIYXJyRxyEBJkVYvcdkKbWzlyK8Tx4DViwKTDVk74XYokEXsrpOAEQjDusnTYRwvAdfSimnR6UV8DEOxcjUgliuwB1YCywodMR2F5XJ/1GPLFIuCoEGPLiKyZ+A//Vqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILn1eG2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E12EC2BCB3;
	Sun, 16 Nov 2025 21:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763329676;
	bh=pWYF/le3Qm/HubEQE1Ds+oFzfoE/9PrQTt+2HHhwDxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILn1eG2GIfhzddilwyMY53H3eTd+v6fsSyeUw8F1O/HAxBcnkLPn0og6f4TAr82uM
	 iUeiQm0+sMmujTVpiLZ4Ft1LrRJuiUSlnseR+KKiwnE6YFdxcuQDD3n37BXTAw8npN
	 //7HQNGVI9qzv51Ma4nxZdN/PJnvglleQHx5eqINJDcln+RomKZXkyWDYGzc/JqXR+
	 EavK9h4BzP7xwSO2rfYnkrHQN8OmykyNVOhkuFDtVXCeyaxhhchEr4bye3eomkR/vX
	 K+vYNiem75+HCJ1PfUdaIUsBB6fzeMXJPcCxWW+5RWxymWXQHx+KBmBMX9EeyemBQi
	 Fhil+lQVQsqHw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 0F9841ACCC98; Sun, 16 Nov 2025 21:47:53 +0000 (GMT)
Date: Sun, 16 Nov 2025 21:47:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH v2 1/3] spi: airoha-snfi: en7523: workaround flash
 damaging if UART_TXD was short to GND
Message-ID: <aRpGidWIakkclJTz@sirena.co.uk>
References: <20251116120038.672178-1-mikhail.kshevetskiy@iopsys.eu>
 <20251116120038.672178-2-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HRdJb4bqzkeBOF7F"
Content-Disposition: inline
In-Reply-To: <20251116120038.672178-2-mikhail.kshevetskiy@iopsys.eu>
X-Cookie: marriage, n.:


--HRdJb4bqzkeBOF7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 16, 2025 at 03:00:36PM +0300, Mikhail Kshevetskiy wrote:

> +				"==================================================================\n"
> +				"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
> +				"This mode is known for incorrect DMA reading of some flashes.\n"
> +				"Usage of DMA for flash operations will be disabled to prevent data\n"
> +				"damage. Unplug your serial console and power cycle the board\n"
> +				"to boot with full performance.\n"
> +				"==================================================================\n");

Multi-line prints aren't idiomatic for the kernel, we usually have just
one line per print.  If you want multiple lines use multiple prints
(like the trace_printk() warning).

--HRdJb4bqzkeBOF7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkaRogACgkQJNaLcl1U
h9D9Nwf9GJmi40PrVoWCgwvdveggyr3o6bLdQm18NZ1RaW6oocbyUMtURrM3jG9W
mUnxJSemDZyVRAkCAp9yun0ua+O+YLzIKVli6pV0TTv9Y6g6LBcIWDS6qI1KC77r
n2WBDwxhYzG8ZtvmCzCUb73qBdLSEZPGi6QBnrdskcsSlnyWm8fJiM7voTf/0wwD
qUqgcEvPBSK91uxNPnoTedAnKnn0SvJHOzlNbh/bEpTUeXnNQkvcz13phACo4Cb5
/VhF2xyDMqQAJltFnpmSw6LhBx5d3OJXurxTZNhfHvY79/bU0qzIfeyjpyOxtyRP
aI37YjjZM/CNW2oupnvUQ1P505auzw==
=wx4p
-----END PGP SIGNATURE-----

--HRdJb4bqzkeBOF7F--

