Return-Path: <linux-spi+bounces-6835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF9A361AC
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 16:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E8A16BBE8
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764FF266583;
	Fri, 14 Feb 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQmypplA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482A747F
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546862; cv=none; b=SQLLiaBQdesXIziV7CgNZd5SROLba5hm/wI+C1lg9kwbwauB36YQ9BUWPx97BXEljmeB0z7/i8oVrLRm/FG07LU0frvDcoR10+DmYgmCSXAA+KKDfY3C59UCk0YggwsWA5UL1mFdlvUAYOrCZJc7+5TdIfIcgKlA1rU09Oqt+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546862; c=relaxed/simple;
	bh=XV8AT4C5Gp3NId7z/OQmyfyGNoiIpsTboDGzh/JM5Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXowJ8XJT/Rflc78jBIqmPM0K/KjYBlOoSiyLL2EGMxar5oRiFzE50mBw3mgG7yy+NaJiIXEqrcyQz0qWSmgtZb2UtOOkcgvex6Fy5jYjqcFxE/z9VsrcwLHnfLzWvHTxZFTkIAsrQXZznL6pPPYD+5Kd5BVtImhB/yD8h2KR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQmypplA; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f7440444efso18977817b3.2
        for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546859; x=1740151659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wygEz6vt3imSF3NwvzsbaEgG5kEjxbe8ddM+Vd/l/w=;
        b=yQmypplAo+bysWaEaKZ3ULDutOw5rDZQx76SFfcPaxlN1GqcxvawtHCw+z5khRyH4E
         6JOQLVhbIZ84vug8gYJLFtVG2Nif3vc61k7W+1bdZwx4IyQvRnLoo+U3ZNm2ZOm8UPmt
         KV4y+vjOyxa2bCyJaKhiNPMxZTRIXhKk9ltgHzK3RIS1y8hR3kYJT8PsQNjHpkZZlQuk
         4hlW0QmB92m2JoDJ6pqm7/CGmfxmqkkbkoOlmzprHgQCe6IFshmHK6jGT9CfSTjjweab
         7ibkuy7PbGG68IreLZZwPDahVtfJvwucA3pa4NigZrFCLXNITu/tRGGNr4U9sWxtYYwl
         ekLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546859; x=1740151659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wygEz6vt3imSF3NwvzsbaEgG5kEjxbe8ddM+Vd/l/w=;
        b=iyFb4T5hMQdk1qAPF1LQBXwjdsXLf7mC4+f7ezaKf0wTa9CxSPPcYOhTdEDINM7dXY
         EQHK0Q41jfrf2tb2YXt2HKGltilbODXgzWsRdeRKEXMHcllaxrU2BEcPNWDql2O6zD5U
         E12jDWjIN44DBfdGxndRCAMMIe48FQwNQY1G4/V1/NYzW7HdUvNAw4RiIgXcNPvX36Ax
         D8UaRixTWNjru4zA8SEIE2iTljGQD4jzVbJEZVGRtThMLMA9/bw9v3CcHY/WkIxsVh0W
         A9EiBLfzPBPvkJ6lHjh8m9XiWqzg4drx66syaSw1nX7lTRlZa8XDO9ygOCOlc/p3h4OS
         SpGA==
X-Forwarded-Encrypted: i=1; AJvYcCW52mdmAo13veAOY9BXsbrTN3cEec/D9mp1MqLD1DAAlgrEVkwrQ2yTWt9MKpqp5VW62EqDfpRXcd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ma31/8JIpMLvW5xVB4/GEAnW0Ug0dng8pYjmDLUjxM8HxEgn
	ZBEWCrMoIb2gIxFHeyUfW+6+c196xpihYdhhccXpiwgDH0IiBOdNCFp52XrJKjB3GhuNvCXjGoL
	V2yKwsdUuX3dP92V35dOh7Xzzh4Dsl9XeIkLr+g==
X-Gm-Gg: ASbGncsl4zdB6uPsloQj0wy3Fxb/3gEqq04mshaX7CTtgsbU59nMDX6FTcKoTEc93sR
	6KUoiWdrVddnTb7KrNXtNgdol99s8D7hFFQaFKJ+Y0Z9Cyu5zUg5GxsWwNSsXTKlQ7tweNtqFqa
	amqfQ5U5CsXARTlI6FjJ86Z9LfavwBuNQ=
X-Google-Smtp-Source: AGHT+IG4t59iStpuyGq1+m+dvxq6YGK16dQkcUOiGs7tsyDTNdFxcN+r/HnSGFs01wlQ6aVqrC6vhWCS/t0g0Qj+n0o=
X-Received: by 2002:a05:6902:f06:b0:e5b:21fe:d9bd with SMTP id
 3f1490d57ef6-e5da81026d3mr6137510276.10.1739546859693; Fri, 14 Feb 2025
 07:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-spi-s3c64xx-fifo-depth-v1-1-e1b1915e3ee7@linaro.org>
In-Reply-To: <20250214-spi-s3c64xx-fifo-depth-v1-1-e1b1915e3ee7@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 14 Feb 2025 09:27:29 -0600
X-Gm-Features: AWEUYZkkGWUD60LMpHEHi4hDR2nuH8MPeQ82wDcgpZ-r7ywAfZ4HSSClhEmifNo
Message-ID: <CAPLW+4n3bQOGDewkh1Yfftticp5n3sOnvmVxgNz=rnmWVf6vmg@mail.gmail.com>
Subject: Re: [PATCH] spi: s3c64xx: extend description of compatible's fifo_depth
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Denzeel Oliva <wachiturroxd150@gmail.com>, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:32=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> The FIFO depth specified with the compatibles's data is used where all
> the instances of the IP define the same FIFO depth. It naturally has
> higher precedence than the FIFO depth specified via DT. Specifying FIFO
> depth in DT becomes superfluous in this case. Extend comment about
> compatible's FIFO depth.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 389275dbc003..9c47f5741c5f 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -139,7 +139,9 @@ struct s3c64xx_spi_dma_data {
>   * struct s3c64xx_spi_port_config - SPI Controller hardware info
>   * @fifo_lvl_mask: [DEPRECATED] use @{rx, tx}_fifomask instead.
>   * @rx_lvl_offset: [DEPRECATED] use @{rx,tx}_fifomask instead.
> - * @fifo_depth: depth of the FIFO.
> + * @fifo_depth: depth of the FIFOs. Used by compatibles where all the in=
stances
> + *              of the IP define the same FIFO depth. It has higher prec=
edence
> + *              than the FIFO depth specified via DT.
>   * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the =
field's
>   *               length and position.
>   * @tx_fifomask: SPI_STATUS.TX_FIFO_LVL mask. Shifted mask defining the =
field's
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250214-spi-s3c64xx-fifo-depth-6787f108be83
>
> Best regards,
> --
> Tudor Ambarus <tudor.ambarus@linaro.org>
>

