Return-Path: <linux-spi+bounces-817-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFE283CD4F
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 21:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30C31C24C6C
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 20:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F0137C4A;
	Thu, 25 Jan 2024 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aA34IaJ5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043E137C2D
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213999; cv=none; b=XG90BFlE8QCob/V5khmnHlrIXks/97SQbES71bOArsZ5pfGz03oQaXhcxCCVwkue1rxm0uvEO66BaSbiFrXbK9mXW4jjtlAFutOH/YW5sn+GOjl9f3nRqX5epfyMuGfsRj7WYbEMkKsiJyDNJS5MUALU0NSiE6xlUorWUx3aH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213999; c=relaxed/simple;
	bh=PhI9LW/VlbekrhSAPPRbJUPp4nixxFeRGjHAOy1SKHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmUmPh4tnC9i7PVdAtiAR6R0v2+x6yU4EziNWQryxHvAkCPt6ZVrjPtH9oy8QHCaEMCn/CNWFkXEVNcHlM37egOdUrYOgKZWGNV/LT1/bqnYP6dPGfV+K+4dvmhQkW1J78isHnGBB4LiCwCDkqgLVnEXeqKiAlZvhcdjZOPMOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aA34IaJ5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d71c844811so38939385ad.3
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706213996; x=1706818796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AMn0y6UWpR7xw27jljzDWKtm5PPL6Cu6Mug2W0VcTk=;
        b=aA34IaJ54qmnN4639ntC0tBaqILwKLtWGgrubPDL42t7BoVYBjeWxUYWALtJ61N5dC
         3JhqHizcKmyiEjULvkyUaQBVdkxCRxx6Bk3CvgNgnSrJfeUmXMBfmdwBCtIxZPb/9bWo
         Ei/vFFMofDL+pP/fP90jLr3MsrZkTiRcClsByswP4HWxICQKZPP+ZYWLhSzb7MruJErZ
         HJDYCLuen6vJzs+/qlFZchYBYCHK/Gu15yOlA098gCZQY9wP/L4akPdFMbWAokPpzzbP
         6uCqxY/GXwlRkficGYt4NTcIYYQtwJEmzP5V7GfMzqvvqakLX8aUMNKIhmdvzWBDc+GO
         MRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213996; x=1706818796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AMn0y6UWpR7xw27jljzDWKtm5PPL6Cu6Mug2W0VcTk=;
        b=klqOg8Ao1xAkK4XCIBu58h8mXr82SeCeO1qK28O/hBxM2aRU5s1JmlPpPuqBtsfCwS
         5rE0eMUJmwfoVY1P52xVGhEiAR0MWPAGWU0ydPFUXcDW9h5BW6jkR8EIoC63yetiOTMl
         eVcC3oe/uvv60L05LmLEyBOa+XNlWXWhDsZJp7ypmC23vpq2lSm/yacLjMnCwqwzmpHx
         QoCv0ASBx55yO+Z0UqgXro7hRz4SuRMtUX13ehzc7jBa/XWrJ2zZu/DdWPqvM9E1HCvV
         tGbDsTGpPn1BPLPoJ0nqrVD02coretbZ4vZbrtzl8vbj0gnP6cOJrHSSdbRNqKNnXUEB
         KLsA==
X-Gm-Message-State: AOJu0YwukKZjGx2mKJLovpcdz5xZpWk3jCX9S4Xa9TAekGC22O4s26Hg
	aQDvfaidRwZaI/SVr4bONPN2e/FTFqy0DSJ/EURo6909tJswMU6DMp0XIG1nw4h9X8LD03HFMNf
	Rx0vVmmqjxmuyva8hHiPXV7+aL4YlTG31VMEQrA==
X-Google-Smtp-Source: AGHT+IEDlNMo5aTWzDJycnq3U1sMwSmzGwmT5xXHVku5Um1940OW4HPZE75X2sbisg5ytxzRxcqd5yUDHa1l+h1tjfo=
X-Received: by 2002:a17:902:ecc4:b0:1d8:94e4:7718 with SMTP id
 a4-20020a170902ecc400b001d894e47718mr262595plh.114.1706213996125; Thu, 25 Jan
 2024 12:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-13-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-13-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:19:44 -0600
Message-ID: <CAPLW+4nW1LyMT2CGD7R_oRPtRgNQiyUjjUqZJYTAJ2HJMW9yfg@mail.gmail.com>
Subject: Re: [PATCH v2 12/28] spi: s3c64xx: check return code of dmaengine_slave_config()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:50=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Check the return code of dmaengine_slave_config().
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 107b4200ab00..48b87c5e2dd2 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -297,7 +297,9 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *d=
ma,
>                 config.dst_maxburst =3D 1;
>         }
>         config.direction =3D dma->direction;
> -       dmaengine_slave_config(dma->ch, &config);
> +       ret =3D dmaengine_slave_config(dma->ch, &config);
> +       if (ret)
> +               return ret;
>
>         desc =3D dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>                                        dma->direction, DMA_PREP_INTERRUPT=
);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

