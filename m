Return-Path: <linux-spi+bounces-1058-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1F849ECF
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 16:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284D8B2127D
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1D2D608;
	Mon,  5 Feb 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iP4sVD7h"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADB376E1
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148405; cv=none; b=FvKal7NJvSo7SCWAt6GkSi+ir5nESmI+tBF8Ij0kgW7rDrGcnRyAMb6w/Nn++i3knJbISWexfDEAGbsECofrNQjSjuz0+7/1XDpMjp1viTXQHP2ZHXPUT1tCP+Y3qvVAWMSsl1RiuLsZXa6nJS7inkjuCkYCMGdJDdDMW13rVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148405; c=relaxed/simple;
	bh=Tj/tSyznD6niSn67AzAu0cOFqdiubGqC2gQgO7+0PPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAxFe/hUanMzaY8tGL85EituX3McQ/9DZIZgcepxAa4uB6eb4wDqy/d1+6yOZXlWE7byeevQ0NyyjPJXsDg2DdIn+xmbqZvgwnoDPcAaKKkzoxtLOJrhwOQQHENWSLIlqHiYSc78n3crDL/Y+VdegYg5IUo/D9phUdNqco3Oh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iP4sVD7h; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4082849a12.0
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 07:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707148403; x=1707753203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKMXANMb2L0d4cSkguf2jw1WiTCcS41jyvz5JuSTL3Q=;
        b=iP4sVD7h7Lpr2wvcPYz6y0GbWFJelJ3+aAe3FeRtzyWsY0/c0j2zUtFOEKclalXZ09
         q282t57sGhCT52qVfKCNm4cl61+tdCGlDuVQytigyLcgoaIb5oxqZi005reA1RJfFcma
         dd3ginGfpxwH0can8qIXe0CgRifQrPZ5+bDxXRS2KikU5AXlfgKy/mQNjx5TLiDPmCfH
         hfCKG8nfmoCf3MlL4k0OjheUoLR3mPV8NDnuvRrr3wU6o4LhUkWmN+0iFQvpP+5aGr6J
         a+zjndPPIhWWzBhOf5H0gwBxrpQ9GaQodusiyFpYy8I5ImPvfzN+mZJIuYw65zus5c98
         nQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148403; x=1707753203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKMXANMb2L0d4cSkguf2jw1WiTCcS41jyvz5JuSTL3Q=;
        b=CG2EJR0PC4eZmiQUIrld8w0atjytH4yPIbg1s5GxfEgCpX1S5bofLuvrbVYuBhP0CZ
         G6uu2/o+ugK4c2kZq2REv+f+ak1qECer9VfrVCqGXlhiRG60n1WmY1aF3E15szL5x+fd
         dSq66HLQb7c/cjutr+U9ZWFe2Yb5sbJPfuFukSCmjOMzNoCMWm0akaiD8fL8Akot87gy
         uZ2z8XZKEY14J1fb7flHc0VLM96THt2VJG5vEV7dp2i/VJGTI9YY2Z0EDgTQf0hmoqEz
         D8djqsrS2R+gk5gbkE0zMc5qmsO37osNdPMGguR/cnXUiDf95jL7aEg2UNWDnkPLyM1q
         32/A==
X-Gm-Message-State: AOJu0Yy0ZRdsYPGUaX5uzkF1tIhCwc4IEsq0TBfUW9neGTIMy3EFRMvy
	tRcVivONZ7aF+diq5JchP69bovvhSBqRtbiL7n3RfuOGEjkyk5Z+MhF2w5aGg0BvCRh+t0O5jkn
	iEoDmj7iue7AaQYPBaHbkWeN3U5i95TFhmNZnoQ==
X-Google-Smtp-Source: AGHT+IGiQ8mgXBzzUxrLOOHInjCHEUGgvmdllRmofPYa6NtB9hGeupI8S22TOVaYwtQCQLIyLsSLsY86I4vrGeoUsvs=
X-Received: by 2002:a05:6a20:c891:b0:19e:4ae5:730f with SMTP id
 hb17-20020a056a20c89100b0019e4ae5730fmr57615pzb.30.1707148402893; Mon, 05 Feb
 2024 07:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124513.447875-1-tudor.ambarus@linaro.org> <20240205124513.447875-7-tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-7-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 5 Feb 2024 09:53:11 -0600
Message-ID: <CAPLW+4=S7+ur0Csd-qQcEBo2_Z3Dy9ZtarYY0=jYhY33kc4WDA@mail.gmail.com>
Subject: Re: [PATCH v4 06/16] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:45=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> of_device_id::data is an opaque pointer. No explicit cast is needed.
> Remove unneeded (void *) casts in of_match_table.
>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index ccb700312d64..807270ec3c8a 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1512,31 +1512,31 @@ static const struct platform_device_id s3c64xx_sp=
i_driver_ids[] =3D {
>
>  static const struct of_device_id s3c64xx_spi_dt_match[] =3D {
>         { .compatible =3D "samsung,s3c2443-spi",
> -                       .data =3D (void *)&s3c2443_spi_port_config,
> +                       .data =3D &s3c2443_spi_port_config,
>         },
>         { .compatible =3D "samsung,s3c6410-spi",
> -                       .data =3D (void *)&s3c6410_spi_port_config,
> +                       .data =3D &s3c6410_spi_port_config,
>         },
>         { .compatible =3D "samsung,s5pv210-spi",
> -                       .data =3D (void *)&s5pv210_spi_port_config,
> +                       .data =3D &s5pv210_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynos4210-spi",
> -                       .data =3D (void *)&exynos4_spi_port_config,
> +                       .data =3D &exynos4_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynos7-spi",
> -                       .data =3D (void *)&exynos7_spi_port_config,
> +                       .data =3D &exynos7_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynos5433-spi",
> -                       .data =3D (void *)&exynos5433_spi_port_config,
> +                       .data =3D &exynos5433_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynos850-spi",
> -                       .data =3D (void *)&exynos850_spi_port_config,
> +                       .data =3D &exynos850_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynosautov9-spi",
> -                       .data =3D (void *)&exynosautov9_spi_port_config,
> +                       .data =3D &exynosautov9_spi_port_config,
>         },
>         { .compatible =3D "tesla,fsd-spi",
> -                       .data =3D (void *)&fsd_spi_port_config,
> +                       .data =3D &fsd_spi_port_config,
>         },
>         { },
>  };
> --
> 2.43.0.594.gd9cf4e227d-goog
>

