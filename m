Return-Path: <linux-spi+bounces-675-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D184283999D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 20:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA49B2F3F6
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B72823D3;
	Tue, 23 Jan 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XH87orin"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4EA85C66
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038121; cv=none; b=q05qm5/MTu7PMXVzqJgkfUhPNv1WAdpn47Es2e1pBzyY9nY9z1Iao7sZr79W7eQuv5ytC+ow2K15eByAhrdyy0Hlv65GwyogAYbufou/uAAOLgldPErNZ9NxV7z27YcNNFpt6bm9xjQ3nZ9iq2/kpJotzu5qeVua7uuSVZVFDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038121; c=relaxed/simple;
	bh=z635edAjEZRLK9uYsv6D75GltoeAuq2T8K98RgKsohU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFtZFdVLYCvvvlWN8for0MdkD2sjs3tq6a/7owWW4D/0wLCWug3FCi4nvjMi8Ge+kAKLEQ/EAbeE3LcWriZma4Ih3r4Va7kxsByT6CD6+5q646YpC0SgAS5f2He2liMorT3rYpDctKIF5LfNXvT1u4ZZrpbwEwIo/z41FJS4jSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XH87orin; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dd7b525cd6so795577b3a.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 11:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706038120; x=1706642920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4fx2jRa6XWdzoBOQRFudfhQ7Cys5tOUHx4aJsazh8w=;
        b=XH87orin++yohiMfBwAoFVV9WdBMKy+twg/U6p/3DyC9KKTOU2Ux3eLbdMfNgfkODT
         ppj7MvP0UEPdg6jEE5yAgZJvT/XXOtMm2ElKwrRwEkVaArOZLozQ8ORNwNgs8bDa8asU
         /rn+q+Ke3bT8gefXTQ+LrLW55JQhv4q1x7wguM/Vwu9Whh0g7jpL5Zt7xDaOWe8L6bz5
         cNisxXxI0IQgX4RWq2IQgPrBOrWWzqV4tOTLOOfjyQv/6vsOetesi3H3EwmHWBlNyngt
         vtoakd+H+8kUbkC5yVFqV+TzKZ+SL2E7oviXIw6OHpzBZKwcyBDRRyJBRaSo9Qp9hGap
         A3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706038120; x=1706642920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4fx2jRa6XWdzoBOQRFudfhQ7Cys5tOUHx4aJsazh8w=;
        b=wE/GXWTQyrPyE/0uLLgdOo2itTRTXarDqwoLkxfm+UYoFFTcu/AZ+mRmhp5UnhrE8D
         2/rL94WVIqzQO2uOtn3UqViolcZ08NHwf9VInK2SgDP9yW6QmP/rztgp+uGi6PkCZGXP
         oQzafzQU7ck1qwuECoXxGHOywnBJSx7pd5TNb+oB2sAYg7p81aNE5VLp5qTk5s9wPMDc
         viUao5I2HSOpXD1ZCsVdHh+ruF/tGpkC021g1rKjyrTk3K5beJLRjvmfgUo6LOVI4S1k
         OLQSxr8CJ0uh6G2rwl6ap/y+/t7Ae2V/+b8YfV7jafWtPNOEiYUsc3f/RV9fThtRq6PG
         w50g==
X-Gm-Message-State: AOJu0YytPkWOWK4aRA0YAr9uokf9hxXL+YI7LBJcEsH7GditKWOqJfX4
	OZlrafmZCGnwTv4QBvxAjcUR9cHiwfgwzHYUqyGZe5S56qZlx+X7hJH7yAtLaFH24zpTx4FO0y4
	CBdasd+ZrK379jjoLx5Ayd+jSxlRX31gvp8tjHw==
X-Google-Smtp-Source: AGHT+IE4pMdlHZBzRIybtPg+syPs+PySUc9Nk1uvLXRsfE7U/0t69O5o5wVcE/JsP6QewXSBCaO+EnVOVMCLRSuJrjI=
X-Received: by 2002:a05:6a00:460e:b0:6da:bceb:3990 with SMTP id
 ko14-20020a056a00460e00b006dabceb3990mr3781418pfb.53.1706038119921; Tue, 23
 Jan 2024 11:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-17-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-17-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:28:28 -0600
Message-ID: <CAPLW+4k-5vdkBNdewTgG72iAr0oLv1zXncnmx-qy6diJqQMNDg@mail.gmail.com>
Subject: Re: [PATCH 16/21] spi: s3c64xx: add missing blank line after declaration
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

On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Add missing blank line after declaration. Move initialization in the
> body of the function.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index f5474f3b3920..2abf5994080a 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1273,8 +1273,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
>  {
>         struct spi_controller *host =3D dev_get_drvdata(dev);
>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_devdat=
a(host);
> +       int ret;
>
> -       int ret =3D spi_controller_suspend(host);
> +       ret =3D spi_controller_suspend(host);

Why not just moving the empty line below the declaration block,
keeping the initialization on the variable declaration line?

>         if (ret)
>                 return ret;
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

