Return-Path: <linux-spi+bounces-4452-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1559658E6
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 09:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9A4287711
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 07:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C371160873;
	Fri, 30 Aug 2024 07:41:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB51586CD;
	Fri, 30 Aug 2024 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003688; cv=none; b=DtNBuxgsT28c48LhWH+SAivPaxT91jqEvRoiEPiLeogJFCLEQCg02iytoyXtzLhaSKs0Uu/VxO/JnPnhfofCliorne75c7zxUjFPCzvB3AetF61fX2DZFAUeEqsB6Le0pSIG+C6bRaSAWAW9NpAU+NbeNMgv8g2VlbAhji+Jla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003688; c=relaxed/simple;
	bh=mo1TeP1IBhA/jtc/JYDbU8A7ZfiTPlT83vrDmoL/2p8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3D6FbtnFpk7BNHZStFMdD3YbpbHvcOcAyR2zNqX+EC6tmA4jFY8WrRAA7YwBej7aj0FTXl0COUP2zEedAhx0/Qva+84hGL/oyz2QEh/iCKBsHT+H+1XQnSLmafM39eqkFDN6iDzFmEy5+wfCl2WTsBiABtFFRYLPzekfR63WuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id AFT00110;
        Fri, 30 Aug 2024 15:41:10 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 15:41:10 +0800
Received: from localhost.localdomain (10.94.18.5) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 30 Aug 2024 15:41:10 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <broonie@kernel.org>, <mika.westerberg@linux.intel.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] spi: intel: Add check devm_kasprintf() returned value
Date: Fri, 30 Aug 2024 15:41:06 +0800
Message-ID: <20240830074106.8744-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024830154110add78573d8131156199649953e4904e6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

intel_spi_populate_chip() use devm_kasprintf() to set pdata->name.
This can return a NULL pointer on failure but this returned value
is not checked.

Fixes: e58db3bcd93b ("spi: intel: Add default partition and name to the second chip")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/spi/spi-intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 3e5dcf2b3c8a..795b7e72baea 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -1390,6 +1390,9 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 
 	pdata->name = devm_kasprintf(ispi->dev, GFP_KERNEL, "%s-chip1",
 				     dev_name(ispi->dev));
+	if (!pdata->name)
+		return -ENOMEM;
+
 	pdata->nr_parts = 1;
 	parts = devm_kcalloc(ispi->dev, pdata->nr_parts, sizeof(*parts),
 			     GFP_KERNEL);
-- 
2.31.1


