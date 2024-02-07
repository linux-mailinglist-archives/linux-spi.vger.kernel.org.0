Return-Path: <linux-spi+bounces-1172-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD0084CE54
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 16:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242A0B21E41
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E557FBBD;
	Wed,  7 Feb 2024 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELlOjE0w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596F7993B
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320680; cv=none; b=Ul2spiMdOKuZ3NJi5ydtvctKDousQm1gfaW8HLW/THltpb8f+bkrvQG4yeB9x5kyizewKgf+gQBfkDQ7U/i6hBJBJNb+y72IemSMRCQvKXWthOifBp7E+XDhZh3HsRuG7M0mHKn2fOWe3rtFJcT9tKWs39ISSanFIHNZg187kiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320680; c=relaxed/simple;
	bh=hkvLvW5bir63qGmigcs+g/1lCwmcJeYVQAJXfmIzNFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCmxrqqpulamP3EZeNO1fuzLyMpUnOeqPaie93z/PjemANdkNelCHtjz/bKjgNfHtESfrvii15KdhSqNM9nxjbb+uE62dAHki0uxpfNBCSdeO2bTdKviVr0FxkjeOsF0PkuhrMQoLlMJ/5wPhr6gLuSD/IunWgC9cJNmnoHsP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ELlOjE0w; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-296dcd75be7so555317a91.2
        for <linux-spi@vger.kernel.org>; Wed, 07 Feb 2024 07:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707320678; x=1707925478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjM9X4mSlwFPt/1gwrjtYdpsyoYU4c7cfCOblUpLYMA=;
        b=ELlOjE0wWbwSKt/f2BcpxFm3rpijzImxHkj9nGQ8AI4x4GBlVFDRoxLbNchWSBOC0g
         O8S+6jcpFpdMA19jcPKtIYfezGgfNYmW0QuWvqeFRTDezY9T+gGG9c71LLmY/wGCpEws
         x+xQ+3+lrGW/9NkSaXqr/1xX11kbaqTBs3JRi8XavDC2PSaZots4iL8dHJBEcP95vUDV
         aTiSJbQ0PeuYWghvxZ+ovg6UhHXC8NsMPdlTyvJG3seWyGKtNNr4TS6Rw589owarxAl4
         pFmPbBkxRF7esKLP6o9Jk7MHddmLhP7kS2IVGkv8FI1ZKEpgHFjfAWNeK3fzqfytiKSi
         NuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320678; x=1707925478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjM9X4mSlwFPt/1gwrjtYdpsyoYU4c7cfCOblUpLYMA=;
        b=CvBHdlXOYj+nnBwGD7kCfQncbbeG4mBnw2zRgKBZFAO4hcTNTMDG6Qe428DauxCZ+I
         D5fZPs/HHNFksFNYTYrHnGJj/ZT+mWoT8aN+CMUKr9v+Uc9HDUteU4bapKZUeBbdwl+o
         /+uHu8OOpHSgJBwJH6TC+tlsEuOnbZNGKyIWhKgh0d8LWp183rA2lvX0HDbQ1muaV+88
         ukzqK6o62ohsSj1RgtHy6BgwoZfA3t6fczI9d9mwDnjYW7wHsmZiZy2vOJgKqcBd70KF
         nDGA6wBmHa38eaqZLpqXF3Ko0cPrkpmSSRqn0xMUuIWTBiG24Erjiv2IE+DGFU+bkANh
         /0tA==
X-Gm-Message-State: AOJu0YyUus6yYt1IMjoiCtq0mpukqCWj0ZRsrWS4/5KOwD69jqayqYIp
	IcpJiOjzEF5O/fdufcqhwWv6mNoY2EhzENglk4XLBY5Ap/2oRi5aIj+i0vzJgt2HJPKP2taRxLU
	QvCh9VnluyuSRR5rCbngXgzAkrez8ju5drZg41g==
X-Google-Smtp-Source: AGHT+IEOlo/KPrp4YPJuYvFD5Blwu/nidyNMltgHO7/0dpAc6+9Bv8bsnV+2FJETRdJtJxCs7qFvqtu+bC4a80lxed0=
X-Received: by 2002:a17:90b:4c85:b0:296:2057:28c with SMTP id
 my5-20020a17090b4c8500b002962057028cmr3040845pjb.31.1707320677939; Wed, 07
 Feb 2024 07:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207111516.2563218-1-tudor.ambarus@linaro.org> <20240207111516.2563218-3-tudor.ambarus@linaro.org>
In-Reply-To: <20240207111516.2563218-3-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 7 Feb 2024 09:44:27 -0600
Message-ID: <CAPLW+4nyYxeZcvmrK8FJ4cvpxOs4=mPzBC5JcCPB5yNBNqkVAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] spi: s3c64xx: prepare for a different flavor of
 iowrite rep
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:15=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> There are SoCs (gs101) that allow only 32 bit register accesses. As the
> requirement is rare enough, for those SoCs we'll open code in the driver
> some s3c64xx_iowrite{8,16}_32_rep() accessors. Prepare for such addition.
>
> Suggested-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 7f7eb8f742e4..eb79c6e4f509 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -414,6 +414,26 @@ static bool s3c64xx_spi_can_dma(struct spi_controlle=
r *host,
>
>  }
>
> +static void s3c64xx_iowrite_rep(const struct s3c64xx_spi_driver_data *sd=
d,
> +                               struct spi_transfer *xfer)
> +{
> +       void __iomem *addr =3D sdd->regs + S3C64XX_SPI_TX_DATA;
> +       const void *buf =3D xfer->tx_buf;
> +       unsigned int len =3D xfer->len;
> +
> +       switch (sdd->cur_bpw) {
> +       case 32:
> +               iowrite32_rep(addr, buf, len / 4);
> +               break;
> +       case 16:
> +               iowrite16_rep(addr, buf, len / 2);
> +               break;
> +       default:
> +               iowrite8_rep(addr, buf, len);
> +               break;
> +       }
> +}
> +
>  static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>                                     struct spi_transfer *xfer, int dma_mo=
de)
>  {
> @@ -447,20 +467,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_sp=
i_driver_data *sdd,
>                         modecfg |=3D S3C64XX_SPI_MODE_TXDMA_ON;
>                         ret =3D prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
>                 } else {
> -                       switch (sdd->cur_bpw) {
> -                       case 32:
> -                               iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len / 4);
> -                               break;
> -                       case 16:
> -                               iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len / 2);
> -                               break;
> -                       default:
> -                               iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len);
> -                               break;
> -                       }
> +                       s3c64xx_iowrite_rep(sdd, xfer);
>                 }
>         }
>
> --
> 2.43.0.687.g38aa6559b0-goog
>

