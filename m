Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7918732CFBE
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 10:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhCDJdT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 04:33:19 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:35387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbhCDJcv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 04:32:51 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBDrM-1lUMHm2BTC-00Cj4A; Thu, 04 Mar 2021 10:30:16 +0100
Received: by mail-oi1-f178.google.com with SMTP id w65so5825197oie.7;
        Thu, 04 Mar 2021 01:30:15 -0800 (PST)
X-Gm-Message-State: AOAM533wP01QFagunv9I2PTmsnsJ2jj3qeCwgJi3uiEHeke0a3GGjwAB
        Gj17FI6fRWtNPxn8WHpe1SSJVThJoDhMQa5SD4Y=
X-Google-Smtp-Source: ABdhPJw9uBr6qnUdYOKxaWbXMTUVBRRhs8WjTeJMLjKfrKtwZ6pHKDu0JmaPxdme0uAqtllpnrMi8LbsIwEL/vQ9FQo=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr2227269oib.11.1614850214795;
 Thu, 04 Mar 2021 01:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-3-brad@pensando.io>
In-Reply-To: <20210304034141.7062-3-brad@pensando.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Mar 2021 10:29:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1aVfA=kp-dW+YKZ9cG=sD6+efSBYtB6GXu0X4MBjb0xg@mail.gmail.com>
Message-ID: <CAK8P3a1aVfA=kp-dW+YKZ9cG=sD6+efSBYtB6GXu0X4MBjb0xg@mail.gmail.com>
Subject: Re: [PATCH 2/8] spi: cadence-quadspi: Add QSPI support for Pensando
 Elba SoC
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
X-Provags-ID: V03:K1:zZDvOlE4nqNUUuAyZzh/usSCD0KiQ6nlGSFZT31UI2ETik+ilI4
 IKMM9laWEXaB0mWupyr6SiXwcQandLRlTe5uc7B/09Z9Iss2AcUUILFTg5BJq24Bk9lf0Hj
 /BbpxcG1Wj19syF42c5Fw0F4/ZhbKOc540253cxBRNUUFBvKwMSJDKFbjHwxqE08hAzOsIF
 CQWU7RF3KIKj7S9HOZoow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0spHj1g4cLg=:/DrpZTpnGKr0guHu+hAKCQ
 6tCdSb8KPfbXYXg/dPzh80u//KkMVzb9MuL/KHFXKDj+olT/iSCh1fPcSmNVI91Cg9j4klMX9
 NcR80sEptP0ndCSYcThS9ejKd4q2ODIjqgNBf4Qn7PjGhuddjmVi+yXNSbR7LkaJq4J+Y1Rgw
 etl9brsnVCYdR+/9o+G4kWmXA/3G/Z87ixcaukYDgSOmorYQL8O0WErazzCX3cHWcn2w/heZv
 BjkYb1ArrBQk9yS7swOIVlq3/INq/UDAns1l+YPn3TwqWLIXuWjYZMp1ahYe5n0oQFygezPly
 41xhNTUQXBXj3k2cMtg/ne5R6nnf7uLSn+0nxtaws0TA9AAqS2ijmpQYRwx6pT74iuhtAKSzv
 hX0x0cgU2BvFTcBrlZYqQdKTQLkkwg8pyfqiQ/ijzKGLaM91Vtl5U5sABCkc2Z/COHN0iC1On
 8q6ouMGMroMPoejVVJD/V49w5umDSdWxP5RXie3BD1gURndjUQLHZlCaAiXhp6VgMSnJBvKEo
 pWImVsG8sbm7WX7sK3imTisPnJmn8C3SkI56Bg6T5UoajCBcC2X0v/qSVwlXtKqcg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 4, 2021 at 4:41 AM Brad Larson <brad@pensando.io> wrote:
>
> Add QSPI controller support fo Pensando Elba SoC.
>
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 442cc7c53a47..fb0d9b0bd596 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1353,6 +1353,7 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>         cqspi->rx_chan = dma_request_chan_by_mask(&mask);
>         if (IS_ERR(cqspi->rx_chan)) {
>                 int ret = PTR_ERR(cqspi->rx_chan);
> +
>                 cqspi->rx_chan = NULL;
>                 return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
>         }

Please don't mix whitespace changes with code changes.

> @@ -1632,6 +1633,10 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
>         .quirks = CQSPI_DISABLE_DAC_MODE,
>  };
>
> +static const struct cqspi_driver_platdata pen_cdns_qspi = {
> +       .quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_DISABLE_DAC_MODE,
> +};
> +
>  static const struct of_device_id cqspi_dt_ids[] = {
>         {
>                 .compatible = "cdns,qspi-nor",
> @@ -1649,6 +1654,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
>                 .compatible = "intel,lgm-qspi",
>                 .data = &intel_lgm_qspi,
>         },
> +       {
> +               .compatible = "pensando,cdns-qspi",
> +               .data = &pen_cdns_qspi,
> +       },
>         { /* end of table */ }

As mentioned in my reply to the dts file, the compatible string needs to be
somewhat more specific.

I also wonder if it would be better to define separate DT properties for the
quirks at this point, so not every new SoC using this device needs to have
its own quirks definition.

       Arnd
