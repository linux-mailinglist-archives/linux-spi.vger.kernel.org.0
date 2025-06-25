Return-Path: <linux-spi+bounces-8774-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00322AE8E3B
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 21:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F956A19B9
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626C2DCBEC;
	Wed, 25 Jun 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4QXLqq6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D482DAFDC;
	Wed, 25 Jun 2025 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878561; cv=none; b=P/TgM6TNzTYr4aIdITNPMvbqwSj6dXALeIgRygDc5dfIUClpnGXEhkK/158tlTLIIc44Ki1U06G1R7APcnvi0XmnPsp9fjx7hODDtcmvIO8Yo4/55ThDDv2xPvid6Z+FfRi9uRFPpn8OPVgsG06rylBCf7SHji2C9pU6dnV0EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878561; c=relaxed/simple;
	bh=7Sd7sVxVdbI5zpGrbLMBR22Yay4++u6jSk3NFuFiVcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCqIgMAav7BA5F0LfzcFLuhsbhb4f/L2/PJE43v+RzB4sj/okXl88mL+ooxOtMzRBtTKH9jg2Z0k4YIUkusSyYy1UhLyZxrNb6thmAjO0Wj8LJe6EgHoTw3jBfz5cJqpEjdTiDXz2LUUJWrMcGFCG27uU1SJt2u9k8+PkOtI0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4QXLqq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1E9C4CEEA;
	Wed, 25 Jun 2025 19:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750878560;
	bh=7Sd7sVxVdbI5zpGrbLMBR22Yay4++u6jSk3NFuFiVcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4QXLqq6E4COOnW6sbwSuEqhg635cQt7j06+oahl2yEACpCq3I2TMxI2GNCice/yn
	 DIklwP07sjLEkZzVMdwmm6mn+ju01/BrtuxsUgh8nKq4NfdD+7RkIlSH5QnsJ7KVbW
	 O5kae0LKcDGeCB2mItEJq6H54FscdzuvosP7YoUOu3gMNeMmYHidaLGto45gk+IEBA
	 u/F0O2s3d3IyIp8RqvdGYQXQNFneZPpw27TSAcA33AOmnPseIDZ94YVnn9MYEl6eaI
	 tmWoKjt/wlT4jfbHVqEVz6fK2So3goY/sSWosfq1eIqCezapWnUEoRQfsq1TRAUEXa
	 p6P+4QgZcsvQQ==
Date: Wed, 25 Jun 2025 20:09:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
Message-ID: <b4649385-ee50-499b-a965-e08f04fe0d3b@sirena.org.uk>
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
 <20250624192304.338979-4-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3H6V8ZNFDZaGNSIs"
Content-Disposition: inline
In-Reply-To: <20250624192304.338979-4-fabrizio.castro.jz@renesas.com>
X-Cookie: He who hates vices hates mankind.


--3H6V8ZNFDZaGNSIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 24, 2025 at 08:23:01PM +0100, Fabrizio Castro wrote:

> +static int rzv2h_rspi_unprepare_message(struct spi_controller *ctlr,
> +					struct spi_message *message)
> +{
> +	struct rzv2h_rspi_priv *rspi = spi_controller_get_devdata(ctlr);
> +
> +	rzv2h_rspi_spe_disable(rspi);
> +	rzv2h_rspi_clear_fifos(rspi);

A bit interesting that we need to clear the FIFOs, but it's just one
register write so probably not worth worrying about.

> +	ret = devm_clk_bulk_get(dev, RSPI_CLK_NUM, rspi->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot get clocks\n");

> +	ret = devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
> +			       dev_name(dev), rspi);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot request `rx` IRQ\n");
> +
> +	ret = clk_bulk_prepare_enable(RSPI_CLK_NUM, rspi->clks);

Are you sure that the interrupt handler is safe with the IP in reset and
clocks disabled...

> +	init_waitqueue_head(&rspi->wait);

...and the wakequeue head it wakes up not yet initialised?  This is also
a concern during unregistration where devm things will be unwound after
the remove() function has run.

--3H6V8ZNFDZaGNSIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhcSVoACgkQJNaLcl1U
h9AzsQf/Qa7qnQsZsSuz1hz9jQymHdMNk+PB06BGH0NHeck6ow7ZoGnmDbl7AK3C
9d7F2yTAXGk+wl8+1rzETO/TU4X3wgRRekZF3bEJ/yoISR1J5AEMhClbpyvPiR88
yvQsYJiuveAs6iU55L7Z0neYAvp7RiKaiim6ni/VDKuK59PmK/enC8yJm0UwR/el
3SnwQqrMaSq/MfQ9f6C54OVGcxNvQE+On9pd2wqyDCeCjpVsFV9K0+7lSgbEjg/k
MDYM2XDLubJRXIdL9a0gOl6IYi/kZXhYcSO4T4Cvci0otYitat6CVWOwcStyQ/df
ON+fNZbTzzQbRXjOziitywFskeuh9w==
=EA/O
-----END PGP SIGNATURE-----

--3H6V8ZNFDZaGNSIs--

