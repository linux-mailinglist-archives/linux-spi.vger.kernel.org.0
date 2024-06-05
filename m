Return-Path: <linux-spi+bounces-3240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3162A8FCD6C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9181C23D56
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1661C8A1D;
	Wed,  5 Jun 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjFXtMX5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734471C8A17;
	Wed,  5 Jun 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589071; cv=none; b=qsjfcyeVOGBHTvK8ry+OF4sFMgkPd7H2I4L3C3/siTPiPZxFcgKy3kgsf4FsYweKZqJXoV+3AScBAcFQWVEwfDrIu72vwCc4JI+gxn6JcvmQOC055vSdU1s3TCDeVSLfoqpNVobEqNGqswdld6Uv4PMTwFcMJHVH4MMPSQWDf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589071; c=relaxed/simple;
	bh=+9XR9D566kw6iA75tZC94ARRosjdnoVEMyLQT0Yu6vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWJGA2Ly0eYqZtPYUeV+CU1Z1dn0W4d2extsEXJN+u8xwzWty41AvhZ/bmgw3iRSRIimZmRkqr2Z30N7ibrdPMtc9RKJcz0cRcLboV+R1aS21Xwa4Kc/tpzK2w2wmDNJR0VSE+O7iojUxA7GpKefX0N1kgxMrUz32VDc2Zu0OZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjFXtMX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D9C32781;
	Wed,  5 Jun 2024 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589070;
	bh=+9XR9D566kw6iA75tZC94ARRosjdnoVEMyLQT0Yu6vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjFXtMX5uQFVovTwSf2nRBgaa+YdT3Pgs/iHnc4dneE0FDDgyu1YjplJz9AgEx3wj
	 /qOosPRvMxC0vF3C1OkJlUD8ZiLct0Ds0Q1sroQfAGnNfTJ7U3hcb+P2vjuRzy5iAS
	 UODbvDKtV0Vh7vHLUhIO7OBlUF2gG77FVExpQUAmQUvkN23qSSu8XqAAWWjjBbXc7c
	 OrmAu79S+Rm0QvSZpPjPgJJ/N6/9lkBzkdi+Xn7RiHxehojTcEKQay+XSU8I75t3Zl
	 XK1s1NIIRmYqBcheQJgHn3tjcjKGH/l2gcITvB58L/8P2UdD/96Jayt4cIujAHPNFF
	 eIgcq2wcGLb+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Witold Sadowski <wsadowski@marvell.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/18] spi: cadence: Ensure data lines set to low during dummy-cycle period
Date: Wed,  5 Jun 2024 08:03:52 -0400
Message-ID: <20240605120409.2967044-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index b7e04b03be58e..ee342501b759f 100644
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


