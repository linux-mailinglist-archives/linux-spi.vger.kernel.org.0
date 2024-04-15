Return-Path: <linux-spi+bounces-2341-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F354A8A52B6
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB85286B03
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0974437;
	Mon, 15 Apr 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gQL9I3Sl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1EF1BF2A;
	Mon, 15 Apr 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190176; cv=none; b=WveaKsi8LacF0gkNqV07ylieyoKZD+rwSnWs3x00cJsFW30f0YzxOL8QjZ6Uo5hr/0k0bW4mXJ9uMzRrh0QnnevGqhc7wUovUiUmIdOyX5o6XSbPldHXTYPYi+Ox0obyHl8H0Qbron45dKR/Qq6Io23OqrbxDtPYwRrBEh0g0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190176; c=relaxed/simple;
	bh=1YRY54k3vyX1uzqTMx1L2E2ipg8FlVWxApQn9lv5kbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mzV1/4OlDanUtARm2JCb8xWQE/+IUFFrl3DrVKG94NeU/5XX/MJ2La2Hlg+7aPZGkD62r0xLWj+0mtc8Sy2IdjKoaG7DKDTSNQ2IpEK9PxJwyFmZhq+dsp+W6weYGPzCvoR4wiczbpXOBPfC9u5EB0aFTUFTX6us6vLtT0IsNUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gQL9I3Sl; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43F5UOmh015882;
	Mon, 15 Apr 2024 09:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=0
	kXxYAZuX27SLXTJi/54uAlRfhQwQpi4/hDZmGJ0H/w=; b=gQL9I3SlvkRs7l82y
	QU/MRRf1A56H+fyUikm6/Hegx2+ffeFR07DVMxaBBas0BA4t2sED8wm0JK22a83i
	iaxia2A43y4C68+6rfvRxozLURS4OT4uLw/CxJut0dnFkkZqYrII9hq0bR79+J9q
	sfyuFwgDCyT9vJdMjeYljqaIcMXilO4g2U94vWMNoSlyPUgZc5KfN9yVFp4lmi6B
	YFX3H6itnE32eb2e1F5tBf25qMv+oxuWrzLHQoHrmJrva2gxLl61yBU+2FLbuPRq
	onm4492qzcJsX38Vnw2uJMeH1qQCheD/jbUYXzuICi8aGTE7b4QT7SZxFb3KqfGp
	Xn15A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqey9hc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 09:09:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 15:09:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 15 Apr 2024 15:09:25 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 18FB1820244;
	Mon, 15 Apr 2024 14:09:25 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v6 0/4] Add bridged amplifiers to cs42l43
Date: Mon, 15 Apr 2024 15:09:21 +0100
Message-ID: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jYZ_kLGQTIm76R9H_dYwCde32KJayZU7
X-Proofpoint-ORIG-GUID: jYZ_kLGQTIm76R9H_dYwCde32KJayZU7
X-Proofpoint-Spam-Reason: safe

In some cs42l43 systems a couple of cs35l56 amplifiers are attached
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

Series changes since v5:
 - Add back help for GPIO_SWNODE_UNDEFINED
 - Correct some typos
 - Only check for undefined swnode if the Kconfig is set
 - Add a pr_fmt
 - Move swnode_gpio_undefined to include/linux/gpio/property.h
 - Remove includes of fwnode.h
 - Use %pwfP to get firmware node name
 - Remove NULL check on acpi_handle

Series changes since v4:
 - Remove extraneous fwnode_handle_puts in driver/spi/spi-cs42l43.c
 - Make Kconfig for swnode undef gpios not user visible
 - Add some missing headers
 - Add patch to update handling in spi_dev_set_name
 - Remove stray blank line
 - Use ACPI_HANDLE_FWNODE

Series changes since v3:
 - Add Kconfig to make swnode conditionally built
 - Add define for swnode name
 - Add custom init and exit calls to register swnode
 - Use export namespaces
 - Always name swnode SPI devices after the node name
 - Correct some header includes
 - Use HZ_PER_MHZ
 - Use some swnode helper macros
 - Use acpi_get_local_address
 - Correct some handle puts
 - Add some dev_err_probes

Series changes since v2:
 - Add missing fwnode_handle_puts in driver/spi/spi-cs423l43.c

Series changes since v1:
 - Add missing statics in driver/spi/spi-cs42l43.c


Charles Keepax (3):
  gpio: swnode: Add ability to specify native chip selects for SPI
  spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
  spi: Update swnode based SPI devices to use the fwnode name

Maciej Strozek (1):
  spi: cs42l43: Add bridged cs35l56 amplifiers

 drivers/gpio/Kconfig          |   9 +++
 drivers/gpio/gpiolib-swnode.c |  44 +++++++++++
 drivers/spi/Kconfig           |   1 +
 drivers/spi/spi-cs42l43.c     | 135 +++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c             |  12 ++-
 include/linux/gpio/property.h |   4 +
 6 files changed, 200 insertions(+), 5 deletions(-)

-- 
2.39.2


