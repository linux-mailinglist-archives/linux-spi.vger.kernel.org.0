Return-Path: <linux-spi+bounces-6526-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A80A20AA6
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 13:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4668D7A3D71
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE47619F41C;
	Tue, 28 Jan 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlyH1pdJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AB12F5A5;
	Tue, 28 Jan 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738067845; cv=none; b=M0KWPQlX5eiX+hcTBDr4vifbUlNHksMopw6cllD/XfPIjG3+hjo0mFiBwVixpyPFYUec5Mat303QlBG/Yw1qtGn37+pI97Bj6EBASOcG8w9Ytnrqs29YT+2EBwWa5A60UXbJIpGfNIP3b73LXXPKAB8FxJZlD5S5y+14qDtUPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738067845; c=relaxed/simple;
	bh=qz3e8xDv9vNVbI2kX24dN6HQHDUseqJD3RxrmrJ0cpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5xeMOpCrvT1pnrB4muPwWN4d1BAV6iSXPHqQ1YxIVSzG/Phg2HbU3CuZXOMu//OQbvfid5gTIZtBaqXvneEHUg5paK2JCMfLTp4sUwDrmx2q8Irm8CNa5LoVEUPytNwpSowWTSn1vDhnwgJCE91cJswwGoG7YIhNK6Q5MKvqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlyH1pdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA42C4CED3;
	Tue, 28 Jan 2025 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738067845;
	bh=qz3e8xDv9vNVbI2kX24dN6HQHDUseqJD3RxrmrJ0cpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlyH1pdJiKjGn8uLrDGey0+BR7Y1XDI7/k3IOlVaPDd2IG10n7iynKhrIxW1/9+t0
	 QXsyA+5wubDIlfT4qOEvm+6bWHeQ/Dj3KzK8uAcqx7Nd9rFI3i1CZpAFiPdxtjFjlx
	 eFiiDMOHVUGYVSv5ESIkT1Ng18KOneUYiiZKg8gdZRocGojxNST6AkvpiW+oP25sib
	 hVU/b2cKo15dj/AspvsmoUGd6mvuYtpZ88RXutbZXqf+VcZnIGh+dXYe9omIsExEhY
	 Zp6h7VPdoclI/eJSJ4QjzGyAQDHpyvyqaXXGGMyhOcIBk1q7XR6+sQvrrTNdA1HkzL
	 HYBYWWWyjSsAA==
Date: Tue, 28 Jan 2025 12:37:19 +0000
From: Mark Brown <broonie@kernel.org>
To: patrice.chotard@foss.st.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	christophe.kerello@foss.st.com
Subject: Re: [PATCH v2 2/9] spi: stm32: Add OSPI driver
Message-ID: <ec35dbd3-5730-4cc8-8025-d349740d1ba5@sirena.org.uk>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-3-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gwleQ6q+I0YDdApo"
Content-Disposition: inline
In-Reply-To: <20250128081731.2284457-3-patrice.chotard@foss.st.com>
X-Cookie: I never did it that way before.


--gwleQ6q+I0YDdApo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2025 at 09:17:24AM +0100, patrice.chotard@foss.st.com wrote:

> +static int stm32_ospi_tx_poll(struct stm32_ospi *ospi, u8 *buf, u32 len, bool read)
> +{

> +	if (read)
> +		tx_fifo = stm32_ospi_read_fifo;
> +	else
> +		tx_fifo = stm32_ospi_write_fifo;

> +		tx_fifo(buf++, regs_base + OSPI_DR);

It feels like the _tx_poll and tx_fifo naming is a landmine waiting to
surprise people in the future.  The code sharing makes sense but the
naming is just looking to cause surprises, especially with it just being
a bool selecting read or write.

> +static int stm32_ospi_tx(struct stm32_ospi *ospi, const struct spi_mem_op *op)
> +{

> +       return stm32_ospi_tx_poll(ospi, buf, op->data.nbytes,
> +                                op->data.dir == SPI_MEM_DATA_IN);

Though the one caller is also using _tx only naming, it's a bit more
tied in with the op sending though.

> +	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
> +			  SPI_TX_DUAL | SPI_TX_QUAD |
> +			  SPI_TX_OCTAL | SPI_RX_OCTAL;
> +	ctrl->setup = stm32_ospi_setup;
> +	ctrl->bus_num = -1;
> +	ctrl->mem_ops = &stm32_ospi_mem_ops;
> +	ctrl->use_gpio_descriptors = true;
> +	ctrl->transfer_one_message = stm32_ospi_transfer_one_message;
> +	ctrl->num_chipselect = STM32_OSPI_MAX_NORCHIP;
> +	ctrl->dev.of_node = dev->of_node;

It looks like the controller only does half duplex as well so it should
set SPI_CONTROLLER_HALF_DUPLEX.

--gwleQ6q+I0YDdApo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeYz34ACgkQJNaLcl1U
h9DqGgf9GDpZoVHpFVphDLNJ/mT+2DuKd1ifuBqlhnL1uv3N5P3QycT2pGfzJm1x
rZYo8crCyUHSEEg8gJTFGRLvS4HMZnLiMPXAoO5haFS9MlQhkB9q4ycTO34H9ji9
fGJBMxjfNulkaQDTQCSTLQGLVG9btkfagUgPlT+44DJoJosJpgBxa/jRNV1aY5RV
mLna5fVv+UcrVwHwTcCks6+Zlo0yJLqnUNwO8Su5oJwaMZVgF6FzWHb9rtVmP5dX
Juozjf/iY5Q4GqgaFveLPKpGtdZ3ExFW/PozDcRWMaV0IgXJ050vnIYHjJztITmG
ywanYl7T6WSekQkkXSYYKko0xayygw==
=oZuU
-----END PGP SIGNATURE-----

--gwleQ6q+I0YDdApo--

