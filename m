Return-Path: <linux-spi+bounces-3481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E8190F017
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54E01F2718C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6663CF51;
	Wed, 19 Jun 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K/KG7ysU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE182E832;
	Wed, 19 Jun 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806655; cv=none; b=ejqkTiElknV9H6YA1h98kMXvKdtuDoQMpW5uJWvagqj/B/aPjVbfpa3xRQkFvSAUvoJ3wXNnMvENWDhGdXRRSPu5GJs5nyAvpk0+HZvw1U7EFWY0weTFETFuV2PHXDPCIH7YgYk0GfVY7+nkJUiguNQRwv2zbRpclRK5DcVL4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806655; c=relaxed/simple;
	bh=2wAJYUkiHXSwJonlq1BbCPMpJf9fP5eXwCBLL5PUsJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7xaGzSyVwlDYw4Tc6L/IqCYvdwrF9GaW8vaG0D5hEvDoaKbmwY+yM9poN/qRQ1nKP3bjUPeIZrICfuidhkfri/YrKeH12+Fy4trTGAjFcHBsglaXCPOZ/5fnim1XhgDKPVu4PPGsQTxLy55kmSCs208jCsXMeYAUoBq4JB10HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K/KG7ysU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7Rs99022901;
	Wed, 19 Jun 2024 07:17:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	P3Gt9mfC+pnmtUDgEue7Z/UeXUNBQdZgZxA/27xWj0=; b=K/KG7ysUtVV47T/u4
	oAmqVzTlmq2SDPmrrV6jytyDW5ISoS5KxptOAMj+7RFRPvN2hjc2W4S9UZ6HqDa5
	wuc+24zDA/b7lhLno6OjCWKGIR9pu4I4GWHC86tT7hxPmbJNEqQIdwWtKjTyW5dx
	+kF2Itx6rdnMvadUVPHYbgLbp/CI5aI6L1ZKouMKy8Y7XCsncZkGjtPdrdzANmxx
	ki1kZL0QAOlLIsu5x5nq4rRDbGlp8+A3bhahTEkMQJyZQJQtzBGMz4p1exafUiyE
	3vnJea2ryYWV4l5uw9YjdHHt8UR9rYLCGznN3vOBh1KgkbJU8mR6mwaQ/46RKCYP
	4Wmpg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yutyc1602-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 07:17:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:21 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 36BF13F7088;
	Wed, 19 Jun 2024 07:17:21 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v9 4/9] spi: cadence: Add Marvell SDMA operations
Date: Wed, 19 Jun 2024 07:17:10 -0700
Message-ID: <20240619141716.1785467-5-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619141716.1785467-1-wsadowski@marvell.com>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QktV02qZhROh0bVUDfUaMeVCdBvoVBI5
X-Proofpoint-GUID: QktV02qZhROh0bVUDfUaMeVCdBvoVBI5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

In Marvell xSPI implementation any access to SDMA register will result
in 8 byte SPI data transfer. Reading less data(eg. 1B) will result in
losing remaining bytes. To avoid that read/write 8 bytes into temporary
buffer, and read/write whole temporary buffer into SDMA.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 56 ++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index d0222284c507..c79f2a2931a8 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -310,6 +310,7 @@ struct cdns_xspi_dev {
 	u8 hw_num_banks;
 
 	const struct cdns_xspi_driver_data *driver_data;
+	void (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
 };
 
 static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
@@ -515,6 +516,52 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 	}
 }
 
+static void m_ioreadq(void __iomem  *addr, void *buf, int len)
+{
+	u64 tmp_buf;
+
+	while (len) {
+		tmp_buf = readq(addr);
+		memcpy(buf, &tmp_buf, len > 8 ? 8 : len);
+		len = len > 8 ? len - 8 : 0;
+		buf += 8;
+	}
+}
+
+static void m_iowriteq(void __iomem *addr, const void *buf, int len)
+{
+	u64 tmp_buf;
+
+	while (len) {
+		memcpy(&tmp_buf, buf, len > 8 ? 8 : len);
+		writeq(tmp_buf, addr);
+		len = len > 8 ? len - 8 : 0;
+		buf += 8;
+	}
+}
+
+static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 sdma_size, sdma_trd_info;
+	u8 sdma_dir;
+
+	sdma_size = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_SIZE_REG);
+	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
+	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
+
+	switch (sdma_dir) {
+	case CDNS_XSPI_SDMA_DIR_READ:
+		m_ioreadq(cdns_xspi->sdmabase,
+			    cdns_xspi->in_buffer, sdma_size);
+		break;
+
+	case CDNS_XSPI_SDMA_DIR_WRITE:
+		m_iowriteq(cdns_xspi->sdmabase,
+			     cdns_xspi->out_buffer, sdma_size);
+		break;
+	}
+}
+
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 				       const struct spi_mem_op *op,
 				       bool data_phase)
@@ -566,7 +613,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 			cdns_xspi_set_interrupts(cdns_xspi, false);
 			return -EIO;
 		}
-		cdns_xspi_sdma_handle(cdns_xspi);
+		cdns_xspi->sdma_handler(cdns_xspi);
 	}
 
 	wait_for_completion(&cdns_xspi->cmd_complete);
@@ -736,10 +783,13 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (!cdns_xspi->driver_data)
 		return -ENODEV;
 
-	if (cdns_xspi->driver_data->mrvl_hw_overlay)
+	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		host->mem_ops = &marvell_xspi_mem_ops;
-	else
+		cdns_xspi->sdma_handler = &marvell_xspi_sdma_handle;
+	} else {
 		host->mem_ops = &cadence_xspi_mem_ops;
+		cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
+	}
 	host->dev.of_node = pdev->dev.of_node;
 	host->bus_num = -1;
 
-- 
2.43.0


