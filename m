Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF12E843B
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 17:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbhAAQ4T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhAAQ4R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:56:17 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9AC061573;
        Fri,  1 Jan 2021 08:55:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n3so3609507pjm.1;
        Fri, 01 Jan 2021 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L/gCv/bt29Lids4NqNMCGnupZanWu1rzMA+oLszbsEM=;
        b=fVzoGZOLGPB0P1BXu3jr26HnZLLXZ13i/G70DkLSPqNdxyinjBjU2Z8rq8j/or/Jtd
         5Wz6/lOt1FPHGcNde6aIj752AwkaDDx3J2kknebedpgJ7gQ0V/NsaWEGSpQQOVNUXVih
         wwYz3C6VExmF+lZLOK6aeAI12qICJZIhU8BuyY26XSkzoxpVMzofKBuzflyIx7zLelwa
         NQvI/r5l33gJXaVEf7d4Q4CAFP19BcG8onF0cung1F4sC1rauOMV5Qx3MaIynva9rwF+
         j04ivImQN7RBpI+8+1wBd6KJmOcVJzQwveKuzrrJfTHq8f5ZifRWTZ/qQKLqNpzkggRm
         qT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L/gCv/bt29Lids4NqNMCGnupZanWu1rzMA+oLszbsEM=;
        b=Vjevyd/Z85zlTI6Dw1FRBwlz6/ozG3UwE5ErGOXbOwPD5r1G98S7/+8dupeuqB3OJd
         0rc9vTdsVoyfeT2xo0R1emClT1pjjuMt7ENhl9gsnbUNBRLCG81dD0CNzSeey3thMVZp
         /TsTSAPXHpldWNd0CpZt1OQyxLfTGmw7GO2exzfHMhzUeBT6tpXE25epKl+Lrbyybe15
         2tdwIfuP3d+ZBLhgL8bG4Xe8TEQDQn8Ke7BpnRgUZ3P8Camw3kjaHZHC80qGtvrdsaAb
         96IbLN/kEZbj37tAEyKBRt8OJuB4VMTbV2TmrbBO/jNVmmczVrrPZfB+0jMv5tOD5I5/
         cudQ==
X-Gm-Message-State: AOAM5320o8nrv9oApfPAm0bPJiS+C/DavB/KHNdIf6fFvEEwOd5x+pdn
        hGlqzqcxEcXyzGDcva2FUaM=
X-Google-Smtp-Source: ABdhPJxs/i/JADyQO9mxNRl6CW47gkY51PoANWqV9w//PRy+AIWEsNQMMeMTfC1dzEsLBpruFAB/bw==
X-Received: by 2002:a17:90a:c396:: with SMTP id h22mr18709651pjt.84.1609520136798;
        Fri, 01 Jan 2021 08:55:36 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:55:35 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, digetx@gmail.com, thierry.reding@gmail.com,
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
        tanmay@codeaurora.org, tiny.windzz@gmail.com,
        ddavenport@chromium.org, jsanka@codeaurora.org,
        rnayak@codeaurora.org, tongtiangen@huawei.com,
        miaoqinglang@huawei.com, khsieh@codeaurora.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        groeck@chromium.org, varar@codeaurora.org, mka@chromium.org,
        harigovi@codeaurora.org, rikard.falkeborn@gmail.com,
        natechancellor@gmail.com, georgi.djakov@linaro.org,
        akashast@codeaurora.org, parashar@codeaurora.org,
        dianders@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 00/31] Introduce devm_pm_opp_* API
Date:   Fri,  1 Jan 2021 16:54:36 +0000
Message-Id: <20210101165507.19486-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This patchset add devm_pm_opp_set_clkname, devm_pm_opp_put_clkname,
devm_pm_opp_set_regulators, devm_pm_opp_put_regulators,
devm_pm_opp_set_supported_hw, devm_pm_opp_of_add_table and
devm_pm_opp_register_notifier.

Yangtao Li (31):
  opp: Add devres wrapper for dev_pm_opp_set_clkname and
    dev_pm_opp_put_clkname
  opp: Add devres wrapper for dev_pm_opp_set_regulators and
    dev_pm_opp_put_regulators
  opp: Add devres wrapper for dev_pm_opp_set_supported_hw
  opp: Add devres wrapper for dev_pm_opp_of_add_table
  opp: Add devres wrapper for dev_pm_opp_register_notifier
  serial: qcom_geni_serial: fix potential mem leak in
    qcom_geni_serial_probe()
  serial: qcom_geni_serial: convert to use devm_pm_opp_* API
  spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
  spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
  qcom-geni-se: remove opp_table
  mmc: sdhci-msm: fix potential mem leak in sdhci_msm_probe()
  mmc: sdhci-msm: convert to use devm_pm_opp_* API
  spi: spi-qcom-qspi: fix potential mem leak in qcom_qspi_probe()
  spi: spi-qcom-qspi: convert to use devm_pm_opp_* API
  drm/msm: fix potential mem leak
  drm/msm: convert to use devm_pm_opp_* API and remove dp_ctrl_put
  drm/lima: convert to use devm_pm_opp_* API
  drm/lima: remove unneeded devm_devfreq_remove_device()
  drm/panfrost: convert to use devm_pm_opp_* API
  media: venus: fix error check in core_get_v4()
  media: venus: convert to use devm_pm_opp_* API
  memory: samsung: exynos5422-dmc: fix return error in
    exynos5_init_freq_table
  memory: samsung: exynos5422-dmc: convert to use devm_pm_opp_* API
  memory: tegra20: convert to use devm_pm_opp_* API
  memory: tegra30: convert to use devm_pm_opp_* API
  PM / devfreq: tegra30: convert to use devm_pm_opp_* API
  PM / devfreq: rk3399_dmc: convert to use devm_pm_opp_* API
  PM / devfreq: imx8m-ddrc: convert to use devm_pm_opp_* API
  PM / devfreq: imx-bus: convert to use devm_pm_opp_* API
  PM / devfreq: exynos: convert to use devm_pm_opp_* API
  PM / devfreq: convert to devm_pm_opp_register_notifier and remove
    unused API

 drivers/devfreq/devfreq.c                     |  66 +------
 drivers/devfreq/exynos-bus.c                  |  42 +----
 drivers/devfreq/imx-bus.c                     |  14 +-
 drivers/devfreq/imx8m-ddrc.c                  |  15 +-
 drivers/devfreq/rk3399_dmc.c                  |  22 +--
 drivers/devfreq/tegra30-devfreq.c             |  21 +--
 drivers/gpu/drm/lima/lima_devfreq.c           |  45 +----
 drivers/gpu/drm/lima/lima_devfreq.h           |   2 -
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  31 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |   2 -
 drivers/gpu/drm/msm/dp/dp_ctrl.c              |  29 +--
 drivers/gpu/drm/msm/dp/dp_ctrl.h              |   1 -
 drivers/gpu/drm/msm/dp/dp_display.c           |   5 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  23 ++-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  34 +---
 drivers/gpu/drm/panfrost/panfrost_devfreq.h   |   1 -
 .../media/platform/qcom/venus/pm_helpers.c    |  22 +--
 drivers/memory/samsung/exynos5422-dmc.c       |  13 +-
 drivers/memory/tegra/tegra20-emc.c            |  29 +--
 drivers/memory/tegra/tegra30-emc.c            |  29 +--
 drivers/mmc/host/sdhci-msm.c                  |  27 ++-
 drivers/opp/core.c                            | 173 ++++++++++++++++++
 drivers/opp/of.c                              |  36 ++++
 drivers/spi/spi-geni-qcom.c                   |  23 ++-
 drivers/spi/spi-qcom-qspi.c                   |  25 ++-
 drivers/tty/serial/qcom_geni_serial.c         |  31 ++--
 include/linux/devfreq.h                       |  23 ---
 include/linux/pm_opp.h                        |  38 ++++
 include/linux/qcom-geni-se.h                  |   2 -
 32 files changed, 402 insertions(+), 428 deletions(-)

-- 
2.25.1

