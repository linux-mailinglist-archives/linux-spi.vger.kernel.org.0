Return-Path: <linux-spi+bounces-2107-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C39891824
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 12:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C9C1F22B3C
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5285F6A35F;
	Fri, 29 Mar 2024 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hQ/do6zP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2D48CC6;
	Fri, 29 Mar 2024 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712860; cv=none; b=GGKBbIaDX9TOsfeGDls9aKR3MrL5rk81akxaytfHDeoMJI4s2FTgCZP92EELfHu/l/R2chozP2jLZ/Agi5fD6BPGwR7CX+7Xzq3Rf3l2Vbm/KmZiD0AUQTVroJlklEcKEvu8i0FUxL5JT9gefG1JjjrEv8EnfR3kCNx5ZqsYmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712860; c=relaxed/simple;
	bh=lFol9FzMjnm1vekVek6KkTwPZc9NZqqvmXMqmpAmd5E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tKlZJn2L4a/6dHLwdChyJmRQu2uw5gtAYbnrn8BVhnVB/kTU5xS2154BiYQioMXC9UvVpWnUz+fcJuym3OrryQ/WSxVdYF0kzH/8e8mlOk8hpDZy9BgojTAJU7BMf4YxEbHG3e3tMCYhCqeo7x8+LJPhxnDPtR0wwzWiQhGf/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hQ/do6zP; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T51HNJ032384;
	Fri, 29 Mar 2024 06:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=+
	mU/SMmDAcUvg7lb1qqrbA9DXKrb4Kj7TJ69DvbDP3M=; b=hQ/do6zPap7YiYrz8
	rGr0bgGIfuyHbHUvSFqLFIAuBPswGd6EcB+vd4F7LHqOrQZtJlKG12E2hkC1hTwj
	M+/lAYtA8KmFAGXWPjeF3uUp2FFjtYO3/QBHXs2y08g7kvLqgDB4La8N9BSseffL
	XvtdFN4S53/oqPFn5ZG3LZksu4lEzxnaWzviyqpAdFkpFauqEFTFEX4IS9KP60nU
	PPOdOUp9YzXls5iBaRXkkyddz1LdS9HMPyaQYzERYfilB5QqWVVJbTnByLj8yzfE
	sP4TFlY0YwxU8c4xSN2Lv0xV12CJkmM6neSk8Es5KoFxN4AQwBVHAN5K6Au4m1Fb
	PxjwA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x4k7k4747-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 06:47:33 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 11:47:30 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Fri, 29 Mar 2024 11:47:30 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 43049820244;
	Fri, 29 Mar 2024 11:47:30 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/3] Add bridged amplifiers to cs42l43
Date: Fri, 29 Mar 2024 11:47:27 +0000
Message-ID: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MRz61n_RL0Yk7Lk-R1h66hrTNZ6AcNKH
X-Proofpoint-ORIG-GUID: MRz61n_RL0Yk7Lk-R1h66hrTNZ6AcNKH
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

Series changes since v2:
 - Add missing fwnode_handle_puts in driver/spi/spi-cs423l43.c

Series changes since v1:
 - Add missing statics in driver/spi/spi-cs42l43.c

Charles Keepax (2):
  gpio: swnode: Add ability to specify native chip selects for SPI
  spi: Add a mechanism to use the fwnode name for the SPI device

Maciej Strozek (1):
  spi: cs42l43: Add bridged cs35l56 amplifiers

 drivers/gpio/gpiolib-swnode.c |   8 ++
 drivers/gpio/gpiolib.c        |   9 ++
 drivers/spi/spi-cs42l43.c     | 155 +++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c             |   7 ++
 include/linux/gpio/consumer.h |   4 +
 include/linux/spi/spi.h       |   2 +
 6 files changed, 184 insertions(+), 1 deletion(-)

-- 
2.39.2


