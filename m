Return-Path: <linux-spi+bounces-2292-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA148A0BD8
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36516280A52
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A08142E65;
	Thu, 11 Apr 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ojbC6CIx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572613CF91;
	Thu, 11 Apr 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826401; cv=none; b=Uvy3D6Lx7tpc6S5RjrvKtyO1DjOcgfiB9d4wkDFaXNjuaMicjQuz/UINS8AWcBGbWCkZMClJiFmf0teB8zFwCy4eWjvgtYx5cIQrI/pZ6y9NEEtabjxZhKmxWtd0b8OYXqMhzA7pRdLkSMPUcrzkSfwJnOBpkDXwrHvMT6jcnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826401; c=relaxed/simple;
	bh=Dw4OiJySKJyi55x3c7YHB1abWRK7uxOPkFLeIeCWC1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qg2XOMpp6BA7naokex8VnPeHekU8a7gdl4KrjoBW01QOZ9T2fxxsFw+Qj4avE772nMXVcsOJz/mzeknSruGfVIG1xU2rsQQNKdk+4OwPqLbDbNnn6sgenQ8jtyWwCLMHMVcZJMgPF4xkainrfI+GWznyAK+sV1e/sBjD1eoBLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ojbC6CIx; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naFK004518;
	Thu, 11 Apr 2024 04:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=L
	pYSOT7i5AL8Na8w+Od+/QE7jZeltnffRlfPOlqLx6E=; b=ojbC6CIxhWalYpXMY
	0A3Q7We5bO1YPXwSREopQHNeaJ98/jDaq+yGf8QXilslgLrLaOp1nkiVz/xSbbG+
	oE/E7gbwwhfn0Jf1DV5ImINuZLzxMgQMPEhLRWeBDOaLgsqiFQBh7dMaVQg1u+4l
	4ttot5FmOX8fvQjaoim7coW/H7Wi3mFdV5q1y+Aauo8tyrAEugWhUod6VeoSJBjv
	HaFJtPeU1KMg/IaHmyb+Ru1eZlg4Deb7GYglAvJgiO8UVpX4lLGXvH+Rdi+npSiM
	NZhu2+ZW1O9N+ZJetIxgUi6nb2oH5u9e2IxesIPlahMt1W5ty2JEOGgXAPSF3OnR
	D6hiQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq0gx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 04:06:31 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 10:06:28 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 10:06:28 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6B6B6820243;
	Thu, 11 Apr 2024 09:06:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/4] Add bridged amplifiers to cs42l43
Date: Thu, 11 Apr 2024 10:06:24 +0100
Message-ID: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RuqMV_EM_wbH8HdoqjpApFZaHVksYb89
X-Proofpoint-GUID: RuqMV_EM_wbH8HdoqjpApFZaHVksYb89
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

Charles Keepax (2):
  gpio: swnode: Add ability to specify native chip selects for SPI
  spi: Add a mechanism to use the fwnode name for the SPI device

Maciej Strozek (1):
  spi: cs42l43: Add bridged cs35l56 amplifiers

Charles Keepax (3):
  gpio: swnode: Add ability to specify native chip selects for SPI
  spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
  spi: Update swnode based SPI devices to use the fwnode name

Maciej Strozek (1):
  spi: cs42l43: Add bridged cs35l56 amplifiers

 drivers/gpio/Kconfig          |   3 +
 drivers/gpio/gpiolib-swnode.c |  40 ++++++++++
 drivers/spi/Kconfig           |   1 +
 drivers/spi/spi-cs42l43.c     | 135 +++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c             |  13 +++-
 include/linux/gpio/consumer.h |   4 +
 6 files changed, 191 insertions(+), 5 deletions(-)

-- 
2.39.2


