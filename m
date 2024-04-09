Return-Path: <linux-spi+bounces-2247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B189DA02
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046921F229CA
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB68287F;
	Tue,  9 Apr 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="k47aHYb/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604F12F583;
	Tue,  9 Apr 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668906; cv=none; b=ERzuZlU65yCWMIF813RxhHhaay27NUeleNUA8aUw/uvMw3XQQ/RxH3UHdIy+2+cdAEk8VqgVWbmgue1o4+dQungrGOcRxJPMzm9J6Rs/LUT00aqagIC8pNaRVrAiYCA81CL7UeAb0Wdqx2kb48Q38/QVpD0JhZLmogH2vhCHI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668906; c=relaxed/simple;
	bh=CW0bUoT91C+OeS4fWfs9Zf2yKy/etG27Os3gDIXkWwM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MQ5cwkZuiOKBpKugwLMQ6b8mEFHhwuj0VSieXROLQXlJZpaYLyhUx/VEwcqqVxnE3SQ/SkchCcIwaVBexRqk76jqkzzgcRdGwlApT67uoXZzfgBt7V4ucacGOUHeQUltw0loZ98e4SPzJSzHn3wobJcaBHGJBSy0T6KxD2AETpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=k47aHYb/; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43961qne028753;
	Tue, 9 Apr 2024 08:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=9
	B6Yj62AqiPbBiYEjnlqHocokHAxYIlAj/0KAIUQZPQ=; b=k47aHYb/QEt2VwAWb
	ol1V5fH1hp0mdXSNnJlqFzDFPj00Xw880wSCEbcpmXOpIjxr0O5c741jVFqe8tca
	mu3g/ra+qMfWCnANerpJxK3kE6aZ4HGADBzY5jpTIxPCWcxlTzgvhFevE5IVlxXu
	XDLlwRqgRysJqEEFpdquu22BYdYr1XHq1vadlDpRtuvYmvCWdus6rOAo0toaZ7oB
	ez85sXZhagScoCOjrFJsxTi3BcqoebOgJXst+cZQRCih4KHjL3IcDFv8Xjy+KSAU
	ilaPAAhji/huWU32HLEcmAafgVqvbg5ksb2cCRbuoTYafBco9XbKeJWdJV+YVQjX
	tTzbQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjjvq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 08:21:27 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 14:21:26 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 9 Apr 2024 14:21:26 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2616A82026C;
	Tue,  9 Apr 2024 13:21:26 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/3] Add bridged amplifiers to cs42l43
Date: Tue, 9 Apr 2024 14:21:23 +0100
Message-ID: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q65mljCcFTYMm3oVy_LrC9FRUcpqu8ti
X-Proofpoint-GUID: Q65mljCcFTYMm3oVy_LrC9FRUcpqu8ti
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

 drivers/gpio/Kconfig          |   9 +++
 drivers/gpio/gpiolib-swnode.c |  38 ++++++++++
 drivers/spi/Kconfig           |   1 +
 drivers/spi/spi-cs42l43.c     | 139 +++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c             |   6 ++
 include/linux/gpio/consumer.h |   4 +
 6 files changed, 195 insertions(+), 2 deletions(-)

-- 
2.39.2


