Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDC2EA4F2
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 06:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbhAEFiE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 00:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbhAEFiE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 00:38:04 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6795BC061574;
        Mon,  4 Jan 2021 21:37:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y19so69706107lfa.13;
        Mon, 04 Jan 2021 21:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BJ/BPOn4zLwcKVC4z1IVu61Cm54JUVzrqo0fobfeksQ=;
        b=M2Es2CYFztXBLoaAP1ExQ7Vg6pKuoSXUrIU64+JTXYurORjVHO4RUkWy9a4XEoyOmG
         p+VIGZyFQ/Ing35CuPyPBd6B4LN5jbTFWoeaA6uNlz16qXwUa5QLGdINIx92MIRiXt7L
         Zr2800UU5QComKFAIo/5zErU+/CEX/4DxD1wTH9rYHenrgCp8KW1mnHqhljdneV9CceE
         iqZGVqZc1D9tzQGGs54/GpfLBIPz2RVk4vGUsoB8JaGKT8svSxHoGEdC1W3xaidDname
         k13zeTaPJz88q5qUalH7p2qGQftucEcvNP+dpZhBsrFsu193HiFOUS2RkJzRrsvQmy5X
         /6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BJ/BPOn4zLwcKVC4z1IVu61Cm54JUVzrqo0fobfeksQ=;
        b=dSGIWRMrGV2wI6AAe9Hd0nYjc//DnIiTX+tz3BwTWbpotphs3DeuqCpo7Tl4jHdS/J
         uA4GCNr8zuRC6iDP2Aa0A9GTJpazNAxv6oQ+rKDf6Az40Ot9h85irthFiKIS82PWlsbM
         GYBIBDxReE5Cy11faNNXhRBLXixXylvt1myreWmmcGzk6i0t8oDOLecqmI/gPNKPnRsn
         rXiqqo93MNI91exC4qMrv+IdtD2bolb4w9U+d8ybnsiTebgrvSVGCxZS3JRovK1GoOds
         Bkph9nHZGqT/HbJOFO79C/qwbNxbKbWlqvFMTU0RLagKkW0TAaw4TBJu9K/2F35GFgLP
         RxMg==
X-Gm-Message-State: AOAM530j0EM4TUHTEZl7YtpwC1K2F2vjwXFJCsyBVrVUtnjQTJcqZbOC
        k1ditAJWsuUSoHiqi5O9gZjzyGisRZ/kCnUf8xg=
X-Google-Smtp-Source: ABdhPJxBh2b69EQE0oS8msD6rntMrwUkYVv9SESod0vmy4ovFZpV4FPqGzA4LTLOdctSMhxU1bPsvxj13MHhmKM2D30=
X-Received: by 2002:a05:6512:2e9:: with SMTP id m9mr32046955lfq.118.1609825041442;
 Mon, 04 Jan 2021 21:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20210103035706.24168-1-tiny.windzz@gmail.com>
In-Reply-To: <20210103035706.24168-1-tiny.windzz@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 5 Jan 2021 14:36:44 +0900
Message-ID: <CAGTfZH0s0iiR1jaebU8KyJ7mdvZMOUQXfmuxGh0PJ_v0diXtfA@mail.gmail.com>
Subject: Re: [PATCH 31/31] PM / devfreq: convert to devm_pm_opp_register_notifier
 and remove unused API
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
>  Use devm_pm_opp_* API to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 66 +--------------------------------------
>  include/linux/devfreq.h   | 23 --------------
>  2 files changed, 1 insertion(+), 88 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6aa10de792b3..f593f30529ec 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -2004,40 +2004,6 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  }
>  EXPORT_SYMBOL(devfreq_recommended_opp);
>
> -/**
> - * devfreq_register_opp_notifier() - Helper function to get devfreq notified
> - *                                  for any changes in the OPP availability
> - *                                  changes
> - * @dev:       The devfreq user device. (parent of devfreq)
> - * @devfreq:   The devfreq object.
> - */
> -int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
> -{
> -       return dev_pm_opp_register_notifier(dev, &devfreq->nb);
> -}
> -EXPORT_SYMBOL(devfreq_register_opp_notifier);
> -
> -/**
> - * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq
> - *                                    notified for any changes in the OPP
> - *                                    availability changes anymore.
> - * @dev:       The devfreq user device. (parent of devfreq)
> - * @devfreq:   The devfreq object.
> - *
> - * At exit() callback of devfreq_dev_profile, this must be included if
> - * devfreq_recommended_opp is used.
> - */
> -int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
> -{
> -       return dev_pm_opp_unregister_notifier(dev, &devfreq->nb);
> -}
> -EXPORT_SYMBOL(devfreq_unregister_opp_notifier);
> -
> -static void devm_devfreq_opp_release(struct device *dev, void *res)
> -{
> -       devfreq_unregister_opp_notifier(dev, *(struct devfreq **)res);
> -}
> -
>  /**
>   * devm_devfreq_register_opp_notifier() - Resource-managed
>   *                                       devfreq_register_opp_notifier()
> @@ -2047,40 +2013,10 @@ static void devm_devfreq_opp_release(struct device *dev, void *res)
>  int devm_devfreq_register_opp_notifier(struct device *dev,
>                                        struct devfreq *devfreq)
>  {
> -       struct devfreq **ptr;
> -       int ret;
> -
> -       ptr = devres_alloc(devm_devfreq_opp_release, sizeof(*ptr), GFP_KERNEL);
> -       if (!ptr)
> -               return -ENOMEM;
> -
> -       ret = devfreq_register_opp_notifier(dev, devfreq);
> -       if (ret) {
> -               devres_free(ptr);
> -               return ret;
> -       }
> -
> -       *ptr = devfreq;
> -       devres_add(dev, ptr);
> -
> -       return 0;
> +       return devm_pm_opp_register_notifier(dev, &devfreq->nb);
>  }
>  EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
>
> -/**
> - * devm_devfreq_unregister_opp_notifier() - Resource-managed
> - *                                         devfreq_unregister_opp_notifier()
> - * @dev:       The devfreq user device. (parent of devfreq)
> - * @devfreq:   The devfreq object.
> - */
> -void devm_devfreq_unregister_opp_notifier(struct device *dev,
> -                                        struct devfreq *devfreq)
> -{
> -       WARN_ON(devres_release(dev, devm_devfreq_opp_release,
> -                              devm_devfreq_dev_match, devfreq));
> -}
> -EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);

Need to support devm_devfreq_unregister_opp_notifier()
because sometimes, the user wants to release the resource by himself.

(snip)

Best Regards,
Chanwoo Choi
