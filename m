Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669AE2EA465
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 05:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAEEVn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 23:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhAEEVm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 23:21:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399BC061574;
        Mon,  4 Jan 2021 20:21:01 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m25so69559725lfc.11;
        Mon, 04 Jan 2021 20:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=B860AzMgXAcQbUHUbf70b4l/yONB7SP9ETLhkVV/9Kk=;
        b=BxxVRr19Y61/q1MfIVDbAfOD6Pn7m0N6NtJ9x15u+M5dbVYh+nUQHUAltWjM+CcrGe
         CPn/enMEeNIBifLYHbdghhPIQc3SwYr8bzoKzcwfuNlB5Sj7TrQYZsUlnizdJYLRzfq3
         nYZtFMGTwRt8NQuTqdQY4EGPeTmeNYsviJQUUGlrtNKrs+2lh58/vI4xZSJYEmeot5Ed
         3oCmivykUP/e07hDTMa9Z+eUqR26g7BUpLAbSYGcYW3Hv+ARUFxy5JRf7Qx0xClnlY7X
         4jR9uVJ1/OPguNONAPZwQqXpYtn9p58brYD2wMatJjug9tf+7NWvdFdZTTDfhsyXkif8
         rNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=B860AzMgXAcQbUHUbf70b4l/yONB7SP9ETLhkVV/9Kk=;
        b=dZ12HAYGZSzL64kSoonyuSZ5a8zdfAZ8KwSWQlNoRMFQ56zLnW5TypVXMeAMSh6HVw
         fwIh4WeSH5fz94xwE35dxJAia9T2fKKSJHwWWbbe3Qw1EE3IfHgWE42ncn8MDrbn/Npd
         c07k18N8uePpNksPfHNp6XI8jOjILX52rwW/Y76iaJWBg0OKJZzsuIdzdCXhySR52rHI
         TmyWtO1zXoLJmpnArILUYUvXP1FPXHHCKDMCj3n/+9ZnvqO+nkAeiHiqNndTniXMFWu/
         3MUXuytKiFdeHE+sHBqj8NG4S6qmA+csvVomDprxhKZtX72eJzNbb9EO0HIfamYok+DU
         JCzA==
X-Gm-Message-State: AOAM532lUlNj472yAnkgaVsC5bbK+huTKM2qy6RAJV6bBT+mnyIf+MEj
        7Jof09dAHdY8CJxR/dgCiHj3Kpwz4Z2Y9rkZZfg=
X-Google-Smtp-Source: ABdhPJzMBRIdRVxImI6rx5wCsTNCMgLaUWmYMSy2IefUCusnR45rYsdiTbOJKcHaQhm8DaDXvSHnmqk+7LFyEsc3XXo=
X-Received: by 2002:a2e:8156:: with SMTP id t22mr35076797ljg.263.1609820460360;
 Mon, 04 Jan 2021 20:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20210103035605.23973-1-tiny.windzz@gmail.com>
In-Reply-To: <20210103035605.23973-1-tiny.windzz@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 5 Jan 2021 13:20:24 +0900
Message-ID: <CAGTfZH1eE_a-qvOb+GDRogipNS1c+K48JL6pYQ3UovpQR9zUbA@mail.gmail.com>
Subject: Re: [PATCH 29/31] PM / devfreq: imx-bus: convert to use devm_pm_opp_* API
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

On Sun, Jan 3, 2021 at 12:58 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use devm_pm_opp_* API to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/imx-bus.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 4f38455ad742..ff26ef049b1b 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -61,7 +61,6 @@ static void imx_bus_exit(struct device *dev)
>  {
>         struct imx_bus *priv = dev_get_drvdata(dev);
>
> -       dev_pm_opp_of_remove_table(dev);
>         platform_device_unregister(priv->icc_pdev);
>  }
>
> @@ -123,7 +122,7 @@ static int imx_bus_probe(struct platform_device *pdev)
>         }
>         platform_set_drvdata(pdev, priv);
>
> -       ret = dev_pm_opp_of_add_table(dev);
> +       ret = devm_pm_opp_of_add_table(dev);
>         if (ret < 0) {
>                 dev_err(dev, "failed to get OPP table\n");
>                 return ret;
> @@ -141,18 +140,11 @@ static int imx_bus_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->devfreq)) {
>                 ret = PTR_ERR(priv->devfreq);
>                 dev_err(dev, "failed to add devfreq device: %d\n", ret);
> -               goto err;
> +               return ret;
>         }
>
> -       ret = imx_bus_init_icc(dev);
> -       if (ret)
> -               goto err;
> -
> -       return 0;
> +       return imx_bus_init_icc(dev);

Remove the unneeded blank line under '.return imx_bus_init_icc(dev);".

> -err:
> -       dev_pm_opp_of_remove_table(dev);
> -       return ret;
>  }
>
>  static const struct of_device_id imx_bus_of_match[] = {
> --
> 2.25.1
>


-- 
Best Regards,
Chanwoo Choi
