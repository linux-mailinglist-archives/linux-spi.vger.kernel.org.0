Return-Path: <linux-spi+bounces-6267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB0A0738C
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 11:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8F93A44C7
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FEE21518C;
	Thu,  9 Jan 2025 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS8Ujapm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB46201017;
	Thu,  9 Jan 2025 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419251; cv=none; b=RMP/BjP0rw6Wp41hLRaANAcEIHbWb9kpmwuYlTDTGZBB/iJq3ay6VKsNJhSUIFUq55qH4if3KxjfWCSfLuGtZ64p4wXiDktOMsc9BeOxOVIBW2VqP4UyzyA/ybijoq8O7Dr4RupnrT3Frsi4ll9YYzZHuIHNqVzi2M4ZuAplonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419251; c=relaxed/simple;
	bh=h8J8++x/SPrVUzEFVs5zhDuFY1mLq8RA9BaSdcsqzrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le4aoJ1lbfw8Za3+/7hQ4kFYzcEteuVwFaPNpcZp2D3Ew4ovc+QznNjSDRX4IPH8G2zT+/LGeoH4gJ6i4Ck3iSaNWGfCL3XZnV113hamZCwDV4X9u1yk/Zyge5YdQX9+5qVgdhgsoiVbq89zEj/gKkR3iQdpzBoMizrvAYa+qAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS8Ujapm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361c705434so5944305e9.3;
        Thu, 09 Jan 2025 02:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736419248; x=1737024048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H12VuDd/2TasMvsWMD3RENPoV6jtBGVe+6nE1Cy5Zr4=;
        b=VS8Ujapm9hMhWV7fX+Krtvr2zzskEoEJy9kMThtB/fBOnkzZ32q02wjKUet3SBlZKi
         oolprBYc5mP1MQ3XRZPt7v+66WshqCG99yFyC8pE2mjnkm6oQsf09i/vmVhVamgsel3g
         T51L0O1XWinA/0xiv8HHQmtzwXMBCo5wzeT5M5X1urxH7jXq1htddPJkWJZkQ89i6WgU
         VInx+k7joC3N+dJkrx8X8aR0FHfh6mXm0rMsGclLzCk+VTUaLdFO+TarorB7rCTash8O
         fwSh+LZxp6AMDeNBe9xZims9KkVpig4fI6Xm3wYQZGWv3lcXwHpiVgSDJ4j5MjahweQO
         hP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419248; x=1737024048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H12VuDd/2TasMvsWMD3RENPoV6jtBGVe+6nE1Cy5Zr4=;
        b=QFKlatUc6zx+v73nksQHCOWX1xzAvrIEQNrOgw0wTUpdmijLXFMP7Y5JwdiyrVVfA4
         MJbQrIbhu38VgFSQh2gPujSMZ15g8GwYtymqTs6AX6PQR1CMwMKQkJA3CZKYVIi+AnPB
         lGXJMkmsdSGFta+PrYrwnhn7qEkSYaJndN4LhZwPIUAVa8esKC7VlLADWwEW+x2FoK3y
         wJcQDuo1cHPy3C/8uHF9XuGO5agQXQ0kK/JOPdnKbS3b1xWg/3Y+gwWKSgY02D7G6tHe
         bjqDZg5w+35Whd+cJT+3BbnZw/CMHX9osMPkrY2Rss7LVWD7mfniff0VbW1DUi72Qmhy
         bLvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3gUAo9jLU1vNtHSM9oHc6rByPpxyhPtXmb1w+a7yetjq4KItqWB9UhERBDzXgWxIgp12V5h7yEUDXZRw=@vger.kernel.org, AJvYcCWZdlPWDK5VWXkwstOaLnUv+Uw4DK1F08g8mM5CjNdqlGYhJs+NpC7BrtULqTFYScWfs4NNznGaq/azqkM=@vger.kernel.org, AJvYcCX3gaoLkbvR1hF8K+fO2LtmGcreyGnuNzhMV7rmcEuZBwXQ8hSkg1wp/HKXJbanviRPTdeTJPqwnLzj@vger.kernel.org
X-Gm-Message-State: AOJu0YwZE+kNgnefMxc0yaOmEMuDxdwBehVS0w4f1+fbOhizxWpU1S/g
	wJiITI+Jlo+HeLuXM6cBA9P053GHcAzRDF16iK+pOWMpMKlipNhT
X-Gm-Gg: ASbGncsOLzKuYZQ7S6i132Xi9dI+3Ox04x3FqBi51MyGKI7NM4ErylDxpsinKvMe3dx
	jMrI2JdkBkomhHZxw2Ip2UGWRvyFIybqYisQaIGoAYi5dVtDQ7FWdiilODyRfMJ4K5CkBI0ojs/
	1DApb3cYilWP49BvyS1w1Smc/yH5trqPNTP6EmTnxcANKZfouu5Q48WSTEX69puc5oZHkifocxl
	JZYOlKWuKmNbnmFrVGxS4VTKVdaoF6EbOzyAsQlZu7JuJ4/UCVfN4O0JMZn7neFbT8P/e69ljEm
	T3yXZcCwYiZzwYNQKAnubtGikhZnJwVd+iCFyZIDxZ4=
X-Google-Smtp-Source: AGHT+IHQMiYIW88iHQrG/WIm1rdUe0t9bG8GjgtwQCFKjU3Ves8ZUXmcldHTVahEq8jN+rt8gsEtPg==
X-Received: by 2002:a05:600c:510a:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-436e2696db5mr52740255e9.11.1736419247865;
        Thu, 09 Jan 2025 02:40:47 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92794sm50158585e9.37.2025.01.09.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:40:46 -0800 (PST)
Date: Thu, 9 Jan 2025 11:40:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com, 
	broonie@kernel.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH V1 1/6] arm64: tegra: Configure QSPI clocks and add DMA
Message-ID: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
References: <20250103060407.1064107-1-va@nvidia.com>
 <20250103060407.1064107-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ironxgkswerd4jcc"
Content-Disposition: inline
In-Reply-To: <20250103060407.1064107-2-va@nvidia.com>


--ironxgkswerd4jcc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V1 1/6] arm64: tegra: Configure QSPI clocks and add DMA
MIME-Version: 1.0

On Fri, Jan 03, 2025 at 06:04:02AM +0000, Vishwaroop A wrote:
> Set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to 99.99 MHz using
> PLLC as the parent clock. These frequencies allow Quad IO DT
> reads up to 99.99 MHz, which is the fastest that can be
> achieved considering various PLL and clock divider constraints.
>=20
> Populate the DMA and IOMMU properties for the Tegra234 QSPI devices to
> enable DMA support.
>=20
> Change-Id: I1dded904aa8e0f278c89998481e829f1ce474e8c
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi
> index 984c85eab41a..96d0f13390ae 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -2948,6 +2948,13 @@
>  				 <&bpmp TEGRA234_CLK_QSPI0_PM>;
>  			clock-names =3D "qspi", "qspi_out";
>  			resets =3D <&bpmp TEGRA234_RESET_QSPI0>;
> +			assigned-clocks =3D <&bpmp TEGRA234_CLK_QSPI0_2X_PM>,
> +					  <&bpmp TEGRA234_CLK_QSPI0_PM>;
> +			assigned-clock-rates =3D <199999999 99999999>;
> +			assigned-clock-parents =3D <&bpmp TEGRA234_CLK_PLLC>;
> +			dma-names =3D "rx", "tx";
> +			dma-coherent;
> +			iommus =3D <&smmu_niso1 TEGRA234_SID_QSPI0>;
>  			status =3D "disabled";
>  		};
> =20
> @@ -3031,6 +3038,13 @@
>  				 <&bpmp TEGRA234_CLK_QSPI1_PM>;
>  			clock-names =3D "qspi", "qspi_out";
>  			resets =3D <&bpmp TEGRA234_RESET_QSPI1>;
> +			assigned-clocks =3D <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
> +					  <&bpmp TEGRA234_CLK_QSPI1_PM>;
> +			assigned-clock-rates =3D <199999999 99999999>;
> +			assigned-clock-parents =3D <&bpmp TEGRA234_CLK_PLLC>;
> +			dma-names =3D "rx", "tx";
> +			dma-coherent;
> +			iommus =3D <&smmu_niso1 TEGRA234_SID_QSPI1>;
>  			status =3D "disabled";
>  		};
> =20

It looks like these are missing the "dmas" properties that go along with
"dma-names".

Thierry

--ironxgkswerd4jcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmd/p6wACgkQ3SOs138+
s6FRyBAArLhV5rctxHEQgk4iZayQJDgJP13MmKqqnGbx5C7uCQzRAWAtkXRJVKk+
IWmMu4/pTOVWj0wGHSVuh4o3GJpq5pZ8H0GZsnuOGdhEGfK8uK0/s71p8/xoY5L0
XKPv/ta8Iyc90KjK/ajKz2BWAV6c2LKcpKXpV1d5KnHC7DXFXKmvQ0k4zp0j6yDX
hSamA2QtJ6XpG8Zyq2JZ1+AkMIYYRnf0D3o+89oU/cD9/FqN9PiG7VszFYcHV+2w
XzWuHIRVO4EhqHGW4VdODzrnk4OLzQqENp1usIZmYIjGUMsaFIkTZXCmy9o57yD3
kxkcEb33dJcjzafI9V6ucf420g7cGsoNly8BfFNBSyONYe4q78kB6x6eZ4ep8mfJ
sAX67BL7LQTJyqRi+pEN/vSkYd1cCHZTCx4Dk9CXCP1Fo+Z6I77EpJIB+V32qy2g
UahOBXCPP+CQlZVrduplxqRlI1ecmqflXZqbHHyvVEq0cowmwQA/pwbaUHi/1hY7
TjTHocuTBZFrckrtgao4wbIxxnBKnmdcG0I7A2JoJeyrtD0PVLcHBwfH/UkD0ZRl
FJtp51WU25/UC44YojhwJs5PQYbFHXQsP3K51TvsgkIWigRz+1CTApIwFpbAuxKp
3GzNSVtKKkJN37/6c005+asXZVl7cvAHLkNdGnNCFuhfOJRE6KI=
=Z3sA
-----END PGP SIGNATURE-----

--ironxgkswerd4jcc--

