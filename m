Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1F55E2F2
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiF1CYU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 22:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbiF1CXH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 22:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBDA24943;
        Mon, 27 Jun 2022 19:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3DD6185C;
        Tue, 28 Jun 2022 02:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC1BC34115;
        Tue, 28 Jun 2022 02:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656382964;
        bh=1lnzaHrP8/Nz40BDmWvhOM2XuhI02Wl0KrII2CAXXCU=;
        h=From:To:Cc:Subject:Date:From;
        b=aeMvU36yIXCqEijvlelJCe1C60yQ2uubCn/jMLzU1bQlms62onpBYDIZjEg1ESLr+
         gVa+4Tgq3Gw4lm6t/P+Z7hGe56MTW2S4zLNFjPnmKTOskPoBDgKJ1wvb/d9yrxS/IZ
         Lj4h5putrO09EhYr4h0K5Btc4KuHotxNXALohe2Y9fza/sm/dTJy0a1SFK0T1CiFdA
         kjk3ZT/PEJ3grJOU/i3D5ymkzcWJ58UZSATLEwhhqof4NXSE75XDYBCD8Pr/3to/U9
         2q3DS0xX1lduZ+UDvNuCu8WCP1w95E9HYmNiU3OsR5+sarvU72PBa1zRa0l43MkqQu
         vOJJ3ZmxJ/o2A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/34] spi: spi-cadence: Fix SPI CS gets toggling sporadically
Date:   Mon, 27 Jun 2022 22:22:08 -0400
Message-Id: <20220628022241.595835-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

[ Upstream commit 21b511ddee09a78909035ec47a6a594349fe3296 ]

As part of unprepare_transfer_hardware, SPI controller will be disabled
which will indirectly deassert the CS line. This will create a problem
in some of the devices where message will be transferred with
cs_change flag set(CS should not be deasserted).
As per SPI controller implementation, if SPI controller is disabled then
all output enables are inactive and all pins are set to input mode which
means CS will go to default state high(deassert). This leads to an issue
when core explicitly ask not to deassert the CS (cs_change = 1). This
patch fix the above issue by checking the Slave select status bits from
configuration register before disabling the SPI.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Link: https://lore.kernel.org/r/20220606062525.18447-1-amit.kumar-mahapatra@xilinx.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index ceb16e70d235..90b18c32f859 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -69,6 +69,7 @@
 #define CDNS_SPI_BAUD_DIV_SHIFT		3 /* Baud rate divisor shift in CR */
 #define CDNS_SPI_SS_SHIFT		10 /* Slave Select field shift in CR */
 #define CDNS_SPI_SS0			0x1 /* Slave Select zero */
+#define CDNS_SPI_NOSS			0x3C /* No Slave select */
 
 /*
  * SPI Interrupt Registers bit Masks
@@ -449,15 +450,20 @@ static int cdns_prepare_transfer_hardware(struct spi_master *master)
  * @master:	Pointer to the spi_master structure which provides
  *		information about the controller.
  *
- * This function disables the SPI master controller.
+ * This function disables the SPI master controller when no slave selected.
  *
  * Return:	0 always
  */
 static int cdns_unprepare_transfer_hardware(struct spi_master *master)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	u32 ctrl_reg;
 
-	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
+	/* Disable the SPI if slave is deselected */
+	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
+	ctrl_reg = (ctrl_reg & CDNS_SPI_CR_SSCTRL) >>  CDNS_SPI_SS_SHIFT;
+	if (ctrl_reg == CDNS_SPI_NOSS)
+		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	return 0;
 }
-- 
2.35.1

