Return-Path: <linux-spi+bounces-5613-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A869BBDBE
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 20:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3C01F22F3C
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 19:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F771CCB3A;
	Mon,  4 Nov 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3BonnUb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582171CC899;
	Mon,  4 Nov 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747297; cv=none; b=Y1cFqWyszYXU2i0mXXbuB8mSdLMLHGdt42NyzwzlOyy0fUx5EVGUqqVEobHfF0yaL3IcNftZRwVRFyIzUsCdTm2DhHWLiN6oy7BKrQTymvQnX9yCHtnf/7bIo2pCRq85ZmY6cKpZnBwUoFKvo5t8bfXwGc5ww2hhUMeMVnjNoxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747297; c=relaxed/simple;
	bh=byWXfqOzyItB0XDO7CHWIRppOPCIsx9LfjgTgf+kgto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ssj1AKMDkqR2quEILZWGaPRjL8UfdfbeOa3cwJa2j5Dli7XYl13huwlpHUgd0b2SI59YaIxQoZXj0NyKbSHySRFyg7TPUElTP41JBmjtjvuNu/wl2ejrYx5pBHUZa5Z984gE/mBTyTgQg7WH0Ac64Vy8VFh6ATzJyu+JwFxEXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3BonnUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC7BC4CECE;
	Mon,  4 Nov 2024 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747296;
	bh=byWXfqOzyItB0XDO7CHWIRppOPCIsx9LfjgTgf+kgto=;
	h=From:To:Cc:Subject:Date:From;
	b=b3BonnUb9sj9IUI87wtN77U2CJGSMrpe/uz8eFNe4DvXdHHkFbAlx5XYiQ5R8icqj
	 gEckYtu4VM+LzGW/lM0itT5A0q2y63XUp4LhQN/FE9loQN24XAof35GPW5lUBUaec5
	 otQlZyWhhAWDPhZ54CdIaBIxS3DR+lbiEH52t9IlKfcNnl/yOgy3PhCmCJsj7LuX4M
	 +tNkag5bZ4PGZHKsYOjsAzk0fl8FgigKf5Keyqq8oOG9iYEntt3/s1M/b3yzxitl5t
	 A+UdbfLESU6trdqiA4qTfynzsa6FeOoBsNVLLoTYqyUTCH/GLam48suB0pR7GKzlg2
	 mi3dvf2rk5Isg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:07:59 -0600
Message-ID: <20241104190759.277184-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/spi/spi-qcom-qspi.c | 2 +-
 drivers/spi/spi-ti-qspi.c   | 2 +-
 drivers/spi/spi.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 49b775134485..2b5cd9fee1a2 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -771,7 +771,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	host->prepare_message = qcom_qspi_prepare_message;
 	host->transfer_one = qcom_qspi_transfer_one;
 	host->handle_err = qcom_qspi_handle_err;
-	if (of_property_read_bool(pdev->dev.of_node, "iommus"))
+	if (of_property_present(pdev->dev.of_node, "iommus"))
 		host->can_dma = qcom_qspi_can_dma;
 	host->auto_runtime_pm = true;
 	host->mem_ops = &qcom_qspi_mem_ops;
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 0fe6899e78dd..c615ad56c676 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -824,7 +824,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	}
 
 
-	if (of_property_read_bool(np, "syscon-chipselects")) {
+	if (of_property_present(np, "syscon-chipselects")) {
 		qspi->ctrl_base =
 		syscon_regmap_lookup_by_phandle(np,
 						"syscon-chipselects");
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c1dad30a4528..e6063e536298 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2454,7 +2454,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			nc, rc);
 		return rc;
 	}
-	if ((of_property_read_bool(nc, "parallel-memories")) &&
+	if ((of_property_present(nc, "parallel-memories")) &&
 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
 		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
 		return -EINVAL;
-- 
2.45.2


