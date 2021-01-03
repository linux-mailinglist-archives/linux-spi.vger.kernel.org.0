Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE522E8C2E
	for <lists+linux-spi@lfdr.de>; Sun,  3 Jan 2021 13:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbhACMxW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Jan 2021 07:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbhACMxS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Jan 2021 07:53:18 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCAC061573;
        Sun,  3 Jan 2021 04:52:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s26so58212924lfc.8;
        Sun, 03 Jan 2021 04:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fk3XVwTVefOkLbjfXssBtwAHpD8Tcrjmd5/AelczwWk=;
        b=OEwi935j2c7KzefgNI021QgzicjnnEwbFY0PXx/zRGw9iI/W1MDCJ33nGdFVdpmgK6
         RIgzZmniThNKQQabZIGWFU35FpubtXtN1R5LazrU8yKIIFEOMvqtTZZ5S+ZI5PwASUDh
         TxHNixDO7dAndqM40/SeY3e6JavgLO8CB6IJk5nojllWAWb2ldsg7Qly/g8+ynFW8oPL
         cgNdsvF1E/S8ZWp6UVfr4ESinENcARg/2ifmbIPl9lUD5TbUttr2X8f7TQ9nNIigPWTg
         IihawwezkYm0eV/L9yiGEhYwV/JPSY1nrPQG12uGVCCkWe86XrpZBpVdlnOYyDyypc5T
         yDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fk3XVwTVefOkLbjfXssBtwAHpD8Tcrjmd5/AelczwWk=;
        b=UiDySKvwgUMp0aJWlYasd22/NicHgjglLcBjz4Q751IwqBWHzZni59MNoQxzWf4ci2
         fWaiWrq0pkSwtVsd/ufsMtavJAb0Ro4knKV22D84wlPuyWZQHX5rvRaFR7ceSf6DZvr1
         EmsO+XCHXan/Bo0J3zjFH8GvnO2NN/FEKnX6+y8EjE234bF+763lbSCYq2BxmwIztYw2
         ySkQhBVA6J8v5PELp4dGFtFTI5yUtL7V4XOjsn6+DQ7IMz8Fhbi+/cFNnGnxRevxQPHL
         rOEhfc0zLS+kuJ1PWBpY1kenD65S3QkbkH90ot/AIE/6SPoHu11w38Qvi4hGVqnaggJv
         B7aA==
X-Gm-Message-State: AOAM533me0Pa2Z6ADRlIh7q/Cf8PFJEiE+yH5TTqo6ctMksMvpr32Cxq
        KTsm5ueSVowmQ2IQ+dJSKQ7hwXCo2ps=
X-Google-Smtp-Source: ABdhPJyPgqSAU0iBjgqgqRPmpr/i7kF7QwsvsLVJIEREfmn2IS2TU8rSoup8JfPW09bcJNWdHG7m2A==
X-Received: by 2002:a05:6512:612:: with SMTP id b18mr32820924lfe.598.1609678355624;
        Sun, 03 Jan 2021 04:52:35 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id b26sm8429011ljk.132.2021.01.03.04.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 04:52:34 -0800 (PST)
Subject: Re: [PATCH 00/31] Introduce devm_pm_opp_* API
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com, krzk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yuq825@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run,
        robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, stanimir.varbanov@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        lukasz.luba@arm.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, ddavenport@chromium.org,
        jsanka@codeaurora.org, rnayak@codeaurora.org,
        tongtiangen@huawei.com, miaoqinglang@huawei.com,
        khsieh@codeaurora.org, abhinavk@codeaurora.org,
        chandanu@codeaurora.org, groeck@chromium.org, varar@codeaurora.org,
        mka@chromium.org, harigovi@codeaurora.org,
        rikard.falkeborn@gmail.com, natechancellor@gmail.com,
        georgi.djakov@linaro.org, akashast@codeaurora.org,
        parashar@codeaurora.org, dianders@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <819f4eaf-18e4-678d-84dd-e4ac9d88c414@gmail.com>
Date:   Sun, 3 Jan 2021 15:52:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

01.01.2021 19:54, Yangtao Li пишет:
> Hi,
> 
> This patchset add devm_pm_opp_set_clkname, devm_pm_opp_put_clkname,
> devm_pm_opp_set_regulators, devm_pm_opp_put_regulators,
> devm_pm_opp_set_supported_hw, devm_pm_opp_of_add_table and
> devm_pm_opp_register_notifier.
> 
> Yangtao Li (31):
>   opp: Add devres wrapper for dev_pm_opp_set_clkname and
>     dev_pm_opp_put_clkname
>   opp: Add devres wrapper for dev_pm_opp_set_regulators and
>     dev_pm_opp_put_regulators
>   opp: Add devres wrapper for dev_pm_opp_set_supported_hw
>   opp: Add devres wrapper for dev_pm_opp_of_add_table
>   opp: Add devres wrapper for dev_pm_opp_register_notifier
>   serial: qcom_geni_serial: fix potential mem leak in
>     qcom_geni_serial_probe()
>   serial: qcom_geni_serial: convert to use devm_pm_opp_* API
>   spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
>   spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
>   qcom-geni-se: remove opp_table
>   mmc: sdhci-msm: fix potential mem leak in sdhci_msm_probe()
>   mmc: sdhci-msm: convert to use devm_pm_opp_* API
>   spi: spi-qcom-qspi: fix potential mem leak in qcom_qspi_probe()
>   spi: spi-qcom-qspi: convert to use devm_pm_opp_* API
>   drm/msm: fix potential mem leak
>   drm/msm: convert to use devm_pm_opp_* API and remove dp_ctrl_put
>   drm/lima: convert to use devm_pm_opp_* API
>   drm/lima: remove unneeded devm_devfreq_remove_device()
>   drm/panfrost: convert to use devm_pm_opp_* API
>   media: venus: fix error check in core_get_v4()
>   media: venus: convert to use devm_pm_opp_* API
>   memory: samsung: exynos5422-dmc: fix return error in
>     exynos5_init_freq_table
>   memory: samsung: exynos5422-dmc: convert to use devm_pm_opp_* API
>   memory: tegra20: convert to use devm_pm_opp_* API
>   memory: tegra30: convert to use devm_pm_opp_* API
>   PM / devfreq: tegra30: convert to use devm_pm_opp_* API
>   PM / devfreq: rk3399_dmc: convert to use devm_pm_opp_* API
>   PM / devfreq: imx8m-ddrc: convert to use devm_pm_opp_* API
>   PM / devfreq: imx-bus: convert to use devm_pm_opp_* API
>   PM / devfreq: exynos: convert to use devm_pm_opp_* API
>   PM / devfreq: convert to devm_pm_opp_register_notifier and remove
>     unused API
> 
>  drivers/devfreq/devfreq.c                     |  66 +------
>  drivers/devfreq/exynos-bus.c                  |  42 +----
>  drivers/devfreq/imx-bus.c                     |  14 +-
>  drivers/devfreq/imx8m-ddrc.c                  |  15 +-
>  drivers/devfreq/rk3399_dmc.c                  |  22 +--
>  drivers/devfreq/tegra30-devfreq.c             |  21 +--
>  drivers/gpu/drm/lima/lima_devfreq.c           |  45 +----
>  drivers/gpu/drm/lima/lima_devfreq.h           |   2 -
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  31 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |   2 -
>  drivers/gpu/drm/msm/dp/dp_ctrl.c              |  29 +--
>  drivers/gpu/drm/msm/dp/dp_ctrl.h              |   1 -
>  drivers/gpu/drm/msm/dp/dp_display.c           |   5 +-
>  drivers/gpu/drm/msm/dsi/dsi_host.c            |  23 ++-
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  34 +---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h   |   1 -
>  .../media/platform/qcom/venus/pm_helpers.c    |  22 +--
>  drivers/memory/samsung/exynos5422-dmc.c       |  13 +-
>  drivers/memory/tegra/tegra20-emc.c            |  29 +--
>  drivers/memory/tegra/tegra30-emc.c            |  29 +--
>  drivers/mmc/host/sdhci-msm.c                  |  27 ++-
>  drivers/opp/core.c                            | 173 ++++++++++++++++++
>  drivers/opp/of.c                              |  36 ++++
>  drivers/spi/spi-geni-qcom.c                   |  23 ++-
>  drivers/spi/spi-qcom-qspi.c                   |  25 ++-
>  drivers/tty/serial/qcom_geni_serial.c         |  31 ++--
>  include/linux/devfreq.h                       |  23 ---
>  include/linux/pm_opp.h                        |  38 ++++
>  include/linux/qcom-geni-se.h                  |   2 -
>  32 files changed, 402 insertions(+), 428 deletions(-)
> 

Hello,

Could you please add helper for dev_pm_opp_attach_genpd() and make
cpufreq drivers to use the helpers?

I'd also like to see a devm helper for
dev_pm_opp_register_set_opp_helper(), which should become useful for
Tegra drivers sometime soon.
