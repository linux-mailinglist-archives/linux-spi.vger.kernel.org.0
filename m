Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22DB2EA44B
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 05:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbhAEEOz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 23:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAEEOy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 23:14:54 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453AC061574;
        Mon,  4 Jan 2021 20:14:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o19so69649978lfo.1;
        Mon, 04 Jan 2021 20:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7CEt7ox6RQz0kN+jN2Je6Gp8EPaWa97ojAZRj8xL6is=;
        b=L7UKc00npJs0IL02JDUDBurCBSgNMJ7czHbDQgVayzM6dCGWR7CEIoKIvy7+aK5on3
         0S5EDXpjvshfBoDjf44q+N+FBx91jkWnAA2dAdz5MQa3eaur4d11dGyvwaqvj0y7Lkby
         iOKBe85CZLFKx/RMjzQtS+d8/UjrMtIq1ToJ55lauroSXo0eBy6wpK9CMYHEKlqJVr3A
         EhFPEGkCVAkZ4hASfjxvhOKIu7pXSrTYfDxacg3xbr3VAFBLHSafSfvYFCjvANM6suJx
         8eL+J6xu7XU6FMQHLnE/jqobXnnkXyeNxOHQ73VJ6yM9pVWLXxYYRYxOJPwHTXeaz+9Q
         s6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7CEt7ox6RQz0kN+jN2Je6Gp8EPaWa97ojAZRj8xL6is=;
        b=fNoQRJ7UehA95wbJhEc8uICPj7d8FqH6YghXUsv1rZXMpyeAwSdvRqKYUy43dGDLSb
         Pi38+UMHc+NPp4ynQV9E/exCOaX0r2BoTE6PW9EM4Ux7m4dWjFN1Dz1Pemra6nuwCIUw
         nUdxfKUT/2bT6Kxep0Kth+g46Qio/35jf5QKggNdWq8lj1per5t4/893Qy9u5Tdynj6C
         8wWqWCuKwAW888b3N7JCnZqx9olFzOGHh2KuXa2vXscVIz8ktELsqy4tCFNO0O+yqumw
         2iKbSijyl1+/PKNvZZ8FkQi1ktxYyE4SLc3jpvvMMnYe1lWdFWin8+Tm46KB/nPqSeJH
         9bSw==
X-Gm-Message-State: AOAM533AcitmmnJfp5EO3ROLCuOst3bSjs8sDkv/cXYStExlsgIeboZe
        C+O+ksgvm/91oGEkS0F5DLU21bBttOXZmSM6+m8=
X-Google-Smtp-Source: ABdhPJz51qUgiiepOCOol+C1B9t+K4pzzTb6+kK694uGFC+1BDUaJDKdOlg7C3DMIRWrphTAbkwCZRa1MhY1aPNnUro=
X-Received: by 2002:a2e:b4a7:: with SMTP id q7mr29801680ljm.391.1609820052120;
 Mon, 04 Jan 2021 20:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20210103035540.23886-1-tiny.windzz@gmail.com>
In-Reply-To: <20210103035540.23886-1-tiny.windzz@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 5 Jan 2021 13:13:35 +0900
Message-ID: <CAGTfZH37=e4RgdR4xg-3s9-pRjqunHi2jfPQqQgVWkxW94GwOA@mail.gmail.com>
Subject: Re: [PATCH 28/31] PM / devfreq: imx8m-ddrc: convert to use
 devm_pm_opp_* API
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
>  drivers/devfreq/imx8m-ddrc.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index bc82d3653bff..9383d6e5538b 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -370,11 +370,6 @@ static int imx8m_ddrc_check_opps(struct device *dev)
>         return 0;
>  }
>
> -static void imx8m_ddrc_exit(struct device *dev)
> -{
> -       dev_pm_opp_of_remove_table(dev);
> -}
> -
>  static int imx8m_ddrc_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -419,7 +414,7 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       ret = dev_pm_opp_of_add_table(dev);
> +       ret = devm_pm_opp_of_add_table(dev);
>         if (ret < 0) {
>                 dev_err(dev, "failed to get OPP table\n");
>                 return ret;
> @@ -427,12 +422,11 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>
>         ret = imx8m_ddrc_check_opps(dev);
>         if (ret < 0)
> -               goto err;
> +               return ret;
>
>         priv->profile.polling_ms = 1000;
>         priv->profile.target = imx8m_ddrc_target;
>         priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
> -       priv->profile.exit = imx8m_ddrc_exit;
>         priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
>         priv->profile.initial_freq = clk_get_rate(priv->dram_core);
>
> @@ -441,13 +435,8 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->devfreq)) {
>                 ret = PTR_ERR(priv->devfreq);
>                 dev_err(dev, "failed to add devfreq device: %d\n", ret);
> -               goto err;
>         }
>
> -       return 0;
> -
> -err:
> -       dev_pm_opp_of_remove_table(dev);
>         return ret;

devm_devfreq_add_device() doesn't return any integer value.
Even if devm_devfreq_add_device() returns the right devfreq instance,
the 'ret' value  is not the return value of  devm_devfreq_add_device().

On this patch, 'ret' value of 'return ret' is from imx8m_ddrc_check_opps().
Surely, it is well working with this modification. But, it is not code
for exception handling.
So, we need to remain the following codes:

    return 0;
err:
    return ret;

>  }
>
> --
> 2.25.1
>


-- 
Best Regards,
Chanwoo Choi
