Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A4337DD8
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCKTWP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhCKTVi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:38 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC0C061574;
        Thu, 11 Mar 2021 11:21:37 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z25so3607014lja.3;
        Thu, 11 Mar 2021 11:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nr3MMopQK2U9fHQgnqesF0TFAIQZjafir6ZJocCIzyI=;
        b=MyIkaSeXkIuqBbDFC2RZN06Z7+tiTtAyEFnuG6JcB8fVDc/Sps5Y/4lD3XbsyeO4ae
         TVru7tnsGRkHH9T+lqIfziLi24bGn4Y8kTsTE9yDA1ltlFtHAtJpiks0QkaZ9aRplxPS
         5gaASxaSxYV09M2FNYhkdvW8CF+zEtfZisqi7xVpZXA/1IPDNlhxHt6m05FCcOY89lyR
         2GdG2+f4JHdOC1hDD3wwJPE/7krkXhXW5bP+CHhYBHdm3OpOYonPaVP1OLWWZ9Kwv+eU
         27iTZCIS1IVBb33goI5qAl9/7f1WShlaTr+5bUuPY/hADp7/1yeTfOzDA3lIhMeLMcrB
         kshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nr3MMopQK2U9fHQgnqesF0TFAIQZjafir6ZJocCIzyI=;
        b=SU8oCQXPSZuT7rjtLz2JzEq3yTH5DnZthgvl/KK2CbcWvCrUzxrVqM/XgZ0WkQM8xc
         8Whk3xb+TsUHQ5B0ypA7ggtbf6fg09csUXCxlgTUE6Tvb2rG+7SZwjxxfsrfd6A9fkKq
         vqdzH9bjMCS+FoZJPuPwsI9aOo6+XpV8hug0/U8JX3XYbMvKa0xTAuSjWH9o8vELuO+z
         /fdLEiRyStdDusvSisJLu6b0K56RCUwR46y/nCVBSNZk74ItkbACKu8k1HgvIeI9rCg1
         dYOaPc8CqjaaUIieYQPkVFyk6LqRZ2cj4MRQ7Zp/OirJ/M99AkJeZQRM2eQrmSD8b2fd
         kAXA==
X-Gm-Message-State: AOAM531iMjIci2L41j8DNaDVAOeo8UKHtywdRyRdYwcLEbgR0eVcPIcL
        Vv0mrzTpiq8ZdyQvKILWDB0=
X-Google-Smtp-Source: ABdhPJwV50MJdowwGjHNgx6AtXCWhwuCfX9B+Ri0kWRJuRnNED/9RtxV4BcKLyAa4veO0GRq4JAp4w==
X-Received: by 2002:a2e:9f45:: with SMTP id v5mr215188ljk.183.1615490496374;
        Thu, 11 Mar 2021 11:21:36 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 00/14] Introduce devm_pm_opp_* API
Date:   Thu, 11 Mar 2021 22:20:51 +0300
Message-Id: <20210311192105.14998-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds resource-managed OPP API helpers and makes drivers
to use them.

Changelog:

v2: - This is a continuation of the work that was started by Yangtao Li.
      Apparently Yangtao doesn't have time to finish it, so I
      (Dmitry Osipenko) picked up the effort since these patches are
      wanted by the NVIDIA Tegra voltage-scaling series that I'm
      working on.

    - Fixed the double put of OPP resources.

    - Dropped all patches that are unrelated to OPP API. I also dropped
      the Tegra memory patch since it doesn't apply now and because I plan
      to switch all Tegra drivers soon to a common tegra-specific OPP helper
      that will use the resource-managed OPP API anyways.

    - Squashed couple patches into a single ones since there was no
      good reason to separate them.

    - Added acks that were given to a couple of v1 patches.

Yangtao Li (14):
  opp: Add devres wrapper for dev_pm_opp_set_clkname
  opp: Add devres wrapper for dev_pm_opp_set_regulators
  opp: Add devres wrapper for dev_pm_opp_set_supported_hw
  opp: Add devres wrapper for dev_pm_opp_of_add_table
  opp: Add devres wrapper for dev_pm_opp_register_notifier
  serial: qcom_geni_serial: Convert to use resource-managed OPP API
  spi: spi-geni-qcom: Convert to use resource-managed OPP API
  spi: spi-qcom-qspi: Convert to use resource-managed OPP API
  mmc: sdhci-msm: Convert to use resource-managed OPP API
  drm/msm: Convert to use resource-managed OPP API
  drm/lima: Convert to use resource-managed OPP API
  drm/panfrost: Convert to use resource-managed OPP API
  media: venus: Convert to use resource-managed OPP API
  memory: samsung: exynos5422-dmc: Convert to use resource-managed OPP
    API

 drivers/gpu/drm/lima/lima_devfreq.c           |  43 ++---
 drivers/gpu/drm/lima/lima_devfreq.h           |   2 -
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  24 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |   2 -
 drivers/gpu/drm/msm/dp/dp_ctrl.c              |  31 +---
 drivers/gpu/drm/msm/dp/dp_ctrl.h              |   1 -
 drivers/gpu/drm/msm/dp/dp_display.c           |   5 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  14 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  33 +---
 drivers/gpu/drm/panfrost/panfrost_devfreq.h   |   1 -
 .../media/platform/qcom/venus/pm_helpers.c    |  18 +--
 drivers/memory/samsung/exynos5422-dmc.c       |  13 +-
 drivers/mmc/host/sdhci-msm.c                  |  20 +--
 drivers/opp/core.c                            | 151 ++++++++++++++++++
 drivers/opp/of.c                              |  36 +++++
 drivers/spi/spi-geni-qcom.c                   |  17 +-
 drivers/spi/spi-qcom-qspi.c                   |  19 +--
 drivers/tty/serial/qcom_geni_serial.c         |  24 ++-
 include/linux/pm_opp.h                        |  34 ++++
 include/linux/qcom-geni-se.h                  |   2 -
 23 files changed, 300 insertions(+), 196 deletions(-)

-- 
2.29.2

