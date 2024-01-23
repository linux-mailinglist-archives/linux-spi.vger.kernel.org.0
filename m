Return-Path: <linux-spi+bounces-630-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F39B838F7D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 14:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD42B27F96
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F35EE93;
	Tue, 23 Jan 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MR33zzv1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EEE5FEEE
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015421; cv=none; b=bDvImrkg7wHyHX21/JnyJgTbxdlv+LuPv1i7aLXFWfvipZW465jl7ncZgrj8XZb2iRtlZDF64GuPHnHAZlAlXQblq0iOEzQHCBR4wARx+bOAmwZ+GTBxPM2X504T5VPw/AnQvFDBaUuR87dahU/jUoUv5MekOd/uhh0MnyE3Hcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015421; c=relaxed/simple;
	bh=S8Dj3R8prRqV+AGEE3+JoAYYKm0kKP9XmwiZ7qnLb7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrgPTwKC63WijsGBcvRbMb4JY55MOle+kPzIurlyVrnF/XAFWQafdvM+DlYdbjs/moks5NPWCunGuhgvulhdjtj1n+Krs8FPnILKj7haK/VU2nLecxO2+sIyclDPkgg7mcxjQ90jniyJCffS7ZQFbxFHTCHsZsagHPTPQ73xJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MR33zzv1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f254d1a6daso44230017b3.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706015418; x=1706620218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClWdOeIIsl1FRVjuiLa2Y1YzPPvokp0yG8BguuXnqc0=;
        b=MR33zzv1dMLfOlp2DyTnpO8VSm44CSkBBMt8RazjoKHX03SNdOib5O3TQz2ZIR1PwV
         kbJSOOHl8q1MZQ4mwxHksEl+4RHE9M6TfgqCihvK6zEiYUQImxxnFuJnJx4HWKBITgLn
         XJDPWzi7z44a4mYx2dcF8+V/0uyrUoaVLNizJhys8b9ajq7V3PIqM7UM4x/OM5iPyP06
         uF4PB/Rnl5qO1UI0jxAVoMNW5+59UQTVc4gcaOpZrZneDWzgZohKSH8laWUlUNXl7Bmu
         eF+DfZQ0JDYyNUfR/z4TP5it9t4BQ/3q55ejAwNCPhVQIU5zZdHUigE7wT5nBxGp/hAk
         KEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706015418; x=1706620218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClWdOeIIsl1FRVjuiLa2Y1YzPPvokp0yG8BguuXnqc0=;
        b=PppfIvki+GaWmZXp3WkftxH4u/py0BIcSeDh+QqT5/IdYcelKKZLaelBkuar9ZPjXX
         ZHG/x9lKo1j/R+xiVHP6XxRxIb6FoMiuTfF6QzpFplvKqCzmjXECSU2DeyHFiK5WRUQK
         /rJVWK/ZxNkSOky7o3Qh5wMF73+9kQRU7uFZnG/Ye8m3POVBQ92n3xkQvNGOm09X2o9Y
         h9gVNBXCVwEDNCfIPuN+F4KlFqHovy47rye2E529GIzulavVHiaZJv+wPZCWDXMQbioh
         MW1LxdAYt2K5Dfll6zP58k1NNqO4McvOt+WFBWEn5cCprpAek3+IiNPS9oXoGSx9vLXc
         oWvg==
X-Gm-Message-State: AOJu0YxOvFGQJrSXV8VLDDdct8dt1sq9eNSLLBLZgFIwVytBQBWCge/C
	j165mP4nGYlht1m/X4ZYHP1jFBg1EzNv1xvAIVTdrNkbHC2w6xJmXcUlf2hGlxdQNuPe7Yq2tW5
	e83xB202YH03kno8SrPLtcKagZX5uSp3uY6fYDEN6/DPglymRYqg=
X-Google-Smtp-Source: AGHT+IEB3Cxo0INGCf0y2wXya0QKY/fgxTBzH8Ng/kwVYdAssiWSk0LizxhqKtTwMuP+AZRocKYHManbRbjqV6LExu8=
X-Received: by 2002:a81:8306:0:b0:5ff:4281:a6a with SMTP id
 t6-20020a818306000000b005ff42810a6amr4578656ywf.8.1706015418575; Tue, 23 Jan
 2024 05:10:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de> <13ba99e2578d4448fd85f516fbe328f5d05eda05.1705944943.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <13ba99e2578d4448fd85f516fbe328f5d05eda05.1705944943.git.u.kleine-koenig@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Jan 2024 14:09:42 +0100
Message-ID: <CAPDyKFr8=4=qWM0AR7ZZ-MyGUH+kLZZRWhVE4vu94cZqB5jxnQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/33] mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yang Yingliang <yangyingliang@huawei.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 at 19:08, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>
> To be able to remove these compatibility macros push the renaming into
> this driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

It looks like we need a decision if this should go via Mark's tree,
the series altogether - or if each subsystem maintainer should apply
each patch separately and postpone the final cleanups.

While waiting for a conclusion, here's my ack.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_spi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index b8dda8160c4e..bf35761f783a 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -935,7 +935,7 @@ static void mmc_spi_request(struct mmc_host *mmc, str=
uct mmc_request *mrq)
>  #endif
>
>         /* request exclusive bus access */
> -       spi_bus_lock(host->spi->master);
> +       spi_bus_lock(host->spi->controller);
>
>  crc_recover:
>         /* issue command; then optionally data and stop */
> @@ -967,7 +967,7 @@ static void mmc_spi_request(struct mmc_host *mmc, str=
uct mmc_request *mrq)
>         }
>
>         /* release the bus */
> -       spi_bus_unlock(host->spi->master);
> +       spi_bus_unlock(host->spi->controller);
>
>         mmc_request_done(host->mmc, mrq);
>  }
> @@ -1157,7 +1157,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>         /* We rely on full duplex transfers, mostly to reduce
>          * per-transfer overheads (by making fewer transfers).
>          */
> -       if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
> +       if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
>                 return -EINVAL;
>
>         /* MMC and SD specs only seem to care that sampling is on the
> --
> 2.43.0
>

