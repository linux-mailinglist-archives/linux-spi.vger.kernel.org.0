Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3275E1154C0
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFQA1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 11:00:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41765 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFQA1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 11:00:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so8324842wrw.8
        for <linux-spi@vger.kernel.org>; Fri, 06 Dec 2019 08:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nG0AIEWyaDpD7iKL2b1aqMfl0IExioq+VFWLz9xErA=;
        b=lwicLnoBDRfFvepqChk+TjAYyRImgAnqWPlXZ7NbSsIqmxD+nG/T58pnFw8TfxVhWD
         dfDg9/rmlVzPF/y18cZ+HwgsPJKNicoHQxckMPLLrselZUo9gWa6vuPhPHuCm5c6+Pow
         2D6ZAsITrsEjaZEH/hpOQI2OR0Nft2FqPNpQ3GQD8MFxduegzIWvt9P2o2M6p/45GJGH
         lkvgDnW9XVu+4PaBIBCN8IeTUICDCKBwa77MBjvkFa9sfUBIVnNBRxGNWRoGvmnYEYGF
         7gXu+gPOyTnTSK7GEdsIRY5OrJW0S2r+2qFbto+3ZlyuYAohBXlkC0OUNbt9AU0cdWDN
         OiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nG0AIEWyaDpD7iKL2b1aqMfl0IExioq+VFWLz9xErA=;
        b=D/XF0nhmLaNF8LEYr8W9AQLnnmEFOw6RmNBVkByOyrY9GBoV15yYXP3WDgf3E42ilX
         fmjUzoYFEl6zQhry3Ea7G0mNV9h0jmEHxL5elvkkutiqOYivCxMZxpY3eNpnPVL8NHU+
         LdrjBHv8Q21BIhEoO7cvleJYdO/O3GXy6w29rRq97GD6KqYiUHvBvHxJDJXZc2DgJn1Y
         VCSQeZGblhQ/EB23gw+1oKapKfPx/wcvh4qRYZsQ/ikVYi1kP0OXApusuKd3YtHXSWf+
         QPQX44Cei53npuPhQL45yXL/2RMwKQsl7XklpCEqpw5cyda1MBmtjEnlqOFazZp0gyuo
         PSoQ==
X-Gm-Message-State: APjAAAVt/wAp6MQcOOGsazxS5FJHLbv3RQPfz++Bt1Z2oAFtKxioxPQH
        0L6J/nASHmpfb+xcw8B5xqhkwg==
X-Google-Smtp-Source: APXvYqyXPyic6axNQaYXJiIt6c3rWgU55m6Iq2cyOkgc9/732vTB71+WfvXx6DseFGfgpXBaCmswtg==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr16768309wrm.131.1575648025066;
        Fri, 06 Dec 2019 08:00:25 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id d19sm3891496wmd.38.2019.12.06.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:00:24 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/3] TI QSPI: support large flash devices
Date:   Fri,  6 Dec 2019 17:00:06 +0100
Message-Id: <20191206160007.331801-3-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206160007.331801-1-jean.pihet@newoldbits.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
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
---
 drivers/spi/spi-ti-qspi.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 4680dad38ab2..13916232a959 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -524,6 +524,33 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
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
+			max_len = QSPI_FRAME * op->data.buswidth;
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
@@ -574,6 +601,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 
 static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.exec_op = ti_qspi_exec_mem_op,
+	.adjust_op_size = ti_qspi_adjust_op_size,
 };
 
 static int ti_qspi_start_transfer_one(struct spi_master *master,
@@ -599,12 +627,11 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	frame_len_words = 0;
 	list_for_each_entry(t, &m->transfers, transfer_list)
 		frame_len_words += t->len / (t->bits_per_word >> 3);
-	frame_len_words = min_t(unsigned int, frame_len_words, QSPI_FRAME);
 
 	/* setup command reg */
 	qspi->cmd = 0;
 	qspi->cmd |= QSPI_EN_CS(spi->chip_select);
-	qspi->cmd |= QSPI_FLEN(frame_len_words);
+	qspi->cmd |= QSPI_FLEN(QSPI_FRAME);
 
 	ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
 
-- 
2.23.0

