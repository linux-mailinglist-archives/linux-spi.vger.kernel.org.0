Return-Path: <linux-spi+bounces-12138-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89134CDE7DA
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 09:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91380300B98D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Dec 2025 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C6316188;
	Fri, 26 Dec 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R33qWfpQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC15314D28;
	Fri, 26 Dec 2025 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766737805; cv=none; b=GOSyoyti0vpZglf+Jc4RakchVG2N/xZmt7Zhya/v0QduLC7SwT6kKKZE/uZi+6QbQmF39wSJWSmVWL4JIDpCHQwDL/dL0wXnO3ctjo4pCn9i+XQNDfKAX392rUJnLlo8va/LSpGdgrU33IlVCoP6kmCjlnYoyQX7/+WoGg2fGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766737805; c=relaxed/simple;
	bh=50qYJ2DZ96TiSEEgFQEJGsQA5DUBzpAAjzlrDEelmgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WS8paXsYotfwgs7yWiBKh/TJvzjtqG65PEWIDxPWjJMS8o1ad5CHzTjX40L30mg1aCmJg/stpD7pxAc6GH977AVZc8NTTByhIxELrQoJA02ob6fSWn1AgA2aQp4tmjrsEKrCXfL2CqQH34W0Mip2SGzxmEQYR1vNOhq6bEHAAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R33qWfpQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ8TLtN43288529, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766737761; bh=/YCmdqLFVOU0Zv6DNVRLclyXRlZ/6iZL3but2jGhJRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=R33qWfpQqxycHJ0/c9ZSc/Xsb8yZ3G2kPzYydqhK7L9baoeZrXInQwJCwW3+SKvhh
	 U9npH1VI772x4HAa9icmYMthPIcLraNJy4TP6mC1IA7fDBxzaP/2A82scwHeBLWLEM
	 j6jqekONumrPQrCQ7rOifE/2sgVQVuxX9rqm6Rb3iixu75uL1mq6hBKM+FB2ucrv8p
	 akWyS+gFPLPpNIsmVAV8XERXjspupm+xQvfkMFpb/hNvvZxJJY+uRKUruk052inTV7
	 hlg2TToUpgc3yDCf/C5H08x1zqsnOa+ot3SuCRXhp4TrlhzL+9bX8RuDPdBetJDhnO
	 clYRHFPSdI+2Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ8TLtN43288529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 16:29:21 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:29:21 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 16:29:21 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Dec 2025 16:29:20 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <perex@perex.cz>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <flove@realtek.com>,
        <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou
	<oder_chiou@realtek.com>
Subject: [PATCH 0/4] ASoC: rt5575: Add the codec driver for the ALC5575
Date: Fri, 26 Dec 2025 16:30:15 +0800
Message-ID: <20251226083015.1052120-1-oder_chiou@realtek.com>
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


