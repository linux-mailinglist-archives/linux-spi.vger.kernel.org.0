Return-Path: <linux-spi+bounces-821-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE5A83CD9F
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 21:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415BC1C20BBD
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2BD1386CB;
	Thu, 25 Jan 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gthl0H1S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96F1386BA
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215135; cv=none; b=mN0uJ90V0484/TgAEoOVvCO+nhdKr4zG3GtG7WTyLYNCsvLOVHvsBnLFivYkNfzvW2shVYO1Y03bZPJUbVoPS3ex7WHbqiXRrah+A6Y0jxBdcMtnmPcELbZEsMGs5+IZdTJmlt/l62H5tq+LEOgJ//sPMmYMq5E5KYjZcTb2G+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215135; c=relaxed/simple;
	bh=as8BxR+QqTPluaUhYT7i9ae+BmGNNbMHHNTI1DbPeLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdtYq0PjqhDsKqFIFx5r2k+Go+LhPrFJzgFhKiNW6rqHz+AcWKPC4TiUW8UrnP0zpvbEnlKC94m60OZSh3KL7bFu2jgHUyUfSLHj06GtIBj3bkDf+0gS3S2xQeBZnvbYm8NT/Ete/cRfb/EEWmxccnqZOyDPNd/AMuCtaCy9Tc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gthl0H1S; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so4168590a12.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 12:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706215133; x=1706819933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YW4kVaU4qs4/wv4NEfs20us9zrffpc4IBOWQ2Q3fD5c=;
        b=Gthl0H1SL5pH6/nK+uMoSBbK7Y0m30Ms5oXRlQaFBe/TkPP4753hF0TuLxFWbXU3Fl
         oT3dmSw9L8+Hr617q6vK0IQncs8r11F9tAjpLA1dPW1+WSOpDYZyvXrOhWOR9INz+NlE
         x7q2ul6gS1CupMZbPcH5HAChrLpKlgwQhkqFHIJUPRsBeoCiiNZuETQ/91V2gEJQ9oUz
         HKvdbqerEU8EYANNV+ttk7UwNng9u5hUHvUvyKu8C7zXownQEWG6LPbYPU6wn8Ud0/dJ
         tLtDRRT0Rk2TQ65xIao4HcnrKcKI3OD/2JJcqhRMmSC/HFWMZY5qKOf1If2cnyGQI/wm
         EEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215133; x=1706819933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YW4kVaU4qs4/wv4NEfs20us9zrffpc4IBOWQ2Q3fD5c=;
        b=jfw//qBBa00y9DqB1TLS27mooyMcWmz2lSZaXkUP3ESY/Vm97JxR5yMSD5kNUa+bAS
         Nomgo6Pc2qDYyN+85/HYUp7nZJE2uZe+FN/Lu7lYNfhzHenxbO7Cs/emSVkHLR11NBm8
         406wOp4v9EAWTaKpKmT0kB7WZkFSdnLB2iHKH1d9dBZ5tJet/R0mjlzqaOnqXiWz9I51
         A75/qGwkiYeFw3DyRsOybYkIhvuYx+OSMbRYf8N8hiXwVcl5FZ1V4+Dpc9dj/cJqiiHZ
         iXg6rdgzuZ4UJMVqVCiJtrOX7QhiM4CKminetD8FnV/EGsImucTdZ7GBv3M4fZubUa25
         EAXg==
X-Gm-Message-State: AOJu0YzEQW1BzrAPYwM2pKYTs/kAdz5ip/in5wPV66sL4HOIGjt812iX
	mTgXj5bWFNb39j7tg//gGuxFEStwvmr1lLKwt15l4mHxcuGTNo1arUc7kc9hhFHH5//0Z20c7pE
	bZL09TfrIXDyAYvRjzxcDl2/v15faKR9QuqqwvA==
X-Google-Smtp-Source: AGHT+IHG2ateeum/Uje9xZ8HLCfUOWS6BVCrZklVdP/xXcY/9sA6a/GK03uHDwyYdokYaPXVysBq+NAthGfqOEN/Jk0=
X-Received: by 2002:a05:6a20:ce89:b0:19c:61d6:d050 with SMTP id
 if9-20020a056a20ce8900b0019c61d6d050mr199714pzb.72.1706215133202; Thu, 25 Jan
 2024 12:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-18-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-18-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:38:41 -0600
Message-ID: <CAPLW+4m+JO=7_hy4BaNtSZj18=ybHtk4n7E939=NEQC4dvdAsA@mail.gmail.com>
Subject: Re: [PATCH v2 17/28] spi: s3c64xx: drop blank line between declarations
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
> Drop the blank line and move the logical operation in the body of the
> function rather than in initialization list.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 00a0878aeb80..bb6d9bf390a8 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1282,8 +1282,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
>  {
>         struct spi_controller *host =3D dev_get_drvdata(dev);
>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_devdat=
a(host);
> +       int ret;
>
> -       int ret =3D spi_controller_suspend(host);
> +       ret =3D spi_controller_suspend(host);
>         if (ret)
>                 return ret;
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

