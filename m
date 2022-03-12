Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A704D6ED0
	for <lists+linux-spi@lfdr.de>; Sat, 12 Mar 2022 14:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiCLNaV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Mar 2022 08:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiCLNaV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Mar 2022 08:30:21 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8462B269
        for <linux-spi@vger.kernel.org>; Sat, 12 Mar 2022 05:29:15 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05F093F60E
        for <linux-spi@vger.kernel.org>; Sat, 12 Mar 2022 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091754;
        bh=OCrj2Lr7nKg3/D4n6AH2mK+/SAYpiHPGeQpPG1FkFdg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=wGSnEqAgjHrDfvY7OzkWEWtQb/612fnlsOvlWmaAjYkT9PzOj0BTAHOilqNTXxAKT
         4014KhJzvuqJ7H+VKrfrPSLZEuMpAlmXMvZJE16BZafTlnH0MVnjG81EvK5geWY73y
         sYaJbr127WhQIt6eBwQbPh4Vyp3a4QHl+reo+PasrQ9ltRLQR8/BRNO+eEAnzpJxU7
         2aD3pxOeyinORmunyP3i73v+Q39kNJNBtSXXmbOkolD5gjcIdA6XdfNtWq5QEG2vbw
         LdqfeGxeeC5CLrJSuyiqY+8h+A5zo2UWSXCp5ZjN4OBkziBIVXsrEB7+6LKXydGYID
         ybosZQT9iob8g==
Received: by mail-wm1-f71.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso3535685wme.1
        for <linux-spi@vger.kernel.org>; Sat, 12 Mar 2022 05:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCrj2Lr7nKg3/D4n6AH2mK+/SAYpiHPGeQpPG1FkFdg=;
        b=GE9LMTivavxuvN4oDezR8k3PfuZkCjPI0fU4L2b3H1tM+hcHLxYLCPVb7gc+b+5J/5
         yxSld6iIkNToDZ/NPJEPwvh7K9H4v7RA/wIsJKEAu1I1W3VUNr9ODfGcufAAOwsmvff3
         ZPqq2Qv2jDhRs7dtF+Ac31jRUobr63H/u8/n08WOnM30UfePLkEz3as/VkoFynO7JLgp
         qT8mVjFGfhhCcmI0GHh6nPIlo4kMafeXLg8WrvJ33kk3NfpoHuPQ9PEa9EAvicVFtLXL
         1KLlg9i868WXkD1BkFOzRa15MkWZgmZLOKdRnoeoatmtbKrZgc3zFYT7Ir1TtylvB1Bm
         nMvw==
X-Gm-Message-State: AOAM531UtSrx2NluANz7Wm15EsRMmUkD5c4B3awyGQ68bCFlmOFwIuhm
        EVjtjYqWVFtzLWBdBvnJEk4XxgXf0PlA4sonGpOc2gXFXfC6pZjr8fR+hd5QCbt2uAE1SZKJ88d
        gEBb9i/Zgci051pkswmwkKaE/Q3e9rudLjwZ/5A==
X-Received: by 2002:a5d:4dca:0:b0:1f0:2543:e10e with SMTP id f10-20020a5d4dca000000b001f02543e10emr10689842wru.60.1647091753468;
        Sat, 12 Mar 2022 05:29:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx08jwnIztDnOLiXVDOEbPcafrm/CtfYrKe3rhTTULaSTSBSgqOJ8fo2V1YMqeSSpK6UdbZbQ==
X-Received: by 2002:a5d:4dca:0:b0:1f0:2543:e10e with SMTP id f10-20020a5d4dca000000b001f02543e10emr10689827wru.60.1647091753256;
        Sat, 12 Mar 2022 05:29:13 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 00/11] Fix broken usage of driver_override (and kfree of static memory)
Date:   Sat, 12 Mar 2022 14:28:45 +0100
Message-Id: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This is a continuation of my old patchset from 2019. [1]
Back then, few drivers set driver_override wrong. I fixed Exynos
in a different way after discussions. QCOM NGD was not fixed
and a new user appeared - IMX SCU.

It seems "char *" in driver_override looks too consty, so we
tend to make a mistake of storing there string literals.

Changes since latest v3
=======================
1. Wrap comments, extend comment in driver_set_override() about newline.
2. Minor commit msg fixes.
3. Add tags.

Changes since latest v2
=======================
1. Make all driver_override fields as "const char *", just like SPI
   and VDPA. (Mark)
2. Move "count" check to the new helper and add "count" argument. (Michael)
3. Fix typos in docs, patch subject. Extend doc. (Michael, Bjorn)
4. Compare pointers to reduce number of string readings in the helper.
5. Fix clk-imx return value.

Changes since latest v1 (not the old 2019 solution):
====================================================
https://lore.kernel.org/all/708eabb1-7b35-d525-d4c3-451d4a3de84f@rasmusvillemoes.dk/
1. Add helper for setting driver_override.
2. Use the helper.

Dependencies, merging and stable
================================
1. All patches, including last three fixes, depend on the first patch
   introducing the helper.
2. Merging idea: everything via driver core (Greg KH?).
2. The last three commits - fixes - are probably not backportable
   directly, because of this dependency. I don't know how to express
   this dependency here, since stable-kernel-rules.rst mentions only commits as
   possible dependencies.

[1] https://lore.kernel.org/all/1550484960-2392-3-git-send-email-krzk@kernel.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (11):
  driver: platform: Add helper for safer setting of driver_override
  amba: Use driver_set_override() instead of open-coding
  fsl-mc: Use driver_set_override() instead of open-coding
  hv: Use driver_set_override() instead of open-coding
  PCI: Use driver_set_override() instead of open-coding
  s390/cio: Use driver_set_override() instead of open-coding
  spi: Use helper for safer setting of driver_override
  vdpa: Use helper for safer setting of driver_override
  clk: imx: scu: Fix kfree() of static memory on setting driver_override
  slimbus: qcom-ngd: Fix kfree() of static memory on setting
    driver_override
  rpmsg: Fix kfree() of static memory on setting driver_override

 drivers/amba/bus.c              | 28 +++--------------
 drivers/base/driver.c           | 56 +++++++++++++++++++++++++++++++++
 drivers/base/platform.c         | 28 +++--------------
 drivers/bus/fsl-mc/fsl-mc-bus.c | 25 +++------------
 drivers/clk/imx/clk-scu.c       |  7 ++++-
 drivers/hv/vmbus_drv.c          | 28 +++--------------
 drivers/pci/pci-sysfs.c         | 28 +++--------------
 drivers/rpmsg/rpmsg_core.c      |  3 +-
 drivers/rpmsg/rpmsg_internal.h  | 13 ++++++--
 drivers/rpmsg/rpmsg_ns.c        | 14 +++++++--
 drivers/s390/cio/cio.h          |  6 +++-
 drivers/s390/cio/css.c          | 28 +++--------------
 drivers/slimbus/qcom-ngd-ctrl.c | 13 +++++++-
 drivers/spi/spi.c               | 26 +++------------
 drivers/vdpa/vdpa.c             | 29 +++--------------
 include/linux/amba/bus.h        |  6 +++-
 include/linux/device/driver.h   |  2 ++
 include/linux/fsl/mc.h          |  6 ++--
 include/linux/hyperv.h          |  6 +++-
 include/linux/pci.h             |  6 +++-
 include/linux/platform_device.h |  6 +++-
 include/linux/rpmsg.h           |  6 ++--
 include/linux/spi/spi.h         |  2 ++
 include/linux/vdpa.h            |  4 ++-
 24 files changed, 171 insertions(+), 205 deletions(-)

-- 
2.32.0

