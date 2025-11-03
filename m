Return-Path: <linux-spi+bounces-10977-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E401BC2C62F
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 15:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D221E422300
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB530DD11;
	Mon,  3 Nov 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDfJi9cI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64B2652B0
	for <linux-spi@vger.kernel.org>; Mon,  3 Nov 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179332; cv=none; b=FEXLrVQV5osPNE9QpqUXkPZuP6sXcUh8YwYOumRKxnQwptKlpbWcBdjiTwJOSYDByzyaF/L6TD9zqx/E0fL88VhdUADk5Ch5qSoxzDZ70fwmR2QZx+um54yn2vmjg922Hiweo3UVrKFqkPYOaVSx/an1wB2LG6jnKbegnHQZmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179332; c=relaxed/simple;
	bh=tJd57umSrSrMkwMZ4jsEEr5dXkJRBQnG/iLqH9kTtT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcWU6CMeTE7fS7c1DZd/JygK1YNKhBkg9fpOX7qEfEljH13TOSFxeI/I9XlT9NEgBLwnlLaQja/S3Mz0YQn34RokisymPBx7p2OfMFwPiTPtMEg0tiwJRjmI5askdui8pW6x657OO4L5r+0E9Eq+ixph4nLpZn4H6Crugz50PYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDfJi9cI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711810948aso31694625e9.2
        for <linux-spi@vger.kernel.org>; Mon, 03 Nov 2025 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179328; x=1762784128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xis5fSul0gQO0a8v8x/O3Qgi2bVvhMEH98mMW3na7kE=;
        b=KDfJi9cIGcm3MKYPmtf/mSweRhDOVoXILgEMEpRmjCZOL4ldidPDclPG1E1GfWDF6+
         NglG5WxTayeklzJGuZoj4De0sg0nNscMyFCtblzoyKGJ8Voy1XmvtZZgvUY2lALhvzGW
         P7w0gxSXrphHEOaGXBxP7DEX+XIYdQVI+dHMy+WfAT/bN1DWd4eH9pTOVE7SUJEUT6mx
         Qbcgsxfu7BFZITIfmD9r7KLixRYruRwlrFQP413a0SESldQ/pZ+MyYq0DIm8Mp5PXoE1
         ig1ob1cqCOwzMYEo77pUZ6V9vJ2xUD0059W3855RF/zmdsAxHiU1dvtfIEIB5con5l3e
         i5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179328; x=1762784128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xis5fSul0gQO0a8v8x/O3Qgi2bVvhMEH98mMW3na7kE=;
        b=lD4uTCMlLgQKUffKh2uksd9qN9ovVQ5IBjWOoqiwOzVy1W4tcSPB5nWMoATbcOyiBw
         G3hfSIgWO10okTyRE1xobYdLnpiwGYu2L8ArKmDDRNSoN+QmmK15z6VvZwAYBcBXDBde
         AUVJLoRFWQk+U5VWSIZhOPTQqsxrVhwMYzIQgT26uF344mNa9RVx2bPpasTa7V+T+uDl
         mxVomvQUrsKK8IB/Lh5LJBUfNP/TONuW9yu4f34Jo2gLn6DcBRxvDndyXoMg5rC869uh
         Q1pmyflXkFY1sBJSs7lAlRiqDEqBHoY7q+YE9kP2UAmXiODN1azu8cbm6tmIxuu5zyeT
         79Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Uaywd3857iVzaA7cfSqqQ1It2pUXeygPIlXdKkGANGSvsVGVfv8ArrMwwEeLzEDpviK9m2KHk94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbeua1BQIXnKNtV/S0djQtcjmKCYMtFdbpc1idwFd5ilTwH7I
	Qp4zaWAI1oMxlugGBxx4FE4QGVJ9cs1ASD+13kApFr2IJ8a9Xbt0r97x
X-Gm-Gg: ASbGncu0EZOaMdKSRC3xblypSAjSiyijDfOr+efd2BclpLHKJTOVnixnkQ3C7+atM3+
	Yi2ASXzAMHmHAWQjavYHUuohxVHjEyffZB5Ma8DVT84p04F7Epvav3QxqOpsoYa9hcBwJQCkxl2
	Mpha7vo+NJw8eoVjEm/chfDFMvnenvnWFRdej6HFEymy9KsUD+gNeCeTQ/OwTPkn6j9K24WLmsW
	KtGfi4qEA7WxT1XW1VvLH3PE41kzVkboHtX9/yIdNtJNSaLoLeCvxNCBsQeUG2X6lGMedZ/q3nK
	3zyDBKnP0AONx4nX7J23hXNUVeWP65sS47pIVGWQo5lUmXT0fGdc/VFRexBzI3McWRE26hG3tSE
	/SWM1n4v8FHydHkWP0CReBR5FqVugtFvT7P9O99MGuMyQoxUsrVPjdoZAPn4MTVqdqd/EMvRLe8
	3Qz08t8+vPWZyvk7HahshQrXHlYhduvsciNkoMdxeN+TSc0oAwvgHoHUxqyrspKX4=
X-Google-Smtp-Source: AGHT+IG/NyKSA8+Ck+AODhZFBQsqS988o0/8irLATr+tquMGH5sogqa3ax99aZPEXnB+qAqlgcsQQw==
X-Received: by 2002:a05:600c:871a:b0:471:d2d:ac42 with SMTP id 5b1f17b1804b1-477307c5165mr110192245e9.14.1762179327861;
        Mon, 03 Nov 2025 06:15:27 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fab7b79sm86939075e9.0.2025.11.03.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:15:26 -0800 (PST)
Date: Mon, 3 Nov 2025 15:15:24 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com, kyarlagadda@nvidia.com, 
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] spi: tegra210-quad: Refactor error handling into
 helper functions
Message-ID: <w3clgkw6xt5qd2qimxltkxbzjkhokgddf454vrfbw4yhbumdpq@ahq7lte4iqdq>
References: <20251028155703.4151791-1-va@nvidia.com>
 <20251028155703.4151791-3-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lli4tbylqnpu2c6d"
Content-Disposition: inline
In-Reply-To: <20251028155703.4151791-3-va@nvidia.com>


--lli4tbylqnpu2c6d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/3] spi: tegra210-quad: Refactor error handling into
 helper functions
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 03:57:02PM +0000, Vishwaroop A wrote:
> Extract common cleanup code into dedicated helper functions to simplify
> the code and improve readability. This refactoring includes:
>=20
> - tegra_qspi_reset(): Device reset and interrupt cleanup
> - tegra_qspi_dma_stop(): DMA termination and disable
> - tegra_qspi_pio_stop(): PIO mode disable
>=20
> No functional changes. This is purely a code reorganization to prepare
> for improved timeout handling in subsequent patches.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 84 +++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 40 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--lli4tbylqnpu2c6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkIuPwACgkQ3SOs138+
s6Gymg//YjL75UguTsHt3WntzsZXMUpzKXhNOHi3yy8b1KSppwPRFrMZM/lNtF6g
Ui6GW5VrF0uPbFBjHqiURyo2pGjw3VFohwg7B7+QTfgEByi/yQpy6npR66YDDOgr
g2xRSpi0jOzl6MWxOtfym1/K1blxXx+NSPIafkT/4ZSZ++IH/e139s+FbTzeIzF0
6nbWSalPKRzQxfJ2dJTp38VIYj74i7CTnsT/2+sERl4KryIyXZcUGikZ5DEbR1JM
dEQLZuZwmJDzulfuxskyiDPqUXYoLJXWtaG45WKHEuGkpXlVP4oSaC/IXZGxKM5C
UyU7yidPe3LipfBmuevDNkqI3FcWtR2dBE0j4Z1jcXv0ao0t2BvZcIbLP9DSi+Th
wo0rzEtydDIJKIRO+ymxJ39Ioebeoh//b4x0DuLn+pRPswwfDAupxwsR0DH+A6iD
ePZZC84a9IaHuhpKTTVwkoSximlrwvKZlSJ0r2sKHDDSvYcnXuJGI16h1bkG/sCW
FqKQnYBiBKQRw0Chl1T74+bDVt1GPjBfnMN9PV5D/R+advf1c7Yili2lYanB41jx
0BDwJNEQh/zR7D7ZAe2Ns+jBAPSlCTAmrM6oXsoOyDKqATK2kdAgfxD5K7gZzYxv
M1BhObLbr3gnEml3HLhkg5bghA+cDLdFEDd3mwxuB629o7ALZwo=
=UI7C
-----END PGP SIGNATURE-----

--lli4tbylqnpu2c6d--

