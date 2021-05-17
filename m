Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEFD382404
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 08:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhEQGRf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 02:17:35 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:26411 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhEQGRf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 02:17:35 -0400
Received: from localhost.localdomain ([172.17.195.94])
        by TWHMLLG4.macronix.com with ESMTP id 14H6G61f052301;
        Mon, 17 May 2021 14:16:06 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
From:   Zhengxun Li <zhengxunli@mxic.com.tw>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, broonie@kernel.org,
        jaimeliao@mxic.com.tw, Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: [PATCH v5 0/2] Add octal DTR support for Macronix flash
Date:   Mon, 17 May 2021 14:14:46 +0800
Message-Id: <1621232088-12567-1-git-send-email-zhengxunli@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com 14H6G61f052301
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds support for Octal DTR for Macronix flashes. The
first set of patches is add Macronix octal dtr mode support and
Macronix octaflash series support. The second add the Octal DTR
mode support for host driver.

Changes in v5:
- Based on Pratyush patch[0], modify the length of the value written
  to the Octal DTR register (1 is changed to 2) and add check ID in
  SPI mode.

  [0]https://patchwork.ozlabs.org/project/linux-mtd/patch/20210506191829.8271-3-p.yadav@ti.com/

Changes in v4:
- merge patch 2(support octaflash Id) to patch 1(support octal dtr)
- add switching back to default mode(1-1-1) support if octal dtr is
  disabled
- delete the duplicate code settings initialized by the Profile 1.0
  table. (such as cmd_ext_type, rdsr_dummy, rdsr_addr_nbytes, etc.)
- add a description about stacked die

Changes in v3:
- Add support for Macronix octaflash series.

Changes in v2:
- Define with a generic name to describe the maximum dummy cycles.
- Compare the ID directly in the loop, no longer copy and execute
  memcmp().
- Add spi_mem_dtr_supports_op() to support dtr operation.

Zhengxun Li (2):
  mtd: spi-nor: macronix: add support for Macronix octaflash
  spi: mxic: patch for octal DTR mode support

Zhengxun Li (2):
  mtd: spi-nor: macronix: add support for Macronix octaflash
  spi: mxic: patch for octal DTR mode support

 drivers/mtd/spi-nor/macronix.c | 185 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-mxic.c         |  41 ++++++---
 2 files changed, 215 insertions(+), 11 deletions(-)

-- 
1.9.1

