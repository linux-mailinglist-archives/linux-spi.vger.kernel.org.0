Return-Path: <linux-spi+bounces-6959-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4480A47AA0
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3C53AC7B9
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0021D5BD;
	Thu, 27 Feb 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeAqEP7A"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411E22A1CB;
	Thu, 27 Feb 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653112; cv=none; b=s3BW95BWmS/OSISifj+ZqipEChXlHwqTS5wCTS1qARMcvwUl9Z/bNdsju0yr1+UfHc4uPN2/q4oc1oiimULnWxX2E9dKgaJiikfrySoP1eSC4P+drulmzaxmk5Houe9hjRRz8iRz3Lc5pCwjhX6uwXPUhNX4VIiX/U983bBNNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653112; c=relaxed/simple;
	bh=+Q2GcbXrqqS3P5H/IateYvsCHJixfshJ8PfZtYJ4/K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivKFtcz7OfpcuJeyuuYx6DO1UZl4/u3oPuwTt+oXdWTChBflXOLFZDan6TPV7ETjmPRB5tepbCQBogvKsxmKXUGCR9q5tTtIkTyLxZuMwEiLsI9oC7kdjvNgnDQ3KMhEOJpJyLwiFEqTrTUP8dqncOuWxeUsT9uDwEDkTeLMm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeAqEP7A; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390e702d481so189195f8f.1;
        Thu, 27 Feb 2025 02:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740653109; x=1741257909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q2GcbXrqqS3P5H/IateYvsCHJixfshJ8PfZtYJ4/K0=;
        b=aeAqEP7AoOgN5VFjRFXq9XbcKUiEwc0B+nYfgujNFwyRJEw7+L1s/r9qpPXtSZiH25
         BO10m+xx6SEHOIPCOTEp1rSiTPStlc98wBrh6CdCGGVjDQnPX7uB2rtHcnEhMV4EXzJ2
         CbU/thnssOyzLJvr0xa61QI49x6jH4NoILmkETaOJ/Cax32N8dbvTBosl25WzBAryJFn
         dzCIqdcwFAqxUoRZL2+5YGbfV2fOOYeeroLaKMP7BnZ17G+2wdkIhyBvmJW4VdnYRhBh
         +PYNbDe3w4REkc/0A2tI65M4S6A+zlBccIJbIN2Bnjp5L4YJHkbioCkTPfWQPNqTolq3
         +0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653109; x=1741257909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q2GcbXrqqS3P5H/IateYvsCHJixfshJ8PfZtYJ4/K0=;
        b=W/oJGCRTGddmqDKBE7a1fhYdXGPRH4jKVnQsJ9UEtb53amM8M0696V9aTmaHdaCW5C
         YL8jtX4Pm5dxUTUIOTtpkVnp1U+k1sIzRmVXTwxRP+3XuQ2jZmsdBhd9FQNhrNaix+pY
         s6xN0wOLs6mcRPhT4K4+zkUeexyIYiuefchu+yjPupQbqJB6o4A8yNif6GhuN+g769+A
         9ZqFLewDmnLTKnhoYQq4bozCfj7TWVQeCOxLSdEdBlgXe+Ho+m+a3NvyQ6CtVDddMQkv
         zBImoT8NMmpimczbPP0dmaL6Bkutgm7IDUa3NIUeG6SF+uivnHwabq4hkzPOOaKpoFev
         GC/w==
X-Forwarded-Encrypted: i=1; AJvYcCU9nqRPgFMWuNlasFDCZ8XbsvkIcVHU1A5XSziMvWNxmlrK7umW/b/XiOWF9pLUOiRSJ8sq+6/IIe7f@vger.kernel.org, AJvYcCUDt/LLAJ4aEByEoVVGYkm0PiavmI3DUjvK/rjhHYuk5S2hLqO1IgLpcgqZ7Ktl4ojPdkInJ0es5f7N8yY=@vger.kernel.org, AJvYcCXlBr73t9KIu+oe2ipegxXFFTQuxFrGrGEhasndI/2mDPFNofE0biWtg6JDcNVuXdDjeRAVt4D2IN16L4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzerI4b/XZrvD05UvcZ8tLfg2Hc11f6jkHK43uT87Ttq1IeIAC0
	8qUT5hGAcM7g9BgolThr+MCmqAP2KeVAlQTkcsMXuBcqx+c/yWkZAp+PNg==
X-Gm-Gg: ASbGncvRc45E7uGLy9P5us64ylCXoEQW6fQ25oim6c8BouRh0nAtd+qIBM9UmJtQAS8
	QUF9gR2uRoV/APkMi/Rk+reBKttT2K4nFkyZcru3AmtdZNxC7QfKA2oY2DZj4pqUoGuRaVGg/pN
	DqCPZFoWJn1Fg3ZSnMSipVKtgUXSj5xKSCw5vsrPKe9WD6sxWqZcZqwUYWeNqYnjkw+iMZXC1KV
	+L9C7J04TaJlrRTd+GveJ/YNWjGNNe6S/kFED/PK7LfZY4ZI/2e6QtkIv4sVr/xyaJz6YqllLFa
	yTVqNh7N8WwnjVv8U/dwjhxJlp96bAIrGoDLgxgsujde5S9NT1wfFfuCqZgxvhkgIFZsyALJmd5
	zEu2iO0FxouYl
X-Google-Smtp-Source: AGHT+IHA49MofxnHaSdabYQ1UAnisVzQLjhknXMU454Du12x614NOv8tJF69LNpTIw1GoPFOxWmULQ==
X-Received: by 2002:a05:6000:1787:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-390e158a24dmr2152768f8f.43.1740653108891;
        Thu, 27 Feb 2025 02:45:08 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479596dsm1616556f8f.7.2025.02.27.02.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:45:07 -0800 (PST)
Date: Thu, 27 Feb 2025 11:45:05 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com, 
	broonie@kernel.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH v2 3/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and
 support x4 transfers
Message-ID: <kb7g5xx6i6ydjgmltitcfaqlnhjuygcn7a6v7c34z75nykjnm3@2mybamhzwpbp>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
 <20250212144651.2433086-4-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="smohwlpuzwmja7aw"
Content-Disposition: inline
In-Reply-To: <20250212144651.2433086-4-va@nvidia.com>


--smohwlpuzwmja7aw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and
 support x4 transfers
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 02:46:48PM +0000, Vishwaroop A wrote:
> This patch corrects the QSPI_COMMAND_X1_X2_X4 and QSPI_ADDRESS_X1_X2_X4
> macros to properly encode the bus width for x1, x2, and x4 transfers.
> Although these macros were previously incorrect, they were not being
> used in the driver, so no functionality was affected.
>=20
> The patch updates tegra_qspi_cmd_config() and tegra_qspi_addr_config()
> function calls to use the actual bus width from the transfer, instead of
> hardcoding it to 0 (which implied x1 mode). This change enables proper
> support for x1, x2, and x4 data transfers by correctly configuring the
> interface width for commands and addresses.
>=20
> These modifications improve the QSPI driver's flexibility and prepare it
> for future use cases that may require different bus widths for commands
> and addresses.
>=20
> Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>

With that blank line between Fixes: and S-o-b: dropped, this is:

Acked-by: Thierry Reding <treding@nvidia.com>

--smohwlpuzwmja7aw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfAQjEACgkQ3SOs138+
s6EeuxAAk1IAdbqFPV5e/5T+wcb9TBBi2UXUZhOzCQYnnkwGt4yRX1aKxJkiW+Zj
fLSn/uvUz2qxCl/QaZzs/1iOjUBbxxp4l08YdRzftSvZrkeTESNTj7ej/nVc+FrM
S8PE78UvxETtwT7UsJ0NimrQCt3/7tbq+i/bOFSI2z2/7UuH5+G0x2wI0sj1oCQ/
SzFKOjVGy9toHfHtxMYwi6pv5vFkYQvHzydEhlN8aeWFBWfe7J46RPy9F4rhrunP
909RtZQrQJj1ShHPQKzUJY2vUF4bBYH8/KA/rieV2Qaq/nXr1xC/ggx18F4ECfub
TwT+TaQB0rDnSDOFrQlK+UfH/pxDQCU4plNEknFvd1INsx2zgBbY6nengZ9iehPW
2gxY1CGbtL2V4J8yeSG43NK0zh+wpulfRIZQF0UUtJ5Jo6dVIcui04XwoNJirmq1
dKtLdeW2VBqEozYFOKeSn8pCynqsJCQPAcZPwxvQg1JaYJDxsjch7SykT5kQNrc+
WwE7U/8MY42+mMvyeiHLE1enNyHkpbArsgzYQvVe3uQGlmkThePLC3f5FNrulWrb
AGBtKW6qddDUJaHhqVT3oIyyvNUJfV2eSdEOcFw4Ie2kGzj+C38qhi8EWM4xXyys
StX8M1IizH8jyKCgasuXA92MIwn0LhlraElYreVbhStRHayHNS0=
=6E9P
-----END PGP SIGNATURE-----

--smohwlpuzwmja7aw--

