Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4168717E16
	for <lists+linux-spi@lfdr.de>; Wed, 31 May 2023 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjEaLdZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 May 2023 07:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjEaLdZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 May 2023 07:33:25 -0400
X-Greylist: delayed 1779 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 04:33:24 PDT
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB15E8
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 04:33:24 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q4JcD-0072Jh-NF; Wed, 31 May 2023 12:03:41 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1q4JcD-001Lbs-0q;
        Wed, 31 May 2023 12:03:41 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Cc:     fancer.lancer@gmail.com,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] spi: dw: announce driver probe
Date:   Wed, 31 May 2023 12:03:39 +0100
Message-Id: <20230531110339.321387-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ben Dooks <ben.dooks@sifive.com>

It is useful to know the driver probed, so print some basic
info when it does, such as the spi bus name, irq, etc.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/spi/spi-dw-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 071a7604a8ab..8e8a0d063519 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -958,6 +958,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		goto err_dma_exit;
 	}
 
+	dev_info(dev, "%s: irq %d, %d fifo, max freq %u",
+		 dev_name(&master->dev), dws->irq, dws->fifo_len,
+		 dws->max_freq);
 	dw_spi_debugfs_init(dws);
 	return 0;
 
-- 
2.39.2

