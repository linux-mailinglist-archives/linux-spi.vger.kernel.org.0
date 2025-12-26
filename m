Return-Path: <linux-spi+bounces-12142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC48CDE81D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 09:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E582300796F
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7FA314D1F;
	Fri, 26 Dec 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cNoleGhv"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE23148C3;
	Fri, 26 Dec 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766738279; cv=none; b=Y8HzDDEUCuGC9HYIBQfVXjKMw1PKM3HdMm6RWffuY4evI5+IIV/e15/vrIjIbFsDCJMIQklYv2VBdCfCjKA5AW9Hlm9+lne+rrF0HbvucBnGhWK87h+YRDmUp6h2Rov8qb3ADatShoeLI2WLjMxQPO1fSVlKfhFmXPDi13OMLUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766738279; c=relaxed/simple;
	bh=50qYJ2DZ96TiSEEgFQEJGsQA5DUBzpAAjzlrDEelmgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H7OnMH5wG31PtyEP7QcIeHmuvJNyMCKpM6ystIbkLWElaELXxNefHzLrsr99YLlPSsyF7qw7LpGa7yrmmiubA3jg9D1cYNMeXrwobvAAYOgWEDnLb/jcPy/8K4fAgtk86rWM5c4PCQWunjfsU4K/Grqzz1lKFPBR8M/1pRb/VVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cNoleGhv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ8bXK913311934, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766738253; bh=/YCmdqLFVOU0Zv6DNVRLclyXRlZ/6iZL3but2jGhJRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=cNoleGhvw5b0+qXe2kPiTF31q2V8mJ9l9/lWHcToptkBZsQXthOctDN4hPki7bKYg
	 dUwG9Uq0HzAUErup1tzfpM19Li0SWy+kn3ycC4u3WQX9sNo683VImm/kjisHPPZu0+
	 KBqZ11QGX8g2X0+hPqFDOfswfgo9O4tVu/5UyAk3Plck0neTh6Xb8PhEabcogOTKal
	 G9TshQHRUacJ3jFYzBKBAZpJ+geDybmy32Rpuou9VHbz8Yx8lgUHUwxVrjhqzcIYOo
	 ZP9vL2K7xJi/CP1JjKRPQ59cedDP+bdpGW2DqtK+wLHFktZSjJY5ZZHIwv/Fw4WFTg
	 K35bpjfIWEUEw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ8bXK913311934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 16:37:33 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:37:33 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Dec 2025 16:37:33 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <perex@perex.cz>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <flove@realtek.com>,
        <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou
	<oder_chiou@realtek.com>
Subject: [PATCH v11 0/4] ASoC: rt5575: Add the codec driver for the ALC5575
Date: Fri, 26 Dec 2025 16:38:56 +0800
Message-ID: <20251226083856.1052608-1-oder_chiou@realtek.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi all,

This patch series adds support for the Realtek ALC5575 audio codec.

Changes in v11:
- Patch 1/4:
  - minor fixes
- Patch 2/4:
  - change of_find_spi_controller_by_node() gating to CONFIG_OF
- Patch 3/4:
  - nothing
- Patch 4/4:
  - achieve reverse-christmas-tree notation
  - remove formal version check
  - revise check whether the firmware boots from SPI or not
  - minor fixes

Changes in v10:
- Patch 1/3:
  - export of_find_spi_controller_by_node()
- Patch 2/3:
  - remove realtek,rt5575-use-spi
  - add spi-parent for firmware-loading
- Patch 3/3:
  - use of_find_spi_controller_by_node() to get the SPI controller and add
    the spi device for firmware-loading
- Link to v10: https://lore.kernel.org/all/20251216071853.3929135-1-oder_chiou@realtek.com/

Changes in v9:
- Patch 1/2:
  - modify the comment
  - change the compatible name to "realtek,rt5575-use-spi"
- Patch 2/2:
  - remove the standalone rt5575_spi_driver module and integrate its
    functionality into the I2C driver
  - move the SPI firmware-loading function to rt5575-spi.c
  - use the match data to distinguish between w/wo flash
  - minor fixes
- Link to v9: https://lore.kernel.org/all/20251211110130.2925541-1-oder_chiou@realtek.com/

Changes in v8:
- Patch 1/2:
  - remove the variable rt5575_spi_ready
  - use the multiple compatible names to distinguish between w/wo flash
- Patch 2/2:
  - add compatible enum "realtek,rt5575-with-spi"
- Link to v8: https://lore.kernel.org/all/20251201105926.1714341-1-oder_chiou@realtek.com/

Changes in v7:
- Patch 1/2:
  - add a caption for the tristates
  - remove the redundant enum of the SPI command
  - add the error log in the request firmware failure
  - change the function name rt5575_spi_fw_loaded to rt5575_fw_load_by_spi
  - minor fixes
- Patch 2/2:
  - modify commit message
- Link to v7: https://lore.kernel.org/all/20251121084112.743518-1-oder_chiou@realtek.com/

Changes in v6:
- Patch 1/2:
  - modify commit message
  - add select SND_SOC_RT5575 to config SND_SOC_RT5575_SPI in the Kconfig
  - revise the boiler plate in the head of the file
  - sort the include files
  - use a structure to transfer the spi data
  - use the poll() related function instead the for-loop
  - revise the UUID to the private ID
  - minor fixes
- Patch 2/2:
  - modify description
- Link to v6: https://lore.kernel.org/all/20251031073245.3629060-1-oder_chiou@realtek.com/

Changes in v2 to v5:
- Patch 1/2:
  - move the firmware to the subdirectory
  - remove the empty functions
  - remove the cache_type in the regmap_config
  - add the error log in the run firmware failure
- Patch 2/2:
  - nothing
- Link to v5: https://lore.kernel.org/all/20251015103404.3075684-1-oder_chiou@realtek.com/

Oder Chiou (4):
  spi: export of_find_spi_controller_by_node()
  spi: change of_find_spi_controller_by_node() gating to CONFIG_OF
  ASoC: dt-bindings: realtek,rt5575: add support for ALC5575
  ASoC: rt5575: Add the codec driver for the ALC5575

 .../bindings/sound/realtek,rt5575.yaml        |  61 +++
 drivers/spi/spi.c                             |  23 +-
 include/linux/spi/spi.h                       |   9 +
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   3 +
 sound/soc/codecs/rt5575-spi.c                 | 118 ++++++
 sound/soc/codecs/rt5575-spi.h                 |  27 ++
 sound/soc/codecs/rt5575.c                     | 352 ++++++++++++++++++
 sound/soc/codecs/rt5575.h                     |  58 +++
 9 files changed, 651 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5575.yaml
 create mode 100644 sound/soc/codecs/rt5575-spi.c
 create mode 100644 sound/soc/codecs/rt5575-spi.h
 create mode 100644 sound/soc/codecs/rt5575.c
 create mode 100644 sound/soc/codecs/rt5575.h

-- 
2.52.0


