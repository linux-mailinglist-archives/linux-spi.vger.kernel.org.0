Return-Path: <linux-spi+bounces-2009-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0374988C4C8
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137B61C61923
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85A376053;
	Tue, 26 Mar 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZHxseVw9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97377F7C8;
	Tue, 26 Mar 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462290; cv=none; b=K2xP1EFKwMWNZQGPYVnENoQrB5G6Afj2sq1G+rXUtmGGVy5eYsLLVwgOHNYl9YHkMgxA1VOWJaRCicIIv9bF1FEQx1DGSDiRUKQY0jmnssrpd9i+xVjbcR6NHIBjLJDxMgyaAeWX6sITneG9+nCi4R5BM/n0c/dyOL+RwX69mi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462290; c=relaxed/simple;
	bh=RT6HSUWziNjh0DyUN+VyxLpq9Q8jhGRYp/rHRkgQb4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESPaU9gwVlfwd2hUKGs14iobzHSb55d/UVEcWnbyHg99tDYTJtgiJnk3fZCU7XkmSU2W7ahX6nCkJFMtvljRoM/ZVATr8Y1i7UN4YpkUotyx0uQc4kM8XSwSizQQc8vBWfvDxrZovA7/Nwme3cJq1JZ1hdps9tQDLPfNzljObMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZHxseVw9; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q79uU8026416;
	Tue, 26 Mar 2024 09:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=4
	NtiBv4Lh/zR4jqlmzESI/1KvypLtdYOe+J93npl964=; b=ZHxseVw9iwpqvPEx7
	dbzAXDyUBKPbLNMZFLfpPP8VxdP2cySxFU7tFUgaWIzEEIf6fzaY+qP+8/HronjK
	SeXTu1A7X6fWN6pJcnfPrE+G0167IkB1eULpMAI+ZyG4aiufMyx0gmwHURk7Sfjj
	BvZYYVQMq4hcxpobZEy05IaQvw83fyVEaUopxawuMdyDK7o8sUa8Yu7gLyuou6xF
	S99Do8CIpcKI9Y8fplgROrg6xe7LCE2AJ/seiFL/xHLUNJbV8DHY0MFmEcfBkmUO
	pN/Sk78AWbhOr154j92JtGbstLpSnlnhynBi28TUjiLqFX8hhr8UY2l1f/dv2YHt
	Lid1w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3x1ugm5b9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:11:10 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Mar
 2024 14:11:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Tue, 26 Mar 2024 14:11:08 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8FB80820241;
	Tue, 26 Mar 2024 14:11:08 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/3] Add bridged amplifiers to cs42l43
Date: Tue, 26 Mar 2024 14:11:05 +0000
Message-ID: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yAUZGjQ3m8CNU7ZvWaoqQu5QoNXcgut3
X-Proofpoint-GUID: yAUZGjQ3m8CNU7ZvWaoqQu5QoNXcgut3
X-Proofpoint-Spam-Reason: safe

On some cs42l43 systems a couple of cs35l56 amplifiers are attached
to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
by a SDCA class driver and these two amplifiers are controlled by
firmware running on the cs42l43. However, under Linux the decision
was made to interact with the cs42l43 directly, affording the user
greater control over the audio system. However, this has resulted
in an issue where these two bridged cs35l56 amplifiers are not
populated in ACPI and must be added manually. There is at least an
SDCA extension unit DT entry we can key off.

The process of adding this is handled using a software node, firstly the
ability to add native chip selects to software nodes must be added.
Secondly, an additional flag for naming the SPI devices is added this
allows the machine driver to key to the correct amplifier. Then finally,
the cs42l43 SPI driver adds the two amplifiers directly onto its SPI
bus.

An additional series will follow soon to add the audio machine driver
parts (in the sof-sdw driver), however that is fairly orthogonal to
this part of the process, getting the actual amplifiers registered.

Thanks,
Charles

Charles Keepax (2):
  gpio: swnode: Add ability to specify native chip selects for SPI
  spi: Add a mechanism to use the fwnode name for the SPI device

Maciej Strozek (1):
  spi: cs42l43: Add bridged cs35l56 amplifiers

 drivers/gpio/gpiolib-swnode.c |   8 ++
 drivers/gpio/gpiolib.c        |   9 ++
 drivers/spi/spi-cs42l43.c     | 152 +++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c             |   7 ++
 include/linux/gpio/consumer.h |   4 +
 include/linux/spi/spi.h       |   2 +
 6 files changed, 181 insertions(+), 1 deletion(-)

-- 
2.39.2


