Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD142C819
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbhJMRzn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 13:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhJMRzm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 13:55:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10E6C061746
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 10:53:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w19so13812941edd.2
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vL4wHlXoObWaIJMSvBAH6mZwwplVWNyO56sQB7dapM0=;
        b=2dnJLUKCx3K8k6fe4zGbY7WUtBRVBbtEbodzjAjTbKDCvn4VI68gWEPjuCOqpkPp/V
         c5PpJSWrPVO5JGQimGHojdmLzaCGu0ouUAtd93GLWlifhwz0jkbhHT94YMv/29NeHJMX
         mR0iHW9EW83TvnmB1ke9D7RylbWDYCCeATLYA8xlWlIEcsZeUL040Mzl3a1mgn827Nxh
         t1p7HoSoVI5pILkj5Y0gM7XXv/LhHrfKi9OzAnNT74zI5CFttqyjODSRpwrGrJ787zKm
         CcI3ISJpaA84IdgI+j8EcX6HYRFpi8FzmmsRlRPYGDr481IUESWaJu0hn1ii0MsdqU2p
         ubBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vL4wHlXoObWaIJMSvBAH6mZwwplVWNyO56sQB7dapM0=;
        b=nlRcGQb+cHzKBFf6CY8YE29ojyGpE9/p2QF/A0A4rp7pPAt6AArzzKghrzT8pxcRm/
         XOy/Hl12UkOLYDXQjZDZU8ubLtV6gkFUBlCg614q0P7t7Cw1l7NNwgqNIwP5s93rQbbO
         wOnWVXwPR4SNk//bZyFPcv3sjK4gSpTOmBCiTzPS7b/3lg2yoXxHE1+ApZrAqnmpB5kl
         61a5+1ar2MGsnhgenbog+mXCJC1nmDF0SnF5uIR5qZclEW0EEZRVVl+TtSAwoXUqi6W2
         VrT62pFRZoD2e9NszJtMX3T1NAevtS3nxiw0H9Bu2ejP0WEWX+pqgEvt7wwd6nln/tOe
         dcsA==
X-Gm-Message-State: AOAM531+KYZTw6e7uYMuADbI1NW5jd4zDnfZ6+jwCRQPcVxZyjrjIETq
        MnfW7RHpBHBZ36erd3BrTfiIQBMGFhWjm9RaxM54aOJTKVDDqg==
X-Google-Smtp-Source: ABdhPJwGLvGKJU0T4kkxzDIrIomjfXEHdeUC+7jxo1/eKA4gya0frJUJrIpmu+tpnhWl1oJJTZAy3XPSevWXUtNtx5U=
X-Received: by 2002:a17:907:2bc2:: with SMTP id gv2mr733986ejc.433.1634147617387;
 Wed, 13 Oct 2021 10:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de> <20211012153945.2651412-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211012153945.2651412-4-u.kleine-koenig@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Oct 2021 19:53:26 +0200
Message-ID: <CAMRc=Mcx1+dXwUQNnpKGtq7_nCMQo7xxDLUs5mJ=bVRT8-CuHw@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] gpio: mc33880: Drop if with an always false condition
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 12, 2021 at 5:39 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> An spi remove callback is only called for devices that probed
> successfully. In this case this implies that mc33880_probe() set a
> non-NULL driver data. So the check for mc being NULL is never true and
> the check can be dropped.
>
> Also the return value ofspi remove callbacks is ignored anyway.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpio/gpio-mc33880.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
> index f8194f7c6186..31d2be1bebc8 100644
> --- a/drivers/gpio/gpio-mc33880.c
> +++ b/drivers/gpio/gpio-mc33880.c
> @@ -139,8 +139,6 @@ static int mc33880_remove(struct spi_device *spi)
>         struct mc33880 *mc;
>
>         mc =3D spi_get_drvdata(spi);
> -       if (!mc)
> -               return -ENODEV;
>
>         gpiochip_remove(&mc->chip);
>         mutex_destroy(&mc->lock);
> --
> 2.30.2
>

Applied, thanks!

Bart
