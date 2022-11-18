Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA83862EAA5
	for <lists+linux-spi@lfdr.de>; Fri, 18 Nov 2022 02:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbiKRBAP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Nov 2022 20:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiKRBAO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Nov 2022 20:00:14 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 17:00:13 PST
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A25D1BF46
        for <linux-spi@vger.kernel.org>; Thu, 17 Nov 2022 17:00:13 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Nov 2022 09:59:09 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id C17CE20584CE;
        Fri, 18 Nov 2022 09:59:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 18 Nov 2022 09:59:09 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 50695B62A4;
        Fri, 18 Nov 2022 09:59:09 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] Introduce Socionext F_OSPI SPI flash controller
Date:   Fri, 18 Nov 2022 09:59:02 +0900
Message-Id: <20221118005904.23557-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds dt-bindings and a driver for Socionext F_OSPI controller
for connecting an SPI Flash memory over up to 8-bit wide bus.
The controller supports up to 4 chip selects.

Kunihiko Hayashi (2):
  dt-bindings: spi: Add Socionext F_OSPI controller bindings
  spi: Add Socionext F_OSPI SPI flash controller driver

 .../bindings/spi/socionext,f-ospi.yaml        |  99 +++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-sn-f-ospi.c                   | 818 ++++++++++++++++++
 4 files changed, 927 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
 create mode 100644 drivers/spi/spi-sn-f-ospi.c

-- 
2.25.1

