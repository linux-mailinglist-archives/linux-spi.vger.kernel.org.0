Return-Path: <linux-spi+bounces-1079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135CF84B22A
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 11:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB7F287645
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8DC12E1D1;
	Tue,  6 Feb 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+JzJVH1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1812DD91
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214366; cv=none; b=F0KKU5VBPyK2P0u36Grhez01CB8X9s0m3MNbvbKeoed9u8q+2T6UdhZkcunZJiGLsE03BMw2VqSkZd+ajp5n3xHvQtAC3C9pEGENZurAnkalS5W/Bog9hVt7jg11BWvIG0KAXulWMZLVwtDlxRHupoV73VCJnwdUsdmOwDac7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214366; c=relaxed/simple;
	bh=Av25SvJY+VoNb8IAXb8ten2tW6yMRrOZ0ZoYKecDGM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4GnI6ChuBHaCvfr8t1WugJn25vyKI8Ig92C+GpjwIjRNehby6FrpNDug97XmWaj+z3ivqI+YRj46rtHEYvlJozSHmNfEvySPuFxTCI5sDNVbs1mJdOZicRph4E9/KQtjOQhK7e3PUCkiR4nFf9/e2Yq1BweOf+wo55KyNToVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+JzJVH1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c3ac1fdb9so3204096d6.2
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707214362; x=1707819162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RtzBJx6wCZPpOqlih50m+fMwaDQ7Jnq2Nn6LSXNODY0=;
        b=p+JzJVH1MM/61FUBQqjrKL7WO2ltkZzIAQZoZWOfibzETc1Q1OQlaxFvqGWVYnKblf
         7X+aURNckWXmKKQBqwDR7zLPHjrlo8sssVZJmJoCzWa9U0RxwC46LM5dl4VAluWz0KeB
         OVx642kKk1rEKYlsx0up7aDaJ2hdOhk8Cf0u6wkljugoTzocPCm29Yier56EIv7qaito
         qwcA6Sc6LCwa+183PN6/FmgCMGwHQxxZ/4lyRj3g1Necr57zVzCpoGSevwIAFN4qyPhQ
         /M0RXhuzckxpp7MA9tpVO5q9M+A0GjuZ25aoz42JhIoIBY3AYYxdPQ89KkBi+Mq0ldaC
         HLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214362; x=1707819162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtzBJx6wCZPpOqlih50m+fMwaDQ7Jnq2Nn6LSXNODY0=;
        b=trdOTiCGT7qZ0/IWzC8QKG14W9Rxx+unI6CV1AOUI2yX3CfPctwrcqEHTUXIPwk2FO
         JjrS35Qqb8QJ3KrkQz+hHjHN0O0CSzAZfl4SaqzrinlcIuaAA9GtLbL6WG8qIYpOraad
         MYCFkGbZPDGoC67JJU8ghM/3Bd/aNGwj3s7DtPLbeWyDWu3KgG3hU5dh5ah/YzrmiIG2
         zHIneQVZ6K9z7t8QxEYgx51JTpG1OFVWV7I8iK9z/4Y5IDmxh/i8fkt3mLfqR6wOJ6sm
         D3I0MiBQ+gIJL4/YLvoagEcFc3U7CkDVRPhmcW33UyqjOq6W0OolmTlcZ73wKCg13/TT
         Rd8w==
X-Gm-Message-State: AOJu0YyN2cXTmFlSrV7D9iO0QDZev4RAtU5V0pVEOKQ8Y/zwLvO6pn8k
	PQIXAQN4E8djubXF48DPSYbrYG9reGD4XXxHnawpTaOLblwNBCi7dbCkytbxxGlruQmw67U3T6b
	Sc7t34iOF0UBLIrKWA4Qkh8BCoxI+5URu7Bx1lQ==
X-Google-Smtp-Source: AGHT+IGMnZCoArTwWYltdog0J5CuS3/WLyIEtaUP+2kn+xaLD0CqS4Ik67E9lGPDKQvE0SR3tqrIbbn5FwyITbeWlxE=
X-Received: by 2002:a05:6214:4107:b0:681:7ba3:3649 with SMTP id
 kc7-20020a056214410700b006817ba33649mr1703512qvb.63.1707214362070; Tue, 06
 Feb 2024 02:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org> <20240206085238.1208256-5-tudor.ambarus@linaro.org>
In-Reply-To: <20240206085238.1208256-5-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 6 Feb 2024 10:12:30 +0000
Message-ID: <CADrjBPqaE9Mmbr+zkHOAadr3aLSu3GMjS4nPPd4VZY4s2DTznA@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: s3c64xx: add support for google,gs101-spi
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Tue, 6 Feb 2024 at 08:52, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Add support for GS101 SPI. GS101 integrates 16 SPI nodes, all with 64
> bytes FIFOs. GS101 allows just 32 bit register accesses, otherwise a
> Serror Interrupt is raised. Do the write reg accesses in 32 bits.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

The patch ordering seems a bit off with this series..I believe it should be
1) dt-bindings patch (docs first)
2) Add the use_32bit_io flag / functionality
3) gs101 support (this patch) that uses the use_32bit_io functionality

Peter.

>  drivers/spi/spi-s3c64xx.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index cb45ad615f3d..9ad0d513fb30 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -19,7 +19,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
>
> -#define MAX_SPI_PORTS          12
> +#define MAX_SPI_PORTS          16
>  #define S3C64XX_SPI_QUIRK_CS_AUTO      (1 << 1)
>  #define AUTOSUSPEND_TIMEOUT    2000
>
> @@ -1538,6 +1538,19 @@ static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
>         .quirks         = S3C64XX_SPI_QUIRK_CS_AUTO,
>  };
>
> +static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
> +       .fifo_lvl_mask  = { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
> +                           0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
> +       .rx_lvl_offset  = 15,
> +       .tx_st_done     = 25,
> +       .clk_div        = 4,
> +       .high_speed     = true,
> +       .clk_from_cmu   = true,
> +       .has_loopback   = true,
> +       .use_32bit_io   = true,
> +       .quirks         = S3C64XX_SPI_QUIRK_CS_AUTO,
> +};
> +
>  static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
>         {
>                 .name           = "s3c2443-spi",
> @@ -1550,6 +1563,9 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
>  };
>
>  static const struct of_device_id s3c64xx_spi_dt_match[] = {
> +       { .compatible = "google,gs101-spi",
> +                       .data = &gs101_spi_port_config,
> +       },
>         { .compatible = "samsung,s3c2443-spi",
>                         .data = &s3c2443_spi_port_config,
>         },
> --
> 2.43.0.594.gd9cf4e227d-goog
>

