Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C192FDA9E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 21:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbhATUQr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 15:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733217AbhATOA5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jan 2021 09:00:57 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F5C061786
        for <linux-spi@vger.kernel.org>; Wed, 20 Jan 2021 05:59:46 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2E1Q-00EO67-LI
        for linux-spi@vger.kernel.org; Wed, 20 Jan 2021 14:59:44 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2E1H-00EO4n-MI; Wed, 20 Jan 2021 14:59:35 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2E1G-00121c-TB; Wed, 20 Jan 2021 14:59:34 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v5 0/2] spi: Add support for Realtek RTL838x/RTL839x SoC SPI
Date:   Wed, 20 Jan 2021 14:59:26 +0100
Message-Id: <20210120135928.246054-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

v5:
- Changed SoC compatible to list exact models

v4:
- Added SoC series-specific compatible matches.

v3:
- Added cpu_relax() to busy loop.
- Dropped .remove callback from driver struct.
- Use (variations of) realtek-rtl as prefix.
- Dropped Kconfig entry, and use MACH_REALTEK_RTL setting to build the
  driver, since there's no point booting without the SPI-connected flash.

v2:
- Rewrote from spi-nor driver to regular spi driver, implementing only
  set_cs() and transfer_one(). (Thanks Chuanhong Guo!)


Bert Vermeulen (2):
  dt-bindings: spi: Realtek RTL838x/RTL839x SPI controller
  spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SPI
    controllers

 .../bindings/spi/realtek,rtl-spi.yaml         |  41 ++++
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-realtek-rtl.c                 | 209 ++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
 create mode 100644 drivers/spi/spi-realtek-rtl.c

-- 
2.25.1

