Return-Path: <linux-spi+bounces-672-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B8839945
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 20:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642B61C2339D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4C1292D1;
	Tue, 23 Jan 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8ZB+YR9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C3128375
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036787; cv=none; b=a6Di5IoWxVVQHTm9/kNP2phgGvTi+ZxHbL5A2EG34MEJrKo9bYFVxIDIZiK2oz4NiZ7DHMu0iP9HmTAC82Yqt0Ty2jk68LotTQQTCCA3uXLMCvlS7FKr/ivOCR/VdGK4d/4OBmJVtZ1ACCOia6gMPmaM2jbtwdtx3CZ8XpR3kMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036787; c=relaxed/simple;
	bh=5IKq56rZiQOYgPeWbGnpyMEk8pqBBnPZA0ayr4DR8xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufBu3hQjlmWtxHOhvw53kI2GpYvWGQ8nrLCgfpEzKljls0yYz60wSSGNnkXmBw3To/KKQ9GMTRzwNyABcDLGYeEspP12EqaydJbG1blugazJB2sBH4Z0V6liz9ouI7Avg3ycZ/FcoSRK7JUSnAVnCFFkAAjKhX2hs6PygLEohKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H8ZB+YR9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dd7deb57d4so750737b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706036785; x=1706641585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdLtmnUfI+i2IE7Csxqqy3c+cHq7ckx9/lEVoMFKEOA=;
        b=H8ZB+YR9cEdBWEfz5ekJjjjLZumA1iqc/cZ7hYQwjt7Xqjd2T5jDhh2Nn+matZ6KjA
         j4K9QuphvwtovvlggoRvup10qCkZ5JPN1UweQKOALMghSOYYMYiasTSDXGnx7kjoBSxR
         QeU/bdEc9vLiwY+OVd0tQgw6VFptcVQPvsjgDKFYzdUxljbiMFzQOdiOlujTy1LcZcE9
         XE5d9U6372aYzJu0SKOo3mWGaSRt691/tW7YhqM/j/p4rEXWWPYR21mm3m7s6W3bUlUG
         I4/sLZTOfED8u1Xr7QH+2m/hnaONnLbuoNl90hQ9hakSpRBljD8fOdWThnUZ4V32zlRs
         1kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036785; x=1706641585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdLtmnUfI+i2IE7Csxqqy3c+cHq7ckx9/lEVoMFKEOA=;
        b=tUB+ir5WALNKgjEhFcBPMSCZa3bCMftPXKSL7aTeEv8wP0w524iCh2k4jszkOp8PCT
         AsMp4z8Rj9OhfbrIQTV7bgy4VPVXmw2K8rF+LV1AiaOaD1jzrOfzGoD4yclRh/RtVinc
         E3AKNF6wGvahzINk4y9vSi3zntKrZcjj4ERlZ335tNl9gzjceErc76oT7X74Nmvh6zsl
         nDHY9nRo+UESZ1Rq1aJEs1OqiQR78PUECo04tmPgDTMoP/TUH/rGnjgewxP9DZvWQnmE
         CK6nAxBYnX99PObxncUVbS/B0xpiRWI75DuZLze1fW0jc6VANQi3XlYWGr1Qrb05O98D
         AgZw==
X-Gm-Message-State: AOJu0Yy+HuRnsWGxEAtsYoNtMnQCL1nNyssv6CLw81l8wCMK9n9v2DPX
	ARLgqmcBZfBwDK8xzi4zdVBv17KQB3RWRdopt8/2rKvogEl9UgkXI9Rx1RxrixmUwgPrfa6+g8w
	WJ21p0yNzJ+DumpjKRwieOUalB/b84bSbQ0FTOQ==
X-Google-Smtp-Source: AGHT+IE7eMXgr8fyduKjXpnWZmowsEhu4ODPRkNQaCqLV70A0lHSDhtv7fTrbwCQAQct8ubtrHaDOhEQ26uZTOBuRjU=
X-Received: by 2002:aa7:9a47:0:b0:6d9:a0da:4fbc with SMTP id
 x7-20020aa79a47000000b006d9a0da4fbcmr3559257pfj.36.1706036785556; Tue, 23 Jan
 2024 11:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-4-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:06:14 -0600
Message-ID: <CAPLW+4n-ryLp+MEv1tgX4RfMdtWP+kAyzABqyQ1uJ+V5f0_WuQ@mail.gmail.com>
Subject: Re: [PATCH 03/21] spi: s3c64xx: remove extra blank line
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
> Remove extra blank line.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 187b617e3e14..26d389d95af9 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -16,7 +16,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
>
> -
>  #define MAX_SPI_PORTS          12
>  #define S3C64XX_SPI_QUIRK_CS_AUTO      (1 << 1)
>  #define AUTOSUSPEND_TIMEOUT    2000
> --
> 2.43.0.429.g432eaa2c6b-goog
>

