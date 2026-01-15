Return-Path: <linux-spi+bounces-12419-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB4D27721
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 19:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EAAB305975C
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B073BFE4B;
	Thu, 15 Jan 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnqmmgYL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E73BFE27;
	Thu, 15 Jan 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500141; cv=none; b=cJhHBm7RzjQjGhsk1PK0PPmPzODUye11e+c/Zacln06zv0GPULhFlEUlsZCOVdU4ggnDY+x0ddYDddmRKVGHimWrMFh4n0ltN3wk0N5nbBOttpxJE7feZwDN/zgB0WdPUnM2rK+diQ95pI5WLscPZ9dFbu/a7zIrPfpFepgGWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500141; c=relaxed/simple;
	bh=Kn6CM13muJURtMblhTu+B8XKHuWGrLq8ki08pxGulnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS5LSjxY7o/6dPrNzq8qBUms7oT2v8zifPvt/FugC2YthgIM1DdeM9acItGY0MBBfEOBn5iTblvVPe5LNMtRcMNJdee5e5cTRm9sKD9z34sz44mfBd3MY6qZuzfLBSc6oJ3srw1pFOiKQUYTrR9V0+/M6VJWQnB+eSTGqM+lD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnqmmgYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A19EC116D0;
	Thu, 15 Jan 2026 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768500140;
	bh=Kn6CM13muJURtMblhTu+B8XKHuWGrLq8ki08pxGulnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnqmmgYLIO6vRVPEhJA3xqQRcAHI6Tr3rX+0ylbgKHHb5hZzfFXPsbTSHSvUoTfcy
	 KSEvpK0KVybSKHRc9Mk22oQmrUiJfX6pOUH/YzS6T51JTeH3qJ38gmod01boQy8jqo
	 K35TBA4GxXb79819zJk5FTZ9ho+8gmxwDHciXSKrh45aHekKYMN+BJwNVdDSkq8hL7
	 IORdvIetisScuTmE9sGnsLeiqZOFuNuYEGCDYzZ3ZVovKy/YM8jkjJohVCRKXhg465
	 xtFDN2HOrzraBuxvz5OPud2GyD4ZVDXuC0Efsy/YU6x4r6gu2PY7zv5onXLoqE3IBh
	 AG+iQhZhbQCYA==
Date: Thu, 15 Jan 2026 18:02:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: clg@kaod.org, boris.brezillon@bootlin.com, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	BMC-SW@aspeedtech.com
Subject: Re: [PATCH 2/2] spi: aspeed: Add support for non-spi-mem devices
Message-ID: <1adf54a9-56f5-4fc4-bba2-837a132fd123@sirena.org.uk>
References: <20260115150454.1575970-1-chin-ting_kuo@aspeedtech.com>
 <20260115150454.1575970-3-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvW1NsWVoVmF5xI9"
Content-Disposition: inline
In-Reply-To: <20260115150454.1575970-3-chin-ting_kuo@aspeedtech.com>
X-Cookie: Are you sure the back door is locked?


--xvW1NsWVoVmF5xI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2026 at 11:04:54PM +0800, Chin-Ting Kuo wrote:

> +static int aspeed_spi_user_transfer(struct spi_controller *ctlr,
> +				    struct spi_message *msg)
> +{

I'm not seeing anything here that won't work with transfer_one() rather
than transfer_one_message(), that would reduce open coding so if you can
do it it's preferable.

> +	ctrl_val = chip->ctl_val[ASPEED_SPI_BASE];
> +	ctrl_val &= ~CTRL_IO_MODE_MASK & data->hclk_mask;
> +	ctrl_val |= clk_div;
> +	chip->ctl_val[ASPEED_SPI_BASE] = ctrl_val;

This should fit with the prepare_message() callback.

--xvW1NsWVoVmF5xI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlpK6cACgkQJNaLcl1U
h9DIhwf/W8/a6WTvTXkoR6TsMYE4X1woUmylZmwsFN2UaCmgI1L/AfPz/YPV++Kg
zpWoAhy89sXrI0dewD0d/9r5c6eV/TvYD0nF4IHAwCU7lDxZf3fet4WOztYITdcI
J9XpQD+PGCwrjHTRjq+aXUYYhrS7vGhDUOUuY0xwgglOgygS/c8TRAAe7kcaR/jg
a2X3FYPadw1n/Y44EqG84FWyElTCFCz3V38pry5fc5IPQ9eYIgxD+MkxWa5ReSAg
byWuVsR0D55WyOEdf+ZSkYm4tvHmiM29MuVJmF5MXfP9jnJeG+2KSwKoDRYDQYWZ
9bvRisvSKoCqiQKNeacaATDXKGw6Eg==
=ENSf
-----END PGP SIGNATURE-----

--xvW1NsWVoVmF5xI9--

