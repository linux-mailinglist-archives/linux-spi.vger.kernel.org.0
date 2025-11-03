Return-Path: <linux-spi+bounces-10978-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A305AC2C5AF
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 15:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA9024E1F8F
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1392F9D98;
	Mon,  3 Nov 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTdhDetG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22B2727E7
	for <linux-spi@vger.kernel.org>; Mon,  3 Nov 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179413; cv=none; b=WUkQ72DUFHQWWk8YenrzMZgThECAfAcfrF9jvlB/aZBuIk4UzhEuP6qORdyelsmN6y7hh1uOMqCIrB8b3qXjwrv/oYXY1DKSCxeiPZjX2thR7EkfTjO5no9sG1Jr2iWrCyYxzc4+dY4n1RJie4nxfA/7QrEvJgC6xNLPKd8T3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179413; c=relaxed/simple;
	bh=wZ6rUp95l1VI3OxxaYss9GPCFbABLcXZVNiUabj2IeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btQ82A8mgnmjj5HV+WOwIrdC4zI/dtVJVWV9Y1Jh1w1VlQ5mWXzmgE588aCEC81MYGlhzoJX9lPTLQ/56EanaVtHiiAG6lA0EilHsXAGwAEXYJEUbByF1fjply7lPJLLoklgw1lCCeNOTqzRF9+2FBnMy5UYlmaCzXGX4/rcVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTdhDetG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c19b5de4so2473701f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 03 Nov 2025 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179410; x=1762784210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AK6B3GPgKTLS+sYJ2QFwdaDDOy+dXg0ukpEcj9To1Xk=;
        b=lTdhDetGKWmH4U2jeiuvPUG2Bb62TTFHQaa6mHXbJsAdJpUdJIcvg2N6uczqNnWKhn
         lrTMYHNng+EdajPYwRvm6UVc7VemjefXLslrz5y9Cn6erziUy8isQmeXSSltyhBzxBP1
         lbh1CKY4IraYfppGPIDerS4IVurGqu9hHt1cHmimKIffdkF6kp2J4No1JOT+9sx+FKJN
         Ii3m1n6YWeFJxsw7JMHe1+Yoc/Bfo1YFoHGVfXurap/O2In1VHi6IOuajUUgJaG1I/Dl
         6T4dWnGAn0+lqQ3AV8pv7tC+WS5ZWK1DIkRD3vtZv5kTQhJ5KGkEszPiljHRX7lgm7TU
         qXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179410; x=1762784210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK6B3GPgKTLS+sYJ2QFwdaDDOy+dXg0ukpEcj9To1Xk=;
        b=Otu6uaVmFGfD18V7JwFCKuYWVxU1vuUnC9b528C8fWtOj8PuF9fVgNlJVrro3uuE2O
         nAhGRPjM3IzVOfWS2UcpJb9Xy6ozFVsv3dMojSEXFOc5/Q5Yd2Io7UOYs4cxwF3SjZmq
         nVPV8R0eo4r9QWtxRlFdWUpxlk889OWhsyqSDPdCjD0arQxJoN+6VmuUm2N/Wzxi4RW4
         64XZ0im+vr2oHNuILlZt+yinrVra0L/au+evGE6OVDMd7f6n6FhWri/LrHs/v2PCYzJv
         Rg6P4vOHpgUoNmmmgDJQBFAjzgwOkJWvLN7Y38LPAP7DVdMSyaHYlnLr16p0nGonzgLO
         gfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhL8MtARizsFCmYrOxpWmyTMNOvgj9OGFDt+6jj/I7w7YRfNY1uwF8qXmsqlpUqrRAYB4+tNW3VUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPO7kD3Xp4VGFnlmP3JaAVJkvtrCGpFRDDfKWmvmzVCTzJCsOd
	VsrhmGdsFQKobp3iy0JsozpcfK77ZNIwYcCnQW8IWZ5GfiC3KZhNqGsD
X-Gm-Gg: ASbGncseOsrpJRH/aDr+2JVGQMSSVNb6De6b76L1K7DLG1Kg6CpFebR+ryPj9dPB1yO
	1PkCPPGDZpJgJo83B1OVL9QomDQ5dAk5v02OU46Jh99ZOwQUjmhVF1VlsuZH8gt+RWm+ZA05wfX
	mxb8/RWMnOODkbO7Zxmi83j8kxMk7qWBSRv1w0SEoCOrKUjFIZw3fWSAQlLrCWA9BHj74UBkwdW
	Cb36po14gA//6CCX7931BlT757SsN5VfRlcJEVnJ7BWn3pe+qOjAAvMHkj26RNzxjx6gM62ci25
	N8JJhpKlcU5m4O7hJGq0Yf40EvRDgolzXMvGDo39yBwjvBummJ/8sJ1EsZa0GkMZOgpOZMCAsoS
	uFGpVqIQhG6vhnqR6Yli7tRA9xk/eDo0y5ev9aI0I/2Yit3aT3CFLT7boaRe06WVCaS2OE+uP+n
	tTwMepcM7moBujEwvbeqvCl2R11M0EUni+1lfUomYULkiK48UpuzwQBwWFp8JY4hhoKoFcKeyCb
	5FSW3Ld4z7G
X-Google-Smtp-Source: AGHT+IFLLHTGHcAuIPyGKMZXwN/E6JsPzYuvadEdbaB5JanFKglVSWXPVxk4ppTMgy82SxhKIiaxmw==
X-Received: by 2002:a05:6000:268a:b0:429:d426:fb9 with SMTP id ffacd0b85a97d-429d4261238mr2280493f8f.34.1762179409528;
        Mon, 03 Nov 2025 06:16:49 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429cdf42104sm10403042f8f.3.2025.11.03.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:16:48 -0800 (PST)
Date: Mon, 3 Nov 2025 15:16:46 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com, kyarlagadda@nvidia.com, 
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] spi: tegra210-quad: Check hardware status on
 timeout
Message-ID: <wo3oezxxxqbld326h7736lzyspgk7odvvvcamgp5wemtxsnzee@ybl3kg54arvy>
References: <20251028155703.4151791-1-va@nvidia.com>
 <20251028155703.4151791-4-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gzoofza66yihpibs"
Content-Disposition: inline
In-Reply-To: <20251028155703.4151791-4-va@nvidia.com>


--gzoofza66yihpibs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/3] spi: tegra210-quad: Check hardware status on
 timeout
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 03:57:03PM +0000, Vishwaroop A wrote:
> Under high system load, QSPI interrupts can be delayed or blocked on the
> target CPU, causing wait_for_completion_timeout() to report failure even
> though the hardware successfully completed the transfer.
>=20
> When a timeout occurs, check the QSPI_RDY bit in QSPI_TRANS_STATUS to
> determine if the hardware actually completed the transfer. If so, manually
> invoke the completion handler to process the transfer successfully instead
> of failing it.
>=20
> This distinguishes lost/delayed interrupts from real hardware timeouts,
> preventing unnecessary failures of transfers that completed successfully.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 100 +++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 20 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--gzoofza66yihpibs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkIuU4ACgkQ3SOs138+
s6FGmA//foQG6+9yuS/wubcK2SRlH+jBiF4e521dUqV22u1TxiW6hnbBogOH3lW7
Bejz5Qa05wuRQfz1V0yIlZuc137y/LhqjwN5rnkktOd1eVIsIy2gQdan28iMzlAq
5949P75ohtNWxwRNwero9W6W8cyV7ZZymdW4w8yxdSBlhhIy8UOQZEi4xecsxoOV
qhmUAenz74bkcJWwtJ+3noqxouJwi8+EwBe4m7vPwHCaVj4F8n87JrYjUQr0Yn9W
s/iobChVpC2fEFWKScg3iwACpn1IefAVGgNmH0kI5koYSxIbUdZvmNcrKj3sXvC6
FPrdv/sd4EeVbRgzy5ipWh8JcsgQnbhBbO7cawogGu/cry8JMHVN7CgJ0wDZ03W9
OptTKOgr9/7KBsMdZwqeEsVkzRDnhksSSh8IUT3RaMMEQBEENf+cYNRslDjEY0Zz
VEwRuUdpdi6ciNpm8p9Z1z2GDF/r1syb++z63AVLefUCxtApwI505ljqf42uNppU
3XZ8VkjK8ToRBLDRxfas/0RvFjrUVTku/Gh2sOWPP0h5Pn5jyBKgKVUYgJQhLbiT
JWBYo/c/1jqRYwc4o8Fk/M8wxpoTjq9a9MRYbt9+hEpTTB8nIceKhRwPtwi/BOUR
DkovGIAcINw/zIY4frjEjiHia1lKqlWLYpRjy3uuXws9wQgProA=
=UHnL
-----END PGP SIGNATURE-----

--gzoofza66yihpibs--

