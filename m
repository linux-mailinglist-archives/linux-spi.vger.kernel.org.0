Return-Path: <linux-spi+bounces-3337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF53900105
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 12:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ED21C22AD4
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB315D5D0;
	Fri,  7 Jun 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CTnzQumF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F3156972;
	Fri,  7 Jun 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756476; cv=none; b=sQrdi5sxuLyefX6Nf5Ho76YC9FZr/UttswkqTl2RjaBBaNvZxsRYCAUo8+dSXr2E1yzU1x8dn1MCeD2thvHtk5j/rZbO6L2sVfyfyP3C29h/dQ0lLwS4NB+EbfpvHRQG/AKRMflaBPH8i3TgCzLZKtDWhAmmsvVOdfS6MI2aFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756476; c=relaxed/simple;
	bh=dyVyLefOikmRtBPVetXROQZZVtQIp30035Nayce89c8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OKJZNtpdyiKyDeag+/itrFVSNj6Wcz9rnsWPOEYfjA/sas7IX1xIhHTNzAS4Uuus5SxFYNF2vh+F8fqAl5preU+UnjJZCf2xE8WqHTSqdV87lYtiCvz3UM0OhUTr0b52mAcMi0KPwkdy50QpFB0lSrC5i+fWXDriYLg9Uw9+SyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CTnzQumF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4576TmmW026247;
	Fri, 7 Jun 2024 05:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=6SZT7Vg8SBdcI7/u
	p7vQsqWryzwf0Hs49+SBIRhYVR4=; b=CTnzQumFs6+eYyrhaDAbYS0vp51rbx/e
	k4wC0JFdINUNzhptkuOFfjze6zE70q3/DXba2T06vTzxHNpij4y/57BVJL4fWv4N
	p5GMz+6Se2dhM1gJZgDW+Gm/t78hLeeCYso36lA4GfbM6bY8vi855F+J5XvSHv2u
	unS0QqcBhXQEd3/XXKflYntyMWVoZ2HzFubuZivX4o5Bl9y/XPufE/RHLAD4CtH+
	Yg6pCRjBH4+9X2RIP6PcP4poaunnMiHRm3RU3kIPTjyrC+5iBbiP5gbV6xscFKEd
	4ACgzC2iW9HH22kpWYiMMmLa+9Zc7Mi3SmaKiT+kiLvwd9Df2omH5Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yg11xxb09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:34:25 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 11:34:23 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 7 Jun 2024 11:34:23 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 86686820249;
	Fri,  7 Jun 2024 10:34:23 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz
Date: Fri, 7 Jun 2024 11:34:23 +0100
Message-ID: <20240607103423.4159834-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FntvNQd4mgZmpgeX5L1JE-4nfhYJj5Tg
X-Proofpoint-ORIG-GUID: FntvNQd4mgZmpgeX5L1JE-4nfhYJj5Tg
X-Proofpoint-Spam-Reason: safe

Some internals of the cs35l56 can only support SPI speeds of up to
11MHz. Whilst some use-cases could support higher rates, keep things
simple by dropping the SPI speed down to this avoid any potential
issues.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 902a0734cc36..8b618ef0f711 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -54,7 +54,7 @@ static const struct software_node ampr = {
 
 static struct spi_board_info ampl_info = {
 	.modalias		= "cs35l56",
-	.max_speed_hz		= 20 * HZ_PER_MHZ,
+	.max_speed_hz		= 11 * HZ_PER_MHZ,
 	.chip_select		= 0,
 	.mode			= SPI_MODE_0,
 	.swnode			= &ampl,
@@ -62,7 +62,7 @@ static struct spi_board_info ampl_info = {
 
 static struct spi_board_info ampr_info = {
 	.modalias		= "cs35l56",
-	.max_speed_hz		= 20 * HZ_PER_MHZ,
+	.max_speed_hz		= 11 * HZ_PER_MHZ,
 	.chip_select		= 1,
 	.mode			= SPI_MODE_0,
 	.swnode			= &ampr,
-- 
2.39.2


