Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F96311BD2B
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 20:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfLKTkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 14:40:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33047 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLKTkP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Dec 2019 14:40:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so25421935wrq.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2019 11:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tf7mfSQc2XBRyA6iBQyomQJYKh8y7vhPXY0uorTcMM=;
        b=uQ6wD3OKdk7vxkX1YUJRFpvmQlFFK1HQpVfMGmCNrc83oZBzhcoIfmZdGhS9As/G3b
         v4cpUOelehu7V+pQjYeZEj7084Ifsw0eOgV+gR+/9lvXQlWzkIPN2qSid/PBHcqzLDM4
         X5Li9ttNqigmRwNCxQbI7RVEbKaJEhFQ/RZU/hkhhpZULALuyz3x6JCbovNBg1wdZo6l
         bcycDWM08t9++jK03xssoksDOILaXK+/CkZEU6SI/RFqJgV1mQTSga8qj9/06qh5Cm3K
         cltAK/XGcj0tG58/NRwNilcRM61ghwLKGx0gaXRVDYLXSIMss7k5llnvuupxuvcdbu/Z
         BvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tf7mfSQc2XBRyA6iBQyomQJYKh8y7vhPXY0uorTcMM=;
        b=AbP8yzwq2R3gAfHAxQyLN72qIcSB/qH/TkKjLli3kQRnMrC3TaDOW3WFXW8eXfRx94
         F7P+GVVIdy4ca69+6cn2B1374tliRsfOVFq2Z1AVaO+zMNFlIJ09VNpeSySGhgQB5W+x
         pQbKMNU4hdXhx9wdWpVnF0herrvZ2jVTl/GspWhkeh5dMAC1jl2tyrXlBsu658D2y/xA
         7FphgPA9ZCIsonxpUN/r766VBJ/uK2E4r2SfUH++nfjNACcmrZFJzg+egtyljzX3PoNr
         48kfpLeskXF18V+mBEDNwshw4dJ9UjTPHvZco3KmzaLFwLhH1kv5kF+wrFv3NDSTsy/d
         P5rw==
X-Gm-Message-State: APjAAAXDCgBMJY8bO/UPeelunvjyrFqp3iqxOlJ22Ckbzsl4YlfWVtbb
        IA8fSLRr7RDgCO62WwuC4jqg0A==
X-Google-Smtp-Source: APXvYqwTHxnTVeomZ2NSfFHU0dVTZi5uxzaetWzqGEAhbZKAnrZs5h/Xj90zSu6iW5xPTyxwQHjGgw==
X-Received: by 2002:adf:f288:: with SMTP id k8mr1685347wro.301.1576093213862;
        Wed, 11 Dec 2019 11:40:13 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id x1sm3309964wru.50.2019.12.11.11.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 11:40:13 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/3] spi: spi-ti-qspi: support large flash devices
Date:   Wed, 11 Dec 2019 20:39:53 +0100
Message-Id: <20191211193954.747745-3-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211193954.747745-1-jean.pihet@newoldbits.com>
References: <20191211193954.747745-1-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The TI QSPI IP has limitations:
- the MMIO region is 64MB in size
- in non-MMIO mode, the transfer can handle 4096 words max.

Add support for bigger devices.
Use MMIO and DMA transfers below the 64MB boundary, use
software generated transfers above.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Ryan Barnett <ryan.barnett@rockwellcollins.com>
Cc: Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Cc: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
---
 drivers/spi/spi-ti-qspi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index a18835128ad0..aee4709d105e 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -522,6 +522,33 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
 		      QSPI_SPI_SETUP_REG(spi->chip_select));
 }
 
+static int ti_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
+	size_t max_len;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (op->addr.val < qspi->mmap_size) {
+			/* Limit MMIO to the mmaped region */
+			if (op->addr.val + op->data.nbytes > qspi->mmap_size) {
+				max_len = qspi->mmap_size - op->addr.val;
+				op->data.nbytes = min(op->data.nbytes, max_len);
+			}
+		} else {
+			/*
+			 * Use fallback mode (SW generated transfers) above the
+			 * mmaped region.
+			 * Adjust size to comply with the QSPI max frame length.
+			 */
+			max_len = QSPI_FRAME;
+			max_len -= 1 + op->addr.nbytes + op->dummy.nbytes;
+			op->data.nbytes = min(op->data.nbytes, max_len);
+		}
+	}
+
+	return 0;
+}
+
 static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
@@ -572,6 +599,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 
 static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.exec_op = ti_qspi_exec_mem_op,
+	.adjust_op_size = ti_qspi_adjust_op_size,
 };
 
 static int ti_qspi_start_transfer_one(struct spi_master *master,
-- 
2.23.0

