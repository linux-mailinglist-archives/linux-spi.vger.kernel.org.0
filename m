Return-Path: <linux-spi+bounces-8009-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E62AB049B
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 22:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9331C4C6D7E
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704728BA9F;
	Thu,  8 May 2025 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrconPu9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006C1E1E1D;
	Thu,  8 May 2025 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736079; cv=none; b=rJmC8v7BUBXn/GhGXO/wtn+OKMR4S698mhzbR2gJFiSRmhgqI8xA074p3R5M0uszTMV+7WDKtnsKcokYzQbkr3sNitjnvJmQY4De8Zd6p1zx1O4wGDLCGZ6T1cfOFGPGXS8oDolbJhGKnnbFShUCrk7uSLwvWd1QccheKuJkweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736079; c=relaxed/simple;
	bh=IWqkUmC/HtU7UDGaSHEgVSzn5B33kawytOqertPrlMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M20SYJcCNeA1hNbTHAPTuNORkPGXSbf0Pe71XMeO8CFFGamUBY0VI2nu+3sr97PDcNdlbn4sINEWpW4xUeuXHrHbKxWp5SfP0b7fYgXjmxCQLYCAqo1GXkHqT5CUhlrvKd99Im/sdB3IO6GponEPtc1PaFqInWZErYNLW+Hig0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrconPu9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso10641275e9.3;
        Thu, 08 May 2025 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746736075; x=1747340875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtJQMxYGFNll0psACjnIjhFMP7aU5XrgGwRcy9F2bBg=;
        b=VrconPu9L/7ItdTaAtknvjg6rmV8QocFh0yjVYp+z/PXrdjhFQPKXzrYXYWw/nz6o8
         MioM2Y8yADLc3uKEc9FFbo6Tktjs25zqUhUYYh5KIEM+wNas6vo69voEIdnv2jQaLawM
         3X3sRhFWrGssFcGYNVozPVtuH9eR0k8wcSGshRT5hm3Z5u4kXnD9yxQQ4TXhW9DtYlxP
         TWkX3/Y/W/zKM2ECiJNWYrdS461iyJ4SAEe00hk4Ai+vthciOMEXl2/V2c/NY6tTjwyH
         WSOzyu8gXentgMdNCmm1GIcsPeSFFb/eKV+FkTMtd3WafA+GrKWA6sUEjcZ/NWeGTGFt
         hmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736075; x=1747340875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtJQMxYGFNll0psACjnIjhFMP7aU5XrgGwRcy9F2bBg=;
        b=AXS4/I6oQTmldKciO6WAxTiR5jW7J9Uct76PXDoDz6aPB8+mw4eBKWXHdmKnVIXF6z
         JXXr5YQJd/ymE0DrYkkGkdMFIf7yECi9BRe5JcQieTk1xAcwEfWp9Zd11oNEjQqRXQQd
         /BYWD7ep12kBwFTMlwsDBeZyDYFtzm8cAcEIPBlhf+NNNSAo26lfHYVp5mOibz9BNiRZ
         DYCUIDGzFRKeS6tqFCOqQQ5r73/orb/iiLKgoBlfZ6FjrtHvvesMNHvMps01b5+K8OIN
         zSkflH0DWeSM6ESIMM9Wq67kyQM2i+rDaLjE3Tr6bKiET0yU3n4sF30DPcws6zaVwzJh
         ufew==
X-Forwarded-Encrypted: i=1; AJvYcCUa+UnXnJn5VwBgNm3lpWnvqUFbM3TNrB1nNskWCRCCxoCnOVwA8Kd9E17swNvb/QhgjW7wjIQIBUiT@vger.kernel.org, AJvYcCUaVFFm1N5t7G118QiRSh1YQQbpEFGsn9J1BiP5i0hTAFJMVRr5cqjpU1gYTjVg6rFR8sA0rtVeJ1jvCl7M@vger.kernel.org, AJvYcCVlNbpqi+ST5UHvqxBY6b3m+rV/Rux24gR9rTXBJpP6o67Co751K0NriX9j0wWy5kWNmEWElAMsrnNQ@vger.kernel.org, AJvYcCWetnK1wQx1G9+ct3XUR58H9naA+9Czayuu1QCpst1sstYdinKhRgxYYtpenynfLujm9y8oHAQxHG2FsRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+WurefoNjbDuRPdzcBDiokYPe5D1BQNJBcVSGWj9TCn0VO3o
	h2gz68X+IcHGsBninF26TJk5b23reJuib/dWcZPRC66SvAcWw3pIj4c7lA==
X-Gm-Gg: ASbGnct6a6s9kjKZx7S80pD2TYVuyIL6+qMgpINTgwIDEqC+VZ9wF5jpJcBkPR+1lZ5
	VjFbHME3COQY9MFkEGERK46SSq/FhlTG9QudAKlceRALILnm1UnyXNaACNcqqNwMF7XzogqtKWw
	lB6MdLrEnN1Q5okcTgj0LwhgPTeScAPGoeRQAepam1kSnzw9S1vhTdkuHZARL2oXJXix7UlkLlb
	k4VEiXrmsY/danYDeQf9f1eUzTwgjRHZeYXel/ZaQxT0KEawXmdiYjF9TR0BFzgceMFSC3dTlwt
	rLop//AdNe3rmQIFIRd1R2q7fgeOYe+C07UHMileVYGefbDC8bzysnXPGpHyEdqKShn2y9DAji+
	v2g3uXCsmqjVefgTFOhwFsj++GgM=
X-Google-Smtp-Source: AGHT+IFnWjQ33MMtDxBoEYIvCnklurS8mH7kZx1CC/YeUHC8q6GxC44TL9JcvWZRp5envBhfwaWZqw==
X-Received: by 2002:a05:600c:6819:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-442d6d44db5mr6188455e9.13.1746736075099;
        Thu, 08 May 2025 13:27:55 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aecb0sm49042075e9.28.2025.05.08.13.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:27:53 -0700 (PDT)
Date: Thu, 8 May 2025 22:27:51 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jonathanh@nvidia.com, skomatineni@nvidia.com, 
	ldewangan@nvidia.com, kyarlagadda@nvidia.com, smangipudi@nvidia.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/3] arm64: tegra: Configure QSPI clocks and add
 DMA
Message-ID: <lvzu2huonk6fm7ce77xej7kiwqtwupvbr7ilpn2yppq2cmtrnb@jw2ohtmicprs>
References: <20250506152350.3370291-1-va@nvidia.com>
 <20250506152350.3370291-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gvljn3izqgvhquae"
Content-Disposition: inline
In-Reply-To: <20250506152350.3370291-2-va@nvidia.com>


--gvljn3izqgvhquae
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND 2/3] arm64: tegra: Configure QSPI clocks and add
 DMA
MIME-Version: 1.0

On Tue, May 06, 2025 at 03:23:49PM +0000, Vishwaroop A wrote:
> For Tegra234 devices, set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to
> 99.99 MHz using PLLC as the parent clock. These frequencies enable
> Quad IO reads at up to 99.99 MHz, the maximum achievable given PLL
> and clock divider limitations. Introduce IOMMU property which is
> needed for internal dma transfers.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I've applied this now. The remaining discussions on the bindings patch
are details about how to deal with IOMMU on older platforms, but this
patch in isolation is just adding standard properties.

Thanks,
Thierry

--gvljn3izqgvhquae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgdE8cACgkQ3SOs138+
s6EMIRAAliY7GR+xDac7+0PmuP71PKaV5MtA/YTnq/5d7xUbjCtUfR7kXzjUzqKG
mWKbwmdx75U2U3ATorGUa+pTK0Tj9Ews2blJx+K+alww20/MGqKY4wHQTbjZW9vq
EsBPJ3p4LLL6gtmf0NBpPBCjH7dJYCCLOwAUeRV62QKZ4qv22TBlpfS+m8Ff2zPc
JCCazFWMajzIBafGZ+N3p9pqc5W7mcHppFOs+46fX2dCvjTkEBLkCbQqx/4gJBPO
+eIdhJSivuVN9KSuShTsVC3WnCvIF/HCqFRvrj1X3gkxGCS63N2jmyr1/B5z8WnD
x4l7hfdJ87WhQtpiN8/AZUKG7T9jCg4RHsnTHzC55DlnMR08DitjaCmH9cQGamm+
YEJAPlmlwf4ArUr9JR3FC2Ol8hBM+J8Jo7P7RI8pIi7ZSPTc0aoFTDhDFsu3HOYi
pr3zndqEm+Em5AXP0WAJ2qUDIF6/FyuDGy8hH/6Q1ppF6Je5UMHIf0rIFryGQL/x
gGTweqx8CgtG7/I/nYW7NwsRiTgzHmnDzoFXaMt7pNc6r9P3Hs807cAnkPllG1yo
dOuhedLJq2pNKVSKC4JTGak66uJyij1VdbzeR7irooiAZ+vpKCvGP91QKE09udiD
btDZrdgW8Kwl+Sg8OJvRQXMp1vCTXJ9hZAP2XToxNWC7ckfz9VM=
=wjHe
-----END PGP SIGNATURE-----

--gvljn3izqgvhquae--

