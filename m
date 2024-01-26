Return-Path: <linux-spi+bounces-878-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819E83E318
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 21:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A73E1C2434E
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8422627;
	Fri, 26 Jan 2024 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jrqy0iQa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B63224CF
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299787; cv=none; b=T6kWs4I/3gFxCanQWfZsAZHM1j7NAJclHVE/nvhYsnQPD7+mECzgZbg7BHHvVNs3ZX3sM1s1H88qtLDDr1ikYvqdEwvDz7z1ol+YM8l1IPwTSVppNxz24Xs3Adx3EDLMzclMjrNXAeAglhfWT2UH9egUQS5XMmtAIkaIA0XpDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299787; c=relaxed/simple;
	bh=26UmmMdUwHYMA5666/eDGLbOSATXZsruBdeY8Aig6Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2HBMvzt+DRYLEWI5oCjbY6Ptw1cRL0A1dwr4iPbA0+NkA1n6XvtHZYYcQuVlRjEhhk7hBo42+ybkHRPAFVPa+rIZ+NAKS2Uq0sy6x2XsyLUrHUXvDUaSzSJIs+R1czu1G92sdqgj63nf41vMjKgTnKRCZBq4WLxjICMZ/R0+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jrqy0iQa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d50d0c98c3so18228805ad.1
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706299785; x=1706904585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/1tKkzsqc4Lxn/B+1z+yYYxCGxfUQO3LjVc+R01ieg=;
        b=Jrqy0iQaweq3Ap/pZmCCNtWSZIUqc40SILHnDBAK9CnSNjtUajrLe/zlDEsDJaTqQJ
         fResHodY6jngc5ZaD8ahkEzw1a3WDu7g0CSeMsNQZs9ElA5Rm1elA9aWaOheD6Aej1DH
         4qorXiJ455bmbjdNGLVeYscD9wwOQurtTRUq5tTDM0swkgfFp4JbFjN0igfTcxkQymc+
         2ZMoh90oae4+To1y6tjnkBHvB+Gs23R++w9QXg1J7jA7gGqqTCntXz7jsaRnTFy2C7nL
         NvfL70C7Qw++urjurNNdJqSi8GoqEV42H4MFaiZFxddwzHNTpiUha42J9GmZrmqF60Zk
         LQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299785; x=1706904585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/1tKkzsqc4Lxn/B+1z+yYYxCGxfUQO3LjVc+R01ieg=;
        b=jVIWq8s1hG+Ad2iD2asAoV85Rlo7n/OfHe2CC5miTPFET/fzHs07JXf24eBobi3gLC
         /NE6tCi2QEu67ot5J6jSzNCTsWNWjQ71JZZcHywXgmzbNGBE67yrZqf5P6JBOidnt9HP
         xyiuj8xifeonwJhihccBTDpnzJ9EE1GCVf6prTwJMMkQiB3sJNMuV6hgONv+7P8uZoqo
         x1f2w3Y2Vt8GLyn/s43UMs4erkouKi6pJzIP9thd581GU3Id1Iv2sinxmgk9H6iWohIC
         u5qzL2JRIilBbnaNv0kfI/cZl6UmtfdPjzTJzwrJTa2QoqtSpnEkmdGagZQk3r7Aoj6D
         PwVg==
X-Gm-Message-State: AOJu0YxNh1AbFFBoJifERWNQ8aWp2yhX7dHL64RYO1CA3VZBu7gNoBDU
	/vyGyQrYidP6I53Pe+6LyX6uE8cwbPz5bFrBLqJqDZ8OMyEM87FzzJrFmsyIvA6GiWq4vvr3bXD
	sF7jIeW0VlFKvS/tPQ4K2aqMi/Dsr0K3PleLR0w==
X-Google-Smtp-Source: AGHT+IH2rs0C2o8K7YBb3nQFCnS/YduyrRBKw5z2DfxwWvlgOq59M+qY6wRCka+xar/JGAiMbqPHaDdfeJslVIO1cpk=
X-Received: by 2002:a17:90a:9f82:b0:28e:878f:9b35 with SMTP id
 o2-20020a17090a9f8200b0028e878f9b35mr1869586pjp.34.1706299785635; Fri, 26 Jan
 2024 12:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org> <20240126171546.1233172-17-tudor.ambarus@linaro.org>
In-Reply-To: <20240126171546.1233172-17-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 14:09:34 -0600
Message-ID: <CAPLW+4mZc84mt3E6VJWVJta9o0nKvk00-9vok9-Z80JU45ev2Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] spi: s3c64xx: drop a superfluous bitwise NOT operation
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, jassi.brar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:16=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
> val &=3D ~mask;
> val |=3D mask;
>
> is equivalent to:
> val |=3D mask;
>
> Drop the superfluous bitwise NOT operation.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

That's much more clear. Also I'm pretty sure if you compare .o file
before and after the patch, they would be identical -- another way to
argue the patch has no functional change.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index e9344fe71e56..43b888c8812e 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1089,7 +1089,6 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_d=
river_data *sdd)
>
>         val =3D readl(regs + S3C64XX_SPI_MODE_CFG);
>         val &=3D ~S3C64XX_SPI_MODE_4BURST;
> -       val &=3D ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
>         val |=3D (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
>         writel(val, regs + S3C64XX_SPI_MODE_CFG);
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

