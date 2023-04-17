Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C356E4C0D
	for <lists+linux-spi@lfdr.de>; Mon, 17 Apr 2023 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDQOze (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Apr 2023 10:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjDQOzR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Apr 2023 10:55:17 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DB276B0
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 07:55:04 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54ee0b73e08so423038167b3.0
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743303; x=1684335303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fur1vsPRYGb4bHxVHQwC4yeXMQ8BUZiX8URDo13Jh5Y=;
        b=ca8I5OXFRjYtVdJWR6zaa7SLc3Z539o4eA0Di+IdBEAIVQ4xOXztVzyAH4LVv0DxjM
         wGc5KKb+cA8eVcpSZ9j4njPgrIhaUiSdoBKNB5dcEK2E/zZED6IopD6QtB1b2Jo8kqS+
         8jUU6h44FLRSNsUISU5cp2136sZKefYaglt4nkEE21tz/ELQZ3YdvXZqITWaXdLXbYsg
         XAojCHxjZko9EZseS9DNgvDvQ18Y4nDejlC21UorzTaJrOoua5XMxgytfjzpXjlXwDqx
         tBpbxi86nTrfu6InrIT7OmffVNTgaEGtZDDgeiJrA2zpbdhz05SwImYyRaebjUbed3RG
         ecbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743303; x=1684335303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fur1vsPRYGb4bHxVHQwC4yeXMQ8BUZiX8URDo13Jh5Y=;
        b=WbRlLA1hmlUDcs6hhyoooGHTaxQiKJ7zbDxhYI2fA82VZC0Yf/2+pbi4kH+d47o1t4
         7m8jJncPRYGk+zEoiyhYuBQqmIYZYBSYrO6200bKUkZBUpALxuuzHBXWFtAqp6XdvcUq
         RU4ZAFjbS0nIbJxMyGh5HSarJ9/+kYGjDOX2NV2+XVcnHhdCSi311AGXg6MQW4rrrfu/
         vegSbOqUHJNX9iRzYxit68A6tO5wHKk6kuzwHtz+cJiiA87J0zxOFbHT/iOFMcq+m/Lb
         BXklJT3epBu0gBcXLKaEyMDrPBcw0wvMX1gn4hker+tJC9llOizhU0ZRgMeg9tMeU2EO
         regA==
X-Gm-Message-State: AAQBX9eq0zR3TLRBLQuDOySyTZaybo2KKRSncQnbU4MO4dM9QvQAua4J
        foo9OG3W+EMJeky/lrtQ/9hP5UB54UZRW3mg4t6cOJmDdurbwT4DPdo=
X-Google-Smtp-Source: AKy350a/ZGQMRyt4s8YkzjxrQpaJdxmrR2L1AJJHpIMfsU2yGCHbxIgTQY1VbhWTD8ze1dcmY23ZOAPuN9GaR90A+/8=
X-Received: by 2002:a81:af1e:0:b0:52e:e095:d840 with SMTP id
 n30-20020a81af1e000000b0052ee095d840mr9538749ywh.0.1681743303598; Mon, 17 Apr
 2023 07:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230410184526.15990-1-blarson@amd.com> <20230410184526.15990-15-blarson@amd.com>
In-Reply-To: <20230410184526.15990-15-blarson@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:27 +0200
Message-ID: <CAPDyKFqCv5Y7UzV2vi-500Nq2t4wze4xnXq8=S=DKNTH3HCh0A@mail.gmail.com>
Subject: Re: [PATCH v13 14/15] mmc: sdhci-cadence: Support mmc hardware reset
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 10 Apr 2023 at 20:48, Brad Larson <blarson@amd.com> wrote:
>
> Add support for mmc hardware reset using a reset-controller
> that would need to be enabled in the device tree with
> a supporting driver.  The default is disabled for all
> existing designs.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v9 changes:
> - Previously patch 17/17
> - Changed delay after reset_control_assert() from 9 to 3 usec
> - Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()
>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 5d1e9cef74f5..b24aa27da50c 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -12,6 +12,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/reset.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -70,6 +71,7 @@ struct sdhci_cdns_priv {
>         spinlock_t wrlock;      /* write lock */
>         bool enhanced_strobe;
>         void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
> +       struct reset_control *rst_hw;
>         unsigned int nr_phy_params;
>         struct sdhci_cdns_phy_param phy_params[];
>  };
> @@ -457,6 +459,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                          SDHCI_CDNS_HRS06_MODE_MMC_HS400);
>  }
>
> +static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +
> +       dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
> +
> +       reset_control_assert(priv->rst_hw);
> +       /* For eMMC, minimum is 1us but give it 3us for good measure */
> +       udelay(3);
> +
> +       reset_control_deassert(priv->rst_hw);
> +       /* For eMMC, minimum is 200us but give it 300us for good measure */
> +       usleep_range(300, 1000);
> +}
> +
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> @@ -520,6 +538,15 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free;
>
> +       if (host->mmc->caps & MMC_CAP_HW_RESET) {
> +               priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
> +               if (IS_ERR(priv->rst_hw))
> +                       return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> +                                            "reset controller error\n");
> +               if (priv->rst_hw)
> +                       host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto free;
> --
> 2.17.1
>
