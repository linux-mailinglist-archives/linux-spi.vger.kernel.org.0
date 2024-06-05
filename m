Return-Path: <linux-spi+bounces-3241-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6D8FCDDA
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 14:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A11CB2BD9B
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 12:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321DC1CD44E;
	Wed,  5 Jun 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biwUV3T1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BF1CD448;
	Wed,  5 Jun 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589115; cv=none; b=NsGhoFj3rwN4cnNnP+3Q/uMEbaHU0lWgePnGwhICfR+v8j0jhKdCDIWZJttRpPWI+ccQ0HOo7BtQrSTJou1/arGaGr27PQt8nOWijTK1p3S8LhxHVUAiF5/33wQAMjSyCY0Nm7u8PxRfCv2iN6zBtZZOKBSHxF0tUISgvpF8K+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589115; c=relaxed/simple;
	bh=Pvlv1exqFURZ7yFfeNaFPWfN/fe30G0y1zsVtOQXolE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu8Lk8Ab7wEMd3lp8zljqR0UMvBw5uunp9KFUcHOTtGTNrc6/rUnTDIOJDFoEVaxxHD/y/kMC5sMn/vwUGSbXcIrx/Dl3W7zx6pKpYIP0rWtxNcC9LaU5NAHwJSIyGrflkOUcXT0Y81EdbdADqev1rx1LldJQNqZ1Fpgm5rP60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biwUV3T1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18D6C4AF08;
	Wed,  5 Jun 2024 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589114;
	bh=Pvlv1exqFURZ7yFfeNaFPWfN/fe30G0y1zsVtOQXolE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biwUV3T1yDnGnrlYwFzt+MQF0rPZjBVW75H5Wqtf/818QFiA88zwHDXBLX1wJNG8A
	 Ps+azm5V3tAUGB92hoiTnssPpOrMeJuEmAQnx1BQMfjLfUp0yBoeXYFtR0kvfdcYXS
	 PP+nweWme+eT4c7NB/USPRcL3wgDEJU2qcbSm2lmpV+UKLUyiRuyxR4kbSkO8dqhp3
	 C6zPzIXOBMdZvdbTJmSIp8MuJYwd2KekprUtd2nOXn9PabmqYybJ7ljgOm5Fe9b4hZ
	 1z0L2pWvGwOj5dt+UbA05m4VAOjhkQq5kYsw3tUOB2sZDkoIpdntp+vOGPpc7VOCU7
	 gwsroM0sFGkfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Witold Sadowski <wsadowski@marvell.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/14] spi: cadence: Ensure data lines set to low during dummy-cycle period
Date: Wed,  5 Jun 2024 08:04:45 -0400
Message-ID: <20240605120455.2967445-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120455.2967445-1-sashal@kernel.org>
References: <20240605120455.2967445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Witold Sadowski <wsadowski@marvell.com>

[ Upstream commit 4a69c1264ff41bc5bf7c03101ada0454fbf08868 ]

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
Link: https://msgid.link/r/20240529074037.1345882-2-wsadowski@marvell.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index d28b8bd5b70bc..b8bed8f39d2ae 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -146,6 +146,9 @@
 #define CDNS_XSPI_STIG_DONE_FLAG		BIT(0)
 #define CDNS_XSPI_TRD_STATUS			0x0104
 
+#define MODE_NO_OF_BYTES			GENMASK(25, 24)
+#define MODEBYTES_COUNT			1
+
 /* Helper macros for filling command registers */
 #define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase) ( \
 	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, (data_phase) ? \
@@ -158,9 +161,10 @@
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR3, ((op)->addr.val >> 24) & 0xFF) | \
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR4, ((op)->addr.val >> 32) & 0xFF))
 
-#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op) ( \
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, modebytes) ( \
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_ADDR5, ((op)->addr.val >> 40) & 0xFF) | \
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_CMD, (op)->cmd.opcode) | \
+	FIELD_PREP(MODE_NO_OF_BYTES, modebytes) | \
 	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES, (op)->addr.nbytes))
 
 #define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op, chipsel) ( \
@@ -174,12 +178,12 @@
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
@@ -352,6 +356,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	u32 cmd_regs[6];
 	u32 cmd_status;
 	int ret;
+	int dummybytes = op->dummy.nbytes;
 
 	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
 	if (ret < 0)
@@ -366,7 +371,12 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
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
 
@@ -376,7 +386,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 		cmd_regs[0] = CDNS_XSPI_STIG_DONE_FLAG;
 		cmd_regs[1] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_1(op);
 		cmd_regs[2] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op);
-		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op);
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes);
 		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op,
 							   cdns_xspi->cur_cs);
 
-- 
2.43.0


