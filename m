Return-Path: <linux-spi+bounces-2362-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565F8A67CF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 12:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7CC1F2235F
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B0F1272A5;
	Tue, 16 Apr 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HAfIw/a7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8386657;
	Tue, 16 Apr 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262158; cv=none; b=P7s5jnJW2rEvPzt7KCoGBv1/zotFbrgwzqYHt0JwAD9EP9PT5sW0riewQfcBGfEmhepb1dLBcvmeG/wF4iBWA8JO//8FbdXD0EjAvW/tF5P5g/BHX1O84mWEinu1vUPsToiL5Bs1K8NHkkt5Gr5P5j/WifiZQAPi7av2Pe0FfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262158; c=relaxed/simple;
	bh=cJ9HAUcK8jzuUWxPM9Et5rZDab23wE3Xqh3xVQvyhpI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hRnorBNsrG8rgNFIsMLMCs79JIPNo0PN++hxJj+7yoIG4Bz+fAjLGYYtwTIhtfYksGQVBnUMWYsZ79beHVspjHCwpNnGBaOACLgKC3wHJvRHXLsfJL7Y+5Z6r2xsNIJ880DqqFfZbcZtrIRtgtH1OgTANu+BNzAMdM9++bQsMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HAfIw/a7; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43G2gOLt020556;
	Tue, 16 Apr 2024 05:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=r
	grXXPz7DqwicyPoJeP/WyIk9jHaj85Wn03JT81BbzU=; b=HAfIw/a7aMNkMQq/B
	WrToTGUEXNxg7x1f/fXBtdtNTIknZdgo69PNC2M4Ebdl6Yffdrkjor9LrigXls9y
	dkAJdQVz7wNa8DNoN36HMkatH6XaRWPtnOESaMCPvQARicCfaCGHGxOLyXiQAkPM
	bBpeL+r68Gp8Y9PL44wBtIhk8AvyfG7G4rbVOUyN/ZbKFOqUq5AarZ44+Y8CHN/V
	2QnO0O+W9Rg6SdQNsFnVeSWgeYVv3zMuqwF4LuWRDywi/28Ui0WITHRj/PlbPYtK
	8isFeLopUUipqOWK08dyBodmLdCfqsSFmUKUkGTm4dmc9BmjX78VGogm9C9Gjb9Q
	gq2uw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeyac9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:09:07 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 11:09:04 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 16 Apr 2024 11:09:04 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CB41E820244;
	Tue, 16 Apr 2024 10:09:04 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v7 0/4] Add bridged amplifiers to cs42l43
Date: Tue, 16 Apr 2024 11:09:00 +0100
Message-ID: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qT8ksjuLQ9QbWekC8oYHGwY_Bm_ZP6iU
X-Proofpoint-ORIG-GUID: qT8ksjuLQ9QbWekC8oYHGwY_Bm_ZP6iU
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

Series changes since v6:
 - Use devm_add_action to free swnode

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
 drivers/gpio/gpiolib-swnode.c |  44 ++++++++++++
 drivers/spi/Kconfig           |   1 +
 drivers/spi/spi-cs42l43.c     | 123 ++++++++++++++++++++++++++++++++--
 drivers/spi/spi.c             |  12 +++-
 include/linux/gpio/property.h |   4 ++
 6 files changed, 186 insertions(+), 7 deletions(-)

-- 
2.39.2


