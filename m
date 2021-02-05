Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA198310955
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 11:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhBEKmP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 05:42:15 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:57547 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhBEKgw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 05:36:52 -0500
X-Greylist: delayed 1792 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2021 05:36:52 EST
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 1159dh1f015092
        for <linux-spi@vger.kernel.org>; Fri, 5 Feb 2021 17:39:43 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.94])
        by TWHMLLG3.macronix.com with ESMTP id 1159cf8E014367;
        Fri, 5 Feb 2021 17:38:41 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
From:   zhengxunli <zhengxunli@mxic.com.tw>
To:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        miquel.raynal@bootlin.com, broonie@kernel.org, vigneshr@ti.com
Cc:     ycllin@mxic.com.tw, juliensu@mxic.com.tw,
        zhengxunli <zhengxunli@mxic.com.tw>
Subject: [PATCH v2 0/2] Add octal DTR support for Macronix flash
Date:   Fri,  5 Feb 2021 17:36:46 +0800
Message-Id: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 1159cf8E014367
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series adds support for Octal DTR for Macronix flashes. The
first set of patches is add Macronix octaflash series octal dtr
mode support. The second set of patches add the Octal DTR mode
support for host driver.

Changes in v2:
- Define with a generic name to describe the maximum dummy cycles.

- Compare the ID directly in the loop, no longer copy and execute
  memcmp().

- Add spi_mem_dtr_supports_op() to support dtr operation.

zhengxunli (2):
  mtd: spi-nor: macronix: add support for Macronix octaflash
  spi: mxic: patch for octal DTR mode support

 drivers/mtd/spi-nor/macronix.c | 121 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-mxic.c         |  41 ++++++++++----
 2 files changed, 151 insertions(+), 11 deletions(-)

-- 
1.9.1

