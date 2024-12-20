Return-Path: <linux-spi+bounces-6129-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721789F97A0
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 18:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1526616A5BB
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00922576B;
	Fri, 20 Dec 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnPHBReE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C62253EE;
	Fri, 20 Dec 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714730; cv=none; b=CmZve7Oc3FvfmI9dlijCzJ7rnPvF4YCIUq0TP6YgwnFOJdyEX1lttCzO43T+O2dPHqDAxUObhYtrZiScXiUmCXH+la60HQDAmKt6Uo2UPg1EFpTLTFjJsTMX3htjsbNMb4fwzB6xhAodm25+S/LVyAucE/jyQXSG7PYTWcVD0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714730; c=relaxed/simple;
	bh=3J3Z20U6LCUOXoS4iDJwHTr2ftQBWJ1941sXp4gcxJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AdWw7yYuHA+NVb4bJTa+gLQgRxMHagLvQz1htjbFD6XXNIZANmU8M4dWzhBuAr094vOPn7AbEJkH6YRUGdx6xqtJhm4FIlkakDpOjAu8a4qiYTUT0aU3KLGT4SloSlBI6b5CuawPB1x6cafbKFYD/G5ybJFmVQ9rjAk+sHWysKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnPHBReE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09230C4CECD;
	Fri, 20 Dec 2024 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714729;
	bh=3J3Z20U6LCUOXoS4iDJwHTr2ftQBWJ1941sXp4gcxJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnPHBReExvHuirJIb9g3JIuZuJZeP/fn8hLNYv2fx6RlOT0Foj7SoYoIiuRFt/0Od
	 FWh5d3uoVu8W68/vQfBm1L18FCneo7sT5O2XiPRRVzLCCVoPI+Nu9efmQ3senOe6X6
	 zvpvg981OGN0OlFkGbuh26kkqytQX1Uc/qUj2LSMx04e4YiOlzYHakkGtlZ2SAgnAb
	 zX6UQXOo5v4dwo3f+rTIi1NvkXZ77BwkN9iMlLXjWmi7tnTKgXcnl+zMMmARkeUPKs
	 AOdZnB/KjKyG8xVGO4x8yxovzYNFUUJLYj82bM3zrp2BKfEc7ahG5vQsVNskeD+rdf
	 cczziEwiY2/8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 15/29] spi: spi-cadence-qspi: Disable STIG mode for Altera SoCFPGA.
Date: Fri, 20 Dec 2024 12:11:16 -0500
Message-Id: <20241220171130.511389-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

[ Upstream commit 25fb0e77b90e290a1ca30900d54c6a495eea65e2 ]

STIG mode is enabled by default for less than 8 bytes data read/write.
STIG mode doesn't work with Altera SocFPGA platform due hardware
limitation.
Add a quirks to disable STIG mode for Altera SoCFPGA platform.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Link: https://patch.msgid.link/20241204063338.296959-1-niravkumar.l.rabara@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1755ca026f08..73b1edd0531b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -43,6 +43,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_SLOW_SRAM		BIT(4)
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_RD_NO_IRQ			BIT(6)
+#define CQSPI_DISABLE_STIG_MODE		BIT(7)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -103,6 +104,7 @@ struct cqspi_st {
 	bool			apb_ahb_hazard;
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
+	bool			disable_stig_mode;
 
 	const struct cqspi_driver_platdata *ddata;
 };
@@ -1416,7 +1418,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	 * reads, prefer STIG mode for such small reads.
 	 */
 		if (!op->addr.nbytes ||
-		    op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
+		    (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX &&
+		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
 		return cqspi_read(f_pdata, op);
@@ -1880,6 +1883,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			if (ret)
 				goto probe_reset_failed;
 		}
+		if (ddata->quirks & CQSPI_DISABLE_STIG_MODE)
+			cqspi->disable_stig_mode = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0")) {
@@ -2043,7 +2048,8 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 static const struct cqspi_driver_platdata socfpga_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE
 			| CQSPI_NO_SUPPORT_WR_COMPLETION
-			| CQSPI_SLOW_SRAM,
+			| CQSPI_SLOW_SRAM
+			| CQSPI_DISABLE_STIG_MODE,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
-- 
2.39.5


