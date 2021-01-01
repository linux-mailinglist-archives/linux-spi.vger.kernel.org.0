Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096782E83D2
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbhAANZe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 08:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbhAANZe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 08:25:34 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F44C061575
        for <linux-spi@vger.kernel.org>; Fri,  1 Jan 2021 05:24:54 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kvKQG-00B66A-Bz
        for linux-spi@vger.kernel.org; Fri, 01 Jan 2021 14:24:52 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kvKQ5-00B64X-Pj; Fri, 01 Jan 2021 14:24:41 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kvKQ5-00Bggr-BL; Fri, 01 Jan 2021 14:24:41 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v3 0/2] spi: Add support for Realtek RTL838x/RTL839x SoC SPI
Date:   Fri,  1 Jan 2021 14:24:30 +0100
Message-Id: <20210101132432.2785663-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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
  spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SoC SPI
    controllers

 .../bindings/spi/realtek,rtl-spi.yaml         |  36 +++
 MAINTAINERS                                   |   6 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-realtek-rtl.c                 | 205 ++++++++++++++++++
 4 files changed, 248 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
 create mode 100644 drivers/spi/spi-realtek-rtl.c

-- 
2.25.1

