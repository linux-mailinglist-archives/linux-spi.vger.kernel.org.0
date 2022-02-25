Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87384C3A9F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 02:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiBYBAN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 20:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiBYBAN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:00:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6402819A6;
        Thu, 24 Feb 2022 16:59:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p17so3384729plo.9;
        Thu, 24 Feb 2022 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiS7zOH5DxfqTubKO3X1OdfXi3Y10HKd6+IRDg8Pzvc=;
        b=l/5nZQNcrYoXeyoWHpZnsfjkyGH0hOrm8sEt0pKyiZwYz9yYl0LW8WT1AniShvkhMX
         OAbl8fTdI8cxE27BdATCuPJsEGsbc61xLnZE6n2B7XEBOpbh63MXVZEFf4x1yBjtTz7l
         7Xr9FmJ4P6jQMz9640WXzViGlSdZpaNMrid8j8Sp/VdlSi3QJmA5tuusp0ENVdx2TRTe
         zM1zdWPOUgj6MGNv7kisVOb0SixFNl0cY3lMd8khRcljCERLtT471Y30gbb2P1n9VNmV
         aOB/Kd1jEaa04gDwm12gU8GQlIlNkA0Kf4XpV9i5LokhTDcSND2oBXzAGbesn+CpGGGq
         m/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiS7zOH5DxfqTubKO3X1OdfXi3Y10HKd6+IRDg8Pzvc=;
        b=WjOfBpaSAx09cuJwzfM3uAdvRB3LpzbS3dH0ugw/2rwDzv5X/w3HMFV1G4GdOr+yMb
         YWjEyZ1ONMgDVW+E4pVk1J54OHfj10e0Uo6CsY8aD3smLvwLu3L2tJW/Em1pPULjDT+I
         u/FrNMAdBF7bkIZXQ8mnhk11P1lbU5ZkrjcMoz+fqhHADRJUxcsFNo7s+EyGpLU6grMf
         N4eW+bJR3MoyPe1SJsAo54ljTOnOgmGI5IqLjHNkv6ubRxvcjCZksbtChyqoYDbYoJUx
         +OXP4OxEQMNnALRSKprPtEcld4OKwQy3rz971MEa2OtqMjeGQT6Yb3+ePPIk9XE1GJle
         koPw==
X-Gm-Message-State: AOAM53344vBuRptYXhOr1CUardL9DRs2vAQJC3jr+KPOGz+ycvCpi4Bd
        qz2LHXd+ZaPAQqh5VaG0M7M=
X-Google-Smtp-Source: ABdhPJzXNPFmZeZtZk9oSlMbAG48Y0zgkHECLyhKZFU5kWKJIKXyCb/+zLSVlNc0MDaQNl4N+OhY4Q==
X-Received: by 2002:a17:902:76c5:b0:14e:e325:9513 with SMTP id j5-20020a17090276c500b0014ee3259513mr4990167plt.55.1645750781894;
        Thu, 24 Feb 2022 16:59:41 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:36:37cd:6bd:2964:3d5e])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b004f3a5535431sm742070pfu.4.2022.02.24.16.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:59:41 -0800 (PST)
From:   Dmitry Antipov <daantipov@gmail.com>
X-Google-Original-From: Dmitry Antipov <dmanti@microsoft.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Dmitry Antipov <dmanti@microsoft.com>
Subject: [PATCH v4 0/6] Add spi-hid, transport for HID over SPI bus
Date:   Thu, 24 Feb 2022 16:59:30 -0800
Message-Id: <20220225005936.3485405-1-dmanti@microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Surface Duo devices use a touch digitizer that communicates to the main
SoC via SPI and presents itself as a HID device. This patch's goal is to
add the spi-hid transport driver to drivers/hid. The driver follows the
publically available HID Over SPI Protocol Specification version 1.0.

The specification is available at
https://www.microsoft.com/en-us/download/details.aspx?id=103325.

In the initial commits there are some HID core changes to support a SPI
device, a change to HID documentation, HID over SPI Device Tree
bindings, and finally the SPI HID transport driver.

Dmitry Antipov (6):
  HID: Add BUS_SPI support when printing out device info in
    hid_connect()
  HID: define HID_SPI_DEVICE macro in hid.h
  Documentation: DT bindings for Microsoft G6 Touch Digitizer
  Documentation: Correction in HID output_report callback description.
  HID: add spi-hid, transport driver for HID over SPI bus
  Defconfig: add CONFIG_SPI_HID=m

 .../input/microsoft,g6-touch-digitizer.yaml   |  105 ++
 Documentation/hid/hid-transport.rst           |    4 +-
 arch/arm64/configs/defconfig                  |    1 +
 drivers/hid/Kconfig                           |    2 +
 drivers/hid/Makefile                          |    1 +
 drivers/hid/hid-core.c                        |    3 +
 drivers/hid/spi-hid/Kconfig                   |   25 +
 drivers/hid/spi-hid/Makefile                  |   12 +
 drivers/hid/spi-hid/spi-hid-core.c            | 1326 +++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h            |  188 +++
 drivers/hid/spi-hid/spi-hid-of.c              |  141 ++
 drivers/hid/spi-hid/spi-hid-of.h              |   30 +
 drivers/hid/spi-hid/spi-hid_trace.h           |  194 +++
 drivers/hid/spi-hid/trace.c                   |    9 +
 include/linux/hid.h                           |    2 +
 15 files changed, 2041 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
 create mode 100644 drivers/hid/spi-hid/Kconfig
 create mode 100644 drivers/hid/spi-hid/Makefile
 create mode 100644 drivers/hid/spi-hid/spi-hid-core.c
 create mode 100644 drivers/hid/spi-hid/spi-hid-core.h
 create mode 100644 drivers/hid/spi-hid/spi-hid-of.c
 create mode 100644 drivers/hid/spi-hid/spi-hid-of.h
 create mode 100644 drivers/hid/spi-hid/spi-hid_trace.h
 create mode 100644 drivers/hid/spi-hid/trace.c

-- 
2.25.1

