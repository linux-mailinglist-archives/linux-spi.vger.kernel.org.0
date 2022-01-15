Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAF048F465
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jan 2022 03:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiAOCbk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jan 2022 21:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiAOCbk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jan 2022 21:31:40 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B3C061574;
        Fri, 14 Jan 2022 18:31:40 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i17so4362811pfk.11;
        Fri, 14 Jan 2022 18:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQWlGJA/87lu3B9ptH8VcvnpE+ppPbV/Z9mGI73dEIc=;
        b=oduxCJyoWNpm9/ihf7E9qVuLeKeXGUJjShwxh60TjjIL/z73sLxzNQGpmH5ZctqSDA
         qd7krj/MaYtdmrzIWp14Cr6IPFdJQsLMtXklUDnKGi0zxGV/pLJt9yhkI91nDbvsPEP4
         6zi9VUAPP8WqCbBAkxQjYBL5OMoFHJRBcns/35a855Ui0e5Md7KQ4t91gJcgSjCBSDQd
         8KXQvyObMqiDMWrQza6MCJohEyLoV4VWtTmBdJ47AJce7LeKLMRiFl59BR6ISaF3qanS
         itXJK8Nj8vmNPX5twl1xWgEES8BCLt3exLkjvU3Gr3cdhxb4OECOsRF9Iwx/miZeyF2+
         WCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQWlGJA/87lu3B9ptH8VcvnpE+ppPbV/Z9mGI73dEIc=;
        b=F0/MlZT6MBXAgXANPNORI/qJ7UHRwUligao2WBkvqbUdP35R1cNKs6j7a2QFVgW/rH
         WQdysPed9ErUJg9h7bjYOt25KeM7Dh3QJfgZ7yWa1lD7TI0IvCeeHuCJvIwY2dTAOzP9
         DDJj6846ZOq93ObKCBPa4oE0gUnc0g05b8E0/+1YGQC9sWCOGMKyvSqapRMffo0a/Jx2
         O21reaFx80OuotB84uKLIh6XmiauTieKpHBSWD6XAvdVWuXyk2ZuqitMn7dJiMtX+Ou1
         gDz+Ju9536aqYWikToL7faK8942m97NRlatAn8zQBPy4BHExk66n4W5N0daadwbNtkzM
         7vDg==
X-Gm-Message-State: AOAM533DKzuWIbQw4vTwnPDOo4wK8znXl2l9IBDzHFEIGRmgYqjQdjC+
        ElF0vWSW6/eYTphXCdv9TxY3E+dAu9c=
X-Google-Smtp-Source: ABdhPJyCZnkGkjAGAiAfdX6a66BSn4hjmMrHamtM1k+79yX1HUne2NzGKJtN9QMYhMg2yLvXasZb+g==
X-Received: by 2002:a63:aa4a:: with SMTP id x10mr10246609pgo.589.1642213899593;
        Fri, 14 Jan 2022 18:31:39 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:38:6d64:e944:7a7c:3d])
        by smtp.gmail.com with ESMTPSA id oo14sm6874500pjb.34.2022.01.14.18.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 18:31:39 -0800 (PST)
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
Subject: [PATCH v3 0/5] Add spi-hid, transport for HID over SPI bus
Date:   Fri, 14 Jan 2022 18:31:30 -0800
Message-Id: <20220115023135.234667-1-dmanti@microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Dmitry Antipov (5):
  HID: Add BUS_SPI support when printing out device info in
    hid_connect()
  HID: define HID_SPI_DEVICE macro in hid.h
  Documentation: DT bindings for HID over SPI.
  Documentation: Correction in HID output_report callback description.
  HID: add spi-hid, transport driver for HID over SPI bus

 .../bindings/input/hid-over-spi.txt           |   43 +
 Documentation/hid/hid-transport.rst           |    4 +-
 arch/arm64/configs/defconfig                  |    1 +
 drivers/hid/Kconfig                           |    2 +
 drivers/hid/Makefile                          |    1 +
 drivers/hid/hid-core.c                        |    3 +
 drivers/hid/spi-hid/Kconfig                   |   25 +
 drivers/hid/spi-hid/Makefile                  |   12 +
 drivers/hid/spi-hid/spi-hid-core.c            | 1328 +++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h            |  188 +++
 drivers/hid/spi-hid/spi-hid-of.c              |  148 ++
 drivers/hid/spi-hid/spi-hid-of.h              |   34 +
 drivers/hid/spi-hid/spi-hid_trace.h           |  198 +++
 drivers/hid/spi-hid/trace.c                   |   11 +
 include/linux/hid.h                           |    2 +
 15 files changed, 1998 insertions(+), 2 deletions(-)
 create mode 100755 Documentation/devicetree/bindings/input/hid-over-spi.txt
 create mode 100644 drivers/hid/spi-hid/Kconfig
 create mode 100644 drivers/hid/spi-hid/Makefile
 create mode 100644 drivers/hid/spi-hid/spi-hid-core.c
 create mode 100644 drivers/hid/spi-hid/spi-hid-core.h
 create mode 100755 drivers/hid/spi-hid/spi-hid-of.c
 create mode 100755 drivers/hid/spi-hid/spi-hid-of.h
 create mode 100644 drivers/hid/spi-hid/spi-hid_trace.h
 create mode 100644 drivers/hid/spi-hid/trace.c

-- 
2.25.1

