Return-Path: <linux-spi+bounces-2344-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B018A52BE
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A476B221E5
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB4174C04;
	Mon, 15 Apr 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="R1xDMBxN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422E74BF0;
	Mon, 15 Apr 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190184; cv=none; b=nlV7DhwhfIglyMWMS4M5YZwEAHN0KVrSB4V7eQLUeJ6jEjCI6uiSQlPmB5Eru+ceLIC6kZ0Piuoi7I8Y9mpu6F/SdTscHCPt4EfxG9ttyULQZXMwgUtj6FbZDkyN7QDPWUgSQJ/OvNvZWxY9OxCkO4UWc8mepN4dLwZrcTr0fpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190184; c=relaxed/simple;
	bh=RUOsgDSIuHg3QZx4/pp4VMVuMBxsKm5tNqrRhUmBvU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyRTAcCbL9HzjlAZjv7zBXt+atdG5y+9TVgB1Dq5jYgHMmwY0aOcf26e/hpoogfunszO1t7sUu2jQ6Nc80Vu4ourDbnoUZwhCdeHKcdr6bPI2+UcpU645p/VtKnk0eNdaLjzrH3ajaPWcrTYXqEEZJ4rbiCxid5EQCJmVZ36nLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=R1xDMBxN; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43F5v4tB010751;
	Mon, 15 Apr 2024 09:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=/Md9baTUiJevAOB37V2ITsDxrxZtB+1rRWkng+mwJ1c=; b=
	R1xDMBxN16zyHfoYz6fMMjOdCmdw/Lw5pkg6NEMG5o1PPXBWjIoc03MekHQW2/mY
	cn1HnGLsFM3ObriPpFyWaEgIp8DTnEGllZahiyFCWcjEDPilNnI4S8x97bGnvpGp
	rTKv0zJdXUvlMSuUGZJF1Q8+ce0oYeWBrRrIJJiRAhg11ltQ3vcdxJ1Qyiekm/HT
	g4rTI6XibRLtIyazvgMvObMW2PvWHdJTl9dfYEppFI4b+8WG6sDCHDvDp3M1GiHq
	W8Pq/0q8/rxIa0HHDZH9N5UguQzDbYSmYswwm3foqxEDe47I+7CmQwmc/opavGjD
	gRf9vYAZ45ODk2RO6nivNg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhsk4e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 09:09:28 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 15:09:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 15 Apr 2024 15:09:25 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 21F7A82024A;
	Mon, 15 Apr 2024 14:09:25 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v6 2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
Date: Mon, 15 Apr 2024 15:09:23 +0100
Message-ID: <20240415140925.3518990-3-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: IwDHmTJCciC8FelekLJXJF0_0Rt5WoBs
X-Proofpoint-GUID: IwDHmTJCciC8FelekLJXJF0_0Rt5WoBs
X-Proofpoint-Spam-Reason: safe

Use is_acpi_device_node() rather than checking ACPI_COMPANION(), such
that when checking for other types of firmware node the code can
consistently do checks against the fwnode.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Series changes since v5:
 - Remove includes of fwnode.h
 - Update commit message

Thanks,
Charles

 drivers/spi/spi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a2f01116ba09..d1f82a35f2d0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -597,10 +597,11 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 
 static void spi_dev_set_name(struct spi_device *spi)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
+	struct device *dev = &spi->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 
-	if (adev) {
-		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
+	if (is_acpi_device_node(fwnode)) {
+		dev_set_name(dev, "spi-%s", acpi_dev_name(to_acpi_device_node(fwnode)));
 		return;
 	}
 
-- 
2.39.2


