Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FDD223488
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 08:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgGQGai (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 02:30:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:39197 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgGQGah (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 02:30:37 -0400
IronPort-SDR: fwt5JJyieXYUaUOq0y8l+QWJer3JQ3z+Dne//9vkQhuNLaLDqR2nO2G2HTQKT+lmCM9NJ8oFAq
 6vyd5jcOGwow==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="214265104"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="214265104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:30:36 -0700
IronPort-SDR: V+I1YajGvqWNa7xnfS7WNmctSlHkrktGf2f63Z60Svc+gPmOswOJmuF6SkYPFOAucX+X8ZCyki
 Eszccvo5MhOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="486372672"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2020 23:30:33 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 3/8] spi: lantiq: Move interrupt control register offesets to SoC specific data structure
Date:   Fri, 17 Jul 2020 14:27:52 +0800
Message-Id: <f0f9723a30ea9c2ee48d2199f7512af9e15803b0.1594957019.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Address of Interrupt control registers are different on new chipsets.
So move them to SoC specific data structure.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/spi-lantiq-ssc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 1073a70a4beba..98e1c5d807597 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -50,8 +50,6 @@
 #define LTQ_SPI_RXCNT		0x84
 #define LTQ_SPI_DMACON		0xec
 #define LTQ_SPI_IRNEN		0xf4
-#define LTQ_SPI_IRNICR		0xf8
-#define LTQ_SPI_IRNCR		0xfc
 
 #define LTQ_SPI_CLC_SMC_S	16	/* Clock divider for sleep mode */
 #define LTQ_SPI_CLC_SMC_M	(0xFF << LTQ_SPI_CLC_SMC_S)
@@ -159,8 +157,10 @@
 #define LTQ_SPI_IRNEN_ALL	0x1F
 
 struct lantiq_ssc_hwcfg {
-	unsigned int irnen_r;
-	unsigned int irnen_t;
+	unsigned int	irnen_r;
+	unsigned int	irnen_t;
+	unsigned int	irncr;
+	unsigned int	irnicr;
 };
 
 struct lantiq_ssc_spi {
@@ -793,13 +793,17 @@ static int lantiq_ssc_transfer_one(struct spi_master *master,
 }
 
 static const struct lantiq_ssc_hwcfg lantiq_ssc_xway = {
-	.irnen_r = LTQ_SPI_IRNEN_R_XWAY,
-	.irnen_t = LTQ_SPI_IRNEN_T_XWAY,
+	.irnen_r	= LTQ_SPI_IRNEN_R_XWAY,
+	.irnen_t	= LTQ_SPI_IRNEN_T_XWAY,
+	.irnicr		= 0xF8,
+	.irncr		= 0xFC,
 };
 
 static const struct lantiq_ssc_hwcfg lantiq_ssc_xrx = {
-	.irnen_r = LTQ_SPI_IRNEN_R_XRX,
-	.irnen_t = LTQ_SPI_IRNEN_T_XRX,
+	.irnen_r	= LTQ_SPI_IRNEN_R_XRX,
+	.irnen_t	= LTQ_SPI_IRNEN_T_XRX,
+	.irnicr		= 0xF8,
+	.irncr		= 0xFC,
 };
 
 static const struct of_device_id lantiq_ssc_match[] = {
-- 
2.11.0

