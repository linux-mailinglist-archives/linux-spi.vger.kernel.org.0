Return-Path: <linux-spi+bounces-7821-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1073AA64C2
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 22:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E901BC3A4A
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA253365;
	Thu,  1 May 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuTBOE1p"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF5B674;
	Thu,  1 May 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746131567; cv=none; b=BNoapYA4xqJzOAOBxJBL/Uu3ws9LQ5NF2qtefiO/vMq3SZ83EbRzyjvY6IotxuxKxaVcuMBrhSZB+Q/nx0htgK27HUPlo90xDLGovii2ErsyM7ZzBwwwBGxsyrCYC9AjFTPtnxS5wlUM1p1leKnTUBwBOfjffBYbdIvvln3ZddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746131567; c=relaxed/simple;
	bh=8zJ8ild3gKFpPMeXGplXewCsb2gBsGMSerLSHKUcxLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE9jfJX2BUKu2Z5ZIBngCktBuSc+9bmrn3GyXrQpae4AtP5c5iW4IE3JzeHLX4f29qXuSrSuIIExXkpU36YZD3nKJx0J+LiXhCYtyXOEvZnOV8ZY79SMQmTVz6SyY83L3x2oGWfA73P2gvPHmIXDDJow+r0N6WhmQUEGJ77bHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuTBOE1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB9AC4CEE3;
	Thu,  1 May 2025 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746131566;
	bh=8zJ8ild3gKFpPMeXGplXewCsb2gBsGMSerLSHKUcxLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuTBOE1p94jS3K4voWp/u8LKgDvQzAwt/KoN9qGvqv+FgkF/LPk5MUasGWjNy7DIp
	 R7iAkDsDpMESWTqg2sr64nM8NFSS01p2jRArIhV/cTSgrHhYsgC4PBvkbVb2a9viKl
	 at2aRfn+CJ6hBgJGFnibiWVMfPBgkeWgY3BaX99d1AKND/Yr8rbOaWVuIIvLRHc/CF
	 s9F9pA1tiXBdp37gnNMgMJkygiF4BLwSv9alvptY4PW+ygFBiYE0zhoy2LkXSP0Jne
	 tvi0XqQx5X1evu6brnRhf299xJRvvV20y7Zf7oP0Hdj0BROB0eETdE3P1snxu7rwpU
	 oMKk/7OtI4ekA==
Date: Fri, 2 May 2025 05:32:42 +0900
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Da Xue <da@lessconfused.com>, xianwei.zhao@amlogic.com,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sunny Luo <sunny.luo@amlogic.com>
Subject: Re: [PATCH v2] spi: meson-spicc: add DMA support
Message-ID: <aBPaaisRxH2gKOS9@finisterre.sirena.org.uk>
References: <20250414-spi-dma-v2-1-84bbd92fa469@amlogic.com>
 <CACdvmAhEXstEBdaiktU4n-R6M6mYiBnSx15ZJfb1FOKGD7Zfaw@mail.gmail.com>
 <b202538e-5520-48ce-a957-034c0ce7beb1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+W6B6Qy6EhxzLbXO"
Content-Disposition: inline
In-Reply-To: <b202538e-5520-48ce-a957-034c0ce7beb1@linaro.org>
X-Cookie: Well begun is half done.


--+W6B6Qy6EhxzLbXO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 09:43:40AM +0200, Neil Armstrong wrote:
> On 30/04/2025 04:13, Da Xue wrote:
> > On Mon, Apr 14, 2025 at 2:30=E2=80=AFAM Xianwei Zhao via B4 Relay
> > <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> > >=20
> > > From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > >=20

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--+W6B6Qy6EhxzLbXO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgT2mMACgkQJNaLcl1U
h9DUIwf/VfGJ7nutKjpJfqk62ySD9m9GQfYpOoomW5kTWtiXmE+qp4dX5Xx9OHmt
WbYXA1R0yW6BUuw0QlCsGJLuWEs3Td3/NdgbFKgN9FbxJC4F9upjK9Iig8d5jAnt
2PifDxXGF1eNS9ZTA1fr3JACMxNQtC9/qHoc0AQT2LWBWzHrukmC/LBrOW68Gq0J
8GyvuFPro1RZtmYORCV1LwRThOv4h8xusCWOSJKxWXknTQW0j9r06y1aB8MGvEGs
FfIEDfwZ3oaCG3SL00zoAvHNe/tX4QlPS+gGBfRhkeZ4qp/bFF4ikj1+sAPD46cH
dE77lRcKIldzoUBKCH2XhhHmXA5Jhg==
=/r67
-----END PGP SIGNATURE-----

--+W6B6Qy6EhxzLbXO--

