Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC72364159
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbhDSMQj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 08:16:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40478 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239056AbhDSMQe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Apr 2021 08:16:34 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JCChb7029242;
        Mon, 19 Apr 2021 14:15:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=7SdEfemEgXpMUy0WM2zaZTJbps/vEuTda/G6kyNczgM=;
 b=GHfC8sWTPB0wZ1CO+gLyK0HD0IXGG+z91vTFaoVW++YydctUq77gmEDZXpTZkBzvqqJP
 lg/UPLwY9FBCOpQAF/yCi1gRX+Te+l88VcxpIHm76pExFs0itzLAENp1nKIbO4eHFHYu
 TRjAwjmsOFdp1K/hYKVq2H8xUl2CGGrQSzrqDtXmNK56OofMX5b3T9q1sVpvblho9kGR
 S/MQvZlswbUvcy296u9LlaHItLF18FU7lDSTH0uZGhhCd/2n8hsAQ65VvC+ci3eBA3G9
 dRGVf1vRDhCdvpi/1O3AhB43UUqzuHEcrZwCILz94UplE2z2kTGYrgcD0maqkFQOKF2+ kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 380s5344gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 14:15:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8965510002A;
        Mon, 19 Apr 2021 14:15:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D6392139BC;
        Mon, 19 Apr 2021 14:15:45 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 14:15:45
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 3/3] spi: stm32-qspi: Add dirmap support
Date:   Mon, 19 Apr 2021 14:15:41 +0200
Message-ID: <20210419121541.11617-4-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419121541.11617-1-patrice.chotard@foss.st.com>
References: <20210419121541.11617-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-16,2021-04-19 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add stm32_qspi_dirmap_read() and stm32_qspi_dirmap_create()
to get dirmap support.

Update the exec_op callback which doens't allow anymore memory map
access. Memory map access are only available through the dirmap_read
callback.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 83 +++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 6e74d6bed54c..e2a99f054551 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -331,7 +331,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
 	struct stm32_qspi_flash *flash = &qspi->flash[mem->spi->chip_select];
-	u32 ccr, cr, addr_max;
+	u32 ccr, cr;
 	int timeout, err = 0;
 
 	dev_dbg(qspi->dev, "cmd:%#x mode:%d.%d.%d.%d addr:%#llx len:%#x\n",
@@ -343,18 +343,6 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (err)
 		goto abort;
 
-	addr_max = op->addr.val + op->data.nbytes + 1;
-
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		if (addr_max < qspi->mm_size &&
-		    op->addr.buswidth)
-			qspi->fmode = CCR_FMODE_MM;
-		else
-			qspi->fmode = CCR_FMODE_INDR;
-	} else {
-		qspi->fmode = CCR_FMODE_INDW;
-	}
-
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 	cr &= ~CR_PRESC_MASK & ~CR_FSEL;
 	cr |= FIELD_PREP(CR_PRESC_MASK, flash->presc);
@@ -364,8 +352,6 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (op->data.nbytes)
 		writel_relaxed(op->data.nbytes - 1,
 			       qspi->io_base + QSPI_DLR);
-	else
-		qspi->fmode = CCR_FMODE_INDW;
 
 	ccr = qspi->fmode;
 	ccr |= FIELD_PREP(CCR_INST_MASK, op->cmd.opcode);
@@ -441,6 +427,11 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	}
 
 	mutex_lock(&qspi->lock);
+	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
+		qspi->fmode = CCR_FMODE_INDR;
+	else
+		qspi->fmode = CCR_FMODE_INDW;
+
 	ret = stm32_qspi_send(mem, op);
 	mutex_unlock(&qspi->lock);
 
@@ -450,6 +441,64 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return ret;
 }
 
+static int stm32_qspi_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct stm32_qspi *qspi = spi_controller_get_devdata(desc->mem->spi->master);
+
+	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+		return -EOPNOTSUPP;
+
+	/* should never happen, as mm_base == null is an error probe exit condition */
+	if (!qspi->mm_base && desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
+
+	if (!qspi->mm_size)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				      u64 offs, size_t len, void *buf)
+{
+	struct stm32_qspi *qspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct spi_mem_op op;
+	u32 addr_max;
+	int ret;
+
+	ret = pm_runtime_get_sync(qspi->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(qspi->dev);
+		return ret;
+	}
+
+	mutex_lock(&qspi->lock);
+	/* make a local copy of desc op_tmpl and complete dirmap rdesc
+	 * spi_mem_op template with offs, len and *buf in  order to get
+	 * all needed transfer information into struct spi_mem_op
+	 */
+	memcpy(&op, &desc->info.op_tmpl, sizeof(struct spi_mem_op));
+	dev_dbg(qspi->dev, "%s len = 0x%x offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
+
+	op.data.nbytes = len;
+	op.addr.val = desc->info.offset + offs;
+	op.data.buf.in = buf;
+
+	addr_max = op.addr.val + op.data.nbytes + 1;
+	if (addr_max < qspi->mm_size && op.addr.buswidth)
+		qspi->fmode = CCR_FMODE_MM;
+	else
+		qspi->fmode = CCR_FMODE_INDR;
+
+	ret = stm32_qspi_send(desc->mem, &op);
+	mutex_unlock(&qspi->lock);
+
+	pm_runtime_mark_last_busy(qspi->dev);
+	pm_runtime_put_autosuspend(qspi->dev);
+
+	return ret ?: len;
+}
+
 static int stm32_qspi_setup(struct spi_device *spi)
 {
 	struct spi_controller *ctrl = spi->master;
@@ -555,7 +604,9 @@ static void stm32_qspi_dma_free(struct stm32_qspi *qspi)
  * to check supported mode.
  */
 static const struct spi_controller_mem_ops stm32_qspi_mem_ops = {
-	.exec_op = stm32_qspi_exec_op,
+	.exec_op	= stm32_qspi_exec_op,
+	.dirmap_create	= stm32_qspi_dirmap_create,
+	.dirmap_read	= stm32_qspi_dirmap_read,
 };
 
 static int stm32_qspi_probe(struct platform_device *pdev)
-- 
2.17.1

