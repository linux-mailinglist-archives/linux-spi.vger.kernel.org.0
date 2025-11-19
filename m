Return-Path: <linux-spi+bounces-11353-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D9C7049E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CF6F500EAE
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96F2C21FE;
	Wed, 19 Nov 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JhyqtWVp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DA2FD7C3
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570987; cv=none; b=M/IAISqNX71hmajaxiB6QeqFehZeK07YtTDmDyd6YrnlkpNEG9Y/ySE/MVsVZGL5Xz5Lk/yMc7b7udSccRcsfvloC3mycAS120sg0Z0DewoZRSLO12l9pd2AYwfKj5ENTYKdGryRoGnbv16KXbBI/inAXtko7kENywS3qf+j/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570987; c=relaxed/simple;
	bh=vS3GqcZz5/e1YIqg4Y6p2P5bhXNAXrlTE9+KdZfTBYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/8QQvOeT6IDgJ98zXBW1LBXkIgGuvmcfi/RJeuByCyi4vW8vBiLXw//vd4s1HAVOIYOQ3E/4qJfBfL9f2VV0dP+x7RAjTMzew7iBO29kpXxoAO4dvke+YWIu+1VqF2ScxxVdPNJS5BUolKGcKjvuUbm42NZ4/8inwsQOj3nlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JhyqtWVp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-594285c6509so7345078e87.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 08:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763570983; x=1764175783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpyvLKh/Mmn1vrCVutB6f5Cfy4PhM6ahAnv3kAcqCw0=;
        b=JhyqtWVpX07L0WANl33eI2MP2gt/oATpSqk2/t09c6NF8gPHOxjjVkwBXhrV3HyJeW
         RDflWvH8YPbaQu9YYHAJcxVtl3iBmldLqogqMueKWNDx0OeC7oG/n1F71WoQ9X/X53F/
         k9QctUJ+LAnsOz9Ts1Hra7CPeTAortI5/eLswOD3dLJelSjfG5Q/xRwUfcusrvvI4oGN
         rIJ7O+5uoVka+x+3zksV8SAfGeS+tnJbvBkjhCxbEwh/tG5qwqB6m85o987ceY7IDbkS
         rUDgzz4XMcqm/6VbzK3vuk6XusbzbRP+I6sD/H/knsahFzTTURyPr3KUmGOiXBOk+dFf
         7aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763570983; x=1764175783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpyvLKh/Mmn1vrCVutB6f5Cfy4PhM6ahAnv3kAcqCw0=;
        b=jAEjUHqw3ECubFQQcBm4aM53+ipFpeg4fEW4QkUKv7kWPcP3TBGe9+gxHsNIy0GoMs
         gVXEFLdE7EHUY9UiozuSF622JYEdwKu5Iye9pYO7RN9+7Z9dwLOwOWjJpS/KdnZh0MYX
         3xDgADdaz3WwzZ+i4T33ZHRAesE0bhbRtfcRHrFFH7a4lOx85sRjkZ7Vigi9wxbPoYsc
         3Si7qLhyNhECSmlIxqSjO8a3WiMMhq/H7hdnbRogn/2TzUBsfYHiqHXQoKsi0ibvIj+n
         azIalLa1oQ7xq+j5wsteUGzVcPs5xpvLubZIIKOEvK2u0/7nrP1UK2wHemJlBsg+WUy0
         X6og==
X-Forwarded-Encrypted: i=1; AJvYcCUt1jBxPx5vgtmJ3NfEKFourTc91bcRcNzTFMODRgHmBl25vGk/suJAHPmu5+EDF6mKMoqdu+XI1T0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyke/s9tVaw0m7ZEN2BzUiVwHWRspKNtxoe/ZBZ3Iaq1Vmfm/do
	YQXnhMF3xEmk3TS8c24yzE5hIqgsZwJQwHDxW2Hv2BnIgWA5SRtWacXvGVgPUoYCnAa89FIzA87
	xNUplW+c5u5coieLqj7gmPcLXIEJNYURu+i71nJfbTQ==
X-Gm-Gg: ASbGnctH1gZnNeauuaMszIN5iglhmId5NiObLmU8g76w42R/fEmu4VkBYvSgEhC0oAI
	K4nozYiCQCuhMmmQZ4lchrJr7JrXtzgyxC3ER0OG1OeTYZJ/pHofKwuDTt3OJda61mx6AR4Lrt6
	a0pCtMUhKNk23msyBrdx50VBVW3CuTxs9vfsQlN3kz1mXWHRTaLCLFwKAUShDcL+T/3S5LXLTDG
	6AZMVDj/xOIKf20P+/kH2jhiLPaKtV+tvBiWPMK0MP5DGYruKXC95puM2h/Ci1jQSrI9PbBo2oL
	6nBCcijwza3ZH0QV+Zh0xvDoK6CpqkDBoIOMOA==
X-Google-Smtp-Source: AGHT+IFsTisXqLbVlfib8qoYQct2imtfeHS1nqYYs5EAkrXWjXIV/4PzaUvblCYoNs8nCi4yHoHai6jS2Y+Xg+cm4JI=
X-Received: by 2002:a05:6512:3b1e:b0:595:7854:af77 with SMTP id
 2adb3069b0e04-595841b5442mr7042616e87.22.1763570983255; Wed, 19 Nov 2025
 08:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-lookup-v1-0-029b1d9e1843@linaro.org> <20251119-cs42l43-gpio-lookup-v1-1-029b1d9e1843@linaro.org>
In-Reply-To: <20251119-cs42l43-gpio-lookup-v1-1-029b1d9e1843@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 17:49:31 +0100
X-Gm-Features: AWmQ_bmjhxVSOKFkWMMGQNZ-qd7cGCoUpkpDr5ssCwk_lQAj7mY_DFCa0JUpk80
Message-ID: <CAMRc=MeD4gsyHe_rkGRgRO4p36+szobgCnc0C-CYGWZhm-dQNQ@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC 1/2] gpiolib: support "undefined" GPIO machine lookup
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Andy Shevchenko <andy@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> SPI devices can specify a cs-gpios property to enumerate their chip
> selects. In device tree, a zero entry in this property can be used to
> specify that a particular chip select is using the SPI controllers
> native chip select, for example:
>
>     cs-gpios =3D <&gpio1 0 0>, <0>;
>
> Here, the second chip select is native. Allow users to pass
> ERR_PTR(-ENOENT) as the key field in struct gpiod_lookup, indicating a
> native chip select.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 91e0c384f34ae5c0ed61ccd3a978685d4f72e867..dbb5f7fe7b661979f559fcd32=
ad6e1c463431a18 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4557,6 +4557,9 @@ static struct gpio_desc *gpiod_find(struct device *=
dev, const char *con_id,
>                 if (p->con_id && (!con_id || strcmp(p->con_id, con_id)))
>                         continue;
>
> +               if (p->key =3D=3D PTR_ERR(-ENOENT))

As the build bot pointed out - this should have been ERR_PTR(-ENOENT).

Bart

> +                       return ERR_PTR(-ENOENT);
> +
>                 if (p->chip_hwnum =3D=3D U16_MAX) {
>                         desc =3D gpio_name_to_desc(p->key);
>                         if (desc) {
>
> --
> 2.51.0
>

