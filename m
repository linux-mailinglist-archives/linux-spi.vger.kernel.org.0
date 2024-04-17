Return-Path: <linux-spi+bounces-2394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7868A7FAE
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFDE281D22
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBC8662A;
	Wed, 17 Apr 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="h1DIJM4M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24F524D4
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346235; cv=none; b=Yt8HaULSjscyK1yRrpZarBUanMoItTgbyzADhZQwo0WLPkUq7wDQEYkkAcRiy9uTyjdBzRy9E/nXPEAsjw91V3UUt0A+35uV2E5/duCzLkwhgfMH7DLflH2jhWVfhN9BHDzJALWx9regB4c40Eh+uwkqIZ+BZoaIoH4R/BOhmyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346235; c=relaxed/simple;
	bh=GjrdqncZ5//9d05Z008K4wK4EwFY+7LvkLSVnf3C5S4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZV7hmE7VMCYdvoITMq0f51axTyuaiD8yN2f/oeeuRsC1qeBvgCWx//LKQqT1lIp7S9O+CCrpwNhcgyqBqAZmUliVzlwJIIgdAchXa7UXeC7xb3yYBgk+NfX9I6J3rPcjnAfbOpNyES+qHNsxIuZSCttFpO3d0aLN33DYls/7cGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=h1DIJM4M; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43H6S0np010388;
	Wed, 17 Apr 2024 04:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=0
	1re+/LtdTdj4NjPCa3OoHSP3/l5kYAujW4ucq8yLCc=; b=h1DIJM4M6qrEkd0rY
	eIEJISYlnNci8+b9ucdt/AxMtqLxPU87sgar5xqgUmw+TtvtzfqSC8uD1vuSdso1
	9rV11R5v2IfQMvIvWkx/RGycSEZihnsW/6b6CTCe9y/IdiMrwXbQDym9Fa10N8g1
	2At3281kQVXDZt2zVg2xgRB2bwnodROvmBxFGWpTyJT/vaaTEEysrXSslGZpv7i9
	tG6kdx9bQbMjaEGGVJu3s4cRjlBdiBBuUoEHhj7+Q2Xe5Zt79tXZyClNJ9kSh0PD
	WNZQUjwHyt9/wlM08KiV+DGfOb/f2sIEX9d6WzcPeQSOo4eHbEo2lyziue3e3YJm
	f/fcw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhug2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 04:30:28 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 10:30:26 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 17 Apr 2024 10:30:26 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BCCBF820245;
	Wed, 17 Apr 2024 09:30:26 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] spi: cs42l43: Use devm_add_action_or_reset()
Date: Wed, 17 Apr 2024 10:30:26 +0100
Message-ID: <20240417093026.79396-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: G8OGhH2QeEyYwyR-xcAA7RDrD-YJdoNw
X-Proofpoint-GUID: G8OGhH2QeEyYwyR-xcAA7RDrD-YJdoNw
X-Proofpoint-Spam-Reason: safe

Use devm_add_action_or_reset() rather than manually cleaning up on the
error path.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index cffd9a177808..cdc61cd089ad 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -345,11 +345,9 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 
 	if (is_of_node(fwnode)) {
 		fwnode = fwnode_get_named_child_node(fwnode, "spi");
-		ret = devm_add_action(priv->dev, cs42l43_release_of_node, fwnode);
-		if (ret) {
-			fwnode_handle_put(fwnode);
+		ret = devm_add_action_or_reset(priv->dev, cs42l43_release_of_node, fwnode);
+		if (ret)
 			return ret;
-		}
 	}
 
 	if (has_sidecar) {
@@ -358,11 +356,9 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 			return dev_err_probe(priv->dev, ret,
 					     "Failed to register gpio swnode\n");
 
-		ret = devm_add_action(priv->dev, cs42l43_release_sw_node, NULL);
-		if (ret) {
-			software_node_unregister(&cs42l43_gpiochip_swnode);
+		ret = devm_add_action_or_reset(priv->dev, cs42l43_release_sw_node, NULL);
+		if (ret)
 			return ret;
-		}
 
 		ret = device_create_managed_software_node(&priv->ctlr->dev,
 							  cs42l43_cs_props, NULL);
-- 
2.39.2


