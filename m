Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A452EA414
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 04:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbhAEDsg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 22:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhAEDsf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 22:48:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564FBC061794;
        Mon,  4 Jan 2021 19:47:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m25so69441471lfc.11;
        Mon, 04 Jan 2021 19:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=h3dbOszFbt6OQaWtwfejouXLhmx5RSkLak0dmAl0EsE=;
        b=X2HIPa+2nYHaUq4baszZeg/1lPwfRlrkiazbu8bWAZ/4KVDEZZ8UJLHkCiHzu5BoPv
         +d1r6dGtLI/e5iSeLti/uFDhKLFXF3tY06Jdc3OuTB+60jcWy7nbxvR/X/sbuy5Z2y0a
         zy9Qm2wdvLKFzbzpL5PwnIXh21X/23EVG7mYWxKtxfix082rS5faNNu/pQ57no+v4JD+
         BaQRjUTLWwn1bDT7po749l/CDI6APyFbpmhm4QydCPb2EdRw7tEUospHsYRRgYR6FHym
         oOmjm0bgU9pTqMTv2DoYi3myavoG+000acurgbb4dfthX9S8jl7kSgIjjgmMtRlfqb7V
         Jf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=h3dbOszFbt6OQaWtwfejouXLhmx5RSkLak0dmAl0EsE=;
        b=dd7G3Lb1vaKfHk24dyZxF8NzW1w9V2tfzyOCOJtHql4Jdc7Ln21wRiYgpe62h4dMlh
         HcECjkvf5cmv6Qg/AoIxslXpsDYiNj1rVcy/AGwXEfCk3eGS5UgQPOckRhfr1rxVA7y0
         NTVI6q1N4eisgYlqmdfDanjvhTaomlSLM0B7sMB4ZdZMbk+74bb3j0L0/hD0yvnMtf/L
         mKfFtneEN79Y0LYpSA9IyJAE89XsojR30EPH15BbLTLgKAZ44TZIRtwltSFz6H4OO7Vc
         SqLixdOO/BIR4yE60fjImPZuOw68glbRU6PBStAoVc7Yrvdei+Qq2WCvI/gMuqOALsx2
         E6Gw==
X-Gm-Message-State: AOAM530zwnG8HMQmoTyLufFQhzAb9NS8gQL18hxPbRPhdLAXwVjYJGgQ
        TrGGF5oXeK8DSTdRJQTs6Zm3OKyOizJXfhkQAjg=
X-Google-Smtp-Source: ABdhPJycvDA2y0kJZnyrX/YoD11eP5GdGX7X4MHU9HChkkRYsRnd6ay+qNKHQmx0en+WU3/yCpN8x9PBPa2srmvjcdU=
X-Received: by 2002:a19:6b0d:: with SMTP id d13mr32595793lfa.63.1609818472823;
 Mon, 04 Jan 2021 19:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20210103035445.23696-1-tiny.windzz@gmail.com>
In-Reply-To: <20210103035445.23696-1-tiny.windzz@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 5 Jan 2021 12:47:16 +0900
Message-ID: <CAGTfZH0sLh=8XhBVOzUr9qO2w_=jp-OuWoh5vgNpnmXq6EzYHA@mail.gmail.com>
Subject: Re: [PATCH 26/31] PM / devfreq: tegra30: convert to use devm_pm_opp_* API
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

Hi,

On Sun, Jan 3, 2021 at 12:57 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use devm_pm_opp_* API to simplify code, and remove opp_table
> from tegra_devfreq.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 117cad7968ab..4984cb91e9ea 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -178,7 +178,6 @@ struct tegra_devfreq_soc_data {
>
>  struct tegra_devfreq {
>         struct devfreq          *devfreq;
> -       struct opp_table        *opp_table;
>
>         struct reset_control    *reset;
>         struct clk              *clock;
> @@ -794,6 +793,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>         struct tegra_devfreq_device *dev;
>         struct tegra_devfreq *tegra;
>         struct devfreq *devfreq;
> +       struct opp_tabl *opp_table;

opp_tabl -> opp_table. It will make the build error. Please do build
test at least.

>         unsigned int i;
>         long rate;
>         int err;
> @@ -841,25 +841,25 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>                 return err;
>         }
>
> -       tegra->opp_table = dev_pm_opp_set_supported_hw(&pdev->dev,
> -                                                      &hw_version, 1);
> -       err = PTR_ERR_OR_ZERO(tegra->opp_table);
> +       opp_table = devm_pm_opp_set_supported_hw(&pdev->dev,
> +                                                &hw_version, 1);
> +       err = PTR_ERR_OR_ZERO(opp_table);
>         if (err) {
>                 dev_err(&pdev->dev, "Failed to set supported HW: %d\n", err);
>                 return err;
>         }
>
> -       err = dev_pm_opp_of_add_table(&pdev->dev);
> +       err = devm_pm_opp_of_add_table(&pdev->dev);
>         if (err) {
>                 dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
> -               goto put_hw;
> +               return err;
>         }
>
>         err = clk_prepare_enable(tegra->clock);
>         if (err) {
>                 dev_err(&pdev->dev,
>                         "Failed to prepare and enable ACTMON clock\n");
> -               goto remove_table;
> +               return err;
>         }
>
>         err = reset_control_reset(tegra->reset);
> @@ -917,10 +917,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>         reset_control_reset(tegra->reset);
>  disable_clk:
>         clk_disable_unprepare(tegra->clock);
> -remove_table:
> -       dev_pm_opp_of_remove_table(&pdev->dev);
> -put_hw:
> -       dev_pm_opp_put_supported_hw(tegra->opp_table);

You might remove the 'devm_pm_opp_remove_all_dynamic(&pdev->dev)
under ' remove_opp' goto statement.kkkk


(snip)
-- 
Best Regards,
Chanwoo Choi
