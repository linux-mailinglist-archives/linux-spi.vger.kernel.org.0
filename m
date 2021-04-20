Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303673652BC
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 09:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhDTHCB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 03:02:01 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:23577 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhDTHB4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 03:01:56 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 13K6V2oB084137
        for <linux-spi@vger.kernel.org>; Tue, 20 Apr 2021 14:31:02 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.94])
        by TWHMLLG3.macronix.com with ESMTP id 13K6UM7b083760;
        Tue, 20 Apr 2021 14:30:22 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
From:   Zhengxun Li <zhengxunli@mxic.com.tw>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        broonie@kernel.org, jaimeliao@mxic.com.tw,
        Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: [PATCH v3 0/3] Add octal DTR support for Macronix flash
Date:   Tue, 20 Apr 2021 14:29:36 +0800
Message-Id: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 13K6UM7b083760
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds support for Octal DTR for Macronix flashes. The
first set of patches is add Macronix octal dtr mode support. The
second set of patches add Macronix octaflash series support. The
last add the Octal DTR mode support for host driver.

Changes in v3:
- Add support for Macronix octaflash series.

Changes in v2:
- Define with a generic name to describe the maximum dummy cycles.
- Compare the ID directly in the loop, no longer copy and execute
  memcmp().
- Add spi_mem_dtr_supports_op() to support dtr operation.

Zhengxun Li (3):
  mtd: spi-nor: macronix: add support for Macronix octal dtr operation
  mtd: spi-nor: macronix: add support for Macronix octaflash series
  spi: mxic: patch for octal DTR mode support

 drivers/mtd/spi-nor/macronix.c | 217 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-mxic.c         |  41 +++++---
 2 files changed, 247 insertions(+), 11 deletions(-)

-- 
1.9.1

