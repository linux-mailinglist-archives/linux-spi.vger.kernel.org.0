Return-Path: <linux-spi+bounces-4088-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA794111D
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4161F21F85
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198181A255C;
	Tue, 30 Jul 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="b9oXAC7n"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C571A08CC;
	Tue, 30 Jul 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339950; cv=none; b=d40zkv501pBZPsjGS0R9Ra7l9zFqJEp1qii0dwMPa822PeBzMA3h43gyk8C2KSXjnUv2hvt4J0+Eqnh4S8kL8ck2jpuxSxQXju7xlJCZ/bbpbwVGg27hKh+XfaIVZUlpg6b7Q3q5zpj4uoI6fV3588lOfvEjY9TelmwyzNn5IB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339950; c=relaxed/simple;
	bh=+CBd5Yv0Z6BZHDT/uyNx5AowtK4CgbW38JaEYo7BJYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U40D5t2P8W0xKhx4ET7KKE7Dnnynl0p7usG5KEinSv/XKoOXwKR5z7txWg2fpQFyEE1C1xbZFZwkZ6Hhk1nvLuSlDxZaBR+ZvJXCmtTrtlZKb6m/JsJj7wqoZEhIWeccjYDEScD6522mlbMBT5P2jqlNCdPnJWosdLFDbQbWCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=b9oXAC7n; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U7ucLS030420;
	Tue, 30 Jul 2024 04:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	bOY+y14kzr9Prem9KrqnpiHaMRv7S2r0rtUWzptA2Q=; b=b9oXAC7npwTT6TqdZ
	Z4fTaOqONBnVh/v9k7wnB2jfObG4flfBZeGgGb0ajJKHV4GDNp5ye4BMuNaQXR+x
	QHAImjc0RLSN1IGJi4tSUyY9nvStZEjuTqqlxX1QhbPDGeFjM1iMk6+h24zNAIfG
	kuEy7BZf63V66EaT8yEsaW0Q53L9HRRgyxA8UrzPZUl8Tf2q6vKyheeEe0uRH5zV
	VYNBrbPHJInQz9jqys3h3yDLbDcc0/3HRJKnjsSbGR5Tux0F9QpjmjNWdF2/94SJ
	etYA7se3fNsn4n7g9IPDdHgp0QmBnI+VSe6dMTKSJQDxVhTLbbcS1kXjxdRH27hY
	7gHtg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40n0dqsk96-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 04:45:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Jul 2024 04:45:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Jul 2024 04:45:39 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 4685C5B692C;
	Tue, 30 Jul 2024 04:45:39 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v12 6/9] spi: cadence: Add Marvell xfer operation support
Date: Tue, 30 Jul 2024 04:45:30 -0700
Message-ID: <20240730114534.1837077-7-wsadowski@marvell.com>
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
X-Proofpoint-GUID: sbm9QKm6n_pRWuQ0dmv-x2ZEs68Zgrww
X-Proofpoint-ORIG-GUID: sbm9QKm6n_pRWuQ0dmv-x2ZEs68Zgrww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

Marvell Xfer overlay extends xSPI capabilities to support non-memory SPI
operations. The Marvell overlay, combined with a generic command, allows
for full-duplex SPI transactions. It also enables transactions with
undetermined lengths using the cs_hold parameter and the ability to
extend CS signal assertion, even if the xSPI block requests CS signal
de-assertion.
Marvell overlay is using part of xSPI for writing data into device, and
additional hardware block to read data from the device. To do that xSPI
will trigger 1 byte generic command followed by data sequence. In same
time overlay block will monitor MISO pin to read data from the device.
Due to that SDMA data start will be shifted by 1 byte.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 272 +++++++++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 84a320186aaf..69c08bae7628 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -19,6 +19,7 @@
 #include <linux/bitfield.h>
 #include <linux/limits.h>
 #include <linux/log2.h>
+#include <linux/bitrev.h>
 
 #define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
 #define CDNS_XSPI_MAX_BANKS		8
@@ -193,6 +194,34 @@
 		((op)->data.dir == SPI_MEM_DATA_IN) ? \
 		CDNS_XSPI_STIG_CMD_DIR_READ : CDNS_XSPI_STIG_CMD_DIR_WRITE))
 
+/* Helper macros for GENERIC and GENERIC-DSEQ instruction type */
+#define CMD_REG_LEN (6*4)
+#define INSTRUCTION_TYPE_GENERIC 96
+#define CDNS_XSPI_CMD_FLD_P1_GENERIC_CMD (\
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, INSTRUCTION_TYPE_GENERIC))
+
+#define GENERIC_NUM_OF_BYTES GENMASK(27, 24)
+#define CDNS_XSPI_CMD_FLD_P3_GENERIC_CMD(len) (\
+	FIELD_PREP(GENERIC_NUM_OF_BYTES, len))
+
+#define GENERIC_BANK_NUM GENMASK(14, 12)
+#define GENERIC_GLUE_CMD BIT(28)
+#define CDNS_XSPI_CMD_FLD_P4_GENERIC_CMD(cs, glue) (\
+	FIELD_PREP(GENERIC_BANK_NUM, cs) | FIELD_PREP(GENERIC_GLUE_CMD, glue))
+
+#define CDNS_XSPI_CMD_FLD_GENERIC_DSEQ_CMD_1 (\
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, CDNS_XSPI_STIG_INSTR_TYPE_DATA_SEQ))
+
+#define CDNS_XSPI_CMD_FLD_GENERIC_DSEQ_CMD_2(nbytes) (\
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R2_DCNT_L, nbytes & 0xffff))
+
+#define CDNS_XSPI_CMD_FLD_GENERIC_DSEQ_CMD_3(nbytes) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_DCNT_H, (nbytes >> 16) & 0xffff))
+
+#define CDNS_XSPI_CMD_FLD_GENERIC_DSEQ_CMD_4(dir, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_BANK, chipsel) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DIR, dir))
+
 /* Marvell PHY default values */
 #define MARVELL_REGS_DLL_PHY_CTRL		0x00000707
 #define MARVELL_CTB_RFILE_PHY_CTRL		0x00004000
@@ -226,6 +255,37 @@
 #define MRVL_XSPI_CLOCK_DIVIDED(div) ((MRVL_XSPI_CLOCK_IO_HZ) / (div))
 #define MRVL_DEFAULT_CLK	     25000000
 
+/* Marvell overlay registers - xfer */
+#define MRVL_XFER_FUNC_CTRL		 0x210
+#define MRVL_XFER_FUNC_CTRL_READ_DATA(i) (0x000 + 8 * (i))
+#define MRVL_XFER_SOFT_RESET		 BIT(11)
+#define MRVL_XFER_CS_N_HOLD		 GENMASK(9, 6)
+#define MRVL_XFER_RECEIVE_ENABLE	 BIT(4)
+#define MRVL_XFER_FUNC_ENABLE		 BIT(3)
+#define MRVL_XFER_CLK_CAPTURE_POL	 BIT(2)
+#define MRVL_XFER_CLK_DRIVE_POL		 BIT(1)
+#define MRVL_XFER_FUNC_START		 BIT(0)
+#define MRVL_XFER_QWORD_COUNT		 32
+#define MRVL_XFER_QWORD_BYTECOUNT	 8
+
+#define MRVL_XSPI_POLL_TIMEOUT_US	1000
+#define MRVL_XSPI_POLL_DELAY_US		10
+
+/* Macros for calculating data bits in generic command
+ * Up to 10 bytes can be fit into cmd_registers
+ * least significant is placed in cmd_reg[1]
+ * Other bits are inserted after it in cmd_reg[1,2,3] register
+ */
+#define GENERIC_CMD_DATA_REG_3_COUNT(len)	(len >= 10 ? 2 : len - 8)
+#define GENERIC_CMD_DATA_REG_2_COUNT(len)	(len >= 7 ? 3 : len - 4)
+#define GENERIC_CMD_DATA_REG_1_COUNT(len)	(len >= 3 ? 2 : len - 1)
+#define GENERIC_CMD_DATA_3_OFFSET(position)	(8*(position))
+#define GENERIC_CMD_DATA_2_OFFSET(position)	(8*(position))
+#define GENERIC_CMD_DATA_1_OFFSET(position)	(8 + 8*(position))
+#define GENERIC_CMD_DATA_INSERT(data, pos)	((data) << (pos))
+#define GENERIC_CMD_REG_3_NEEDED(len)		(len > 7)
+#define GENERIC_CMD_REG_2_NEEDED(len)		(len > 3)
+
 enum cdns_xspi_stig_instr_type {
 	CDNS_XSPI_STIG_INSTR_TYPE_0,
 	CDNS_XSPI_STIG_INSTR_TYPE_1,
@@ -294,6 +354,7 @@ struct cdns_xspi_dev {
 	void __iomem *iobase;
 	void __iomem *auxbase;
 	void __iomem *sdmabase;
+	void __iomem *xferbase;
 
 	int irq;
 	int cur_cs;
@@ -312,6 +373,9 @@ struct cdns_xspi_dev {
 	const struct cdns_xspi_driver_data *driver_data;
 	void (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
 	void (*set_interrupts_handler)(struct cdns_xspi_dev *cdns_xspi, bool enabled);
+
+	bool xfer_in_progress;
+	int current_xfer_qword;
 };
 
 static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
@@ -806,6 +870,204 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
+static int cdns_xspi_prepare_generic(int cs, const void *dout, int len, int glue, u32 *cmd_regs)
+{
+	u8 *data = (u8 *)dout;
+	int i;
+	int data_counter = 0;
+
+	memset(cmd_regs, 0x00, CMD_REG_LEN);
+
+	if (GENERIC_CMD_REG_3_NEEDED(len)) {
+		for (i = GENERIC_CMD_DATA_REG_3_COUNT(len); i >= 0 ; i--)
+			cmd_regs[3] |= GENERIC_CMD_DATA_INSERT(data[data_counter++],
+							       GENERIC_CMD_DATA_3_OFFSET(i));
+	}
+	if (GENERIC_CMD_REG_2_NEEDED(len)) {
+		for (i = GENERIC_CMD_DATA_REG_2_COUNT(len); i >= 0; i--)
+			cmd_regs[2] |= GENERIC_CMD_DATA_INSERT(data[data_counter++],
+							       GENERIC_CMD_DATA_2_OFFSET(i));
+	}
+	for (i = GENERIC_CMD_DATA_REG_1_COUNT(len); i >= 0 ; i--)
+		cmd_regs[1] |= GENERIC_CMD_DATA_INSERT(data[data_counter++],
+						       GENERIC_CMD_DATA_1_OFFSET(i));
+
+	cmd_regs[1] |= CDNS_XSPI_CMD_FLD_P1_GENERIC_CMD;
+	cmd_regs[3] |= CDNS_XSPI_CMD_FLD_P3_GENERIC_CMD(len);
+	cmd_regs[4] |= CDNS_XSPI_CMD_FLD_P4_GENERIC_CMD(cs, glue);
+
+	return 0;
+}
+
+static void marvell_xspi_read_single_qword(struct cdns_xspi_dev *cdns_xspi, u8 **buffer)
+{
+	u64 d = readq(cdns_xspi->xferbase +
+		      MRVL_XFER_FUNC_CTRL_READ_DATA(cdns_xspi->current_xfer_qword));
+	u8 *ptr = (u8 *)&d;
+	int k;
+
+	for (k = 0; k < 8; k++) {
+		u8 val = bitrev8((ptr[k]));
+		**buffer = val;
+		*buffer = *buffer + 1;
+	}
+
+	cdns_xspi->current_xfer_qword++;
+	cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
+}
+
+static void cdns_xspi_finish_read(struct cdns_xspi_dev *cdns_xspi, u8 **buffer, u32 data_count)
+{
+	u64 d = readq(cdns_xspi->xferbase +
+		      MRVL_XFER_FUNC_CTRL_READ_DATA(cdns_xspi->current_xfer_qword));
+	u8 *ptr = (u8 *)&d;
+	int k;
+
+	for (k = 0; k < data_count % MRVL_XFER_QWORD_BYTECOUNT; k++) {
+		u8 val = bitrev8((ptr[k]));
+		**buffer = val;
+		*buffer = *buffer + 1;
+	}
+
+	cdns_xspi->current_xfer_qword++;
+	cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
+}
+
+static int cdns_xspi_prepare_transfer(int cs, int dir, int len, u32 *cmd_regs)
+{
+	memset(cmd_regs, 0x00, CMD_REG_LEN);
+
+	cmd_regs[1] |= CDNS_XSPI_CMD_FLD_GENERIC_DSEQ_CMD_1;
+	cmd_regs[2] |= CDNS_XSPI_CMD_FLD_GENERIC_DSEQ_CMD_2(len);
+	cmd_regs[4] |= CDNS_XSPI_CMD_FLD_GENERIC_DSEQ_CMD_4(dir, cs);
+
+	return 0;
+}
+
+static bool cdns_xspi_is_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
+{
+	u32 ctrl_stat;
+
+	return !readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_CTRL_STATUS_REG,
+		ctrl_stat,
+		((ctrl_stat & BIT(3)) == 0),
+		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
+		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+}
+
+static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
+{
+	u32 ctrl_stat;
+
+	return !readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+		ctrl_stat,
+		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
+		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
+		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+}
+
+static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
+					   struct spi_message *m)
+{
+	struct cdns_xspi_dev *cdns_xspi = spi_controller_get_devdata(controller);
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *t = NULL;
+
+	const unsigned int max_len = MRVL_XFER_QWORD_BYTECOUNT * MRVL_XFER_QWORD_COUNT;
+	int current_transfer_len;
+	int cs = spi_get_chipselect(spi, 0);
+	int cs_change = 0;
+
+	/* Enable xfer state machine */
+	if (!cdns_xspi->xfer_in_progress) {
+		u32 xfer_control = readl(cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
+
+		cdns_xspi->current_xfer_qword = 0;
+		cdns_xspi->xfer_in_progress = true;
+		xfer_control |= (MRVL_XFER_RECEIVE_ENABLE |
+				 MRVL_XFER_CLK_CAPTURE_POL |
+				 MRVL_XFER_FUNC_START |
+				 MRVL_XFER_SOFT_RESET |
+				 FIELD_PREP(MRVL_XFER_CS_N_HOLD, (1 << cs)));
+		xfer_control &= ~(MRVL_XFER_FUNC_ENABLE | MRVL_XFER_CLK_DRIVE_POL);
+		writel(xfer_control, cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
+	}
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		u8 *txd = (u8 *) t->tx_buf;
+		u8 *rxd = (u8 *) t->rx_buf;
+		u8 data[10];
+		u32 cmd_regs[6];
+
+		if (!txd)
+			txd = data;
+
+		cdns_xspi->in_buffer = txd + 1;
+		cdns_xspi->out_buffer = txd + 1;
+
+		while (t->len) {
+
+			current_transfer_len = min(max_len, t->len);
+
+			if (current_transfer_len < 10) {
+				cdns_xspi_prepare_generic(cs, txd, current_transfer_len,
+							  false, cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
+					return -EIO;
+			} else {
+				cdns_xspi_prepare_generic(cs, txd, 1, true, cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				cdns_xspi_prepare_transfer(cs, 1, current_transfer_len - 1,
+							   cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				if (!cdns_xspi_is_sdma_ready(cdns_xspi, true))
+					return -EIO;
+				cdns_xspi->sdma_handler(cdns_xspi);
+				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
+					return -EIO;
+
+				cdns_xspi->in_buffer += current_transfer_len;
+				cdns_xspi->out_buffer += current_transfer_len;
+			}
+
+			if (rxd) {
+				int j;
+
+				for (j = 0; j < current_transfer_len / 8; j++)
+					marvell_xspi_read_single_qword(cdns_xspi, &rxd);
+				cdns_xspi_finish_read(cdns_xspi, &rxd, current_transfer_len);
+			} else {
+				cdns_xspi->current_xfer_qword += current_transfer_len /
+								 MRVL_XFER_QWORD_BYTECOUNT;
+				if (current_transfer_len % MRVL_XFER_QWORD_BYTECOUNT)
+					cdns_xspi->current_xfer_qword++;
+
+				cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
+			}
+			cs_change = t->cs_change;
+			t->len -= current_transfer_len;
+		}
+		spi_transfer_delay_exec(t);
+	}
+
+	if (!cs_change) {
+		u32 xfer_control = readl(cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
+
+		xfer_control &= ~(MRVL_XFER_RECEIVE_ENABLE |
+				  MRVL_XFER_SOFT_RESET);
+		writel(xfer_control, cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
+		cdns_xspi->xfer_in_progress = false;
+	}
+
+	m->status = 0;
+	spi_finalize_current_message(controller);
+
+	return 0;
+}
+
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -829,6 +1091,7 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		host->mem_ops = &marvell_xspi_mem_ops;
+		host->transfer_one_message = cdns_xspi_transfer_one_message_b0;
 		cdns_xspi->sdma_handler = &marvell_xspi_sdma_handle;
 		cdns_xspi->set_interrupts_handler = &marvell_xspi_set_interrupts;
 	} else {
@@ -871,6 +1134,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_xspi->auxbase);
 	}
 
+	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
+		cdns_xspi->xferbase = devm_platform_ioremap_resource_byname(pdev, "xfer");
+		if (IS_ERR(cdns_xspi->xferbase)) {
+			dev_info(dev, "XFER register base not found, set it\n");
+			// For compatibility with older firmware
+			cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
+		}
+	}
+
 	cdns_xspi->irq = platform_get_irq(pdev, 0);
 	if (cdns_xspi->irq < 0)
 		return -ENXIO;
-- 
2.43.0


