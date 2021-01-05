Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFC2EA480
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 05:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbhAEEgf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 23:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbhAEEge (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 23:36:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62621C061574;
        Mon,  4 Jan 2021 20:35:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m25so69612140lfc.11;
        Mon, 04 Jan 2021 20:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qD0FtR3erA6kwegaSx7IL4OPdx8eCkd9tLpFM4vCzPY=;
        b=rYL8dvYN5oG6NMZCw7RacaHc5WfWoK4sWwnsrAxrQ6ENTf7OgGvXR2CaVxxY3Pm0xj
         2wHteUcLw+UdA9zkhQnfjL+pDwM/S7IfQ9+rvd/GHb5ZzQN/fEeUdz0uN+2/j9SOg6DP
         5vw3ERODdcr+6F4e/FN03trftl/vgCdI7R9pya3NN2I51/sPqojOow2owtRxTygVBuvp
         LE3KiAjk/uSPfMpnzHMs1jABf71rOnSyPVWDTYkUJlTy5/AC0VJb3lfQ2g1NinVUBHlt
         Zr9u+Za3bswf+TvU9qLTO5vVv+3sgI0BfHR1yLjB0T/AJqaBrNwZRriBTLVmchP0zYQA
         YOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qD0FtR3erA6kwegaSx7IL4OPdx8eCkd9tLpFM4vCzPY=;
        b=Vu9Xw2jvmLjSXf7pygsxgbH7sUqvYa/Nzt0XvSj96i93RTuJSQ13d1qtzflyatmTF0
         Klsx2PoLlUX3oBzLeUy8MlAeNd4aVeV8sVnzra+1KLgvMufhFI7UqV21iiLa/pcanmSL
         BSNFz3v3rCCKHUjv7fQMAklnVwT+DUl1bZCTZM3uMo0gDedJSyF535i2fTQxKWqMHNuO
         CjBwg7I11uTy36Jgu8B9GqVheiLmToigBGoRDPs1zZflPKUeh2EuECLrf52ujKgfpUE+
         uH678vaYmEfLxmodr0EPeNMEc7wjF00t2QbeDmw0jZS44RGnclHFsCw13slbBeL82T4c
         Mi0g==
X-Gm-Message-State: AOAM532S79zbqKaJf9HMm9o2xrPoN9+vvv0GVEZl82k+k4SGH1cOpAz+
        IkrC/uyt+7KIzj9XHMARGPzYhLFpKcY7ZL8k46s=
X-Google-Smtp-Source: ABdhPJyWYSFe/zFRwlGX58UpgZM9x8XaWgX72JT+MdQWG2gDkQiLQbB2JXbuavsJ8jCM6zO6wI9/iwcg9EeH+QwJSXE=
X-Received: by 2002:a05:6512:94f:: with SMTP id u15mr31040115lft.389.1609821351878;
 Mon, 04 Jan 2021 20:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20210103035639.24076-1-tiny.windzz@gmail.com>
In-Reply-To: <20210103035639.24076-1-tiny.windzz@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 5 Jan 2021 13:35:15 +0900
Message-ID: <CAGTfZH3Rb8qsT6ZtT9QWb_oU_Nt9z+UaiyWkExo1uzSDKz6g8A@mail.gmail.com>
Subject: Re: [PATCH 30/31] PM / devfreq: exynos: convert to use devm_pm_opp_* API
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, yuq825@gmail.com,
        David Airlie <airlied@linux.ie>, daniel@ffwll.ch,
        robdclark@gmail.com, sean@poorly.run,
        Rob Herring <robh@kernel.org>, tomeu.vizoso@collabora.com,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        stanimir.varbanov@linaro.org, agross@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        mchehab@kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, ddavenport@chromium.org,
        jsanka@codeaurora.org, rnayak@codeaurora.org,
        tongtiangen@huawei.com, miaoqinglang@huawei.com,
        khsieh@codeaurora.org, abhinavk@codeaurora.org,
        chandanu@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        varar@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        harigovi@codeaurora.org, rikard.falkeborn@gmail.com,
        natechancellor@gmail.com, Georgi Djakov <georgi.djakov@linaro.org>,
        akashast@codeaurora.org, parashar@codeaurora.org,
        Doug Anderson <dianders@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Jan 3, 2021 at 12:59 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use devm_pm_opp_* API to simplify code, and remove opp_table
> from exynos_bus.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/exynos-bus.c | 42 ++++++++----------------------------
>  1 file changed, 9 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index e689101abc93..51752e5ce980 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -33,7 +33,6 @@ struct exynos_bus {
>
>         unsigned long curr_freq;
>
> -       struct opp_table *opp_table;
>         struct clk *clk;
>         unsigned int ratio;
>  };
> @@ -159,10 +158,7 @@ static void exynos_bus_exit(struct device *dev)
>
>         platform_device_unregister(bus->icc_pdev);
>
> -       dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
> -       dev_pm_opp_put_regulators(bus->opp_table);

OPP uses the clock and regulator. It means that there are dependency
between them and the sequence for resource free.

I think that OPP should be removed before clock and regulator.
Your patch always guarantee this dependency? If not, we have to
free the resource according to the dependency.

> -       bus->opp_table = NULL;
>  }
>
>  static void exynos_bus_passive_exit(struct device *dev)
> @@ -171,7 +167,6 @@ static void exynos_bus_passive_exit(struct device *dev)
>
>         platform_device_unregister(bus->icc_pdev);
>
> -       dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
>  }
>
> @@ -183,15 +178,13 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>         const char *vdd = "vdd";
>         int i, ret, count, size;
>
> -       opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
> +       opp_table = devm_pm_opp_set_regulators(dev, &vdd, 1);
>         if (IS_ERR(opp_table)) {
>                 ret = PTR_ERR(opp_table);
>                 dev_err(dev, "failed to set regulators %d\n", ret);
>                 return ret;
>         }
>
> -       bus->opp_table = opp_table;
> -
>         /*
>          * Get the devfreq-event devices to get the current utilization of
>          * buses. This raw data will be used in devfreq ondemand governor.
> @@ -199,25 +192,20 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>         count = devfreq_event_get_edev_count(dev, "devfreq-events");
>         if (count < 0) {
>                 dev_err(dev, "failed to get the count of devfreq-event dev\n");
> -               ret = count;
> -               goto err_regulator;
> +               return count;
>         }
>         bus->edev_count = count;
>
>         size = sizeof(*bus->edev) * count;
>         bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
> -       if (!bus->edev) {
> -               ret = -ENOMEM;
> -               goto err_regulator;
> -       }
> +       if (!bus->edev)
> +               return -ENOMEM;
>
>         for (i = 0; i < count; i++) {
>                 bus->edev[i] = devfreq_event_get_edev_by_phandle(dev,
>                                                         "devfreq-events", i);
> -               if (IS_ERR(bus->edev[i])) {
> -                       ret = -EPROBE_DEFER;
> -                       goto err_regulator;
> -               }
> +               if (IS_ERR(bus->edev[i]))
> +                       return -EPROBE_DEFER;
>         }
>
>         /*
> @@ -234,12 +222,6 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>                 bus->ratio = DEFAULT_SATURATION_RATIO;
>
>         return 0;
> -
> -err_regulator:
> -       dev_pm_opp_put_regulators(bus->opp_table);
> -       bus->opp_table = NULL;
> -
> -       return ret;
>  }
>
>  static int exynos_bus_parse_of(struct device_node *np,
> @@ -264,7 +246,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>         }
>
>         /* Get the freq and voltage from OPP table to scale the bus freq */
> -       ret = dev_pm_opp_of_add_table(dev);
> +       ret = devm_pm_opp_of_add_table(dev);
>         if (ret < 0) {
>                 dev_err(dev, "failed to get OPP table\n");
>                 goto err_clk;
> @@ -276,15 +258,13 @@ static int exynos_bus_parse_of(struct device_node *np,
>         if (IS_ERR(opp)) {
>                 dev_err(dev, "failed to find dev_pm_opp\n");
>                 ret = PTR_ERR(opp);
> -               goto err_opp;
> +               goto err_clk;
>         }
>         bus->curr_freq = dev_pm_opp_get_freq(opp);
>         dev_pm_opp_put(opp);
>
>         return 0;
>
> -err_opp:
> -       dev_pm_opp_of_remove_table(dev);
>  err_clk:
>         clk_disable_unprepare(bus->clk);
>
> @@ -425,7 +405,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>         /* Parse the device-tree to get the resource information */
>         ret = exynos_bus_parse_of(np, bus);
>         if (ret < 0)
> -               goto err_reg;
> +               return ret;
>
>         if (passive)
>                 ret = exynos_bus_profile_init_passive(bus, profile);
> @@ -456,11 +436,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>         return 0;
>
>  err:
> -       dev_pm_opp_of_remove_table(dev);
>         clk_disable_unprepare(bus->clk);
> -err_reg:
> -       dev_pm_opp_put_regulators(bus->opp_table);
> -       bus->opp_table = NULL;
>
>         return ret;
>  }
> --
> 2.25.1
>


-- 
Best Regards,
Chanwoo Choi
