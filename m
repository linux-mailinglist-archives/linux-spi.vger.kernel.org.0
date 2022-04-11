Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DABF4FC452
	for <lists+linux-spi@lfdr.de>; Mon, 11 Apr 2022 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbiDKSsb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Apr 2022 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiDKSs3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Apr 2022 14:48:29 -0400
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C517B1FCDB
        for <linux-spi@vger.kernel.org>; Mon, 11 Apr 2022 11:46:13 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id E4910440871;
        Mon, 11 Apr 2022 21:45:39 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1649702740;
        bh=MEOSG85g2flAtn4jfkWx1n0E434b5qbnpSikVvx4Ey4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggKBNpTY8yeIEbIjwa0+Jgv0UwqtpzgIutbvnQN6S/BpPIOzXmxCHiFr/1DjlILYc
         58x4oCKI1VAq3T75FehJN+rslpGWdzV4u4QOWyA10vQ9iQN52K3ROtoyb3NA+GmNka
         aHasahmVS7h/7waE9Dwc1rGkd27MFQVwdmzmjRoq4I/1divqCsRpIIXlEndueoIuGI
         KiRG0J6AaEb9a8HeXsDtiPzhqO7H+COVQMTb3gLH9gIV/Svr9O547ejS78oIXuTzwt
         RIZ20lKd7yZk7m+20Bp4cit5dN3ZtFk7XxzgKCZQ0526J5zvrpYfj3V90nuvE2JR/E
         b2vLDO+QIxS5w==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Mark Brown <broonie@kernel.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>, linux-spi@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] spi: spidev: add SPI_RX_CPHA_FLIP
Date:   Mon, 11 Apr 2022 21:45:28 +0300
Message-Id: <6ae31ad24f8252418878b21a8759a04b78726dac.1649702729.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <a715ca92713ca02071f33dcca9960a66a03c949a.1649702729.git.baruch@tkos.co.il>
References: <a715ca92713ca02071f33dcca9960a66a03c949a.1649702729.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Baruch Siach <baruch.siach@siklu.com>

Allow userspace to set SPI_RX_CPHA_FLIP mode bit using the
SPI_IOC_WR_MODE32 ioctl.

Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 968dab2f5e3d..ff1a959fb30f 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -63,7 +63,8 @@ static DECLARE_BITMAP(minors, N_SPI_MINORS);
 				| SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP \
 				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
 				| SPI_TX_QUAD | SPI_TX_OCTAL | SPI_RX_DUAL \
-				| SPI_RX_QUAD | SPI_RX_OCTAL)
+				| SPI_RX_QUAD | SPI_RX_OCTAL \
+				| SPI_RX_CPHA_FLIP)
 
 struct spidev_data {
 	dev_t			devt;
-- 
2.35.1

