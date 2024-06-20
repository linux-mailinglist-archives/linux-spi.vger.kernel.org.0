Return-Path: <linux-spi+bounces-3501-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487991048E
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 14:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BDC1F24311
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3ED1ACE6D;
	Thu, 20 Jun 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VA1Nm0sg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B201ACE65
	for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887855; cv=none; b=bb0lJuz2wvyRFQfJB5UA4kFGCTI9+lic6u/tJ6zWiqpEpPTCVGOyXKbKtVAjMxU+DiUJVHdDwz3VuP5WjXQy7oVviIWtSu/+bXXqZ/CA64iBC62UIk7FVTfjF0OhwC0J3LilC+oiYjwfjuYT1AciWEizv3Y0IzEVErwD9X/dAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887855; c=relaxed/simple;
	bh=2HmyC/8aoZ2nPJoKWEKLwCfkQSZpd1ixf1AoMQ48fKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEqd3GNss6CGZve4DVkPEYpiWdDZ6aFLvDryKLPcd0yKT8itmcrOTxqvG4kG2EZMG2L04UuWrcmu/jXkbYpXPxm0A6KXKUk40KFALvnaDBUjL7QipNooJt3TyXXBgfHgtqPzPged8UsHJuZH8DZUYqXeCtSP0+gePhcqZZvicRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VA1Nm0sg; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso811308276.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718887852; x=1719492652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V7Ui2B3eiuQfY6kcWseFEWEENplZ5Qoq4XUDUnDKk3A=;
        b=VA1Nm0sg5UJAsKD6JV6BkbBZ5eCWivY8rCu8G5tU3I07UHRKOBMejLNz5Fq0Hsc0ZU
         CiiCC1bKRnIbRZ0tiFie+ov6PhsWVAhr/oEcUNQ1crM9vT068Wg1W4F0ZjBv8ilqb/Kn
         PS5QSWnd8/uhqydzS+J0rFpE8AhErg6QozuQf776qnWhkCc1vNKuzuvqJn95YgPAMJjm
         AY+3je9Y+6vCdVh9z/OM53FH3PEPPaFcLK3MT0cD+Fk90htAUTn9NXNTbZjhYukmx1ni
         aG537yNuavJ8wKetDfo+d3iG0/S8ckBm2Uxnjpx3Ean9djNdFyaS0MDnCcG8N5k/Gt5d
         G+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718887852; x=1719492652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7Ui2B3eiuQfY6kcWseFEWEENplZ5Qoq4XUDUnDKk3A=;
        b=pBLxJD4ek8Vujj7u6cJWGweeghDTuOxbKVzSoQdmXtoiYM2yV9Tvytk/TwUK9dKAqn
         QVyllBD409FffKdWmeKuNletpwcEa3KbmemEDrCVOFPztflELSSzqo5T8aB3yvcgzTTB
         vNAAj2QTSwNXlON2ONuFfscWIeKvAt0GxfIFtCbnF/tDr7v9RYGLIc6Lq5aAOYM2bP2a
         v6EBG75K2IPbHm3DD7jIYD1EuMOzXgp8Cuo9LZyTE9zQYRJwmyc6OOUAXkvEKAQpdc3E
         e4Fk5tx/L8bHs1yYKxFSM+scgnNJB7CXBFuSYOtsbS4MgFqJYBsiM0ew1iEtQD8hhihP
         1qeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvgrPI7ICZAN5m06YnkACgMkp7F04A58u5y8th0nvt0uCn2QdwyTX7roUv8Kjxs8RfOemLNWHqSdNpI6uaMgU2rUorTYAbfkwO
X-Gm-Message-State: AOJu0YxXUoqcSgq8mqg2S9XX88k6XnI0HjhNeeZ/Mks/+olVKMTpwRMW
	erbbEcToPu0NbQsN63jFy5t7XuU8XKGWq+TrvpM99ot8f5iGHu/7LSdCLq6psPYsHlrD2ngmTvN
	ZfBDMdd2BozTKsk3BoX1Aw5hrXSD4umSJNwjXww==
X-Google-Smtp-Source: AGHT+IFzwmTlSm83S3zIQ/NDj8ijWnvuzYb+Ls9TCG0adu2HJouriCBzHm65cuenwHGzeYmKw4gbmsjLNgVHCs5ygNw=
X-Received: by 2002:a25:81c6:0:b0:e02:b580:d0b with SMTP id
 3f1490d57ef6-e02be203e4dmr5411315276.40.1718887852518; Thu, 20 Jun 2024
 05:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-brigade-shell-1f626e7e592f@spud> <20240612-dense-resample-563f07c30185@spud>
In-Reply-To: <20240612-dense-resample-563f07c30185@spud>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 14:50:15 +0200
Message-ID: <CAPDyKFozcUPuMooDHVSBZomHTGKzseVf9F=YBY_uQejh9o3x7g@mail.gmail.com>
Subject: Re: [RFC v1 1/3] mmc: mmc_spi: allow for spi controllers incapable of
 getting as low as 400k
To: Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	cyril.jean@microchip.com, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 17:48, Conor Dooley <conor@kernel.org> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Some controllers may not be able to reach a bus clock as low as 400 KHz
> due to a lack of sufficient divisors. In these cases, the SD card slot
> becomes non-functional as Linux continuously attempts to set the bus
> clock to 400 KHz. If the controller is incapable of getting that low,
> set its minimum frequency instead. While this may eliminate some SD
> cards, it allows those capable of operating at the controller's minimum
> frequency to be used.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Looks reasonable to me. I assume you intend to send a non-RFC for
this, that I can pick up?

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_spi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 09d7a6a0dc1a..c9caa1ece7ef 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1208,7 +1208,10 @@ static int mmc_spi_probe(struct spi_device *spi)
>          * that's the only reason not to use a few MHz for f_min (until
>          * the upper layer reads the target frequency from the CSD).
>          */
> -       mmc->f_min = 400000;
> +       if (spi->controller->min_speed_hz > 400000)
> +               dev_warn(&spi->dev,"Controller unable to reduce bus clock to 400 KHz\n");
> +
> +       mmc->f_min = max(spi->controller->min_speed_hz, 400000);
>         mmc->f_max = spi->max_speed_hz;
>
>         host = mmc_priv(mmc);
> --
> 2.43.0
>

