Return-Path: <linux-spi+bounces-4943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B8E9844F4
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 13:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A7AB23AF3
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043219E983;
	Tue, 24 Sep 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMNpKgkh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4D154C0E;
	Tue, 24 Sep 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177913; cv=none; b=XyJY+aRJYkRCqHs8mnUK4ipoVZtVaPT2BZ32hznsVW44nl9ZVw1yN+3xr6oPvDGNnZkb0vaAlOlFa8PIaXfhzFhsBY5hsjGhBMl1DCtiO1/XB7F+vqViR9UDP7UcOrzzYNMrNdhfwT5sd5l5LhxjMlyldOapuutkovOwBlpSCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177913; c=relaxed/simple;
	bh=pwjY/eZTWh6CeK5bpC+kwKIQMjLLPjgM+/gsjoFCzd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi16H1qU6ZuZ8ELicFIlgQiZGz0GfkHRpdMccRaXYG3TlViPYrXCCMT168zV6KQ20m27ZJd7dnhQIiTWqyhfXZr3uRQwtb19WxiwbGfRBbuJtpLNEzAh/CBofSo8E1cSICafPzG09Y5oS5pEEONNYWNMIQqNCL7wirZdpXJQ+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMNpKgkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC72C4CEC4;
	Tue, 24 Sep 2024 11:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727177913;
	bh=pwjY/eZTWh6CeK5bpC+kwKIQMjLLPjgM+/gsjoFCzd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMNpKgkhk2x9qZxP0mgOivqgqATTti7gN+IDfiHkBl+XwvZD/QgpbJXW/GjTSnF1N
	 kgBJDDq/MKxCMDisFaOB+IafrPksaKAOfV9/R9myrG8CH0CsWCcfcabfBw1x5Yi6l8
	 inWBKQ2e4qKITksH+keHl+uC2SrC5ZiOydIflpiirL/h8J8RBMGe3P+0/RzsJaliKv
	 3pwJng4CcblZHhLRbLcsml8l8mNHrqSOcdHH0E6SZoZCmt8ci2QDeN7JWMKZGw4X+p
	 1efe9ioj9snoHV1t+88tN5xmfWgEa1JoSQCvVlz8zQPiS/X0H4VyqbfVJl46xX81a0
	 vpWwv7kSG0d4Q==
Date: Tue, 24 Sep 2024 13:38:28 +0200
From: Mark Brown <broonie@kernel.org>
To: AlvinZhou <alvinzhou.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org,
	pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw, AlvinZhou <alvinzhou@mxic.com.tw>,
	JaimeLiao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v9 5/6] spi: mxic: Add support for swapping byte
Message-ID: <ZvKktPc0luV9hItN@finisterre.sirena.org.uk>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-6-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vYKY00WwtUX26EWD"
Content-Disposition: inline
In-Reply-To: <20240718034614.484018-6-alvinzhou.tw@gmail.com>
X-Cookie: Editing is a rewording activity.


--vYKY00WwtUX26EWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:46:13AM +0800, AlvinZhou wrote:
> From: AlvinZhou <alvinzhou@mxic.com.tw>
>=20
> Some SPI-NOR flash swap the bytes on a 16-bit boundary when
> configured in Octal DTR mode. It means data format D0 D1 D2 D3
> would be swapped to D1 D0 D3 D2. So that whether controller
> support swapping bytes should be checked before enable Octal
> DTR mode. Add swap byte support on a 16-bit boundary when
> configured in Octal DTR mode for Macronix xSPI host controller
> dirver.

driver

Acked-by: Mark Brown <broonie@kernel.org>

--vYKY00WwtUX26EWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbypLQACgkQJNaLcl1U
h9DRKgf+OHoohZqsHPzLDF42cwORcgQYodF9PTs81h3wsuMrB+BUBQJ01Tfq5PGx
hvNfl4LSYkkplYPWS7GtNHRIw3DgdSV4QlK3EuDhUQltWDfTEN5mS+V6CEKzPrGG
v1e83CdyiLgvzP//w15ALc0+VnrXASSgg69XdFhoWTsto3wqOAtcBG1bztJi5Vh0
BALEDmmZkJgp5WUnLfw7errgd2ve73ZsW2Rjdoqt/RSvbHJccPxyPCih55KV9R33
ljEvZhxXKO/xfDO1JNmgNR3TNC0V4/jx5w21ZP5mF4Z5h+HWvC19wquCq/4fjqHP
vDyfTjKJ37XOD2ZYcDui3ELEJYy//A==
=tP3I
-----END PGP SIGNATURE-----

--vYKY00WwtUX26EWD--

