Return-Path: <linux-spi+bounces-1103-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C9E84BCA3
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 19:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977B81C22862
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF28E56C;
	Tue,  6 Feb 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6f1/fmW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D6DF5C
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242581; cv=none; b=KuKMSI6DPUt5V3h762JbpTfl7CFfm7PKkfMjL57+B2CsYlgFtBsSoAgTGw72gw/rK76Iy05HZUT/CvjSOXdWqwLiRhYNlSQl/grAXEq6ZIBzX/h80V08NWS7IeaVDf5z3MaRVtmZ2GI/vgOPHiJ5dOUwVlibxX0PKAlPikGJskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242581; c=relaxed/simple;
	bh=1yNqz1LOap9ZaBzHogIYacCcSiFZ5EweLDYC8VgK/dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndF50RV5NELN2f1TiPgdjDgUIggZ5daY7sYdspvuvW6OZaw3u+YfRUMtg2EX1GV7nlf5xwfFUAeyR8MXSXibSe0LXuXH+RRndDF7CWJvXERwofWn/Gylr/kJmGDbe5CMZokLMGu2+X7khm3DOCUuawHuOdDiOZwWO55mRGQ4Xpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6f1/fmW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93b525959so6980275ad.0
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707242579; x=1707847379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M2ibsuTrnhL6GB8ozyWnRVc+0A6pszuE1w54INDDgI=;
        b=q6f1/fmW5OjpA/cQAfS9luL+yIsfsf0bjgYkJV/dJNlaoL+rvycUsVNDsnIQxi35pX
         LdT4MLfd2jK/lJdgkyyHRkgZFEvtY8nRAKhsvHzwY1KAFoEUCU9SPYhCrulYCuUwj7A+
         fU86QdS0ZQOSRWsXmaJKUPktVYxbSud9o1818tqE9c7+AodOYeyHvyQby7fK0nVHL+bb
         L8VwVAYjP/IvgRF+V6MmIaB3pJTJpIwmc4zqEoL4J2HS55WP2CXh9xoc4UNA7eHnsqgX
         q939jswgicnXyQPRsxyd5RkjxQt249tehn7U1O1DXR/cINSm83Hg0qfh3efWgTBFpXHV
         kDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707242579; x=1707847379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M2ibsuTrnhL6GB8ozyWnRVc+0A6pszuE1w54INDDgI=;
        b=ppT1QsUN+jWVPfzEPCiX3lm+2PDbGet0CvZt1UqJkJWOIhnilHQbM9iKo+GMp8nR8Z
         Eu9LN/nfY12zBWW0O2/CatbX6yuRAAmBwjacvm8npueCGy2c0Cui9bIdoITOaCjNdFwE
         B5mpt5Rg7IsXNEuzrIU34F8Mzkh5n6H4k7b/UYjNen4DDkrLzVMA/OjVeTo2ds3OAgL0
         aJG3PRHE0D+x3OZBpJRuDA7InbSqUgE9A8BYcVcuN6euoKWl0HHfNjAQBgZMRMRkUjgm
         dQVZp/ghgWx/llViEqhN3kjphXCGiguNjLw7e4rcCFypahkxkeFuKHXYHnT0HYrIpum6
         XzrQ==
X-Gm-Message-State: AOJu0YxA/5C1z3tXasZekUv3ZVDOAyVFvKP9I5VnUmA6OfqG0K1/MGVj
	250IlnHpPDwWq8bnAURbcxr89szlShTS4v9D6++Zi4qYWjJtOOWb0sXdprVACi2YLjBhwv4k+05
	HK9xk43Ukigen5kXv8ZsxxCpSiDCI/7wshpRuTQ==
X-Google-Smtp-Source: AGHT+IEc3tTD5EyVI03jK3qG4wLOPOwpQ10oPtADyz7X2jUcQIhcGUtJY2M8zQAg2KCaamMiS6UT8QItv6PneOqQsKw=
X-Received: by 2002:a17:90b:4b50:b0:296:a68b:d2e1 with SMTP id
 mi16-20020a17090b4b5000b00296a68bd2e1mr254385pjb.15.1707242579459; Tue, 06
 Feb 2024 10:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org> <20240206085238.1208256-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240206085238.1208256-2-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 6 Feb 2024 12:02:48 -0600
Message-ID: <CAPLW+4=Xd+B=ZncqPgU4qaJ8zY8JJvJZApdUW_v0w6yr2cy9Sg@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: s3c64xx: explicitly include <linux/types.h>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> The driver uses u32 and relies on an implicit inclusion of
> <linux/types.h>.
>
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
>
> Include the missing header.
>
> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")

Not sure if Fixes tag is needed here.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 72c35dbe53b2..c15ca6a910dc 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>

Is this really needed for the further patches in this series?

>
>  #define MAX_SPI_PORTS          12
>  #define S3C64XX_SPI_QUIRK_CS_AUTO      (1 << 1)
> --
> 2.43.0.594.gd9cf4e227d-goog
>

