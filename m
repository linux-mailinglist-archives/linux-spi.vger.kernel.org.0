Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B433A63D
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhCNQfF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhCNQeb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB59C061574;
        Sun, 14 Mar 2021 09:34:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v15so7488859wrx.4;
        Sun, 14 Mar 2021 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dk+u80d7+DPr6f37qq0svEt55gFJ9tkcYaJUZ9gMJ0E=;
        b=odz2KMFjnuhb+rsTA1UTIbkBLsTNRvMBNSMRiw8zxC4bWm7uwaiwsCXODkOpuWYygp
         uPU8oyV7+fL4tqvAu2Qi/KxLJ0NMIZ38VJHySHemlGhL1DlopQm3WtA9Sht2KNeAoAP+
         ZHlURy+2dKRSfqikCGrEaHH90tT+BwxckcE/dd9hWjs9MXYbwQY3As0wpUGcq06VDFmW
         BZuQqJhYdotA3HLtV8KYQagN4hc9Y43XegpW96y5oVt/UTHFtXlOzYG8FybF7viwVXnW
         Qb2ZZrGcp4g4aVCQ/jLBHK8TF8yiL1ImgA0Ni1kpRvRZgV5I0fPJPAEYubbKyERAh0xs
         1gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dk+u80d7+DPr6f37qq0svEt55gFJ9tkcYaJUZ9gMJ0E=;
        b=sa9sIniQZDM0K1yHEQNiU560A5SPjTPXadJ0Ex/Rsgi9/WAyLIcHqEZzvBN4jRgpAD
         IAMO65VvPfPsZQJKxdRxf2W2gRmqLH50bw6unkOVSSe8My9VV0tEuXs2N3B7sYq2hkld
         t5B0SE1qZ+o5rQ4TUDnYWXXh8eg1Nt3L/GhJ0ksKyVosXiMyfCTN8JTA5htFHlsYZW+G
         dXE8cLZCLD9Zl79rAbxHaGdDCO7NfFCyaZR8+gPC7uiwG5lbpKmI6mVWm1RSXeANk6qM
         UcO6A5XH9nY254P9rogpUj2RJmTk0rh/6HpUzaVgJH/PG9+8/XOv62/RnHvmy/k3PMEG
         bLVA==
X-Gm-Message-State: AOAM533lWCsAygB6uwFH7NPu38ABjLQgiY9JNrJ4O1dLIPvYtkQWjmE8
        yjUTwfZwMmGwCxQklTlktpM=
X-Google-Smtp-Source: ABdhPJyleajyRpBrrXUjD8GqJPpb/1++iWRzfLdTQ72N8RYDVENKPnSXNItvO94J7ZdMRAdWS/ix6g==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr23774132wru.214.1615739669218;
        Sun, 14 Mar 2021 09:34:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:28 -0700 (PDT)
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
Subject: [PATCH v3 00/15] Introduce devm_pm_opp_* API
Date:   Sun, 14 Mar 2021 19:33:53 +0300
Message-Id: <20210314163408.22292-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds resource-managed OPP API helpers and makes drivers
to use them.

Changelog:

v3: - Dropped dev_pm_opp_register_notifier().

    - Changed return type of the devm helpers from opp_table pointer
      to errno.

    - Corrected drm/msm patch which missed to remove opp_put_supported_hw()
      from a6xx_gpu. Note that the a5xx_gpu driver was missing the
      opp_put_supported_hw() at all.

    - Corrected spelling of the ack from Mark Brown.

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

Dmitry Osipenko (2):
  opp: Change return type of devm_pm_opp_register_set_opp_helper()
  opp: Change return type of devm_pm_opp_attach_genpd()

Yangtao Li (13):
  opp: Add devres wrapper for dev_pm_opp_set_clkname
  opp: Add devres wrapper for dev_pm_opp_set_regulators
  opp: Add devres wrapper for dev_pm_opp_set_supported_hw
  opp: Add devres wrapper for dev_pm_opp_of_add_table
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

 drivers/gpu/drm/lima/lima_devfreq.c           |  47 ++-----
 drivers/gpu/drm/lima/lima_devfreq.h           |   3 -
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  11 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   2 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  23 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |   2 -
 drivers/gpu/drm/msm/dp/dp_ctrl.c              |  30 +----
 drivers/gpu/drm/msm/dp/dp_ctrl.h              |   1 -
 drivers/gpu/drm/msm/dp/dp_display.c           |   5 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  13 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  37 ++----
 drivers/gpu/drm/panfrost/panfrost_devfreq.h   |   2 -
 drivers/media/platform/qcom/venus/core.h      |   1 -
 .../media/platform/qcom/venus/pm_helpers.c    |  35 ++---
 drivers/memory/samsung/exynos5422-dmc.c       |  13 +-
 drivers/mmc/host/sdhci-msm.c                  |  19 +--
 drivers/opp/core.c                            | 122 ++++++++++++++----
 drivers/opp/of.c                              |  36 ++++++
 drivers/spi/spi-geni-qcom.c                   |  16 +--
 drivers/spi/spi-qcom-qspi.c                   |  18 +--
 drivers/tty/serial/qcom_geni_serial.c         |  23 ++--
 include/linux/pm_opp.h                        |  43 +++++-
 include/linux/qcom-geni-se.h                  |   2 -
 26 files changed, 250 insertions(+), 260 deletions(-)

-- 
2.30.2

