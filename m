Return-Path: <linux-spi+bounces-811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC9383CBB1
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 19:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421541C212E6
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF91339BE;
	Thu, 25 Jan 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5IALI8I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A9111AA
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209109; cv=none; b=mzGdh1MPgL3YrFfWXcE6HO87BNERJemX340DE4uwy5EGEBy8HB53y5VnhZC+rW0XE5rljymfaDfUpoiFLE7KadHOj66X8h2EZCiQQZq4NGw7fHfmRT5vxAt4bN9I1nAtkAglhuAL1bbJpZ7but6Grq/ghaf7UVAD6wG/tdGZGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209109; c=relaxed/simple;
	bh=/yuX+ZwAqeiEBG+9snyPxfUHA4kLw20Lq3tkl7WzUfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haMIh639VLrFArN3PhjudDChOuxPS5unbyXJ0LMY1QiZHMywQ+zA3bRDPWujC0DHXM/FGpcRnWtVlTgT7q7uqTCHLFO3XV4eLlUMMi7NAtlZZL17HPBc8mZ8GtiMLG6KarvJTvEhmGRWVGuuRFsARHhZxbrU6zOYAKxeLoeiVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z5IALI8I; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d70b0e521eso51626815ad.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 10:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706209106; x=1706813906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKodC4CUWzXNZRd0RvY8kflDnv2+qlK7ZzKTDP0BS34=;
        b=Z5IALI8IARtyOtpRCxsnd1W3OOtIIGd8wZHPboiTW3oRYv9oOv0oPbvIzTPYchOJky
         k2UxtyH051QIyOstuDzppF8Uo6ESHt6h7LswT7KHEvH8XymbOJE8FlL2eiKMQNHLMfO5
         zrDWXTrhlt1LdB7CVNLSZ5UJ5p4lSDS7Fnpo/BZYuNjBY3cTWIVqYlh/H6v1plUt0IRo
         2q63v+wsbkvXlPondLo+MQThOsduqhhiRwvP7lCSIhRNkGLzPI4z61AiOLuWQZmEtREt
         1JwGQIoYisbgGsWwuC68mx6FirZKy9J8t+3t8/XKu82mLFZ3ZC08uU0Rb/HsHc/1aZmd
         uKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706209106; x=1706813906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKodC4CUWzXNZRd0RvY8kflDnv2+qlK7ZzKTDP0BS34=;
        b=byBv3mkLav5ewJW5QbjD/JGjP+gponHc45bVGBIajT+rp3TvFBzLcopP2Y81ciOTl7
         nylwSJVQx4u18XQh0gD+LhGsvy/rTSdsJTLC63OUm2LIWLacaUTK70iPzIX5huMxbtrL
         3pNfaf2EWWGqnnbQW7PNHjTHlXOOpDlU3Dsts3BlT7wPB+PSbtX0u9kVLeGrk1j1lfx1
         y6TVmJTnF2mK6DODh/1UeAWkqhPGq95CHTJdvwaDyT3VznmtbZkx5FvtAt0syYYNMGre
         ncjGkNw1wclxRud37Q2xWUFOIs4Gd7REgo6PH/mcDpVeCoclYsprHmpQ/ktHhj0PQCBn
         oj2g==
X-Gm-Message-State: AOJu0Yxd+1SToV34ODeiGIosqYSSpiZmJXLxyyAqZUbva7wxzilu7vwv
	MjbeJPJgrE/Fo8Ng80iJsX7fl2ojmhm2Vr3qKrKohCSiPhAa66CG8NzgzVCHm1rG/lz0low8qzb
	xhkMlL3o+F2d+K6s78rxfkQ94FZxXbrl4N79vfA==
X-Google-Smtp-Source: AGHT+IHGqu+F52i8g1m/kMXpX3DElw6QjaxmyN1VJK+gS/nX+WAvT8nHp1ClH077kwlifFuyQq5EZg0+FOpZfc3CsKM=
X-Received: by 2002:a17:90a:1986:b0:292:bcc9:450e with SMTP id
 6-20020a17090a198600b00292bcc9450emr70570pji.11.1706209106577; Thu, 25 Jan
 2024 10:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-2-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 12:58:15 -0600
Message-ID: <CAPLW+4=kEhMz5eUCTLO5e4RCK23g+EWqRqcGQ-V9FNnL6jaFtg@mail.gmail.com>
Subject: Re: [PATCH v2 01/28] spi: s3c64xx: explicitly include <linux/io.h>
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
> The driver uses readl() but does not include <linux/io.h>.
>
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
>
> Include the missing header.
>
> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")

Not sure the "Fixes" tag is needed here. AFAIU, this patch doesn't fix
any actual bugs, seems more like a style fix to me. In other words,
I'm not convinced it has to be necessarily backported to stable
kernels. The same goes for another similar patch from this series.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 7f7eb8f742e4..c1cbc4780a3b 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

