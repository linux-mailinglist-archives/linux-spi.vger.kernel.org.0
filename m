Return-Path: <linux-spi+bounces-10025-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E17B57EF7
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B4163080
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52F213254;
	Mon, 15 Sep 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFt57mQz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442217A2E8;
	Mon, 15 Sep 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946630; cv=none; b=e+iCKTq3ZJsWdENvSuR5h6tluaVXjB1I7wwrm8rwbRRqKZ+lzCc3xdDHTGPaRdPw3Ub4oN84H+LSJ0jc1cgvx/WaHTJVOHbJtY4VwV7bJO1NiFwF6brdbmwh+spsQVpjs1p5sjhjr/X2eBILzzSIK2YMw/O8YyJaZK/ANsbD5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946630; c=relaxed/simple;
	bh=apPcCqsC8a6v7Kjyoy9pw3XOQ7f+yRGI8jPksoqPdkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htIQEmjWVH1qfNp3AbLrhoBZzVKN15RkhzIPQloWU4nIcGa9T1xr8sbIxX+4eNmv/KoYoIHXe+BOfwTMmK62B/NSyJj6qpw3y0SrUKmGMwlBpJyR5TTk0vkXrFjb8Bvjf8a6+DXOZtf4zksOREsMJpNGJxTo/iZ122JfL/P2lwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFt57mQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F5C4CEF1;
	Mon, 15 Sep 2025 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757946629;
	bh=apPcCqsC8a6v7Kjyoy9pw3XOQ7f+yRGI8jPksoqPdkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFt57mQz/v2JY1RBdOkAHsCBt/JhVM6K/IfIadF5CMVc7qLDvu4ODHS4fLhs2wqDJ
	 8BGNFsvIJWxwPUaEpeim4emSs/5o2hh/tD0hcNYw6RuAzNnhLCTMVAkz94KvtPIi6l
	 9ehKfhFUdY1AbEU/Z8f78KlBqbOVQIt10/tGnyHxKkLhJJUkGF9X8PsTdTwigkdQgz
	 mE7K8k2JqeHVwyxOJovchUFObbp/IiT4rTJfn378MMk7eQe13S5aF450zYKytNQEwr
	 7NiwwNPk5VtUNvTA1+9601OsvFf/MckI8gLZ4vU3WDQi9b+LvKWkvSS01P1tiHDnCB
	 Lp6vkRYteVvIg==
Date: Mon, 15 Sep 2025 15:30:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Axiado Reviewers <linux-maintainer@axiado.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: axiado: Add driver for Axiado SPI DB controller
Message-ID: <9b6aaad6-3dca-49e3-9a59-8e8a0179a517@sirena.org.uk>
References: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-0-814a1fa2a83e@axiado.com>
 <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-2-814a1fa2a83e@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6o3ytfShT2K67AjJ"
Content-Disposition: inline
In-Reply-To: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-2-814a1fa2a83e@axiado.com>
X-Cookie: Use a pun, go to jail.


--6o3ytfShT2K67AjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2025 at 06:11:56AM -0700, Vladimir Moravcevic wrote:

> +	/*Calculate the maximum data payload that can fit into the FIFO. */
> +	if (fifo_total_bytes <= protocol_overhead_bytes) {
> +		max_transfer_payload_bytes = 0;
> +		dev_warn(&spi->dev, "SPI FIFO (%zu bytes) is too small for protocol overhead (%zu bytes)! Max data size forced to 0.\n",
> +			 fifo_total_bytes, protocol_overhead_bytes);

This might be a good fit for dev_warn_once(), I imagine if gets
triggered lots of whatever operation triggers it will happen and the
current code would spam the logs.

> +	ret = devm_request_irq(&pdev->dev, irq, ax_spi_irq,
> +			       0, pdev->name, ctlr);
> +	if (ret != 0) {
> +		ret = -ENXIO;
> +		dev_err(&pdev->dev, "request_irq failed\n");
> +		goto clk_dis_all;
> +	}

None of the other allocations are managed using devm, you most likely
have unsafe race conditions especially if the interrupt line is shared.

> +static void ax_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
> +
> +	clk_disable_unprepare(xspi->ref_clk);
> +	clk_disable_unprepare(xspi->pclk);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	spi_unregister_controller(ctlr);
> +}

This will do a bunch of teardown before unregistering the controller
meaning that new operations might be submitted after the clocks are
disabled which I imagine won't go well.  You should unregister from the
subsystem first, then tear down the other resources.

> +
> +static struct platform_driver ax_spi_driver = {
> +	.probe	= ax_spi_probe,
> +	.remove	= ax_spi_remove,
> +	.driver = {
> +		.name = AX_SPI_NAME,
> +		.of_match_table = ax_spi_of_match,
> +	},
> +};

There were a bunch of runtime PM calls but there are no PM operations
here at all.  That's not specifically a problem, for example power
domain level PM with full state retention would work here, but it seems
like at least stopping and starting the clocks would be a good idea.

--6o3ytfShT2K67AjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjIIwAACgkQJNaLcl1U
h9CPLwf/RhrIkexh1/aNsOJYJL1gMHWTqKfNxLZYYXlBw8Nz2ZLtKKwNdPENxr/Z
+6dnY8StmyTSKkUOHjzsLH7xqN4gGvxf9RIBWHp529LSu+LkTxcGgaAHkfWcftvF
RbnW46hMV/aq4A48M7xL8OlK2FXopDGmyicThrkm6T6XgfKcgMExMlxyDCVEt+0E
YBO2phalHJCkPltNmzJrSbJzf6o0nGEf6Bxl7r/WXadmTRuF2hLZ5cYMJ5G8JC+G
UYfRYZMuVhMh6E0KC55r2JEoYZy+YBYFC+7mkmi2SDxVh2moz9GRkveGp/7L2r82
VajNVG7ozKcYcYpsx5VuwhvpK8r8jg==
=W84H
-----END PGP SIGNATURE-----

--6o3ytfShT2K67AjJ--

