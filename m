Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9922D2E8C9E
	for <lists+linux-spi@lfdr.de>; Sun,  3 Jan 2021 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbhACObP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Jan 2021 09:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhACObO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Jan 2021 09:31:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E463C061573;
        Sun,  3 Jan 2021 06:30:34 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id dk8so24614295edb.1;
        Sun, 03 Jan 2021 06:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ln5/xdl46vtSdR4LXWQxmJUctJoaIW0Vq5QIACIBVo8=;
        b=kdoa4Sb7Hz5+hZwblIxwT6C6Pq1vgI3o6uktF5AXHZ26IkY3BU1ImfkqxyQ3ENHKzy
         s1SH3WujeL0fmV+nJU6yXhf1Fh80v9g2dt5YH5rob5yuuB0av0BKDxMmQQbTCglr3doL
         2ZW+Q4L3LPjUDEiK8CtrITPdj471iGK8YyZwGSWXNqdIdd/9e8VvXTJOleT5BDhzYPEV
         4YipYrqA9MtVSS2XE9z2m8rcEO7yZsETlFrAbor5L6xb4U8UBCJLLTzN0LVOkxo+Jt92
         F8hZ8P+AqcQwlTjzerBzqzkj0Q0CbfYEswo6notB5Zp1CspCQlCgxyZSFrkxucLBl+iO
         kgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ln5/xdl46vtSdR4LXWQxmJUctJoaIW0Vq5QIACIBVo8=;
        b=k0tiso8YXAugwPvhb5Aw3kuY+JdscegxiVT0YERBnF85gp7EKvslWdYHtbN7K1ZOal
         wBOKMd+6txWYihMxgeR8NR/0AWGSY6jbGu9DIs638WGARbwVByoQQseTCoa9WM/d4pQL
         HlmFYecqNHsBkyLcNxBS8D8Wzr3FtGOOVIWYqDiytlHOd5VO0n2OdIOH/p3LloDRu6tX
         Cwuh+7VV+MtpWZV/GjuYie+ev3cuyt7ZzixrzEFjF2gu514iTtXURr9IKswImLwZdnOw
         NhRflI56EcB95+4CgLKyxIhaP0PU8r+Hd81T98h6TI/GuVMfdAqyW1BAnecnmHeqwcKX
         CFAA==
X-Gm-Message-State: AOAM531YfJQaEajeW0ELZbqEoMuwHZvYGoGMf/z9NO86yd+h5W6mmImo
        NwUMuHTHVYekxx7u9vZw5mzEygLw6S1QJSm+8Ek=
X-Google-Smtp-Source: ABdhPJw6jFAYPdCFrr5nWTUKmXg/nfcOHtKrxXEa8lvDyRpKOkMbA+XxS4VTXL+asLwPwirAOww3tpZFDrLzQcZn+UQ=
X-Received: by 2002:aa7:c3c2:: with SMTP id l2mr65799064edr.15.1609684231486;
 Sun, 03 Jan 2021 06:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20210101165507.19486-1-tiny.windzz@gmail.com> <819f4eaf-18e4-678d-84dd-e4ac9d88c414@gmail.com>
In-Reply-To: <819f4eaf-18e4-678d-84dd-e4ac9d88c414@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 3 Jan 2021 22:30:08 +0800
Message-ID: <CAEExFWuLtNkHBHqUXwRiZzoX32VUdPO5=8snyHoFZGYEjvvhmg@mail.gmail.com>
Subject: Re: [PATCH 00/31] Introduce devm_pm_opp_* API
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, yuq825@gmail.com,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh@kernel.org>, tomeu.vizoso@collabora.com,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        lukasz.luba@arm.com, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        jcrouse@codeaurora.org, hoegsberg@google.com, eric@anholt.net,
        tzimmermann@suse.de, marijn.suijten@somainline.org,
        gustavoars@kernel.org, emil.velikov@collabora.com,
        Jonathan Marek <jonathan@marek.ca>, akhilpo@codeaurora.org,
        smasetty@codeaurora.org, airlied@redhat.com, masneyb@onstation.org,
        kalyan_t@codeaurora.org, tanmay@codeaurora.org,
        ddavenport@chromium.org, jsanka@codeaurora.org,
        rnayak@codeaurora.org, tongtiangen@huawei.com,
        miaoqinglang@huawei.com, khsieh@codeaurora.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        groeck@chromium.org, varar@codeaurora.org, mka@chromium.org,
        harigovi@codeaurora.org, rikard.falkeborn@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        georgi.djakov@linaro.org, akashast@codeaurora.org,
        parashar@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

HI,

On Sun, Jan 3, 2021 at 8:52 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.01.2021 19:54, Yangtao Li =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi,
> >
> > This patchset add devm_pm_opp_set_clkname, devm_pm_opp_put_clkname,
> > devm_pm_opp_set_regulators, devm_pm_opp_put_regulators,
> > devm_pm_opp_set_supported_hw, devm_pm_opp_of_add_table and
> > devm_pm_opp_register_notifier.
> >
> > Yangtao Li (31):
> >   opp: Add devres wrapper for dev_pm_opp_set_clkname and
> >     dev_pm_opp_put_clkname
> >   opp: Add devres wrapper for dev_pm_opp_set_regulators and
> >     dev_pm_opp_put_regulators
> >   opp: Add devres wrapper for dev_pm_opp_set_supported_hw
> >   opp: Add devres wrapper for dev_pm_opp_of_add_table
> >   opp: Add devres wrapper for dev_pm_opp_register_notifier
> >   serial: qcom_geni_serial: fix potential mem leak in
> >     qcom_geni_serial_probe()
> >   serial: qcom_geni_serial: convert to use devm_pm_opp_* API
> >   spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
> >   spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
> >   qcom-geni-se: remove opp_table
> >   mmc: sdhci-msm: fix potential mem leak in sdhci_msm_probe()
> >   mmc: sdhci-msm: convert to use devm_pm_opp_* API
> >   spi: spi-qcom-qspi: fix potential mem leak in qcom_qspi_probe()
> >   spi: spi-qcom-qspi: convert to use devm_pm_opp_* API
> >   drm/msm: fix potential mem leak
> >   drm/msm: convert to use devm_pm_opp_* API and remove dp_ctrl_put
> >   drm/lima: convert to use devm_pm_opp_* API
> >   drm/lima: remove unneeded devm_devfreq_remove_device()
> >   drm/panfrost: convert to use devm_pm_opp_* API
> >   media: venus: fix error check in core_get_v4()
> >   media: venus: convert to use devm_pm_opp_* API
> >   memory: samsung: exynos5422-dmc: fix return error in
> >     exynos5_init_freq_table
> >   memory: samsung: exynos5422-dmc: convert to use devm_pm_opp_* API
> >   memory: tegra20: convert to use devm_pm_opp_* API
> >   memory: tegra30: convert to use devm_pm_opp_* API
> >   PM / devfreq: tegra30: convert to use devm_pm_opp_* API
> >   PM / devfreq: rk3399_dmc: convert to use devm_pm_opp_* API
> >   PM / devfreq: imx8m-ddrc: convert to use devm_pm_opp_* API
> >   PM / devfreq: imx-bus: convert to use devm_pm_opp_* API
> >   PM / devfreq: exynos: convert to use devm_pm_opp_* API
> >   PM / devfreq: convert to devm_pm_opp_register_notifier and remove
> >     unused API
> >
> >  drivers/devfreq/devfreq.c                     |  66 +------
> >  drivers/devfreq/exynos-bus.c                  |  42 +----
> >  drivers/devfreq/imx-bus.c                     |  14 +-
> >  drivers/devfreq/imx8m-ddrc.c                  |  15 +-
> >  drivers/devfreq/rk3399_dmc.c                  |  22 +--
> >  drivers/devfreq/tegra30-devfreq.c             |  21 +--
> >  drivers/gpu/drm/lima/lima_devfreq.c           |  45 +----
> >  drivers/gpu/drm/lima/lima_devfreq.h           |   2 -
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   2 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   2 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  31 ++--
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |   2 -
> >  drivers/gpu/drm/msm/dp/dp_ctrl.c              |  29 +--
> >  drivers/gpu/drm/msm/dp/dp_ctrl.h              |   1 -
> >  drivers/gpu/drm/msm/dp/dp_display.c           |   5 +-
> >  drivers/gpu/drm/msm/dsi/dsi_host.c            |  23 ++-
> >  drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  34 +---
> >  drivers/gpu/drm/panfrost/panfrost_devfreq.h   |   1 -
> >  .../media/platform/qcom/venus/pm_helpers.c    |  22 +--
> >  drivers/memory/samsung/exynos5422-dmc.c       |  13 +-
> >  drivers/memory/tegra/tegra20-emc.c            |  29 +--
> >  drivers/memory/tegra/tegra30-emc.c            |  29 +--
> >  drivers/mmc/host/sdhci-msm.c                  |  27 ++-
> >  drivers/opp/core.c                            | 173 ++++++++++++++++++
> >  drivers/opp/of.c                              |  36 ++++
> >  drivers/spi/spi-geni-qcom.c                   |  23 ++-
> >  drivers/spi/spi-qcom-qspi.c                   |  25 ++-
> >  drivers/tty/serial/qcom_geni_serial.c         |  31 ++--
> >  include/linux/devfreq.h                       |  23 ---
> >  include/linux/pm_opp.h                        |  38 ++++
> >  include/linux/qcom-geni-se.h                  |   2 -
> >  32 files changed, 402 insertions(+), 428 deletions(-)
> >
>
> Hello,
>
> Could you please add helper for dev_pm_opp_attach_genpd() and make
> cpufreq drivers to use the helpers?

Thank you for reminding me. But we shouldn't use this for CPU devices
as the CPU device doesn't get bound to a driver, it is rather a fake platfo=
rm
device which gets the cpufreq drivers probed.

>
> I'd also like to see a devm helper for
> dev_pm_opp_register_set_opp_helper(), which should become useful for
> Tegra drivers sometime soon.

For non-cpu devices?

BR / Yangtao
