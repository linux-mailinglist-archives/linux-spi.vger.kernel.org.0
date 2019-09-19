Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD41DB8266
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2019 22:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404641AbfISUZQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Sep 2019 16:25:16 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38803 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404462AbfISUZQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Sep 2019 16:25:16 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B28371BF20D;
        Thu, 19 Sep 2019 20:25:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Julien Su <juliensu@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/4] spi: mxic: Fix DMAS_CTRL register layout
Date:   Thu, 19 Sep 2019 22:25:04 +0200
Message-Id: <20190919202504.9619-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919202504.9619-1-miquel.raynal@bootlin.com>
References: <20190919202504.9619-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the current layout which only matches early non-public revisions
of the IP. Since its official distribution, two bytes of the SPI
controller DMAS_CTRL register have been inverted.

Suggested-by: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mxic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 5d5404642226..7911600cc954 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -145,8 +145,8 @@
 #define LWR_SUSP_CTRL_EN	BIT(31)
 
 #define DMAS_CTRL		0x9c
-#define DMAS_CTRL_DIR_READ	BIT(31)
-#define DMAS_CTRL_EN		BIT(30)
+#define DMAS_CTRL_EN		BIT(31)
+#define DMAS_CTRL_DIR_READ	BIT(30)
 
 #define DATA_STROB		0xa0
 #define DATA_STROB_EDO_EN	BIT(2)
-- 
2.20.1

