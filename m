Return-Path: <linux-spi+bounces-3100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A98CFBBC
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 10:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44517282353
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2F512AAE2;
	Mon, 27 May 2024 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SBgvrXqO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9969D2F;
	Mon, 27 May 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799349; cv=none; b=a86/cQwOhf0lSBQLaqMkKL6KP3xaWSlEc38/zZLw4t89hgY6T5eJcX9I3W8dtV0mYVKcFb/LOSd1NsbEtfCHuh6fQ77m5Brfzxqw5zGsS+RXIKfkOGQp5imf5m7PSaraV9HIM9BWCrPZR+OfcR2lGMsH7HVlPsb4cBGs65HmBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799349; c=relaxed/simple;
	bh=BmWczAvYIeY9VwvByXvG9gzCDUlCbbCoQ+eCq6ftLcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4O8tLW1x0Uu5kZktkHR25xPDGyHINXMTZvl8t3nql5nDJPagFuGfZdA3jIfwuDPu5t4fY0H0UmTM1RN1i6odwExG/Yk7w0zpAqCzOh3T5zKO3+R5C28MK0FOBVoD4lEoWTAqV8IS0DMGAzw3x3oSZRs06NtdV2F3ofDoCE9i2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SBgvrXqO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44QLvMXX010580;
	Mon, 27 May 2024 01:42:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
	y7USUWFIL48Kqj676CFLy76yOo1qxAqx2O8QrwalVM=; b=SBgvrXqOOU2Vwotkc
	zqjQOb3LSLcGnD6bc3+cLbwHBGc8GZHGysDXLKPty41sbDGoAi1+ay+ttYPoU4o9
	AvqH0pukbL7O5saoHjMiCfHrbK9/myZPphcFE0RUZ5dNPJ65a1Lim/QRHG3VI59g
	gSXLD6KcpGXI6JkeaCP1fr05xRmMCCONgTOXTSkcic8WJ+JRTHlqx40WCePMSgPt
	6I1lnv8J8ZLPVJEnu0+REEWsU6G0VX8HH1T9QeitISnYOA+OKWw5py9WWH+Avc1X
	B94rrS795qhPaymzXW5Ya8fcljaXALP/+uuQnOMoZCVN7Iz/eqzjaPpdNSASDRpw
	ZijtA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ybfgf4kyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 01:42:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 27 May 2024 01:42:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 27 May 2024 01:42:23 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id B5F933F7062;
	Mon, 27 May 2024 01:42:22 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v5 1/5] spi: cadence: Ensure data lines set to low during dummy-cycle period
Date: Mon, 27 May 2024 01:42:12 -0700
Message-ID: <20240527084216.667380-3-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527084216.667380-1-wsadowski@marvell.com>
References: <20240527084216.667380-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SOUbQuSREWclqCE7PVnVQce3nX7NWtbM
X-Proofpoint-GUID: SOUbQuSREWclqCE7PVnVQce3nX7NWtbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

During dummy-cycles xSPI will switch GPIO into Hi-Z mode. In that dummy
period voltage on data lines will slowly drop, what can cause
unintentional modebyte transmission. Value send to SPI memory chip will
depend on last address, and clock frequency.
To prevent unforeseen consequences of that behaviour, force send
single modebyte(0x00).
Modebyte will be send only if number of dummy-cycles is not equal
to 0. Code must also reduce dummycycle byte count by one - as one byte
is send as modebyte.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 8648b8eb080d..cdce2e280f66 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -145,6 +145,9 @@
 #define CDNS_XSPI_STIG_DONE_FLAG		BIT(0)
 #define CDNS_XSPI_TRD_STATUS			0x0104
 
+#define MODE_NO_OF_BYTES			GENMASK(25, 24)
+#define MODEBYTES_COUNT			1
+
 /* Helper macros for filling command registers */
 #define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase) ( \
 	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, (data_phase) ? \
@@ -157,9 +160,10 @@
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR3, ((op)->addr.val >> 24) & 0xFF) | \
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR4, ((op)->addr.val >> 32) & 0xFF))
 
-#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op) ( \
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, modebytes) ( \
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_ADDR5, ((op)->addr.val >> 40) & 0xFF) | \
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_CMD, (op)->cmd.opcode) | \
+	FIELD_PREP(MODE_NO_OF_BYTES, modebytes) | \
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES, (op)->addr.nbytes))
 
 #define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op, chipsel) ( \
@@ -173,12 +177,12 @@
 #define CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op) \
 	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R2_DCNT_L, (op)->data.nbytes & 0xFFFF)
 
-#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op) ( \
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes) ( \
 	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_DCNT_H, \
 		((op)->data.nbytes >> 16) & 0xffff) | \
 	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY, \
 		  (op)->dummy.buswidth != 0 ? \
-		  (((op)->dummy.nbytes * 8) / (op)->dummy.buswidth) : \
+		  (((dummybytes) * 8) / (op)->dummy.buswidth) : \
 		  0))
 
 #define CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op, chipsel) ( \
@@ -351,6 +355,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	u32 cmd_regs[6];
 	u32 cmd_status;
 	int ret;
+	int dummybytes = op->dummy.nbytes;
 
 	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
 	if (ret < 0)
@@ -365,7 +370,12 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	memset(cmd_regs, 0, sizeof(cmd_regs));
 	cmd_regs[1] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase);
 	cmd_regs[2] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op);
-	cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op);
+	if (dummybytes != 0) {
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, 1);
+		dummybytes--;
+	} else {
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, 0);
+	}
 	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op,
 						       cdns_xspi->cur_cs);
 
@@ -375,7 +385,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 		cmd_regs[0] = CDNS_XSPI_STIG_DONE_FLAG;
 		cmd_regs[1] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_1(op);
 		cmd_regs[2] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op);
-		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op);
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes);
 		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op,
 							   cdns_xspi->cur_cs);
 
-- 
2.43.0


