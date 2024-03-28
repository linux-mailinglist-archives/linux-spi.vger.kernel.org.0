Return-Path: <linux-spi+bounces-2078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93776890105
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 15:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E726297E05
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764AB8175F;
	Thu, 28 Mar 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Kgmku+wv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F057FBA5;
	Thu, 28 Mar 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634496; cv=none; b=l53enwH3a6ZJ6oGaR+BRxZ9B+TQ7byg+MdIOZQoxJccohfOHB5MuGARXxvHGAKgqg8gso56qb4ABmden3Gr38lgsw5bwSgY11SntKLtaya0NZ/7ldidph2GAEdYLT3iokzN9xgW9dbD3k+8FfUGw6ff9xdzqx/leeEkO2oE+72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634496; c=relaxed/simple;
	bh=3CO+Rdww3PR4tvUhugl/CHCrWadekJJAz2/xlGGetNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLF5AE+2Wx4WgigLWhB9Yjk5m1KjD9RE81PD5mHr7FAqITIpcRRyJyNDmrIdbxkCg0AWJzYec4Lh0NPvGVK14DxnguJDJAHTzayvFUJ2/He8+uLpzlESMMp94MUmUkGCITQrQyyZ4Eh2bmmRuwEINZjeDe3pNn31+JKtzmAvOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Kgmku+wv; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SD0EVI012589;
	Thu, 28 Mar 2024 09:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=9
	OZupOELRT6j6HXIyL9ZzkIc7whnzSrnjmMQylLv5Jk=; b=Kgmku+wvx9dm39XEr
	fTC4afR2ITKX+fUUZua3fa8jen1b6HKiioMS5rzUY4deq22yO87+6czPSzxK35xQ
	Jz2EJK5ib1O7o/jMF4fGPGj+5vNmW1FLge/WCCG3ezHrSPwxCvHSRoa+CQcry994
	hcdK/ycCLIFNkTgOzSdO/SHWAVVoh9UbkdOUO5vi0B2a6PfadhSd0pg1ddbsjUQr
	vXjhtcsOjyKIttoJrG89oI5QErwN0myZAQZ0EfXTKNc1FhJhbz6XCytMSNCPFub9
	PoPBXXClRWdSYW8guvw/dMAi8OAaUdTQwcsRv7jowEJsSaiFYsQMRUmaorHF9tDG
	EeYCQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x4k7k2tjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:01:21 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 28 Mar
 2024 14:01:19 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 28 Mar 2024 14:01:19 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4F819820243;
	Thu, 28 Mar 2024 14:01:19 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/3] Add bridged amplifiers to cs42l43
Date: Thu, 28 Mar 2024 14:01:16 +0000
Message-ID: <20240328140119.1784350-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 86bYUVy9waQR-wQ7H6cK8jg2grov1jJl
X-Proofpoint-ORIG-GUID: 86bYUVy9waQR-wQ7H6cK8jg2grov1jJl
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

Series changes since v1:
 - Add missing statics in driver/spi/spi-cs42l43.c

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


