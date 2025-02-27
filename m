Return-Path: <linux-spi+bounces-6957-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A26A47A76
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E9F3B15F6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F2229B00;
	Thu, 27 Feb 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPeGQvTV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4EE21ABB4;
	Thu, 27 Feb 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652796; cv=none; b=k6jMpBwxPAiFVeD2VoDohm0ni2APzfAITvBN+RzPP0oP6m/+dvl00ViHzCCzy7tACLPY/vsVAPN2++wjBKwKSj7xk6cTlOnwyg1zTWYq2QgU8pVYyH2IgKAvcs9CtQ70Zr5wlqOycyJZYoJvzl1aAh0xWt7f3h91exMbBOoEyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652796; c=relaxed/simple;
	bh=4Z5THPHBB0PyNdgQ73XQc7tWD13PorYiOsgFnskGl+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz/tb17Awrdi9283PtHqebGIklOeFRhYPEHA7+E0G+EUYoosLcaYPbB2OV+oq+ifzc74lb2162qr1Zsv3tNlnziXtWsT3B4p21vxt5BjKKxnAfSZxXous4AfwrmW3KFl0BqSHWciSttYit/zdkEaeC8kThROkRzPO+Thdszkjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPeGQvTV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so400764f8f.1;
        Thu, 27 Feb 2025 02:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740652793; x=1741257593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBNOuunCwK0S7uvVT7lUa1QkbPinEv6RhOlxsz3h1co=;
        b=fPeGQvTVE58N6BSy+ua7dqbVmtpdoXnQ0OZyp8fluuahv4wBqhf2g806jGP/3pA/ba
         bRskVGUZRiF1qd6C0ClBXPEmMfSDHCKWS2JYIr3AWoQp1UNGbd1nWpTR7/ORAFY3e89R
         6RXM5sW45KPizUM5xrzwQRZj6C9+Ri3r22L5y905ySDOl6uc++8dqcprLt+SY6asO847
         GqI2ev8noZUoUnKdqeF78V08X/Ru3sZcln2dD4714qy9Bq31w5sNX0zZB9MTHUcW2fWe
         eFxXoKVUZBWj8ePq6Wd5Zl4h1sutwBLQebYHv7LwHgn3/xeo5kg+89MvdLKiiJ+GCD3N
         QO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652793; x=1741257593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBNOuunCwK0S7uvVT7lUa1QkbPinEv6RhOlxsz3h1co=;
        b=t9DNkrFXoPg6XE+tRsWLw56/CwPpdZ0pwtHMLoFUL4K5aHVpU7oIy7oDf/Q1q6z+Oo
         x2ajE5M9ntpRNC0jIOfa+60M7IZ/X/JUPgI8AIuic3xYoeZuFX9PG3qi5PZ8GSIubh3B
         gfipqTTIcvfaQFII+evrTQ4Ex/MbX9scfgI/BSqQEOKcfElX6je/CyEg3mbUEl/cB8/U
         a8RNjWJ3tyFtkOOrMPoT0w01E0E+boRGhK20ukjQ5UK0UjbcGxds04x3cUYAPYpw5w9w
         7RaSrGuBuR4+5PggagbvsrvqWXyddNaZMLkUgXaPCDmLUHvLmbdwEd7GCY1htTdHJDju
         vzzw==
X-Forwarded-Encrypted: i=1; AJvYcCV4wpdcA9cDeEDa0A5LhQ/ZQJKiShgH/2/T0p3AHNs1JQcOFOvSD7Q2RLJ8Fqn3T7THntZxrtv0PdHfXcI=@vger.kernel.org, AJvYcCWYWmbhcReL0uaMc9Bs7U3CZxhVisMlp/JB+7HE+fn114jw/5nWFK54NLoo4e5urJXL0EaFZc0Sm4xD@vger.kernel.org, AJvYcCXc7U4HSXEa6cZW+uRAYqMCAGUbSkGQ/iK8Bckdp+TDHN9XIagjwg399Tys07yQ2GmkIeyA8TvyrW2a1l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwXB64j06MIXjqLfp3wyz2qsnH8tiZUIJi/o+fpIrmbsNx+Zk
	3pfgeQ911apkZOJsAKgxx5Duq0a9y5kHyNbyDH2gOLtZNGFCs37n
X-Gm-Gg: ASbGncu2nww71Pp4nxQqQ3h3H1LDae3221cLZic4JMnFyP+DcL0SACuxfWnSM6UJlc1
	qNKt1hbWLe1i+Ahlsf3s/VY4wPLEcOLd639vTpJGzhLh1CYR1BIWTToculSTMiyAlHI3lNm1vhn
	rc34Zr0xRYQQFqbSH7y6IlbgKD8Q5avF5PxFXHTGkfemOP832fIkddUo6vIu7z1zYUVSH2KyTQP
	jBbVHAjJW0svIbkUZZS7jjcBmBcENs41Rx9YgW9s/B5Pv4xHX8cc16+Xpe6kdtvK/5k4WS4siKI
	ofgLNHpWlaF+sQQluI0iaP9tFjzVo/Y1voMueSZEd38DQHNnzjsNwyaI5xbOLQWYYEG1fUXnPuG
	Oy912AAPvvBMY
X-Google-Smtp-Source: AGHT+IH+VMXOi+Mhh3bGfInYKPLcazEFfAbSm2XIe+YZ54dISGf+tuIRq1SvNTEluwvTdl0cMpYLsg==
X-Received: by 2002:a5d:5f8a:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-390d4f84733mr7161091f8f.44.1740652792586;
        Thu, 27 Feb 2025 02:39:52 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479652dsm1644708f8f.16.2025.02.27.02.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:39:51 -0800 (PST)
Date: Thu, 27 Feb 2025 11:39:49 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com, 
	broonie@kernel.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH v2 1/6] arm64: tegra: Configure QSPI clocks and add DMA
Message-ID: <a26g7pt3pll5d6jmkucdychrectbaa27ft65cuw7mrlirupx63@ijeqgow2s4ij>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
 <20250212144651.2433086-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4znkw4cymmoafvku"
Content-Disposition: inline
In-Reply-To: <20250212144651.2433086-2-va@nvidia.com>


--4znkw4cymmoafvku
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/6] arm64: tegra: Configure QSPI clocks and add DMA
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 02:46:46PM +0000, Vishwaroop A wrote:
> Set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to 99.99 MHz using
> PLLC as the parent clock. These frequencies allow Quad IO DT
> reads up to 99.99 MHz, which is the fastest that can be
> achieved considering various PLL and clock divider constraints.
>=20
> Populate the DMA and IOMMU properties for the Tegra234 QSPI devices to
> enable DMA support.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi
> index 2601b43b2d8c..0ac2d3aba930 100644
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

Other than the dma-names property which was already discussed, this
looks fine.

Thierry

--4znkw4cymmoafvku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfAQPUACgkQ3SOs138+
s6GgyQ//S5JgXIXb+r9r+GLX2BMYavKQT5LaHF3pKS453MqqbEXkhJX2/AH5w0yX
uPjL5JuS47HyBaey26DxbHmoKUwdaFOFmstOJCs8qmzeox34XrXOeZpeXr2rhBCF
y0Irvpw7HOvDGjYplqLur9NW+KQgOM6eJrGyes1Mc3hbVsUlWVFPNofN0eh4+aI5
b0nwV3+93VvLYjPwr6Zi9SbVt+pjdhj+iPbZym3L7ZV0qo8R+SZ7ON+cB4lf3QWe
dfC8FPNaD1dit/fOmpAM2BpPFBMnhg74i8kqkg8OqL2RpsjLqp+Tcm+U1TK0INiz
NIcXtdqbXhk8Bornqwuxq3pA9E8xrpfZTrClLRR+HdgyR6I0ad0BxHYwyEPy60ZJ
w0CzeZXlyjZeVaAqHPjPiY1e6oVAYDK0DqR34KgIiUS26XmliQgDGWdXQ5AcDLGe
Wyp0tiHwVyvyAvTuOgZ1GkpmOZkppo7KNm9dvANgjS8fvxJVv5EAyIGRKEz9a3wi
TtaUUFmBsZX9H8kcHAVs0mra5qLG6HTQ/tmu6wEQhf5jhNXYpFvCSZdfNgsOPV5h
G3xw/r85MPogzEcIfAchOGW7G91XVnPeoF3NDlv6M5X/xoloveFwmN9qiJriuknt
T2R+pHbXdKcvoKWnSJsV5aO55NzEjRRT4YHkV4mBD29AXM50LMs=
=zY8k
-----END PGP SIGNATURE-----

--4znkw4cymmoafvku--

