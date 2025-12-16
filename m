Return-Path: <linux-spi+bounces-11937-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B378CC1448
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 08:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20F9C3034135
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87133E349;
	Tue, 16 Dec 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hsEMRXEd"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684F33DEF7;
	Tue, 16 Dec 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869475; cv=none; b=SCNQrCjUG/XLMEwbTY8kCPWwvhIV1YRoFraovXDFTt6vP/Dhg5H87R2qZkGPM3wepcIt7jXGuTOXlI+UB4w9ug0ITlNBTVFqU/YdAzsOSdqdJ5YpsYbOltmLxvCuMe8/7XFSdtQ0gCbdnf6ip20uGi5QBmG8V0YuGJcgipCux+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869475; c=relaxed/simple;
	bh=XQy4TWjfNmtoZZIcqLmXVjX+tRvz4vSkRQZ+aofJ8Ro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3udsu0ms+GcjhijT6DH4l2JMvicKLgTamqq6GrgmJgHkik6eK/2jvM6RMjpb7JJLKTNS3SortmZxdpo6zjOLxmbwse77iRR4egH8QsTzj51/V/lJ0mNzHABpywcUVjD60IvOFct9GNmyVj9VtOBt6b3KFXUK1e6Oia5BDJi9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hsEMRXEd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BG7HLFR03480193, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765869441; bh=COjTHkGOHQwpngrKIj3D+ebT53bbr8374fx3+LVak/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=hsEMRXEdCvxZcZlxJbU8WYFzyAkoBRWrNs+rLtB5jOiDQttcWQV3J7r+Lhx6Zagt2
	 cfbLL+pY/Qwy/XCTzNgsAMwoJJUv4mw+97fHRyufl+7YhmGAa4GG7pHJAhGAiECLNW
	 B/yzGZe+v1X3t5qiQfsSOT/ELaDSaRvDCoGieG8m18c+HYUDeLTu7vl54c5tU8Rww2
	 rw1h2N494kSDof+3Maqeo6gUSNTvhF9U4VTAqGUS82Ev+kCBO96MBjGIoSJvSbo3m5
	 ebB740E1pmgQbavJ/BkV1u6jdLyNrL5GZhFRjRAw7ZobBW1KijPHc9y1z9y2npUnj4
	 a3HHUHKID+1oA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BG7HLFR03480193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 15:17:21 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 16 Dec 2025 15:17:22 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 16 Dec 2025 15:17:21 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 16 Dec 2025 15:17:21 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <perex@perex.cz>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <flove@realtek.com>,
        <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou
	<oder_chiou@realtek.com>
Subject: [PATCH v10 0/3] ASoC: rt5575: Add the codec driver for the ALC5575
Date: Tue, 16 Dec 2025 15:18:50 +0800
Message-ID: <20251216071853.3929135-1-oder_chiou@realtek.com>
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

Changes in v10:
- Patch 1/3:
  - export of_find_spi_controller_by_node()
- Patch 2/3:
  - remove realtek,rt5575-use-spi
  - add spi-parent for firmware-loading
- Patch 3/3:
  - use of_find_spi_controller_by_node() to get the SPI controller and add
    the spi device for firmware-loading

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

Oder Chiou (3):
  spi: export of_find_spi_controller_by_node()
  ASoC: dt-bindings: realtek,rt5575: add support for ALC5575
  ASoC: rt5575: Add the codec driver for the ALC5575

 .../bindings/sound/realtek,rt5575.yaml        |  61 +++
 drivers/spi/spi.c                             |   3 +-
 include/linux/spi/spi.h                       |  11 +
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   3 +
 sound/soc/codecs/rt5575-spi.c                 | 119 ++++++
 sound/soc/codecs/rt5575-spi.h                 |  26 ++
 sound/soc/codecs/rt5575.c                     | 359 ++++++++++++++++++
 sound/soc/codecs/rt5575.h                     |  54 +++
 9 files changed, 645 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5575.yaml
 create mode 100644 sound/soc/codecs/rt5575-spi.c
 create mode 100644 sound/soc/codecs/rt5575-spi.h
 create mode 100644 sound/soc/codecs/rt5575.c
 create mode 100644 sound/soc/codecs/rt5575.h

-- 
2.52.0


