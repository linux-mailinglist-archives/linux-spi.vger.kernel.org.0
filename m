Return-Path: <linux-spi+bounces-7996-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2314AAF817
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 12:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0372D9E2680
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600232367A5;
	Thu,  8 May 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zor5QPT2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89333221FA0;
	Thu,  8 May 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700473; cv=none; b=VJbCeDqMoyrjy2PISPQ9GoBNqJNwRxNzkEk8ag+oOsdODWnmhV3klhG2VMrSMXwQpc70rTs7Zmp7p4UnkjqPkWNcpY5Z9onGX9ODS4cZLvhGwv1oBDrh+aHcxZe5Zq7YkppFY9uF+2jru47YA44nnTRYYCLucnFjwLaPaYqh5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700473; c=relaxed/simple;
	bh=KuKPBoDjHDPZ4zNZNAc7e3c9x+J+qxdFTx8dGtAK3ss=;
	h=Message-ID:Date:From:To:CC:Subject:References:Content-Type:
	 MIME-Version; b=nVG3BZdpnqMt6kNBIvi3R7TmN6Bp2fmhh5JZ/TVDAF5ZEPlJ8kfU3XDIpiEAFQplYVOjlv93yxiUiixrR4+ktyG1KSNkyWqOkfV0GgOLMZy0sXr7rJCDsH2D/yD1LFx66R0ilvjwBcvjrHauxy8QPSNzGLkAsCpWKrMXyO4uuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zor5QPT2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf680d351so11064265e9.0;
        Thu, 08 May 2025 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746700470; x=1747305270; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:subject:cc:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xizeysbD+2cKLonCxb9Ikg/JQWMKPiH+tr5vKFbIOfM=;
        b=Zor5QPT2m5SKi6/mOJ61pDqc9bqaX6SlsOKripywQ+UZ4EinkQI27MI8eSfvYP6/8a
         qr1UhsuCfflC5vwlnvVrT07eVx7pfJ7NGYTtF0ZJgAe3tg+shKJGcTHd8u+gCK++uftP
         Kq4nd9A3tDxH7XMGdnz9ZluKNy661YH39LaumWZMazVKLZc57DNV45Eq7HGMzGgSY3vz
         oKetOV4j7Q/BXvIwrfhfHL8vVNtgA6sekI59pM8FM44m7JOoNXbjRWnCnnRwu6DqBCCM
         DVMobZq0/OgAUQGWuf8RarqCr5/e1yA/wD+wWLYpFxtVpp0aISn/yXrn4icyAUyPJJKr
         cf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746700470; x=1747305270;
        h=mime-version:content-transfer-encoding:references:subject:cc:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xizeysbD+2cKLonCxb9Ikg/JQWMKPiH+tr5vKFbIOfM=;
        b=qO8IwWV1hA4V5PQ5i0zJN/ZWHhhbk8HQXc9o44V/liBlJz3DzPpyulz420VWSiM76q
         MuUx81eo/eecwdPVe1GvyFyKphZm9yJGqzKy+M/Zo+mcGVIN3qxY4hev5tYD5TsOgHOF
         uwvvnZKRuxNleXDeksmnUWmucAz2ALgjZGN0Psk6sIl70UES8Y3KbG6L+S+sZNgXl1C7
         HMl07DOXu9ZK28CAlUp047c7PbDn+ek7zOJq70LoEBAqLhQ6N+5f9QjCbN0bliVTOOnL
         lpheYlVqc3HPl2cD7iYB4ONeTXKizd1FFRfkAWG5DRx4Z84DP9owN9+sOZjVO5YAvDTR
         MZcw==
X-Forwarded-Encrypted: i=1; AJvYcCVFVMeE+3vYPTdEIVGqsUlEUQtmdkc0mPjau850sXJ2p+oz0Od/y+7NKf8AW6alGF0fPPW8BT0xCO9yev4=@vger.kernel.org, AJvYcCVpZeiFYJIiIO22jrdUV0DsiJfzibAeHLXO2+EB0M+XLsNay70oEwCpUuImdRKGerTUXfwocSUm@vger.kernel.org, AJvYcCXKQAH1AVA890mwyd3l1ITcuVwDFWK7nzaHOoRA8q5BWdRKXFtMgAG2mN3/9RrpVCb4xPL3RwazTowz3eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXJWoT1OMmw52rqVYm9EAVY4o/13mTrQwm3hyP4YNApkfO1Ek
	pwyMyaemb60t3pNfIPQN17fR4UTcHJlcLg70aA1Jzl7CTWUoMwuKO8mi4g==
X-Gm-Gg: ASbGncvYdyyDWexakk0Pw2rxX0FizyhOdwnYsdG+jbtbRIMRqVVYTh1OmeBgYSfLAoV
	99KY8NKoxw0hXMx+vN1MBXBQjgf+ZGw2UtMtqmrlFIgOP6kpiRXtv4+mrmCAZGvPS892iLJTyxB
	iRFNdcz7qXZhhExr4TZkZjjQ7BcAF0KsvHs+cgBxw2We00Tv5y08g1T3PXeYjWzBG3Dqjl4nyUd
	6KJDsh14FCL5GRAOWo6GKQ8qe525ABm0WKQNk6aF9vo8v5h7sJLPU9RF5+r2CoOhnVbdqF0CI7h
	6tWLqRDnhFr8XdQZ9xHupPrMQtJ7pVda26FD3id8wg3vrl/m2fafciSxazq2
X-Google-Smtp-Source: AGHT+IH0a9roXZBmBGMXIYr5UBAYL9NEGf0Evua2N7Ei76fP3u0l/UvqfgyhZORZuaF/Pyun04enog==
X-Received: by 2002:a05:600c:818d:b0:439:9737:675b with SMTP id 5b1f17b1804b1-442d02e7047mr27334675e9.7.1746700469388;
        Thu, 08 May 2025 03:34:29 -0700 (PDT)
Received: from red.local ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a0bc2e17a3sm1668728f8f.62.2025.05.08.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:34:28 -0700 (PDT)
Message-ID: <681c88b4.df0a0220.27ca51.39ec@mx.google.com>
Date: Thu, 08 May 2025 03:34:28 -0700 (PDT)
From: clabbe.montjoie@gmail.com
To: ldewangan@nvidia.com,broonie@kernel.org,thierry.reding@gmail.com,jonathanh@nvidia.com,devnull+webgeek1234.gmail.com@kernel.org
CC: linux-spi@vger.kernel.org,linux-tegra@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org,webgeek1234@gmail.com
Subject: Re: [PATCH] spi: tegra114: Use value to check for invalid delays
References: <20250506-spi-tegra114-fixup-v1-1-136dc2f732f3@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> A delay unit of 0 is a valid entry, thus it is not valid to check for
> unused delays. Instead, check the value field; if that is zero, the
> given delay is unset.
>=20
> Fixes: 4426e6b4ecf6 ("spi: tegra114: Don't fail set_cs_timing when delays a=
re zero")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/spi/spi-tegra114.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index 2a8bb798e95b954fe573f1c50445ed2e7fcbfd78..795a8482c2c700c3768bd50bf59=
971256893a486 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device=
 *spi)
>  	u32 inactive_cycles;
>  	u8 cs_state;
> =20
> -	if ((setup->unit && setup->unit !=3D SPI_DELAY_UNIT_SCK) ||
> -	    (hold->unit && hold->unit !=3D SPI_DELAY_UNIT_SCK) ||
> -	    (inactive->unit && inactive->unit !=3D SPI_DELAY_UNIT_SCK)) {
> +	if ((setup->value && setup->unit !=3D SPI_DELAY_UNIT_SCK) ||
> +	    (hold->value && hold->unit !=3D SPI_DELAY_UNIT_SCK) ||
> +	    (inactive->value && inactive->unit !=3D SPI_DELAY_UNIT_SCK)) {
>  		dev_err(&spi->dev,
>  			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
>  			SPI_DELAY_UNIT_SCK);
>=20
> ---
> base-commit: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
> change-id: 20250506-spi-tegra114-fixup-dbf6730db087
>=20
> Best regards,
> --=20
> Aaron Kling <webgeek1234@gmail.com>
>=20
>=20
>=20
>=20

Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>
Tested-on: tegra124-jetson-tk1

Thanks
Regards

