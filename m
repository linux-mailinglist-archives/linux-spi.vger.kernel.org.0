Return-Path: <linux-spi+bounces-3983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051D93B431
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329ED1C237E8
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C919E15ECE9;
	Wed, 24 Jul 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wfm0VBv3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232215D5B3;
	Wed, 24 Jul 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836096; cv=none; b=EvnUFHD76tXH2EjMpdhN2raxGkXhVI/gqr3lUP+WwPvlhSMmAFbTSkjUEiVYgHB3HJa+rfJy1BJkSD/JL/F6vPn2aouVq9K1FMjI9wbAfxNA9/KANFiqLToYJM+py77XznDXgRERepSbPg8GxmK6jJ2Kh3CvVrD50tyJyEcLSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836096; c=relaxed/simple;
	bh=nHLgWDjIXidKP/4Crg/Jj9QOYUqJgOLkdt5y2gUXFMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnjAOpehRsz72rxTHzg+KFVdT5rek3NfTgfrsmnr2uLCAGkbmC/PAKBRzj6WoMxsfr4ksdp2yNl1MCWvi1Q9zdw9u8jiNoxMPGZhwd7R7GJ6/CHt0ym+CuSxzJANRWcO+yCqQQfYnfeNpqmS04iFlGAXRH7UM0HwQDvOczpnD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wfm0VBv3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OEGNFP001424;
	Wed, 24 Jul 2024 08:47:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	yxp2F5/kRvSWju7iacrVLSXlSGAo8CkW8AqQesJUZE=; b=Wfm0VBv37RsWuPq8i
	mZ00FHtiBzg6gRY0/GQCwUHTNK2hIairXnH4Z8zGRIUXXz8BsEOLP9m4CeykDIaB
	ZVWq7jRxnGV8VuneiEOGz30xhf+Hr0Emy+0MApkCNbpi5vzcTz0ykVqLJtxfnL6n
	Kg6AsKjr2p7+6M8Kn6BBKpoD1ErfFmWK4f9+nz3VEOFOzN1aUUXa41LhhHumFMHI
	UTNhClouAZSq11AyQYSckIHPrpTbokrKjYJxOrs9acGMP4Zf5gqaGYWRp0MAwn7L
	PFfrm1R1JiUbTMU3tLDmrCOTb+rCdNsGyRiWFbiak0hHXgKSxcUfywRK18AHBNmv
	XJFiQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40k0yh1d6c-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 08:47:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Jul 2024 08:47:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 24 Jul 2024 08:47:56 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 907B33F7070;
	Wed, 24 Jul 2024 08:47:55 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v11 4/9] spi: cadence: Add Marvell SDMA operations
Date: Wed, 24 Jul 2024 08:47:34 -0700
Message-ID: <20240724154739.582367-5-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724154739.582367-1-wsadowski@marvell.com>
References: <20240724154739.582367-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0m0sBurziQf922Y9DfbdX9uinljjjLpE
X-Proofpoint-ORIG-GUID: 0m0sBurziQf922Y9DfbdX9uinljjjLpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01

In Marvell xSPI implementation any access to SDMA register will result
in 8 byte SPI data transfer. Reading less data(eg. 1B) will result in
losing remaining bytes. To avoid that read/write 8 bytes into temporary
buffer, and read/write whole temporary buffer into SDMA.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 82 ++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

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


