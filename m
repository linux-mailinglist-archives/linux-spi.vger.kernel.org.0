Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67FF440EA1
	for <lists+linux-spi@lfdr.de>; Sun, 31 Oct 2021 14:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhJaNW6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 31 Oct 2021 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJaNW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 31 Oct 2021 09:22:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECD4C061570;
        Sun, 31 Oct 2021 06:20:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so31130106lfu.5;
        Sun, 31 Oct 2021 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ml4HoePorbB3uwkIfZq01AIVq0ZLevX5o6NsPpTI0c=;
        b=Z3igLXnvuoQJi5FZI1JWL5XpYtUVODbUdysV9oUu5OA3HDGCPOzuRbO7WVkArCUQrg
         wgiG7jp1XeX1iz2oD4i/mtdZvM9Skf2wEz4OZ/nhZcTXLbDG7s7NeSC6ty1ZINRWX7oE
         tzY8CPLppOpZY0ufRBzwHiPe88ubKrX5Sw5iMA6rD4dq05XCHtjw1xm1tBE5a7Fc9hvt
         dD+7JuGa+vtqjJt8cqXk3BL7i2lFCnzxnMIbu6cbNCkohEiWPeOKEca9l7qWWZNNBGvS
         wv7X1r98dboww6i/4/5HX3+XP/1Hsq7JuH9Iu5vUS9LFnRLGg1Eng7C9PKrT/P8fJWX4
         Ywmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ml4HoePorbB3uwkIfZq01AIVq0ZLevX5o6NsPpTI0c=;
        b=SvUOyMaFUifPGvy3eGjC41x4BYOhFvlOyWxJxvTt028E9iF0SVtXmaxy9LPS4IuQHJ
         ibry2PigUSJYIFwAwzCr3ugc3qChYk0MAq1eXNJr4vnCbTcmvrfXqqq8mSCQuSUZNHbS
         XlJoP23NpgFwBvkbh+cUsF56sB35IhbNjrnfgKuwHQZJdPu+lXRqhSxUKLxoufy9BWmU
         Ouzg9o5ruOawykOaR3Qf2A5tGDzo+0m9v221/nEBMfl1CDv/ot4caN4m4sTPEaNGPHQe
         uzTM05khL/2wIX+kRdzEUDY0ur4HBd9mjceeekCo9NPwSzqh/uaJt7jzhiUZaOTjF00W
         8z2Q==
X-Gm-Message-State: AOAM531RE+Yq1zvMTS5O+f2VmSou3rqLMsz2YzNSJP1+MoIV0mQYQIuw
        aHKNv7Ripjtma/g0v61uGM8ujdQO0w91hZRSpvA9xQuf/J9BcQ==
X-Google-Smtp-Source: ABdhPJwP5ltZLEYCpy4Y5wYCMLT1QMQ2cfYoIJAC3xlPjQsGl38qoc2SBcUim8j5r+MqhRS8M8IuZ3nlHwBbfTcu4u4=
X-Received: by 2002:a05:6512:260e:: with SMTP id bt14mr22784564lfb.129.1635686424771;
 Sun, 31 Oct 2021 06:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-11-brad@pensando.io>
In-Reply-To: <20211025015156.33133-11-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 15:19:48 +0200
Message-ID: <CAHp75Vejm7exqWY9XcaJQCqLgUvoM5E93=0JV2Wew7T6WzTKpg@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] spi: dw: Add support for Pensando Elba SoC
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 25, 2021 at 4:54 AM Brad Larson <brad@pensando.io> wrote:
>
> The Pensando Elba SoC includes a DW apb_ssi v4 controller
> with device specific chip-select control.  The Elba SoC
> provides four chip-selects where the native DW IP supports
> two chip-selects.

...

> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> +{
> +       struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +       struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
> +       struct dw_spi_elba *dwselba = dwsmmio->priv;

> +       u8 cs = spi->chip_select;

Much easier to maintain and follow the code (in the future) if this
assignment is broken to two parts, i.e...

> +

...like this

       cs = spi->chip_select;
       if (cs < 2) {
         ...

> +       if (cs < 2) {
> +               /* overridden native chip-select */
> +               elba_spics_set_cs(dwselba, spi->chip_select, enable);
> +       }

...

> +       regmap = syscon_node_to_regmap(args.np);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&pdev->dev, "could not map pensando,spics\n");
> +               return PTR_ERR(regmap);
> +       }

Why not return dev_err_probe()?

-- 
With Best Regards,
Andy Shevchenko
