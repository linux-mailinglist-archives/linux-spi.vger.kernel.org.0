Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B298C39D539
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbhFGGqi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 02:46:38 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:51852 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhFGGqi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 02:46:38 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id C5A55AD0D3;
        Mon,  7 Jun 2021 14:44:45 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32529T140357020903168S1623048283531022_;
        Mon, 07 Jun 2021 14:44:46 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6a353039b07003a315a0ea3022898f88>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 7
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     jon.lin@rock-chips.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 6/6] spi: rockchip: Support SPI_CS_HIGH
Date:   Mon,  7 Jun 2021 14:44:40 +0800
Message-Id: <20210607064440.31616-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607064440.31616-1-jon.lin@rock-chips.com>
References: <20210607063448.29589-1-jon.lin@rock-chips.com>
 <20210607064440.31616-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

1.Add standard spi-cs-high support
2.Refer to spi-controller.yaml for details

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None

 drivers/spi/spi-rockchip.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index be7d90e18a3f..4b08be25c33d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -108,6 +108,8 @@
 #define CR0_OPM_MASTER				0x0
 #define CR0_OPM_SLAVE				0x1
 
+#define CR0_SOI_OFFSET				23
+
 #define CR0_MTM_OFFSET				0x21
 
 /* Bit fields in SER, 2bit */
@@ -238,7 +240,7 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
-	bool cs_asserted = !enable;
+	bool cs_asserted = spi->mode & SPI_CS_HIGH ? enable : !enable;
 
 	/* Return immediately for no-op */
 	if (cs_asserted == rs->cs_asserted[spi->chip_select])
@@ -509,6 +511,8 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
 		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
+	if (spi->mode & SPI_CS_HIGH)
+		cr0 |= BIT(spi->chip_select) << CR0_SOI_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
 		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
@@ -787,7 +791,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	ctlr->auto_runtime_pm = true;
 	ctlr->bus_num = pdev->id;
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_LSB_FIRST;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_LSB_FIRST | SPI_CS_HIGH;
 	if (slave_mode) {
 		ctlr->mode_bits |= SPI_NO_CS;
 		ctlr->slave_abort = rockchip_spi_slave_abort;
-- 
2.17.1



