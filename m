Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809DF32CFCB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 10:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhCDJhD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 04:37:03 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:48449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbhCDJgo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 04:36:44 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N30VJ-1llby93tLJ-013P6q; Thu, 04 Mar 2021 10:34:09 +0100
Received: by mail-ot1-f51.google.com with SMTP id v12so25508865ott.10;
        Thu, 04 Mar 2021 01:34:08 -0800 (PST)
X-Gm-Message-State: AOAM531K6U4Pz/T2CG3GZQplToTbh/nZo/W2EWUFwx7iNrwMhobKsdkZ
        +nIq13nIr7vthMybEJHBToovOmPv2S6Tj5zW9+0=
X-Google-Smtp-Source: ABdhPJzdWUmRHp4/lKLXv6+q2Thn0Sc0nr1QD99ZxxURYeZleIgI699G+WxW+sTjwSsYr4dfIETXbVshldOB36R2nMg=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr2798119otq.210.1614850447259;
 Thu, 04 Mar 2021 01:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-5-brad@pensando.io>
In-Reply-To: <20210304034141.7062-5-brad@pensando.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Mar 2021 10:33:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Wi5YrTFvfMopzBPdWrZi03abDhL_PanJ4HZ=Ycx8s3g@mail.gmail.com>
Message-ID: <CAK8P3a0Wi5YrTFvfMopzBPdWrZi03abDhL_PanJ4HZ=Ycx8s3g@mail.gmail.com>
Subject: Re: [PATCH 4/8] spidev: Add Pensando CPLD compatible
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:seRvg0yhGSVe9OKFJx/AdzC6Z6J8W7Yhhtv/pNsPzHNCOpa2R8R
 pTnmKCxJLaq3piXSLbEnZz7mAd0jrIaqYbktGLZIaFX8EnXHi9blsl854kTWlCfaAxnCjrq
 jmmA1KZ55lEIR4Vrmynv6H9fFTgvgj2eecHwhMXNEvpANqv9IDV2IhqodpAFs8kKNV+EmPx
 inae/8YJeTb6T6VIgX+tQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3JkiklS7VkA=:JoShOBsLn/zRSJOhd3kGMH
 +W+e8xEZ/rGtTFkcsHuoCYTRpHai47x2AgPTZ4q/VFJMsgIDfJwhBGaZAI8ZqSFGfmIh+drD7
 xQmkCMKOeMyVNELSR6vYcr9P39qsaWDQu2WsPumzan5UNnRmBCdiIK9XswCe4I5yqhhBD0KTk
 mEauzZ7k398LG7O6CByBeUfFJEPqiRB8v2mLrkS9jkPE1dw9ZFVWw6t+nnE8RqNh9fROLcwgl
 +J/7LsPASVnJNecoHsCLv3m3YkYcFWZldgA7BgcsQDlyv5cir77p6/qCn2ZpsFLeTlHoif32m
 BQTbgf55gNmWDhrs0YmEatIAPtCRuMvBxQ2br6PllQWwqdMPzrIH0l5a1GJSQ3B/AILVg+6rD
 nXmLsaNzvY2oRZIDK8trqA+GwfKoXiPLdOC9zUlouOxX8ymWOLExvXmVGiFJt6YDdPpmy+7Iu
 LW5yk53WfbN+UbiHTyQoLZXvsGAAWmWQF6wmamqhkJNwnEinWTDoOypW0nOnyIQ/pBNRv2f/l
 D5hYetov2nd1exf9wJR/vM1Qi3vFPgSxROGjmxoQurZSBwnS7OKR+TyRsgqXJzpwg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 4, 2021 at 4:41 AM Brad Larson <brad@pensando.io> wrote:
>
> Pensando Elba SoC platforms have a SPI connected CPLD
> for platform management.
>
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  drivers/spi/spidev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 8cb4d923aeaa..8b285852ce82 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -683,6 +683,7 @@ static const struct of_device_id spidev_dt_ids[] = {
>         { .compatible = "dh,dhcom-board" },
>         { .compatible = "menlo,m53cpld" },
>         { .compatible = "cisco,spi-petra" },
> +       { .compatible = "pensando,cpld" },
>         {},
>  };

This does not seem appropriate, I think a platform management driver should
have a proper kernel abstraction instead of a user passthrough.

As mentioned elsewhere, it also needs to be way more specific. If this
is a programmable block, the compatible string might in fact need to
contain both a board identifier and a revision number for the programmable
logic, to ensure that the driver knows how to talk to it.

      Arnd
