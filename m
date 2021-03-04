Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B2432CFF1
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhCDJob (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 04:44:31 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbhCDJoG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 04:44:06 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVJZv-1lAuS41mZr-00SQD3; Thu, 04 Mar 2021 10:41:31 +0100
Received: by mail-ot1-f47.google.com with SMTP id r19so26656853otk.2;
        Thu, 04 Mar 2021 01:41:30 -0800 (PST)
X-Gm-Message-State: AOAM530I+9+QJkdM89ohFeJ0bIwpDYQsdXem+VG81N1gM7Co0qdOnMtJ
        YBmQmfR65LQ8A9DhNnZJBuJ3ldTm5VoilusPnR8=
X-Google-Smtp-Source: ABdhPJymlN8iq4nvYqLgYJhERzarQA0luMeji7dvb8ZzGTbfCCd8Xu6l02IlEMNWS4ELx6GbB6I7LENGDKUCNA/BBK8=
X-Received: by 2002:a05:6830:1b65:: with SMTP id d5mr2767842ote.305.1614850889650;
 Thu, 04 Mar 2021 01:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-6-brad@pensando.io>
In-Reply-To: <20210304034141.7062-6-brad@pensando.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Mar 2021 10:41:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2mQ9Tk+xeL-kdpQh3oqgNQeT6c-_KwNLQQ7mEc21fDvg@mail.gmail.com>
Message-ID: <CAK8P3a2mQ9Tk+xeL-kdpQh3oqgNQeT6c-_KwNLQQ7mEc21fDvg@mail.gmail.com>
Subject: Re: [PATCH 5/8] mmc: sdhci-cadence: Add Pensando Elba SoC support
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
X-Provags-ID: V03:K1:kqvBcIEbWL5RCul9WDc6fNmhHfAHrDegFoDqH6kNXYyjXpBPhVD
 0ShsjKMCPpyaixgCdGyTrh/sUWjFUhyJsj25McS0a96ftxJGPYKTtDvbmWjRKCLRRgeQijh
 cA2I6Gu3giO5j/QCwZ9Jv+ETyLafIuZneQtw0dDrHnwAtzSJ5qPRdYayo5ZXOUdvCXZIBj5
 A7zaqpsP//rU8ExUo45AQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fY3YxTFro3w=:MTZb1prOtD1zd5K6gp9R6G
 vr/JCs0FL3fJ1tlfCYDWU2IA5o6c/RgdeJDEYxi4rBGOuVCRTKpZUDO/4vn+Fe46kNXxbdYPz
 V1pY8BWLfJFbdre7VX5ct+qS8Zfo1LsJGVguRSmMSRGsqCJm+r95qnrGlBzj7DYDj7UeCSejt
 F/5HD12iK2QXrUJY/38xIzJ1AyMHFnXRpYg6o9RWRnVlm6092A1tLxeZN6DE2vhPkCK8pofZW
 00c/rzsJ1mh4cYDkhEKKglxhMAJxQnim7HFq2Z3SZX+RrjAa7I6ePupTFGXNjLCABaWujyo9O
 I8Ax12eCAT1xcid1qJSXM4IUN7JC5BQEHci9j71MVHobPO4s56vt815/em6FfSJ+FHhiwo9M2
 aVK3Em+bW4G2mOXaUSMTQ4HvH56R8qUMJJF2mTcrTlGnf23AJ/VzcM1vik0FhI5mQzd5gQKHX
 K1LudIB+IzlINJhh1eJ51QOMa9mXfy6eKId6pivShYtxzvNQ+wLawmDj1N/OHH3DvouoLsboO
 ohV31rEDGyGfet9ztLhVUEi0MGut8yUWHtcDbkq/HkxZVGuUJpronDWFSgofF53Og==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 4, 2021 at 4:41 AM Brad Larson <brad@pensando.io> wrote:

> +
> +static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
> +{
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->wrlock, flags);
> +       writel(0x78, priv->ctl_addr);
> +       writel(val, host->ioaddr + reg);
> +       spin_unlock_irqrestore(&priv->wrlock, flags);
> +}

Please be aware that the spinlock does not actually guarantee serializing
a series of mmio writes unless the MMIO mapping is non-posted, or
you follow it with a readl() from the same device before the spin_unlock().

> @@ -453,8 +441,14 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
>  static const struct of_device_id sdhci_cdns_match[] = {
>         {
>                 .compatible = "socionext,uniphier-sd4hc",
> -               .data = &sdhci_cdns_uniphier_pltfm_data,
> +               .data = &sdhci_cdns_uniphier_drv_data,
>         },
> +#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
> +       {
> +               .compatible = "pensando,elba-emmc",
> +               .data = &sdhci_elba_drv_data
> +       },
> +#endif
>         { .compatible = "cdns,sd4hc" },
>         { /* sentinel */ }
>  };

This introduces a reverse dependency between the modules, which will cause
problems at link time depending on how you configure it. There are two ways
to avoid this:

a) the simple method is to always link every backend into the driver module,
usually leaving them all enabled at compile time.

b) once this gets out of hand because there are too many variants, or the
differences between them are too big, you refactor the common code into
a library module that just exports a functions but has no module_init()
itself, plus a front-end driver for each variant, which now calls into
the common
code rather than being called by the common code.

      Arnd
