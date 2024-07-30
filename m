Return-Path: <linux-spi+bounces-4085-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633BC941115
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198D4285DD0
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA701A08DF;
	Tue, 30 Jul 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DrZqYQrn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A31A073C;
	Tue, 30 Jul 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339948; cv=none; b=seijcx6IxRsF/g0zeMjG2eIwqOc47r2tLQVOtSTWZdJ1GKyRNV5SqxGReY1Rto3KnJzjBkbktTBZd4O8Ijj1sALLpWh7urBliftbRmGR56a9/ptHr9OIRrQvtc/sclQl56lFNqFU5ts3OHoAqj+rbOPFdZX6erbFhL2KN5qU4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339948; c=relaxed/simple;
	bh=KUHep6kCYz5kB8u8z0ZTk9Arr+EnKoLpM9Lfp9GeQY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLLzLizxulRXfN1bJj9QD97SXwC0+xdVtu3VYQfGQO1DxBLi0bintLcWSbE6b1W9Xcbw2C1JRj+dk2c4CEK7maDX4BnCnqMvcVKrvqdpfUzYAP7QoAkjlOQV91HyYvgHHhDcU8qNh/FIeeu3Py77v3Zpc5adFmrTINfjWM+Kyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DrZqYQrn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U7ucLQ030420;
	Tue, 30 Jul 2024 04:45:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
	MDpAfdFEULhG9CVf4SuuzvYwgATaQGckY1hyeSwlH4=; b=DrZqYQrn8lIahr2GF
	TCKAzGx8dJUjiUjj0dHB7fuHihvzRRiYLNWA6yby5wJRyjmai/brhfez7nd7uhrE
	PWa4xG9DTzQryMfAA4Iu1BVPlcDegbocPZvbsnCC+/hoX4yI5yDgDFS5KFIRo33V
	Nh5Yg/3HpYyqfcq61HJ318nhYOgLKdNJImx2w7BYgIm1D+k6sVsQ0vEJrgT7imTr
	fwXHrI8i3mOHSxsvyNmAZo4+StWNpFiiwiiW3eR5Rqz3gIawogDdArl1QU4WkL7A
	T6xj3IW7fqXX55opNLvorGFfRKGpqkJw/p1Trq9h92sCsXI597jYi9Pt03zLkJFD
	SMdpg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40n0dqsk96-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 04:45:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Jul 2024 04:45:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Jul 2024 04:45:39 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 9CA105B692C;
	Tue, 30 Jul 2024 04:45:38 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v12 4/9] spi: cadence: Add Marvell SDMA operations
Date: Tue, 30 Jul 2024 04:45:28 -0700
Message-ID: <20240730114534.1837077-5-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730114534.1837077-1-wsadowski@marvell.com>
References: <20240730114534.1837077-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: v-uxyUg7Xm-q64bsJmVlxQwZXsq86pCy
X-Proofpoint-ORIG-GUID: v-uxyUg7Xm-q64bsJmVlxQwZXsq86pCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

In Marvell xSPI implementation any access to SDMA register will result
in 8 byte SPI data transfer. Reading less data(eg. 1B) will result in
losing remaining bytes. To avoid that read/write 8 bytes into temporary
buffer, and read/write whole temporary buffer into SDMA.
Due to adding 64 bit operations support driver will be limited to 64 bit
system.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/Kconfig            |  2 +-
 drivers/spi/spi-cadence-xspi.c | 82 ++++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a2c99ff33e0a..d7b5c9b5c676 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -267,7 +267,7 @@ config SPI_CADENCE_QUADSPI
 
 config SPI_CADENCE_XSPI
 	tristate "Cadence XSPI controller"
-	depends on OF && HAS_IOMEM
+	depends on OF && HAS_IOMEM && 64BIT
 	depends on SPI_MEM
 	help
 	  Enable support for the Cadence XSPI Flash controller.
diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index d0222284c507..c177bf4ba536 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -310,6 +310,7 @@ struct cdns_xspi_dev {
 	u8 hw_num_banks;
 
 	const struct cdns_xspi_driver_data *driver_data;
+	void (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
 };
 
 static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
@@ -515,6 +516,78 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 	}
 }
 
+static void m_ioreadq(void __iomem  *addr, void *buf, int len)
+{
+	if (IS_ALIGNED((long)buf, 8) && len >= 8) {
+		u64 full_ops = len / 8;
+		u64 *buffer = buf;
+
+		len -= full_ops * 8;
+		buf += full_ops * 8;
+
+		do {
+			u64 b = readq(addr);
+			*buffer++ = b;
+		} while (--full_ops);
+	}
+
+
+	while (len) {
+		u64 tmp_buf;
+
+		tmp_buf = readq(addr);
+		memcpy(buf, &tmp_buf, min(len, 8));
+		len = len > 8 ? len - 8 : 0;
+		buf += 8;
+	}
+}
+
+static void m_iowriteq(void __iomem *addr, const void *buf, int len)
+{
+	if (IS_ALIGNED((long)buf, 8) && len >= 8) {
+		u64 full_ops = len / 8;
+		const u64 *buffer = buf;
+
+		len -= full_ops * 8;
+		buf += full_ops * 8;
+
+		do {
+			writeq(*buffer++, addr);
+		} while (--full_ops);
+	}
+
+	while (len) {
+		u64 tmp_buf;
+
+		memcpy(&tmp_buf, buf, min(len, 8));
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
@@ -566,7 +639,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 			cdns_xspi_set_interrupts(cdns_xspi, false);
 			return -EIO;
 		}
-		cdns_xspi_sdma_handle(cdns_xspi);
+		cdns_xspi->sdma_handler(cdns_xspi);
 	}
 
 	wait_for_completion(&cdns_xspi->cmd_complete);
@@ -736,10 +809,13 @@ static int cdns_xspi_probe(struct platform_device *pdev)
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


