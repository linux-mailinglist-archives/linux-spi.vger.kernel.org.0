Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7932E8CB5
	for <lists+linux-spi@lfdr.de>; Sun,  3 Jan 2021 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhACOz2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Jan 2021 09:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbhACOz0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Jan 2021 09:55:26 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FEC061573;
        Sun,  3 Jan 2021 06:54:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id y19so58500488lfa.13;
        Sun, 03 Jan 2021 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ye7D/hnHohKj9GZLla69A+dQLJx70g9063TQU2F31EQ=;
        b=iK7SW3DQ4woGH0r0YdkZYArDkTd7Dgo+fY+pSD1WAxGTb/ctaTuF9N//N06ci7GyrH
         YRW4NNm9t2SdeQwj9PbJtVEcdiHIHAAksx0rDAhQG/MXzC8GkMyfvmUD81hM7hMdf0rs
         q7kqt+pYr0uGdSn8gBuCIiZfKcjSTnnsPYGo9y80zXt3Te0uuR3v/lQ/luD0fDRtNKIH
         YcirTvnhc3ob0WLgwoZYMxL3VUSEaM+KyIft7dmOLvqnHgCzC2UNFMhlj4GyXddgBsle
         hYOR265lHTcKwXSg8oSiqofnJhcQxgPLq0NIQxXBzuU71FTlGSsQwDcKwsHAZ9VibIWU
         HBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ye7D/hnHohKj9GZLla69A+dQLJx70g9063TQU2F31EQ=;
        b=hLvJ3WDadyQor4/GbxdQC56+Woixra58oshF4ouLbWEc6dn5DYX4jyqSy0pA+7H1zu
         rN3zmBFv2C6TaNcBrYkGF3jaAuJO54CjY3N2MTTpRnzSmrTPkZ091F9LL7Y37ucP1hG3
         nT2FeN+BVn79CAfGjphv+IXz8Y77wE+9BoV85jkwqkpw9Sq9aEvmVs7bDMhcQczASQz9
         pruc0EHiUdfq2Tgdh7O6gwokLtq0UXk6vRplpqFyRBpu6TSiiIewwBS85pQ6YFBYr0ra
         P02ExHiwj3mdyElnufa7dyShEFolr8PfZO1cjbXYjT4SJZJqV3qmBKmQgr0mZQstC4uA
         XKVQ==
X-Gm-Message-State: AOAM531P4Nv0DJLSUjBdhqQAY5bZW2M5e2m/U5ZHULTcT+RGeqtFQvNv
        nF07UmnEqSqwF6eHwIzJwc1/DfVjJkA=
X-Google-Smtp-Source: ABdhPJwQC08Q7sWad01WVanKcVv8Jzsz/53jbuQT+p7kkrtY0pBwR5YN3ixi8BkFbzajTP1lOJoq0A==
X-Received: by 2002:a05:651c:1129:: with SMTP id e9mr32718777ljo.135.1609685684178;
        Sun, 03 Jan 2021 06:54:44 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id b11sm7033439lfi.174.2021.01.03.06.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 06:54:43 -0800 (PST)
Subject: Re: [PATCH 00/31] Introduce devm_pm_opp_* API
To:     Frank Lee <tiny.windzz@gmail.com>
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
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <819f4eaf-18e4-678d-84dd-e4ac9d88c414@gmail.com>
 <CAEExFWuLtNkHBHqUXwRiZzoX32VUdPO5=8snyHoFZGYEjvvhmg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0505ed5c-4ee9-9fc6-2358-bf964cc87c4e@gmail.com>
Date:   Sun, 3 Jan 2021 17:54:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAEExFWuLtNkHBHqUXwRiZzoX32VUdPO5=8snyHoFZGYEjvvhmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

03.01.2021 17:30, Frank Lee пишет:
> HI,
> 
> On Sun, Jan 3, 2021 at 8:52 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 01.01.2021 19:54, Yangtao Li пишет:
>>> Hi,
>>>
>>> This patchset add devm_pm_opp_set_clkname, devm_pm_opp_put_clkname,
>>> devm_pm_opp_set_regulators, devm_pm_opp_put_regulators,
>>> devm_pm_opp_set_supported_hw, devm_pm_opp_of_add_table and
>>> devm_pm_opp_register_notifier.
>>>
>>> Yangtao Li (31):
>>>   opp: Add devres wrapper for dev_pm_opp_set_clkname and
>>>     dev_pm_opp_put_clkname
>>>   opp: Add devres wrapper for dev_pm_opp_set_regulators and
>>>     dev_pm_opp_put_regulators
>>>   opp: Add devres wrapper for dev_pm_opp_set_supported_hw
>>>   opp: Add devres wrapper for dev_pm_opp_of_add_table
>>>   opp: Add devres wrapper for dev_pm_opp_register_notifier
>>>   serial: qcom_geni_serial: fix potential mem leak in
>>>     qcom_geni_serial_probe()
>>>   serial: qcom_geni_serial: convert to use devm_pm_opp_* API
>>>   spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
>>>   spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
>>>   qcom-geni-se: remove opp_table
>>>   mmc: sdhci-msm: fix potential mem leak in sdhci_msm_probe()
>>>   mmc: sdhci-msm: convert to use devm_pm_opp_* API
>>>   spi: spi-qcom-qspi: fix potential mem leak in qcom_qspi_probe()
>>>   spi: spi-qcom-qspi: convert to use devm_pm_opp_* API
>>>   drm/msm: fix potential mem leak
>>>   drm/msm: convert to use devm_pm_opp_* API and remove dp_ctrl_put
>>>   drm/lima: convert to use devm_pm_opp_* API
>>>   drm/lima: remove unneeded devm_devfreq_remove_device()
>>>   drm/panfrost: convert to use devm_pm_opp_* API
>>>   media: venus: fix error check in core_get_v4()
>>>   media: venus: convert to use devm_pm_opp_* API
>>>   memory: samsung: exynos5422-dmc: fix return error in
>>>     exynos5_init_freq_table
>>>   memory: samsung: exynos5422-dmc: convert to use devm_pm_opp_* API
>>>   memory: tegra20: convert to use devm_pm_opp_* API
>>>   memory: tegra30: convert to use devm_pm_opp_* API
>>>   PM / devfreq: tegra30: convert to use devm_pm_opp_* API
>>>   PM / devfreq: rk3399_dmc: convert to use devm_pm_opp_* API
>>>   PM / devfreq: imx8m-ddrc: convert to use devm_pm_opp_* API
>>>   PM / devfreq: imx-bus: convert to use devm_pm_opp_* API
>>>   PM / devfreq: exynos: convert to use devm_pm_opp_* API
>>>   PM / devfreq: convert to devm_pm_opp_register_notifier and remove
>>>     unused API
>>>
>>>  drivers/devfreq/devfreq.c                     |  66 +------
>>>  drivers/devfreq/exynos-bus.c                  |  42 +----
>>>  drivers/devfreq/imx-bus.c                     |  14 +-
>>>  drivers/devfreq/imx8m-ddrc.c                  |  15 +-
>>>  drivers/devfreq/rk3399_dmc.c                  |  22 +--
>>>  drivers/devfreq/tegra30-devfreq.c             |  21 +--
>>>  drivers/gpu/drm/lima/lima_devfreq.c           |  45 +----
>>>  drivers/gpu/drm/lima/lima_devfreq.h           |   2 -
>>>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   2 +-
>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
>>>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   2 +-
>>>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  31 ++--
>>>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |   2 -
>>>  drivers/gpu/drm/msm/dp/dp_ctrl.c              |  29 +--
>>>  drivers/gpu/drm/msm/dp/dp_ctrl.h              |   1 -
>>>  drivers/gpu/drm/msm/dp/dp_display.c           |   5 +-
>>>  drivers/gpu/drm/msm/dsi/dsi_host.c            |  23 ++-
>>>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  34 +---
>>>  drivers/gpu/drm/panfrost/panfrost_devfreq.h   |   1 -
>>>  .../media/platform/qcom/venus/pm_helpers.c    |  22 +--
>>>  drivers/memory/samsung/exynos5422-dmc.c       |  13 +-
>>>  drivers/memory/tegra/tegra20-emc.c            |  29 +--
>>>  drivers/memory/tegra/tegra30-emc.c            |  29 +--
>>>  drivers/mmc/host/sdhci-msm.c                  |  27 ++-
>>>  drivers/opp/core.c                            | 173 ++++++++++++++++++
>>>  drivers/opp/of.c                              |  36 ++++
>>>  drivers/spi/spi-geni-qcom.c                   |  23 ++-
>>>  drivers/spi/spi-qcom-qspi.c                   |  25 ++-
>>>  drivers/tty/serial/qcom_geni_serial.c         |  31 ++--
>>>  include/linux/devfreq.h                       |  23 ---
>>>  include/linux/pm_opp.h                        |  38 ++++
>>>  include/linux/qcom-geni-se.h                  |   2 -
>>>  32 files changed, 402 insertions(+), 428 deletions(-)
>>>
>>
>> Hello,
>>
>> Could you please add helper for dev_pm_opp_attach_genpd() and make
>> cpufreq drivers to use the helpers?
> 
> Thank you for reminding me. But we shouldn't use this for CPU devices
> as the CPU device doesn't get bound to a driver, it is rather a fake platform
> device which gets the cpufreq drivers probed.

Indeed, the CPU device exists seprately from cpufreq driver.

>> I'd also like to see a devm helper for
>> dev_pm_opp_register_set_opp_helper(), which should become useful for
>> Tegra drivers sometime soon.
> 
> For non-cpu devices?

For DRM driver I'd want to use devm for both set_opp_helper() and
opp_attach_genpd().

https://patchwork.ozlabs.org/project/linux-tegra/patch/20201217180638.22748-39-digetx@gmail.com/
