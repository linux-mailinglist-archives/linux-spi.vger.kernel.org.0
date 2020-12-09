Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCD2D46F7
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgLIQmK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 11:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbgLIQmB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 11:42:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573CBC06179C
        for <linux-spi@vger.kernel.org>; Wed,  9 Dec 2020 08:41:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a12so2444958wrv.8
        for <linux-spi@vger.kernel.org>; Wed, 09 Dec 2020 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7EU11PHgFsJFA5nDKbU03Fk+7GyGqDKScGIXgeNQqU=;
        b=eG+oWcIvbvjeSujB8w9rC9FysPL6rBXwMAfVo+NMk/6Vn5Myb8MwqqPgOooFPsZ/uV
         F3mZu/o6uqakiRyeYYzyVDrlewRY41v1pg/KMxL2jGhKoZO8r32FikNzZL9F7NnxW2xT
         WtfBARKMIm2z1zU5M6Bvhn4czPwUeXdSJm0Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7EU11PHgFsJFA5nDKbU03Fk+7GyGqDKScGIXgeNQqU=;
        b=V69ZWdljufbgdJPLoJq2EKORv7BSlgLvUGn/gqEGkOc7MlTTYcddyBbOCSZZQAsoB9
         zNVT2164pWUUW+VS9el2hwMiX3LHE6rCLhqiX9lqrfkws655syIqhxCrWGPkhLqxYWdp
         QFatwF5cWoQ0nVy1ybaZ9O0Gp6xEehlhlF+oDmzFpOzVi19Jh/B/jFZxdLf0wet8YdM1
         ++MigK7L36+Rt1Ezee++qUAbifJIBzmf5gLxAMg3Rj48e2kCuySMKPoC0FruXfoAl0ob
         cWslEptuEecWyEKOtGn1qNNbHw/89o2riq+YbOVWy3euoscbGF3qnEccw+TzDTAT79Y9
         sOmA==
X-Gm-Message-State: AOAM533snwYyThfiPkmYPwgl55SPGA5ETHkKkTSLmjs+c8ByhsOXfpK4
        vPoCA+ZosfnmRveFMk4MRr9EkMrDQUTx3nPcdnCHFA==
X-Google-Smtp-Source: ABdhPJxEl7OMQ/htwgbOiYGTRVp2/9MuAsCc5a1dKA3v6HasSTKSz48ecmPqg7FmN5ROLORNuwCpkQnYAmtTmfvAthU=
X-Received: by 2002:adf:82c8:: with SMTP id 66mr3598316wrc.420.1607532079884;
 Wed, 09 Dec 2020 08:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20201204193540.3047030-1-swboyd@chromium.org> <20201204193540.3047030-2-swboyd@chromium.org>
In-Reply-To: <20201204193540.3047030-2-swboyd@chromium.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 9 Dec 2020 09:41:08 -0700
Message-ID: <CAPnjgZ1nV4FTvA9zAh046Vpki01WfVcowP8CPxrx1b3dONM-Og@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_spi: Don't overwrite spi::mode
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, lk <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 4 Dec 2020 at 12:35, Stephen Boyd <swboyd@chromium.org> wrote:
>
> There isn't any need to overwrite the mode here in the driver with what
> has been detected by the firmware, such as DT or ACPI. In fact, if we
> use the SPI CS gpio descriptor feature we will overwrite the mode with
> SPI_MODE_0 where it already contains SPI_MODE_0 and more importantly
> SPI_CS_HIGH. Clearing the SPI_CS_HIGH bit causes the CS line to toggle
> when the device is probed when it shouldn't change, confusing the driver
> and making it fail to probe. Drop the assignment and let the spi core
> take care of it.
>
> Fixes: a17d94f0b6e1 ("mfd: Add ChromeOS EC SPI driver")
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_spi.c | 1 -
>  1 file changed, 1 deletion(-)


Reviewed-by: Simon Glass <sjg@chromium.org>


>
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index dfa1f816a45f..f9df218fc2bb 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -742,7 +742,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>         int err;
>
>         spi->bits_per_word = 8;
> -       spi->mode = SPI_MODE_0;
>         spi->rt = true;
>         err = spi_setup(spi);
>         if (err < 0)
> --
> https://chromeos.dev
>
