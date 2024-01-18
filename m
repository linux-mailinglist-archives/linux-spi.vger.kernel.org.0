Return-Path: <linux-spi+bounces-499-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B511C8318EF
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 13:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4EC1F24E01
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A9241F2;
	Thu, 18 Jan 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZTcqaJr8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2224B44
	for <linux-spi@vger.kernel.org>; Thu, 18 Jan 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579824; cv=none; b=Ffp1naJB9HJYhwMmGpJcrrSFx5bNnmL2cFxm8bl5KN+jfoeLm91PbK1jyD6D0FjbImthSXlmEB30TgaJBQzFxstklSWIbM/uODYS/qAm339oM5yQdNtOTv5bXUA/gyQShidGzdsLvvBoZjHE7U/noXcKUGrPyP59pCa4DC7PV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579824; c=relaxed/simple;
	bh=pAMYsUs96QClrGlV7krboLoXqnZLTX/RFOOltJDFr10=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	b=BmO1XSGhS4+Nlbfx6NbkyrpJH05Bsq9szT19guCA16VtWV+Tv9OcoOWR4bE8E94byOSTJPCw3yKZsdrBIQLmPttCsTgCntqYGH3d4Rh1wNQuSwCnjPas2Vy1iZstPccGNMMrsNUD+TEd5znhxhRwBymYf42C39E8kZKeSLkShOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZTcqaJr8; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1705579819; x=1737115819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BDHZI0b9AkYKaKAZNk7Q5bCeQYXuTUfI+ueCi8B1giM=;
  b=ZTcqaJr847Y5SwBxPzD8QninDF0405YzyfNl5Bj1eaey+RaIvDwgX+NA
   E27GS0i+cqKSvknW7GD2Z+J/uGp1x41GUjbXLDCKylIEP5QMDtGForZrk
   n83L3VXAHtClwE/14puBY30WdCAgyhziGG4Ph9lvlDrlQSoPPVFjUj0B7
   cDWNsGObV64o6V9KKxLoYd6F7ZS1FVndY0mL6KcUOfDf6UsTIXJU5eRLw
   JCZQH1hYUmW64i+WlDjUCGISR8shWRMUQOvLBRqcR2sssmARRvxBKW9F3
   t3+Uwqsig7qrcXA58Rfi1j82H/n2/7rCZyhdtBYRkBV6pWfAoEL+wVg8u
   w==;
X-IronPort-AV: E=Sophos;i="6.05,201,1701126000"; 
   d="scan'208";a="34961404"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Jan 2024 13:10:16 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 08D77280075;
	Thu, 18 Jan 2024 13:10:18 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 1/1] spi: nxp-fspi: Adjust LUT debug output alignment
Date: Thu, 18 Jan 2024 13:10:16 +0100
Message-Id: <20240118121016.3734770-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the command value and LUT entry values have a fixed width. This
way consecutive output lines can be read much easier.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e13f678f23952..88397f712a3b5 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -591,7 +591,7 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	for (i = 0; i < ARRAY_SIZE(lutval); i++)
 		fspi_writel(f, lutval[i], base + FSPI_LUT_REG(i));
 
-	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x], size: 0x%08x\n",
+	dev_dbg(f->dev, "CMD[%02x] lutval[0:%08x 1:%08x 2:%08x 3:%08x], size: 0x%08x\n",
 		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
 
 	/* lock LUT */
-- 
2.34.1


