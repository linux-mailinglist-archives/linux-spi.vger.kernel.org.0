Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2722348F
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 08:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgGQGam (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 02:30:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:63570 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgGQGal (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 02:30:41 -0400
IronPort-SDR: 1QfXiISSRZzCKSHWET5WG4v7GsfipTNMpwmcMvA1101pAdU1BcizNWVh4gf8yV8rORmBUSQO28
 Y6JjnFAlIDpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147053465"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="147053465"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:30:40 -0700
IronPort-SDR: 2lzccdjrqJwl3+HpghMgQuC4H2TQbd386kji92kmKJGHxn393xCdulBriksNZDFa+67tG82MD5
 sRwusNrmXojA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="318679974"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2020 23:30:37 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 4/8] spi: lantiq: Add support to acknowledge interrupt
Date:   Fri, 17 Jul 2020 14:27:53 +0800
Message-Id: <608923b484d9ef239b44bb545c0b79b27030a6ae.1594957019.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On newer chipsets interrupt need to be acknowledged as they use
different interrupt controller which does not acknowledge the
interrupts automatically.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/spi-lantiq-ssc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 98e1c5d807597..cbe019f995999 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -161,6 +161,7 @@ struct lantiq_ssc_hwcfg {
 	unsigned int	irnen_t;
 	unsigned int	irncr;
 	unsigned int	irnicr;
+	bool		irq_ack;
 };
 
 struct lantiq_ssc_spi {
@@ -623,9 +624,14 @@ static void rx_request(struct lantiq_ssc_spi *spi)
 static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
 {
 	struct lantiq_ssc_spi *spi = data;
+	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
+	u32 val = lantiq_ssc_readl(spi, hwcfg->irncr);
 	unsigned long flags;
 
 	spin_lock_irqsave(&spi->lock, flags);
+	if (hwcfg->irq_ack)
+		lantiq_ssc_writel(spi, val, hwcfg->irncr);
+
 	if (spi->tx) {
 		if (spi->rx && spi->rx_todo)
 			rx_fifo_read_full_duplex(spi);
@@ -660,13 +666,18 @@ static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
 static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
 {
 	struct lantiq_ssc_spi *spi = data;
+	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
 	u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
+	u32 val = lantiq_ssc_readl(spi, hwcfg->irncr);
 	unsigned long flags;
 
 	if (!(stat & LTQ_SPI_STAT_ERRORS))
 		return IRQ_NONE;
 
 	spin_lock_irqsave(&spi->lock, flags);
+	if (hwcfg->irq_ack)
+		lantiq_ssc_writel(spi, val, hwcfg->irncr);
+
 	if (stat & LTQ_SPI_STAT_RUE)
 		dev_err(spi->dev, "receive underflow error\n");
 	if (stat & LTQ_SPI_STAT_TUE)
@@ -797,6 +808,7 @@ static const struct lantiq_ssc_hwcfg lantiq_ssc_xway = {
 	.irnen_t	= LTQ_SPI_IRNEN_T_XWAY,
 	.irnicr		= 0xF8,
 	.irncr		= 0xFC,
+	.irq_ack	= false,
 };
 
 static const struct lantiq_ssc_hwcfg lantiq_ssc_xrx = {
@@ -804,6 +816,7 @@ static const struct lantiq_ssc_hwcfg lantiq_ssc_xrx = {
 	.irnen_t	= LTQ_SPI_IRNEN_T_XRX,
 	.irnicr		= 0xF8,
 	.irncr		= 0xFC,
+	.irq_ack	= false,
 };
 
 static const struct of_device_id lantiq_ssc_match[] = {
-- 
2.11.0

