Return-Path: <linux-spi+bounces-8127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F53AB7FDA
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 10:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287AF1BA4606
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA52283FD6;
	Thu, 15 May 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiC4dWdg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69F1A704B;
	Thu, 15 May 2025 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296649; cv=none; b=gE2+5ZAqOBUTiZ1KrsirJJqdNcaRlPB5bZyF0rGB+u+3bQGszEhpTKJrLTBdSc0jyJDHyRqJ27jvRwUxjGtCFq1EucrxzXDZx7FwTHb1TU4bsD84KX228xzZZoS9n8JbyydCnTt5MsK9uCzPhgDTfDB3IZubAMuPpM4adq1xrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296649; c=relaxed/simple;
	bh=gnZyYamsKRs1mXWJmt8R1pUvw1fIQ115hLDfkIZy6e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXOBF5GnMro/Jpa3g3MOsBb6Xna0mh+m6KanaNrt8Y8VSS85vqCYH+3W306vw2cI+9+gCBv+IHjYpbi8Y9QrGrSxT36IoxsI3xno+YDMZTqgsMgGhktEIgcxiLXaechm5/jWl4XgVW13yetSz+qjPacSv6iS4HaeaMnChrsYT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiC4dWdg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so4788765e9.1;
        Thu, 15 May 2025 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747296646; x=1747901446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hy2qXGW5KXMzxxjud7orCi4omTEJipbX7lKkxc7gJx8=;
        b=GiC4dWdg+9SY9bTRUOiiViuG/z5ieGAPra8r7S/hnapt8MzoudL/O09L6/KwLFl0jL
         Z0Ppbgeyue5XNWwfCw2cGvq+30wRXl+wH+jtWEZN3HlSAq7GrgpkGkhMWxZ7SGTmQHn6
         3R/0ERyTY/vFwdZeKF6B7Jus3nFnaX7w4W18oxg5VhYYr8LzSRfST9qU+RGZU/yktWxK
         u6Wa83UMItY1VqjSzyZO4emY5wiFYoSccqhyT7LgJ86o/m3yCHS3KZv2/ENMkGDbwYHX
         4sX1dkszJuwbzd+/q5/PKFq4kYpfnkbzjinjHklQ+Z+d1CAaNm/1ZIHpW1WGr8w3e5yq
         iR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747296646; x=1747901446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy2qXGW5KXMzxxjud7orCi4omTEJipbX7lKkxc7gJx8=;
        b=TMYEZpI1wbCSd9xlEoVatiCdGIlYZasfH1cyQeWq0xoDAtRyawHTA4o++xWn0PAKHl
         tKcxrN6HGKn2V+blxo9q3CqJeJHZ/mAnyJpb+bhNg7XAZRda5eydCJf5Y+igKF1BB/Zs
         eMaMt8OE2dOLFfhJWSpp5cV9CtX4ObrfK9wZmJXOdM2lIv/CwBZymU8Rpk8JRI1/GJFJ
         0GKDCgbi/p0613BmBANBfRfaWE9QErRcGWkqqx53eTHMVYQwS1bxD0xFSfeTmPJxO4WH
         YtUIE6UzlZOXygQ55OMqcYWIv3ua7CZcN+1eXJmafGSaBWx91bJZOdZS+GJDAfOGgN0a
         xmaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4opqsAc+Em5ytvKFKTZa6N6d+l9IcJB3CzoVzfFh+6kyi+hXuEoLkQH9EemF80jg5k+xMwoYIqsDsY0Q=@vger.kernel.org, AJvYcCVS2FXCQcXnYfWPdXWkDnLtLFzwXjhGs9sN7dGaO2wGGMilMRNFPHN/prXTjaKSrxlUMB36WZjUq6ZJ@vger.kernel.org, AJvYcCViM/rY11jHgGD6/Mdu56tdil1jXvcQGFJ1mu8eSEKY8xcz+HInpJnBuDxCZoiiz98xyT5hxyqSASW26qDX@vger.kernel.org, AJvYcCVkBp8n3vZsgqthKPxmktZAZ7whv472vjrZSBS5K8R+XeJPvQAWMpXoBdc9dqV4Utsaze7fPoELaaCE@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzY9q42k/2m6RzODyzHj2lrC4o/pR49ZaPTaLxCK11jR6fdl5
	r9su4jvPfFa+8cdX1rZvWEEOKsa4Jzaco/ZsVoganz2pWU1yaDxEmZtORA==
X-Gm-Gg: ASbGncvdiN92vfAkBcOb5Dl+LhM+cMq9a53dMsQtkTG/2cW08GH63x5djojKDDja1/a
	6n1SdXj5nGKVlWhXgmdrOUsjY20zZGdPb3xPi4i/tybE9qPMm+I4zUbheLfjjBgE0ves7lejrOm
	PbhrYEHG6Uiy2oy0jpMMg2SW/In1kVAWG64lgrye1Y+lkdOewtYQDtXP9MuGWSJtnL3Bt3pIBIP
	Mj5QwIDY8KxCxOFSWNGeD/ZuXyFhhF7sXJGyAAY3/UMJOAr9vP4+hycK/fAcAapTG1dLFU4uHv8
	a1wTcsPcS0W2Gn3rXqKmenUZ52+RXIQ/frdqTJ/w3lepxSk1Dqf28Vjv1q/s/5ZbLktjD1GomMi
	aievL4iBwxNX45ohPW64rGpAINQJ0M/zsLAi6hXlQdleO3qI1
X-Google-Smtp-Source: AGHT+IEGyyG/LNEAKuRtS2A62/7HsPhFAX86kklkRBv74EAtipUbgt7otHFs31JFx7YXeS0Ae+rpWA==
X-Received: by 2002:a05:600c:609a:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-442f210f700mr57426795e9.19.1747296645706;
        Thu, 15 May 2025 01:10:45 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8ab839esm21120775e9.17.2025.05.15.01.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:10:44 -0700 (PDT)
Date: Thu, 15 May 2025 10:10:42 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: krzk@kernel.org, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jonathanh@nvidia.com, 
	skomatineni@nvidia.com, ldewangan@nvidia.com, kyarlagadda@nvidia.com, 
	smangipudi@nvidia.com, bgriffis@nvidia.com, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] spi: tegra210-quad: Add support for internal DMA
Message-ID: <abbrh34e5ysybbijdyyxut6af4to5mlzbd5idxjj65gtuldnnl@3jqotvz765lg>
References: <20250513200043.608292-1-va@nvidia.com>
 <20250513200043.608292-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xha6jhnwhahixu33"
Content-Disposition: inline
In-Reply-To: <20250513200043.608292-2-va@nvidia.com>


--xha6jhnwhahixu33
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V4 2/2] spi: tegra210-quad: Add support for internal DMA
MIME-Version: 1.0

On Tue, May 13, 2025 at 08:00:43PM +0000, Vishwaroop A wrote:
> Add support for internal DMA in Tegra234 devices. Tegra234 has an
> internal DMA controller, while Tegra241 continues to use an external
> DMA controller (GPCDMA). This patch adds support for both internal
> and external DMA controllers.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 225 +++++++++++++++++++-------------
>  1 file changed, 131 insertions(+), 94 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--xha6jhnwhahixu33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgloYEACgkQ3SOs138+
s6E9/Q//VNWMZH6vwHGacDuSUg00hKDi7gl3PJ0AYCQiBgDDJCF8JDvDLQ+Vs6EY
sYjT1OcyHjjStOKsHWUCuCvnmvdRnRx+fzMMqqG9EnuYdKmPns+yxYcoJ06FcWq5
0rzo7vlUdWWU/Jdy303cHALCxzFjSgJy64k5YWMLwMKHszjYdsM3Td+SANJQecNO
yvI7CuSyw95OsK5zax4skuCYMRbit8clJK1mjvhbxdwGoBRVU+VevJNp28/dArL9
Sib4Ue1HGyaV6Qf5hIID9OdjTEt04+cGdrotaIzpmpMP91FtJ14hlGCwXg9tHSpw
24xytSZIxlfuvtcwlza87ezZgVSncli0OmMaOIagsR+9KgCtqXYycj7mklUrTgDe
wmgR71PayVSWKPzUpJx/du8zrEIy4oheY0tbgf+gIOuLn1khzzJ2O9jABdDDKmBs
4hB9Pi7FLsV5FFD5eeGhVGcxDvpbwEJ2huNx770kAoBCk8xnsTK3SolNV1Ws3B6x
6UD8pohC/vXrNf5OkJ8jrgkVYfRLxNGGn1Snhu+acdoSt9RELBCQJlEf9Qy+mzdV
JqcIu8ew+zbgbilDJZbssPg8Em/tf2Vcq73t8UNDcfzj1frR1i0FiZMuPskpBDSN
mzkC2lELFs2XjcHyrXPERYj61dwsBn1FMO3ajF4J2c5N4x9O/os=
=oqYJ
-----END PGP SIGNATURE-----

--xha6jhnwhahixu33--

