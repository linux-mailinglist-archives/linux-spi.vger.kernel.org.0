Return-Path: <linux-spi+bounces-2342-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620748A52B8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0116C1F23F1B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C52745C9;
	Mon, 15 Apr 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DRxbCwud"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E07442E;
	Mon, 15 Apr 2024 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190177; cv=none; b=qQivgZEo/FRVy2XAHhdurRFugmFrrCMryUog+mwuHGnYTvjbz11D0RPeyjT5CYzHlGhkWZGk1nD614uEqRgnTBU+8+YGzPWPi/DKA5aSzG3wiEyFosNpJ8/8TD0n4+VJtp90wtE3d3rEEwJWz8PpSgc5zk4bSN9wJ6Uvc5QQID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190177; c=relaxed/simple;
	bh=zuZqfWb5LXrOy661E7Kqz3QD5kyZ00vKaD4HNqQ94Ns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auyh4pkcTMRptIOoko6ssaePHf5dXLZiQuwNCQXSJboINP6NGfccG9QDA9aXnkp4sWmoZYSkabS3rA1Y0tT8hTp3wCzvAm1iaK01KF2m56iDGkK8N5tzQo1ncyhyQTT4fq0sNazBoGU+fRsQFCDkRLJlD/dpxMMIVfDJmK76d+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DRxbCwud; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43F5UOmj015882;
	Mon, 15 Apr 2024 09:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=GN1M5wV8cCVdQWv+W/wsd4ven5Ldjiwh0ZMKx83x0M4=; b=
	DRxbCwudGsuno4zY26pZ0kZEktqFb5HcVQY/l0ZuHY+ZrIjTTNJRoF/LqMCy2Inl
	0adWE4W5pHQmUmA/42gSz7hafpu283Ls5gpLV2wreyApO4LdoJT76wsA7BTZgnPi
	OZlghVbG+5M72ZlF3OLXn5bc8oQE/kXGSgRaMgWlVT1sU+Udp0pF5lOSpADAAQET
	RIj6s1cF3FnQJKVOqPE2dEDfkN349TgrpE69znnJPt47lOFXJjSocEtzw7lHWvvT
	UsFjrM/M1GZrrd6Apdsb5PCrdppkC8Ka89M/wsbwrluDtZnn4b9hJKnIq+Argn36
	iypFsgEGEGMFxloJrNZBFA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqey9hc7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 09:09:29 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 15:09:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 15 Apr 2024 15:09:25 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2EBAF82024B;
	Mon, 15 Apr 2024 14:09:25 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v6 3/4] spi: Update swnode based SPI devices to use the fwnode name
Date: Mon, 15 Apr 2024 15:09:24 +0100
Message-ID: <20240415140925.3518990-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com>
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5YiwU0Ns06dilh-BEF_LUjdoJuU07s4F
X-Proofpoint-ORIG-GUID: 5YiwU0Ns06dilh-BEF_LUjdoJuU07s4F
X-Proofpoint-Spam-Reason: safe

Update the name for software node based SPI devices to use the fwnode
name as the device name. This is helpful since swnode devices are
usually added within the kernel, and the kernel often then requires a
predictable name such that it can refer back to the device.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Series changes since v5:
 - Use %pwfP to get firmware node name

Thanks,
Charles

 drivers/spi/spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d1f82a35f2d0..4fcaadf8a484 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -605,6 +605,11 @@ static void spi_dev_set_name(struct spi_device *spi)
 		return;
 	}
 
+	if (is_software_node(fwnode)) {
+		dev_set_name(dev, "spi-%pfwP", fwnode);
+		return;
+	}
+
 	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
 		     spi_get_chipselect(spi, 0));
 }
-- 
2.39.2


