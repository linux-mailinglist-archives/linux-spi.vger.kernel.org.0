Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822F013A986
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgANMln (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 07:41:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33941 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgANMln (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 07:41:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so12039867wrr.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Jan 2020 04:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pEa4178Nhc6GAYjGzu95rHH0vJo43KEdBZ4GRcOPeuc=;
        b=ZUOk1W2DbG3aejm9qsIWCm6mPgJtoDvxDUdOww6Mq62e3mrr+pJ54NC9MQmz3XwsS1
         x/vdyETC/dn3Bf5upRriG12WgW+Un9/jP0hALQU1D3r/XMmLMMYI7RKyjwOArnGLj3aq
         PQKbkGt/McXMZp9UPMT45arE9Z4NHtKm7k1lexgrntwBTsLkoNYnpTZzA6lDvUbHvlpq
         rM929+uUxR8rWRYU0DuaJaQx+Q7eN2yBTN3cAGwkdA9bdADobYTOYZ6P+AY1fnt+98Cf
         Kf1e3q2QHsGpTGI8J3Cty7F9H3PqgsOO73LZY/M57t//VZZYdXGcBblkgNqShH4fAUDL
         l+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pEa4178Nhc6GAYjGzu95rHH0vJo43KEdBZ4GRcOPeuc=;
        b=fR3sSGwIeCXi2C0e5k+2+0n1lvhouhdGKkNLWjVRfCaVdEW2fS7y1RLJk83PZjQ/XB
         ct8qofXD0ddXQ14qKBmqE+eRLUssp8vrxkiPZEhmUqw/3jH1PZKAxwQMaAEA1Wzad+8/
         zzk0lfuuv4MfgAQ8z0jq5NFCAONvwPd8TsLa+lXl9EhiAFN0bqwHjZE2EKvWiEFvZbir
         RgtLu3fESsfKMOOte37Y2G8iqXd+ScO6sX16Z3wTvk/OzQVSzCG33uHM0/L71Txt2ZG/
         1/1OFebjl9/XbH4umXy8Jp3ouYFNx8TM4enHQPT3rLg9gjXPZjE1aAS3oo4l+TE/FPA4
         l7Zg==
X-Gm-Message-State: APjAAAUW3nGBkdDbqQl4V20HaDQgr1wbNeEYCXV35fMAUImEI7+0gTi+
        V4c0GXt/arcPsrJV2yYAlQhTPg==
X-Google-Smtp-Source: APXvYqzkntDcQtAd1BxT8+cRFMOwZf+WAh9KLRXPzCb+fnAJjUF0BFTZjP9SGjinvASsCW8gFJq3CQ==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr24860614wrn.270.1579005701521;
        Tue, 14 Jan 2020 04:41:41 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id i5sm18260185wml.31.2020.01.14.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 04:41:40 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/2] spi: spi-ti-qspi: support large flash devices
Date:   Tue, 14 Jan 2020 13:41:24 +0100
Message-Id: <20200114124125.361429-2-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114124125.361429-1-jean.pihet@newoldbits.com>
References: <20200114124125.361429-1-jean.pihet@newoldbits.com>
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
 drivers/spi/spi-ti-qspi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ad2942b3d0a9..0334e2926998 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -525,6 +525,35 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
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
+				op->data.nbytes = min((size_t) op->data.nbytes,
+						      max_len);
+			}
+		} else {
+			/*
+			 * Use fallback mode (SW generated transfers) above the
+			 * mmaped region.
+			 * Adjust size to comply with the QSPI max frame length.
+			 */
+			max_len = QSPI_FRAME;
+			max_len -= 1 + op->addr.nbytes + op->dummy.nbytes;
+			op->data.nbytes = min((size_t) op->data.nbytes,
+					      max_len);
+		}
+	}
+
+	return 0;
+}
+
 static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
@@ -575,6 +604,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 
 static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.exec_op = ti_qspi_exec_mem_op,
+	.adjust_op_size = ti_qspi_adjust_op_size,
 };
 
 static int ti_qspi_start_transfer_one(struct spi_master *master,
-- 
2.24.1

