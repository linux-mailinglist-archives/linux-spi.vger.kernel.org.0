Return-Path: <linux-spi+bounces-7391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9932EA78D6A
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 13:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8DE3B4550
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B95C239072;
	Wed,  2 Apr 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f7MNR61L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386A23875D
	for <linux-spi@vger.kernel.org>; Wed,  2 Apr 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594260; cv=none; b=tDiYZLGpwpLFwQxgIMEsn65NKGGRXAEr+/BoGsqoKFKspcqBV4/ELqiZWhlJATZBf3hCJpxbhN2Sq1rZYnUG8Z5p+DJ1LOHyAlNJb1/hzfMkZwm38Gl8da5hfVFs+e8DFt72T3lNrp5eQ+ATA0IyfxOSBEd7M3FHpFVRL/u+ANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594260; c=relaxed/simple;
	bh=gg299aIBo0h7KU2NkhsXnk65DPIe/9LaoqfuKARNUFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKJLwlU4kNpHsiKntcNXFy00FxjmTl8jALLnQD1OmdGEvxqxMAlviKmNmzD/ByIb13IrBzJKPZOWYOw9Hdgc3s445gpauHp67fB+1j9w1/Nj02Y+Wxwetfv/jH1tXQu2FJN2Nq0nyfC3ImfSgQct0U0mTs9ifkVDuAPNF+CE67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f7MNR61L; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54993c68ba0so2381386e87.2
        for <linux-spi@vger.kernel.org>; Wed, 02 Apr 2025 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743594256; x=1744199056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9Yx8HGWWz6hgTPomrXgKhcRZgBSmV4fN3I8vYiFJco=;
        b=f7MNR61LPk1qFGkBwWTVkyhgXFOlcrseMnNrrkcFlvm2drbUYeeXnMlpvtukXm4LIl
         Q5HmyG3za8UEN095/WpTOyKgdTgFSO5goCPTIrlwCt3N5COgp+ARHQYb2oTbrh3qA16j
         1kkcGieL2rQ0/O5Ynq9+DTgmr6VN9270ZVHa2TgLUnh8gceoD3vPuPXc3YvvQ3LWt3sF
         11Ui+3EIoukrFsAj9TBFB5cxKN9Dr91usJLXOSL9kbrGkgVGtjMCCN+39+bOarfI7s5T
         nuiWc+7YcE1q3wBLf7jnvpicj/N/GIbxds1MDc7N7tUjQgY+Zav9vhhN+yrGdtqSR911
         g9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743594256; x=1744199056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9Yx8HGWWz6hgTPomrXgKhcRZgBSmV4fN3I8vYiFJco=;
        b=ZidYw0wFy5p7ucIOw8RjOazCAiPXbScq8wD36c5uJGMpl48DmZ7tAR8eefxEJTz2DI
         dcsgGOOz33jM5m9gF0aqhh0R5XoFRWCQIAPx/O3JAZfwh3B+jM0BGrzBTITP3DBtmkR5
         YG6mrGUVzRK0DQxABZO+/FmKiOXUdR6URx3Tx9dvK7Rg/Q7cZ3W3DlmmkDai1ARkEK7e
         f8s12EwdsHPHFGGSl20PTJVYPBlJyavaAMDGpUYJNcxouSljfK+KSk+/N0Lgq88LE3Qm
         aOXh8olAaMB8vFtqf21sdttCruOaoM6b8A+VHPhdmXqyxjq57z9RpXej+it/cNOgTCNY
         fNNg==
X-Forwarded-Encrypted: i=1; AJvYcCWRsXimNkaiRMhsicxC4Lcpwjj+ZIU4W73VWXCUcm6jwfKHOYTPK8pvPw5thwrLYbbdWoz/W4ysFdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29rfniJcatnEkHBHXxDZ0U6wLRWARVB1+bxFXxCWLc0jDxvtF
	iNmXF0QfB0+YVNbDEYj8lOh4mWXz2TgznCBAwZD4PvdmxbGy7ec73wc8pDiLx4voBv8FtSGlNIi
	o1iDnyZYZbrXcoFyrUl9vrGLk7L0q5wynpn6mVw==
X-Gm-Gg: ASbGncuJW/5X+lWgjdXngD6KMkCeaNaoHLcsayaF5wkWLA9mDgJkjwzVafDo2zTBJ7O
	mf3SHikyEA3XGns+12X5tbIXDLmn9U6aooemsqgCTdQR6ww2B8TreFbqjCr5zpuQBiuBc/Kp8GK
	vn+FM9OG2AL0ObDANjXlpQ4HcQg81wAC3xogMO2qXLwTpjfMRALTbgwX3hxA==
X-Google-Smtp-Source: AGHT+IHW/kGqImrLP2FvLwHemjcshG451ryY8vcg74Qlr22qJBaIDv63Gcij3j/k2qFPQPNOKFQ4n1acyWCMv+TErZQ=
X-Received: by 2002:a05:651c:98b:b0:30b:963e:9b1a with SMTP id
 38308e7fff4ca-30eecd3b6c8mr23076271fa.23.1743594255916; Wed, 02 Apr 2025
 04:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401233603.2938955-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250401233603.2938955-1-florian.fainelli@broadcom.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 Apr 2025 13:44:04 +0200
X-Gm-Features: AQ5f1JpN-sWsvmePPYG3vEIc3GLu6mXVKUC_Me1qpDGqIHgBjPryChV7V6bxiug
Message-ID: <CAMRc=MeiALzO3XAmH9BLjxrB3EA1br1tpzHd5Qucw2NCVQ2q7g@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: Restore native CS probing when
 pinctrl-bcm2835 is absent
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 1:37=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The lookup table forces the use of the "pinctrl-bcm2835" GPIO chip
> provider and essentially assumes that there is going to be such a
> provider, and if not, we will fail to set-up the SPI device.
>

Yeah, the consumer driver itself is an unfortunate place to define the
provider data. This could potentially be moved to gpiolib-of.c quirks.

> While this is true on Raspberry Pi based systems (2835/36/37, 2711,
> 2712), this is not true on 7712/77122 Broadcom STB systems which use the
> SPI driver, but not the GPIO driver.
>
> There used to be an early check:
>
>        chip =3D gpiochip_find("pinctrl-bcm2835", chip_match_name);
>        if (!chip)
>                return 0;
>
> which would accomplish that nicely, bring something similar back by
> checking for the compatible strings matched by the pinctrl-bcm2835.c
> driver, if there is no Device Tree node matching those compatible
> strings, then we won't find any GPIO provider registered by the
> "pinctrl-bcm2835" driver.
>
> Fixes: 21f252cd29f0 ("spi: bcm2835: reduce the abuse of the GPIO API")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/spi/spi-bcm2835.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index a5d621b94d5e..5926e004d9a6 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1226,7 +1226,12 @@ static int bcm2835_spi_setup(struct spi_device *sp=
i)
>         struct bcm2835_spi *bs =3D spi_controller_get_devdata(ctlr);
>         struct bcm2835_spidev *target =3D spi_get_ctldata(spi);
>         struct gpiod_lookup_table *lookup __free(kfree) =3D NULL;
> -       int ret;
> +       const char *pinctrl_compats[] =3D {
> +               "brcm,bcm2835-gpio",
> +               "brcm,bcm2711-gpio",
> +               "brcm,bcm7211-gpio",
> +       };
> +       int ret, i;
>         u32 cs;
>
>         if (!target) {
> @@ -1291,6 +1296,14 @@ static int bcm2835_spi_setup(struct spi_device *sp=
i)
>                 goto err_cleanup;
>         }
>
> +       for (i =3D 0; i < ARRAY_SIZE(pinctrl_compats); i++) {
> +               if (of_find_compatible_node(NULL, NULL, pinctrl_compats[i=
]))
> +                       break;
> +       }
> +
> +       if (i =3D=3D ARRAY_SIZE(pinctrl_compats))
> +               return 0;
> +
>         /*
>          * TODO: The code below is a slightly better alternative to the u=
tter
>          * abuse of the GPIO API that I found here before. It creates a
> --
> 2.34.1
>
>

The fix is good for now but I'd still try to move this out of the
driver at some point.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

