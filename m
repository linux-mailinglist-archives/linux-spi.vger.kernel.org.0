Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F22F2EB3D0
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 21:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbhAEUAY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 15:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbhAEUAW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 15:00:22 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B7C061793;
        Tue,  5 Jan 2021 11:59:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id l11so1395884lfg.0;
        Tue, 05 Jan 2021 11:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=w3y172ugq1A8+DfHjAatLK3oOwXsMQTLgHeUXaHnUCU=;
        b=tBCWlgeIGyCHy0ayfKSb2hKeKiEoFzcgiAtzEEfHQ70m4TqSwGsZqX3Xnx4VJJnvbt
         n0OP+1QygM+MIfVv5A7Ue/siY9qUR3JrwvKGHP2W3QTyiHhYMLJ6zdE5Ged8pj1n+RjK
         Bb3lYAmgD2urDHD+97GcmaR9/cYTYUc3lvg36iKQWZkukTkf+xsDRudzvwcq2WaBpdlE
         x0mE68kMXoFvZrIZWNkF8AnSu3p+LzNJVWTcYgez90NbFkWXHh7/NpKY2fPkuOEA7ZKB
         w1aIj7VtjxtrBSQz6IaOTRs86szJNL8Gutp0tvolPIaAjingl3R6BlglT66Kk2USW+JA
         gNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=w3y172ugq1A8+DfHjAatLK3oOwXsMQTLgHeUXaHnUCU=;
        b=Uf/I3Ff5O/z44dopGdFH8VxMEy+ps1lg2RbF8K2iK1xaV9636T3q/i+iYVyUz8Zyni
         MsWVVGYV317Br2hWF051LgKpCrQQHDELvspCXtbGdThQCYNy+XtsQDRrPIJHCE5g2CUn
         EagliKp6DMlD8opHoL7k/2bqsP9vcJr1BCDiroubtkJJaVmWaBeRsHN0Jm3ieCOWOift
         6nSBgguqmLI1KVE3C4wzsqu/PCVOGNE41U6sbkHn1ZVoa1V25290yMCYinIrSgxKAUHF
         zqz0xqumSuZ+BLm4+C5wp2VZPA+3fhGmqSIl5xmiwImFBlPW7nSMEWmyg0JG3x92wW04
         LYaQ==
X-Gm-Message-State: AOAM531POKnTvTZAfrh/y7+Go/Vz1dUBRj/f9Vi+j6ruoHUjl8lYn95s
        mLb00hDHWBa72lE/jSkb+1QGupnzOYrpw4F6szU=
X-Google-Smtp-Source: ABdhPJxefm71gCAP6d5oS17blFAwFnEd9spoEWiCV79bTaAMdk7JG8QCTPTs9zQB67DoNESWvQ4nEkOaTe/eEP/zqxs=
X-Received: by 2002:a2e:8156:: with SMTP id t22mr509678ljg.263.1609876780665;
 Tue, 05 Jan 2021 11:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20210103035540.23886-1-tiny.windzz@gmail.com> <CAGTfZH37=e4RgdR4xg-3s9-pRjqunHi2jfPQqQgVWkxW94GwOA@mail.gmail.com>
In-Reply-To: <CAGTfZH37=e4RgdR4xg-3s9-pRjqunHi2jfPQqQgVWkxW94GwOA@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 6 Jan 2021 04:59:04 +0900
Message-ID: <CAGTfZH0kg=-MLrvEb+oHkaAuS3mV+o+Oia=wUCf=n2v7s1oXMg@mail.gmail.com>
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
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, robdclark@gmail.com,
        sean@poorly.run, Rob Herring <robh@kernel.org>,
        tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        mchehab@kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, Jonathan Marek <jonathan@marek.ca>,
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

Hi Yangtao,

On Tue, Jan 5, 2021 at 1:13 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On Sun, Jan 3, 2021 at 12:58 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > Use devm_pm_opp_* API to simplify code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/devfreq/imx8m-ddrc.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> > index bc82d3653bff..9383d6e5538b 100644
> > --- a/drivers/devfreq/imx8m-ddrc.c
> > +++ b/drivers/devfreq/imx8m-ddrc.c
> > @@ -370,11 +370,6 @@ static int imx8m_ddrc_check_opps(struct device *dev)
> >         return 0;
> >  }
> >
> > -static void imx8m_ddrc_exit(struct device *dev)
> > -{
> > -       dev_pm_opp_of_remove_table(dev);
> > -}
> > -
> >  static int imx8m_ddrc_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> > @@ -419,7 +414,7 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >
> > -       ret = dev_pm_opp_of_add_table(dev);
> > +       ret = devm_pm_opp_of_add_table(dev);
> >         if (ret < 0) {
> >                 dev_err(dev, "failed to get OPP table\n");
> >                 return ret;
> > @@ -427,12 +422,11 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
> >
> >         ret = imx8m_ddrc_check_opps(dev);
> >         if (ret < 0)
> > -               goto err;
> > +               return ret;
> >
> >         priv->profile.polling_ms = 1000;
> >         priv->profile.target = imx8m_ddrc_target;
> >         priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
> > -       priv->profile.exit = imx8m_ddrc_exit;
> >         priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
> >         priv->profile.initial_freq = clk_get_rate(priv->dram_core);
> >
> > @@ -441,13 +435,8 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
> >         if (IS_ERR(priv->devfreq)) {
> >                 ret = PTR_ERR(priv->devfreq);
> >                 dev_err(dev, "failed to add devfreq device: %d\n", ret);
> > -               goto err;
> >         }
> >
> > -       return 0;
> > -
> > -err:
> > -       dev_pm_opp_of_remove_table(dev);
> >         return ret;
>
> devm_devfreq_add_device() doesn't return any integer value.
> Even if devm_devfreq_add_device() returns the right devfreq instance,
> the 'ret' value  is not the return value of  devm_devfreq_add_device().
>
> On this patch, 'ret' value of 'return ret' is from imx8m_ddrc_check_opps().
> Surely, it is well working with this modification. But, it is not code
> for exception handling.
> So, we need to remain the following codes:
>
>     return 0;
> err:
>     return ret;
>

'err' is not necessary. You better to edit it as following:

if (IS_ERR(priv->devfreq)) {
    dev_err(dev, "failed to add devfreq device: %d\n", ret);
    return PTR_ERR(priv->devfreq);
}

return 0;

-- 
Best Regards,
Chanwoo Choi
