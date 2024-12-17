Return-Path: <linux-spi+bounces-6085-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F99F4F60
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 16:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BBF168B24
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D91F7564;
	Tue, 17 Dec 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJMpVIRp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3564174A;
	Tue, 17 Dec 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449015; cv=none; b=kNyNQisM5rfdHR67OYCyn5YzPzBwjrMPBkg0QVXFsfKEbeldG7ld5UEMGmjSAJxgcvtdaLSLqNqorUVim8oskh5otj9kX0TAvHVFpADqvdQOvlRj9kCwMcmHQFLjpP38mWQKry4NWSOSHlAy2NNAF88MXbuBCoWhi+d8MtVGYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449015; c=relaxed/simple;
	bh=SQM3pWI2fvHAG1Oru52325VVqEwN5LXRnhmqFH7vCfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWq9FmArKkHDJYi2Zwc20XmZ5hubbM/I/MMlFxeejgBYoz1m/gYdA6arYQMeVOZhpeaPwYPN0x8NNDdjUtFavCVflCay5nQ+NG9Qxpv/ERueJvLtrY8qghotR1Vjh5O+BGvZ2ujeLYTMgd5AKd/vDgqHOQbs0tn8N21ZW/8aMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJMpVIRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F31C4CED3;
	Tue, 17 Dec 2024 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449015;
	bh=SQM3pWI2fvHAG1Oru52325VVqEwN5LXRnhmqFH7vCfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJMpVIRp+pFyUWESTz+5Qipovcww7eaHihkWBbjXzE1BBmc0dOtsKyXSp1d6D+3J+
	 yvTGRDHYQMoJi9esXzFANIUNxKt2CV2x6HN236W1Gm7oX3PapV/7Xn5Ci54tK9XTZG
	 ivGa6xztcEmEash9mOtCtSe9LHIBz7JGTUvrSJZjKNqglBR0yNj+kHJqXzoH08w/PA
	 ivC89WOOp+0bPwdLawQaHC2Aj/c8DPKo+bKudlj1Pn4hkM5wUjsjQJzZdaD/pG/Esx
	 I7WVp0OyKs6Plx6gga3PVzzVEawc1XYe566sa97rJOBjdrFAvxEIOjCD8BWVJ+luka
	 dq9aUAHO5Psrg==
Date: Tue, 17 Dec 2024 15:23:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: aaro.koskinen@nokia.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: fix reference leak in spi_register_controller()
Message-ID: <a8de1fd5-7eaf-46f8-804a-8b241a3e6448@sirena.org.uk>
References: <20241217073133.2908052-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhA3jEBVEeVKRUv2"
Content-Disposition: inline
In-Reply-To: <20241217073133.2908052-1-make_ruc2021@163.com>
X-Cookie: The sum of the Universe is zero.


--jhA3jEBVEeVKRUv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 03:31:33PM +0800, Ma Ke wrote:
> Once device_add() failed, we should call put_device() to decrement
> reference count for cleanup. Or it could cause memory leak.
>=20
> Found by code review.

This isn't clear to me, spi_register_controller() is analogous to
device_add() and __spi_alloc_controller() is analogous to (and wraps)
device_initialize() so I'd expect the _put() to be done by the caller
calling spi_controller_put() either directly or more usually via devm.

--jhA3jEBVEeVKRUv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdhl3EACgkQJNaLcl1U
h9D7cAgAhqB7KUEudxUgOs9vV137sCySYAo27XuUHkRqCVxSFiQoN+OcMT4vojPV
rC7HB1rUMIDRLeTqHbpFWNiFjMebSC0X7dpT5JXGVr1ehGDZ19dkI1jiQjCG3FWd
YMFU4wIRGq+WLqdUFoxhI0TGTdyzmTu3zkx7DNzr0Z2RnLiRujM9U7EHHRxCuRcN
IceiBSu33zf7BefltQiuGCfOAe5JPnB6lxgOEQoIhuqaMsx2LhS93fM1m/zFTxx3
Co3SB6QWe8rORsu3M8JsO5u1NzIwTgwt4CzSpxv6eEfPGGAPwCvPSVB9p8A3m8v0
gNXP+aDJJUtVdw9pTPx9zMEA3VEv4A==
=dgEN
-----END PGP SIGNATURE-----

--jhA3jEBVEeVKRUv2--

