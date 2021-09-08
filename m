Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2414038E8
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349209AbhIHLhu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:37:50 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:6456 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349204AbhIHLht (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:37:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18858Mo3005982;
        Wed, 8 Sep 2021 06:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=e0hO/WkTJu2dFH32qDYgJsv06weRE3xi79uwFM7IAMo=;
 b=YIXHsen8zGgF46Yu+V4c6e+rMuVXsxD22VvPgqMiqc1yzvoMOre/Df2mzhjm5f+Jg9oB
 FM3PsXH6NLVXrM+FOQQIFqGKKI4SHoVRYOMpg8unbiardOeoQnN7E+zjpB/dVn5L2mXg
 II+7LhPFc3oLFfTLwS4PomPGSXS8/HoeexH67HcNi91fdJnaOWAElSrN0MGBk7B9qE2A
 6xEF8A5+hEW6qIRFJu3xndgLp5haafUuubDAm25Cz2RWWpbGOsHDJNJl0P073UW95Y/k
 6MI0bwmeCFJIpGZfgZxqbyvfwYxsPvR/yOP10FsXTAkqL6tVIhGilVPScfOIqKYgodoM xQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:36:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:36:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:36:37 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D01702BA;
        Wed,  8 Sep 2021 11:36:36 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 10/10] spi: amd: Configure the SPI speed
Date:   Wed, 8 Sep 2021 12:36:35 +0100
Message-ID: <20210908113635.788578-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CXmo9zbLayj4XBM4J5NZx3vlmzKQ5S2Q
X-Proofpoint-ORIG-GUID: CXmo9zbLayj4XBM4J5NZx3vlmzKQ5S2Q
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for configuring the speed of the bus per
device as the fastest clock that is less or equal to
the device max_speed_hz

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 105 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 788a5c42d811..0dde1ce757f2 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -19,7 +19,11 @@
 #define AMD_SPI_EXEC_CMD		BIT(16)
 #define AMD_SPI_FIFO_CLEAR		BIT(20)
 #define AMD_SPI_BUSY			BIT(31)
-#define AMD_SPI_ENABLE_REG		0x20
+#define AMD_SPI_ENA_REG			0x20
+#define AMD_SPI_ALT_SPD_SHIFT		20
+#define AMD_SPI_ALT_SPD_MASK		GENMASK(23, AMD_SPI_ALT_SPD_SHIFT)
+#define AMD_SPI_SPI100_SHIFT		0
+#define AMD_SPI_SPI100_MASK		GENMASK(AMD_SPI_SPI100_SHIFT, AMD_SPI_SPI100_SHIFT)
 
 #define AMD_SPI_DUMMY_CYCL_REG		0x32
 #define AMD_SPI_OPCODE_REG		0x45
@@ -34,6 +38,11 @@
 #define AMD_SPI_TX_COUNT_REG		0x48
 #define AMD_SPI_RX_COUNT_REG		0x4B
 #define AMD_SPI_STATUS_REG		0x4C
+#define AMD_SPI_SPEED_REG		0x6C
+#define AMD_SPI_SPD7_SHIFT		8
+#define AMD_SPI_SPD7_MASK		GENMASK(13, AMD_SPI_SPD7_SHIFT)
+#define AMD_SPI_SPD6_SHIFT		0
+#define AMD_SPI_SPD6_MASK		GENMASK(5, AMD_SPI_SPD6_SHIFT)
 
 #define AMD_SPI_FIFO_SIZE		70
 #define AMD_SPI_MEM_SIZE		200
@@ -42,6 +51,33 @@
 #define AMD_SPI_XFER_TX			1
 #define AMD_SPI_XFER_RX			2
 
+#define AMD_SPI_MAX_HZ			100000000
+#define AMD_SPI_MIN_HZ			800000
+
+static bool speed_dev;
+module_param(speed_dev, bool, 0644);
+
+enum amd_spi_speed {
+	F_66_66MHz,
+	F_33_33MHz,
+	F_22_22MHz,
+	F_16_66MHz,
+	F_100MHz,
+	F_800KHz,
+	SPI_SPD6,
+	SPI_SPD7,
+	F_50MHz = 0x4,
+	F_4MHz = 0x32,
+	F_3_17MHz = 0x3F
+};
+
+struct amd_spi_freq {
+	u32 speed_hz;
+	u32 ena;
+	u32 spd7;
+	bool use_spi100_eng;
+};
+
 struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
@@ -50,6 +86,7 @@ struct amd_spi {
 	const struct amd_spi_devtype_data *devtype_data;
 	struct spi_device *spi_dev;
 	struct spi_master *master;
+	u32 speed_hz;
 };
 
 struct amd_spi_devtype_data {
@@ -191,11 +228,63 @@ static int amd_spi_execute_opcode_v2(struct amd_spi *amd_spi)
 	return 0;
 }
 
+static const struct amd_spi_freq amd_spi_freq[] = {
+	{ AMD_SPI_MAX_HZ,   F_100MHz,         0,  true},
+	{       66660000, F_66_66MHz,         0, false},
+	{       50000000,   SPI_SPD7,   F_50MHz, false},
+	{       33330000, F_33_33MHz,         0, false},
+	{       22220000, F_22_22MHz,         0, false},
+	{       16660000, F_16_66MHz,         0, false},
+	{        4000000,   SPI_SPD7,    F_4MHz, false},
+	{        3170000,   SPI_SPD7, F_3_17MHz, false},
+	{ AMD_SPI_MIN_HZ,   F_800KHz,         0, false},
+};
+
+static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
+{
+	int i;
+	bool use_spi100_eng = false;
+	u32 spd7 = 0, ena;
+
+	if (speed_hz == amd_spi->speed_hz)
+		return 0;
+
+	if (speed_hz < AMD_SPI_MIN_HZ)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++) {
+		if (speed_hz >= amd_spi_freq[i].speed_hz) {
+			if (amd_spi->speed_hz == amd_spi_freq[i].speed_hz)
+				return 0;
+			amd_spi->speed_hz = amd_spi_freq[i].speed_hz;
+
+			use_spi100_eng = amd_spi_freq[i].use_spi100_eng;
+			spd7 = (amd_spi_freq[i].spd7 << AMD_SPI_SPD7_SHIFT) & AMD_SPI_SPD7_MASK;
+			ena = (amd_spi_freq[i].ena << AMD_SPI_ALT_SPD_SHIFT) & AMD_SPI_ALT_SPD_MASK;
+
+			amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, ena, AMD_SPI_ALT_SPD_MASK);
+			break;
+		}
+	}
+
+	if (spd7)
+		amd_spi_setclear_reg32(amd_spi, AMD_SPI_SPEED_REG, spd7, AMD_SPI_SPD7_MASK);
+
+	if (use_spi100_eng)
+		amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG,
+				       AMD_SPI_SPI100_MASK < AMD_SPI_SPI100_SHIFT,
+				       AMD_SPI_SPI100_MASK);
+
+	return 0;
+}
+
 static int amd_spi_master_setup(struct spi_device *spi)
 {
 	struct amd_spi *amd_spi = spi_master_get_devdata(spi->master);
 
 	amd_spi_clear_fifo_ptr(amd_spi);
+	if (speed_dev)
+		amd_set_spi_freq(amd_spi, spi->max_speed_hz);
 
 	return 0;
 }
@@ -322,6 +411,17 @@ static int amd_spi_transfer_one_message(struct spi_controller *ctrl, struct spi_
 	return ret;
 }
 
+static int amd_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *msg)
+{
+	struct amd_spi *amd_spi = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = msg->spi;
+
+	if (speed_dev)
+		amd_set_spi_freq(amd_spi, spi->max_speed_hz);
+
+	return 0;
+}
+
 static size_t amd_spi_max_transfer_size(struct spi_device *spi)
 {
 	return AMD_SPI_FIFO_SIZE;
@@ -360,10 +460,13 @@ static int amd_spi_probe(struct platform_device *pdev)
 	master->bus_num = 0;
 	master->num_chipselect = 4;
 	master->mode_bits = 0;
+	master->max_speed_hz = AMD_SPI_MAX_HZ;
+	master->min_speed_hz = AMD_SPI_MIN_HZ;
 	master->flags = SPI_CONTROLLER_HALF_DUPLEX | SPI_CONTROLLER_NO_TX_RX_CS;
 	master->setup = amd_spi_master_setup;
 	master->max_transfer_size = amd_spi_max_transfer_size;
 	master->max_message_size = amd_spi_max_transfer_size;
+	master->prepare_message = amd_spi_prepare_message;
 	master->transfer_one_message = amd_spi_transfer_one_message;
 
 	INIT_LIST_HEAD(&amd_spi->rbuf_head);
-- 
2.33.0

