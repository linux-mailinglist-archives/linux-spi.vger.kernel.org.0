Return-Path: <linux-spi+bounces-6973-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2947A49183
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2025 07:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862FF16DBDC
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2025 06:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A11C54A7;
	Fri, 28 Feb 2025 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gl9N/KeB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E461BE87B;
	Fri, 28 Feb 2025 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723788; cv=none; b=USmsDTlpIsZ8aHsARZv+pEACvnoSTb5H225jsLQCoQ/3xiU3NfCEY9RBfiB4qxboWBNcmZicnTQmFmd6PBxaI6E1ZC6YCO5PCV4nGmpbaoFTHHyyC6jWJqagvSj2Y+zR0RBZ7J/Rk2q6BZp4XgBtsny3S7HQCccNrrrMVKHITZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723788; c=relaxed/simple;
	bh=9v666/dwEW35XOonDYfSAMRqNdcF/kzGSuqjPi/WTkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rcnmK/WLpEbMKhoNB7ixbCP4qaMDImdTHv7mxBjj87nLMSqfKNHASlnOkJXpJqE5T+UQRrMf3chcAMpiOz6+ASJHdzz6R4qYGoFBhaSiJwfgSXTVre85+ohRo70f/ubCrDlSnv3gSliIHAlkUjyqilC5lb/e2MEAtBmKX82r88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gl9N/KeB; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6f4304e8f59c11efaae1fd9735fae912-20250228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EGtjHx6cqk/IoEviwQ3UR0x/lfXLIpLJhQtpRCQRULs=;
	b=gl9N/KeBxaUb9OkchgOL2MQhNfo0m4u8fyFi5FV4zkxLgbKZue3HT4e/zWEmdevmbw44QqdK+ux4OCOZam6Hzg14Jgib8MuAEJPkS5TJkkl9yhFTiIFDvofHyKMOgs1HL2/H953aZqM7W337Q5ymC+eKBehewhiJGxhQeLnMuQY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:06033555-2f06-453d-b5eb-60706902bf01,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:aef7adb5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6f4304e8f59c11efaae1fd9735fae912-20250228
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <leilk.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1264475581; Fri, 28 Feb 2025 14:22:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 28 Feb 2025 14:22:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 28 Feb 2025 14:22:48 +0800
From: Leilk Liu <leilk.liu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, Leilk Liu
	<leilk.liu@mediatek.com>
Subject: [PATCH v1] spi: mt65xx: add PM QoS support
Date: Fri, 28 Feb 2025 14:22:03 +0800
Message-ID: <20250228062246.24186-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Enable Quality of Service(QoS) support to speed up interrupt service
routine handle. Sometimes, a gic interrupt will be generated after
SPI transmission, but at this time the CPU is in an idle state and the
processing handler will be ver slow. It takes time to exit the idle state
and then become active. This will cause the SPI handler to execute slowly
and cause SPI transfer timeouts.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 197bf2dbe5de..2ab65f858a21 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_qos.h>
 
 #define SPI_CFG0_REG			0x0000
 #define SPI_CFG1_REG			0x0004
@@ -166,6 +167,7 @@ struct mtk_spi {
 	struct scatterlist *tx_sgl, *rx_sgl;
 	u32 tx_sgl_len, rx_sgl_len;
 	const struct mtk_spi_compatible *dev_comp;
+	struct pm_qos_request qos_request;
 	u32 spi_clk_hz;
 	struct completion spimem_done;
 	bool use_spimem;
@@ -356,6 +358,7 @@ static int mtk_spi_hw_init(struct spi_controller *host,
 	struct mtk_chip_config *chip_config = spi->controller_data;
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
+	cpu_latency_qos_update_request(&mdata->qos_request, 500);
 	cpha = spi->mode & SPI_CPHA ? 1 : 0;
 	cpol = spi->mode & SPI_CPOL ? 1 : 0;
 
@@ -459,6 +462,15 @@ static int mtk_spi_prepare_message(struct spi_controller *host,
 	return mtk_spi_hw_init(host, msg->spi);
 }
 
+static int mtk_spi_unprepare_message(struct spi_controller *host,
+				     struct spi_message *message)
+{
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
+
+	cpu_latency_qos_update_request(&mdata->qos_request, PM_QOS_DEFAULT_VALUE);
+	return 0;
+}
+
 static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 reg_val;
@@ -1143,6 +1155,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	host->set_cs = mtk_spi_set_cs;
 	host->prepare_message = mtk_spi_prepare_message;
+	host->unprepare_message = mtk_spi_unprepare_message;
 	host->transfer_one = mtk_spi_transfer_one;
 	host->can_dma = mtk_spi_can_dma;
 	host->setup = mtk_spi_setup;
@@ -1249,6 +1262,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		clk_disable_unprepare(mdata->spi_hclk);
 	}
 
+	cpu_latency_qos_add_request(&mdata->qos_request, PM_QOS_DEFAULT_VALUE);
+
 	if (mdata->dev_comp->need_pad_sel) {
 		if (mdata->pad_num != host->num_chipselect)
 			return dev_err_probe(dev, -EINVAL,
@@ -1292,6 +1307,7 @@ static void mtk_spi_remove(struct platform_device *pdev)
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 	int ret;
 
+	cpu_latency_qos_remove_request(&mdata->qos_request);
 	if (mdata->use_spimem && !completion_done(&mdata->spimem_done))
 		complete(&mdata->spimem_done);
 
-- 
2.46.0


