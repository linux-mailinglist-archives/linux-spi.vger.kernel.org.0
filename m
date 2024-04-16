Return-Path: <linux-spi+bounces-2361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67608A67CD
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 12:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E794F1C2095A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA886AC9;
	Tue, 16 Apr 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CFDX5uC0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897CC86264;
	Tue, 16 Apr 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262157; cv=none; b=UToc3m7O9B67fFRU4hRNzG8DBAl7F+rKiQONB2+8GH8YMUMb16XWOdHXI+/GEOeB1CXOGMmbEo+Nke9cB2A3maoV0qaTSjeOxFpw7xUDRtEa+jaq5qATpeZ7IxwRjdLc+pVfJA9/30jnrx4taRAMgcqgv0vSYMfihALAVAKx7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262157; c=relaxed/simple;
	bh=Rts2V5bNpulnoso6KCg38geGDm80OXPyQF6GeWF0AGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3MsfZkjBTMvyeLea/SF1qasQKAaCHVW2uUxPkfmRiyauNx7i/T30p4oY3VSK+X4KFCfGXNri2BM8GnkMQH9nXVfLGE4i5v+xaWRx3WtrZq92il9aw99otoYW5KkgupEtnsOMB4ZmwOoTqyW5PlpiTsHAzIjahzyraec3AL+g98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CFDX5uC0; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43G2gOLv020556;
	Tue, 16 Apr 2024 05:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=C4+NFl5/bp5sr79hAM5yz+OHF5hlSVVkHqmKIvjZXeo=; b=
	CFDX5uC0+8YTHJeqmTWEWkJMwGTufMea6eZ37kkxLF2Q+gdXlyg1/Vu43BBmIxwj
	vz7nB7gARUgCS8nBw1oAHGoGY9TYMa+q6Mlfjl/UIcUVbEE1odHl7TawlrkRCoNV
	bIbnhk2XCzSK7Tk6pPcMXJyYFE2XH6pQzsbT1MY07eB4dmLOeYLRn8DSY5Lh7ejB
	Szgz3mp22Kg0uuKv8I9ytrUmrnJQEk1BsXIhVu3msizQ2zPWoCVmV+wJxpIAYS3I
	+ryexkm/shBvb4PAIqgX+kA0ZUZrgsuJgX6fslwy2GGQkD7isGzz0F1hKZiwkw4O
	BXXP/DfPIlvjkRF++s5PBQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeyac9p-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:09:09 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 11:09:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 16 Apr 2024 11:09:05 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EF5EF82024B;
	Tue, 16 Apr 2024 10:09:04 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v7 3/4] spi: Update swnode based SPI devices to use the fwnode name
Date: Tue, 16 Apr 2024 11:09:03 +0100
Message-ID: <20240416100904.3738093-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
References: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qlyMfNwxdX8-MGKkWWB-6wcnU3GTgPul
X-Proofpoint-ORIG-GUID: qlyMfNwxdX8-MGKkWWB-6wcnU3GTgPul
X-Proofpoint-Spam-Reason: safe

Update the name for software node based SPI devices to use the fwnode
name as the device name. This is helpful since swnode devices are
usually added within the kernel, and the kernel often then requires a
predictable name such that it can refer back to the device.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v6.

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


