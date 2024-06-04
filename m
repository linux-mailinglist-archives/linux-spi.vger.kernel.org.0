Return-Path: <linux-spi+bounces-3215-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94D28FB354
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7228F286A57
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE383146A61;
	Tue,  4 Jun 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ntCq18NB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDF3236;
	Tue,  4 Jun 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507043; cv=none; b=MhO2aP569eTkCWpVENkDhsHr4abuenxgXS7p4hmsxTFKVrG5s0LpDLnrVVWSy3j6Su1g0R7JZmS6eUKxv45A3Lpo9Mtw0EIKuEQrQo9QfOdKCMNKXSmRu3qZUnejbTC0wou2gGFeCxR7yfp+FEvxmHlSjFr6+1hyZEhU1yZd9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507043; c=relaxed/simple;
	bh=0hGLjFWiIFMsbI4JKLKav0MyVHp4ycP2Ma6r3nGdAEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H361g0aCa8WAoINIkp91YG8SP4idXih2G7aI456BkCn3MHUk62fNx8i04SBYdVNq3SHyrHuBWxUcA/MSl4mSOA5CzBJxcXYLd9vKttxlRsdzJNezOZUWKkn23e6vXJ7Mr6tUBuHTiiCzO/Bb468nBHFx/h314NhgPx0Yt6haO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ntCq18NB; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4547dupi018474;
	Tue, 4 Jun 2024 08:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=F+8rxQO7RSXvZbQV
	W2ms+ZsRV/idSK+u4TSZFYJeK28=; b=ntCq18NBIkTKGGyWrDZUMIswciWzGQZc
	X6WtTV6z8I4Zh9pb8zOG92ifpGi8uRVsctst4vzS3WxAlodevfxm92PHPv/4pJhA
	/iwWF4OJ/jI9GV1Z5yqFDPea5DNv0f0xndOgNJEFRqalLw3ITZUw2VIxrWaKGGrJ
	rVER+eok9x9LeLwlJo8UpFbO6+WIGqYHDBS+CTGb+NaCSG7lh4x900XCZuZ4YhmD
	orQt+XNfdBX07cZTJq/sLpQaGEBg4pXIp+k/A8mvtsiLyJEnK+to6HAGrA5er3vv
	oDFDee29tnAJZgPBSjH/1LFmY4JTN8K6dXFxQExNXTkzm9AQZsjP6g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yg02hjp90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 08:17:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 14:17:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 4 Jun 2024 14:17:05 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E3994820249;
	Tue,  4 Jun 2024 13:17:04 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] spi: cs42l43: Correct SPI root clock speed
Date: Tue, 4 Jun 2024 14:17:04 +0100
Message-ID: <20240604131704.3227500-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vUp6eeGzQsDwNkFkiGDvoxSdY-deO_LX
X-Proofpoint-ORIG-GUID: vUp6eeGzQsDwNkFkiGDvoxSdY-deO_LX
X-Proofpoint-Spam-Reason: safe

The root clock is actually 49.152MHz not 40MHz, as it is derived from
the primary audio clock, update the driver to match. This error can
cause the actual clock rate to be higher than the requested clock rate
on the SPI bus.

Fixes: ef75e767167a ("spi: cs42l43: Add SPI controller support")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 9d747ea69926..902a0734cc36 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -26,7 +26,7 @@
 #include <linux/units.h>
 
 #define CS42L43_FIFO_SIZE		16
-#define CS42L43_SPI_ROOT_HZ		(40 * HZ_PER_MHZ)
+#define CS42L43_SPI_ROOT_HZ		49152000
 #define CS42L43_SPI_MAX_LENGTH		65532
 
 enum cs42l43_spi_cmd {
-- 
2.39.2


