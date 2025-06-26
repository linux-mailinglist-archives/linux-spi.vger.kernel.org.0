Return-Path: <linux-spi+bounces-8788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1967AEA019
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 16:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB9818891BF
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9E72E762A;
	Thu, 26 Jun 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twF+6/xa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671B2E1C6E;
	Thu, 26 Jun 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947161; cv=none; b=XU+c6Um+r5bLAj8b/Qm5mdQ658KvDi6hhUtFtE4vPhTNZbh+vvfQu/DU12SzZXIRXTt3NB3i1wTq6ZG7ZFU57ao+Jn/AwRQhRQoShFe+v2APmaj/KiaIfisFNdDvfc6mJR3RDZHEtvSWpu/acEWfFvvMDjuEsZFOqEIbWNhGBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947161; c=relaxed/simple;
	bh=Rv695NfbVPSJCeu/ChSnA/IUelAjKMvOwkTLol0ujXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBNsGbgT12SjDsf3wuHNJqwxbd3cdUaFeLlAijqUS6ydPDvjrz3D8inpDLhkk2hkHDZoknmMSDXxLq16gDXFEeCAf4j771Bxfjgi3/9jfXHwoTaZVLS2721f/sehjmWMlm/yx+AJdk1wLEBEbOMKBBU5CqzvPZWKyApLM+AZFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twF+6/xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BEFC4CEEB;
	Thu, 26 Jun 2025 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750947161;
	bh=Rv695NfbVPSJCeu/ChSnA/IUelAjKMvOwkTLol0ujXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twF+6/xaFVXVvgLy5voGcm8leOS2kdBeR6fd6aZWfMlYxyzpAExIvZS1l8nWwexyp
	 WtYDav/jpv+jBwXXOQ8TSou+LYVgkRTVMYDI9DS4WwPCugTeVSeCVU+u+qBMqjA1km
	 1MEAcw7buMGGos3dxkMatNHjHL/WHBd1jneQeyr9W93Qcs8ugdEZWC/5amjZkliAZS
	 tA9IsphlIrD6eEHWsC8/4KnpKLPuvXbIh/PydDoPYUZrmDlfddXqsFgmslz7n98i1z
	 db4lvxfS/GuEZ/aX22yNbi0pwcW6emz7gUpcrGFv834xhd+AVyo+obUkgbuGjdZmHn
	 6FQtyurV61l0w==
Date: Thu, 26 Jun 2025 15:12:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <frogger@hardanger.blackshift.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: Raise limit on number of chip selects
Message-ID: <aF1VVebfbX5pJa0r@finisterre.sirena.org.uk>
References: <20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org>
 <pulc4xhdpqfseyugxloid6vvjeducuxghfuh7qre67k5v2zie3@wfpiyoyzalmf>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6EO+i1J3jgXrrKP"
Content-Disposition: inline
In-Reply-To: <pulc4xhdpqfseyugxloid6vvjeducuxghfuh7qre67k5v2zie3@wfpiyoyzalmf>
X-Cookie: Do not cut switchbacks.


--x6EO+i1J3jgXrrKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2025 at 02:59:35PM +0200, Marc Kleine-Budde wrote:
> On 24.01.2024 13:24:24, Mark Brown wrote:

> >  /* Max no. of CS supported per spi device */
> > -#define SPI_CS_CNT_MAX 4
> > +#define SPI_CS_CNT_MAX 16

> Just further increase the limit to 24? Add a Kconfig symbol?

Just increase the limit, it's probably fine.

--x6EO+i1J3jgXrrKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhdVVQACgkQJNaLcl1U
h9B8Mgf/cYyLX3We9wJrWaLCdfd7nutf7ijASzjVD8RrGqluybPbBkINXmqNvfYr
sczqv2p2GLCHLov9dNCglgT/fGwgtkDFdipBobiUUCk+bwc/oYfhJmkpx1ny5yFw
LapC9RVWX+jjK8spi7M8uJQtPTYBw51QzCHTxe5RDuvWNbSOj/o5xxh3ShPbWTWY
kpa9s4QkyJD2hyy2PdAYYPQz69qHx+Bc762Wao9swUeaRq0FfMgWRYicQ+68QbFj
pOsONNVAIARUriH5A/a4BEQV3Ia42sUs6g1OQrmfvBieUw1zzI51sR8Gs6D3w0YY
urPuLiEfA6H0hkmF+YppZQUh9c9LrA==
=TczG
-----END PGP SIGNATURE-----

--x6EO+i1J3jgXrrKP--

