Return-Path: <linux-spi+bounces-11939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AEFCC145A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D592B30424AC
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA8933EAE5;
	Tue, 16 Dec 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TghE9why"
X-Original-To: linux-spi@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385632D440;
	Tue, 16 Dec 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869478; cv=none; b=Z11eTAYtJn+FXeubdyaSaymcU5C3xX6l+RmJ1WN527mzndV/4KfcicPbuurnLk1GajCHT6xuB4R7sKcK/OPmql+kfF8T5zxHDv5P6Z9+LZN+K5yRmKHWYvM0Gv0l5rs5VASlvABStbXBJbuYvYYQNmsYHVjvxWhpmQx7fd0TnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869478; c=relaxed/simple;
	bh=O8uuOcCcTOOnS562ofTqipFHMwjpdk1VNBrk86HL3s8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UK30HJkqP0Sa9wGtsjiL9xmqQz+tcXtAgyz05RYdl1p9hVgSdIGcH//+wMJjTB4HPG8mbe9gtF27oWeL+S8FRZNvPYnxN4Ouh8OQyABfgCdOnBWiKfDit9QAW+XX/edDOHZgARG3/lnhJs+VzekHHzSh+Mtg4c9NLAA6MjVQiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TghE9why; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BG7HQ2k83480199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765869446; bh=ka1AWwWsUQG6PnR+WQFVxCdc8QZy25UOlvOyD07D2kE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TghE9why1TMVQiqZC19NmWybAWTWi05bqJAD+1f7THgMLgf+a1M8D9Uja+LgU4pjr
	 hdCUsbzH0i9Ua2wuVjiE41bCTlrDyIGYzK9ilORNxiJwtQBIQnvlBfmJ4P8+iQAvAc
	 6zyPKjlpMYLWnz774rNDy/WugTqGw8dxNTwudwm1LOza/ZuVhu0wGHK5b7G6LCJGB8
	 zBlssCy3ZMxlrSoZKWY9+8GKNQ2yDQpztvczePynFsgE5IsrCitiwlaCJFWV1AhKQJ
	 tzP7ybBi5NWS/3afXcYc1tosvK2LGZBz4opxLlvQySyfy36Qc6K4FSVFXOJJrQmx7o
	 vmKQesMlN75Fg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BG7HQ2k83480199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 15:17:26 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 16 Dec 2025 15:17:25 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 16 Dec 2025 15:17:22 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 16 Dec 2025 15:17:22 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <perex@perex.cz>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <flove@realtek.com>,
        <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou
	<oder_chiou@realtek.com>
Subject: [PATCH v10 3/3] ASoC: rt5575: Add the codec driver for the ALC5575
Date: Tue, 16 Dec 2025 15:18:53 +0800
Message-ID: <20251216071853.3929135-4-oder_chiou@realtek.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216071853.3929135-1-oder_chiou@realtek.com>
References: <20251216071853.3929135-1-oder_chiou@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The ALC5575 integrates an audio DSP that typically loads its firmware
from an external flash via its own SPI host interface. In certain
hardware configurations, the firmware can alternatively be loaded
through the SPI client interface. The driver provides basic mute and
volume control functions. When the SPI client interface is enabled,
firmware loading is handled by the SPI driver.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/Kconfig      |  10 +
 sound/soc/codecs/Makefile     |   3 +
 sound/soc/codecs/rt5575-spi.c | 119 +++++++++++
 sound/soc/codecs/rt5575-spi.h |  26 +++
 sound/soc/codecs/rt5575.c     | 359 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5575.h     |  54 +++++
 6 files changed, 571 insertions(+)
 create mode 100644 sound/soc/codecs/rt5575-spi.c
 create mode 100644 sound/soc/codecs/rt5575-spi.h
 create mode 100644 sound/soc/codecs/rt5575.c
 create mode 100644 sound/soc/codecs/rt5575.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061791e61907..14f3d09e7117 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -212,6 +212,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_RT1305
 	imply SND_SOC_RT1308
 	imply SND_SOC_RT5514
+	imply SND_SOC_RT5575
 	imply SND_SOC_RT5616
 	imply SND_SOC_RT5631
 	imply SND_SOC_RT5640
@@ -1783,6 +1784,15 @@ config SND_SOC_RT5514_SPI_BUILTIN
 	bool # force RT5514_SPI to be built-in to avoid link errors
 	default SND_SOC_RT5514=y && SND_SOC_RT5514_SPI=m
 
+config SND_SOC_RT5575
+	tristate "Realtek ALC5575 Codec - I2C"
+	depends on I2C
+
+config SND_SOC_RT5575_SPI
+	tristate "Realtek ALC5575 Codec - SPI"
+	depends on SPI_MASTER && I2C
+	depends on SND_SOC_RT5575
+
 config SND_SOC_RT5616
 	tristate "Realtek RT5616 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d687d4f74363..a6406bc907a9 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -253,6 +253,8 @@ snd-soc-rt286-y := rt286.o
 snd-soc-rt298-y := rt298.o
 snd-soc-rt5514-y := rt5514.o
 snd-soc-rt5514-spi-y := rt5514-spi.o
+snd-soc-rt5575-y := rt5575.o
+snd-soc-rt5575-$(CONFIG_SND_SOC_RT5575_SPI) += rt5575-spi.o
 snd-soc-rt5616-y := rt5616.o
 snd-soc-rt5631-y := rt5631.o
 snd-soc-rt5640-y := rt5640.o
@@ -686,6 +688,7 @@ obj-$(CONFIG_SND_SOC_RT298)	+= snd-soc-rt298.o
 obj-$(CONFIG_SND_SOC_RT5514)	+= snd-soc-rt5514.o
 obj-$(CONFIG_SND_SOC_RT5514_SPI)	+= snd-soc-rt5514-spi.o
 obj-$(CONFIG_SND_SOC_RT5514_SPI_BUILTIN)	+= snd-soc-rt5514-spi.o
+obj-$(CONFIG_SND_SOC_RT5575)	+= snd-soc-rt5575.o
 obj-$(CONFIG_SND_SOC_RT5616)	+= snd-soc-rt5616.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
diff --git a/sound/soc/codecs/rt5575-spi.c b/sound/soc/codecs/rt5575-spi.c
new file mode 100644
index 000000000000..c8eadb2f59a6
--- /dev/null
+++ b/sound/soc/codecs/rt5575-spi.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rt5575-spi.c  --  ALC5575 SPI driver
+ *
+ * Copyright(c) 2025 Realtek Semiconductor Corp.
+ *
+ */
+
+#include <linux/firmware.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+#include "rt5575-spi.h"
+
+#define RT5575_SPI_CMD_BURST_WRITE	5
+#define RT5575_SPI_BUF_LEN		240
+
+struct rt5575_spi_burst_write {
+	u8 cmd;
+	u32 addr;
+	u8 data[RT5575_SPI_BUF_LEN];
+	u8 dummy;
+} __packed;
+
+struct spi_device *rt5575_spi_get_device(struct device *dev)
+{
+	struct device_node *spi_np;
+	struct spi_controller *ctlr;
+	struct spi_device *spi;
+	u32 cs;
+
+	spi_np = of_parse_phandle(dev->of_node, "spi-parent", 0);
+	if (!spi_np) {
+		dev_err(dev, "Failed to get spi-parent phandle\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32_index(dev->of_node, "spi-parent", 1, &cs))
+		cs = 0;
+
+	if (cs >= ctlr->num_chipselect) {
+		dev_err(dev, "Chip select has wrong number %d\n", cs);
+		of_node_put(spi_np);
+		return NULL;
+	}
+
+	ctlr = of_find_spi_controller_by_node(spi_np);
+	of_node_put(spi_np);
+	if (!ctlr)
+		return NULL;
+
+	spi = spi_new_device(ctlr, &(struct spi_board_info){
+		.modalias = "rt5575",
+		.chip_select = cs,
+		.max_speed_hz = 10000000,
+	});
+
+	spi_controller_put(ctlr);
+	return spi;
+}
+
+/**
+ * rt5575_spi_burst_write - Write data to SPI by rt5575 address.
+ * @spi: SPI device.
+ * @addr: Start address.
+ * @txbuf: Data buffer for writing.
+ * @len: Data length.
+ *
+ */
+static int rt5575_spi_burst_write(struct spi_device *spi, u32 addr, const u8 *txbuf,
+						size_t len)
+{
+	struct rt5575_spi_burst_write buf = {
+		.cmd = RT5575_SPI_CMD_BURST_WRITE
+	};
+	unsigned int end, offset = 0;
+
+	while (offset < len) {
+		if (offset + RT5575_SPI_BUF_LEN <= len)
+			end = RT5575_SPI_BUF_LEN;
+		else
+			end = len % RT5575_SPI_BUF_LEN;
+
+		buf.addr = cpu_to_le32(addr + offset);
+		memcpy(&buf.data, &txbuf[offset], end);
+		spi_write(spi, &buf, sizeof(buf));
+
+		offset += RT5575_SPI_BUF_LEN;
+	}
+
+	return 0;
+}
+
+int rt5575_spi_fw_load(struct spi_device *spi)
+{
+	const struct firmware *firmware;
+	struct device *dev = &spi->dev;
+	static const char * const fw_path[] = {
+		"realtek/rt5575/rt5575_fw1.bin",
+		"realtek/rt5575/rt5575_fw2.bin",
+		"realtek/rt5575/rt5575_fw3.bin",
+		"realtek/rt5575/rt5575_fw4.bin"
+	};
+	static const u32 fw_addr[] = { 0x5f400000, 0x5f600000, 0x5f7fe000, 0x5f7ff000 };
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(fw_addr); i++) {
+		ret = request_firmware(&firmware, fw_path[i], dev);
+		if (!ret) {
+			rt5575_spi_burst_write(spi, fw_addr[i], firmware->data, firmware->size);
+			release_firmware(firmware);
+		} else {
+			dev_err(dev, "Request firmware failure: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/sound/soc/codecs/rt5575-spi.h b/sound/soc/codecs/rt5575-spi.h
new file mode 100644
index 000000000000..3b296bcac9a6
--- /dev/null
+++ b/sound/soc/codecs/rt5575-spi.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * rt5575-spi.h  --  ALC5575 SPI driver
+ *
+ * Copyright(c) 2025 Realtek Semiconductor Corp.
+ *
+ */
+
+#ifndef __RT5575_SPI_H__
+#define __RT5575_SPI_H__
+
+#if IS_ENABLED(CONFIG_SND_SOC_RT5575_SPI)
+struct spi_device *rt5575_spi_get_device(struct device *dev);
+int rt5575_spi_fw_load(struct spi_device *spi);
+#else
+static inline struct spi_device *rt5575_spi_get_device(struct device *dev)
+{
+	return NULL;
+}
+static inline int rt5575_spi_fw_load(struct spi_device *spi)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* __RT5575_SPI_H__ */
diff --git a/sound/soc/codecs/rt5575.c b/sound/soc/codecs/rt5575.c
new file mode 100644
index 000000000000..c3a9ba22a90d
--- /dev/null
+++ b/sound/soc/codecs/rt5575.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rt5575.c  --  ALC5575 ALSA SoC audio component driver
+ *
+ * Copyright(c) 2025 Realtek Semiconductor Corp.
+ *
+ */
+
+#include <linux/i2c.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "rt5575.h"
+#include "rt5575-spi.h"
+
+static bool rt5575_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RT5575_ID:
+	case RT5575_ID_1:
+	case RT5575_MIXL_VOL:
+	case RT5575_MIXR_VOL:
+	case RT5575_PROMPT_VOL:
+	case RT5575_SPK01_VOL:
+	case RT5575_SPK23_VOL:
+	case RT5575_MIC1_VOL:
+	case RT5575_MIC2_VOL:
+	case RT5575_WNC_CTRL:
+	case RT5575_MODE_CTRL:
+	case RT5575_I2S_RATE_CTRL:
+	case RT5575_SLEEP_CTRL:
+	case RT5575_ALG_BYPASS_CTRL:
+	case RT5575_PINMUX_CTRL_2:
+	case RT5575_GPIO_CTRL_1:
+	case RT5575_DSP_BUS_CTRL:
+	case RT5575_SW_INT:
+	case RT5575_DSP_BOOT_ERR:
+	case RT5575_DSP_READY:
+	case RT5575_DSP_CMD_ADDR:
+	case RT5575_EFUSE_DATA_2:
+	case RT5575_EFUSE_DATA_3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const DECLARE_TLV_DB_SCALE(ob_tlv, -9525, 75, 0);
+
+static const struct snd_kcontrol_new rt5575_snd_controls[] = {
+	SOC_DOUBLE("Speaker CH-01 Playback Switch", RT5575_SPK01_VOL, 31, 15, 1, 1),
+	SOC_DOUBLE_TLV("Speaker CH-01 Playback Volume", RT5575_SPK01_VOL, 17, 1, 167, 0, ob_tlv),
+	SOC_DOUBLE("Speaker CH-23 Playback Switch", RT5575_SPK23_VOL, 31, 15, 1, 1),
+	SOC_DOUBLE_TLV("Speaker CH-23 Playback Volume", RT5575_SPK23_VOL, 17, 1, 167, 0, ob_tlv),
+	SOC_DOUBLE("Mic1 Capture Switch", RT5575_MIC1_VOL, 31, 15, 1, 1),
+	SOC_DOUBLE_TLV("Mic1 Capture Volume", RT5575_MIC1_VOL, 17, 1, 167, 0, ob_tlv),
+	SOC_DOUBLE("Mic2 Capture Switch", RT5575_MIC2_VOL, 31, 15, 1, 1),
+	SOC_DOUBLE_TLV("Mic2 Capture Volume", RT5575_MIC2_VOL, 17, 1, 167, 0, ob_tlv),
+	SOC_DOUBLE_R("Mix Playback Switch", RT5575_MIXL_VOL, RT5575_MIXR_VOL, 31, 1, 1),
+	SOC_DOUBLE_R_TLV("Mix Playback Volume", RT5575_MIXL_VOL, RT5575_MIXR_VOL, 1, 127, 0,
+		ob_tlv),
+	SOC_DOUBLE("Prompt Playback Switch", RT5575_PROMPT_VOL, 31, 15, 1, 1),
+	SOC_DOUBLE_TLV("Prompt Playback Volume", RT5575_PROMPT_VOL, 17, 1, 167, 0, ob_tlv),
+};
+
+static const struct snd_soc_dapm_widget rt5575_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF2RX", "AIF2 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF2TX", "AIF2 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF3RX", "AIF3 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF3TX", "AIF3 Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF4RX", "AIF4 Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF4TX", "AIF4 Capture", 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_INPUT("INPUT"),
+	SND_SOC_DAPM_OUTPUT("OUTPUT"),
+};
+
+static const struct snd_soc_dapm_route rt5575_dapm_routes[] = {
+	{ "AIF1TX", NULL, "INPUT" },
+	{ "AIF2TX", NULL, "INPUT" },
+	{ "AIF3TX", NULL, "INPUT" },
+	{ "AIF4TX", NULL, "INPUT" },
+	{ "OUTPUT", NULL, "AIF1RX" },
+	{ "OUTPUT", NULL, "AIF2RX" },
+	{ "OUTPUT", NULL, "AIF3RX" },
+	{ "OUTPUT", NULL, "AIF4RX" },
+};
+
+static long long rt5575_get_priv_id(struct rt5575_priv *rt5575)
+{
+	int priv_id_low, priv_id_high;
+
+	regmap_write(rt5575->regmap, RT5575_EFUSE_PID, 0xa0000000);
+	regmap_read(rt5575->regmap, RT5575_EFUSE_DATA_2, &priv_id_low);
+	regmap_read(rt5575->regmap, RT5575_EFUSE_DATA_3, &priv_id_high);
+	regmap_write(rt5575->regmap, RT5575_EFUSE_PID, 0);
+
+	return ((long long)priv_id_high << 32) | (long long)priv_id_low;
+}
+
+static int rt5575_probe(struct snd_soc_component *component)
+{
+	struct rt5575_priv *rt5575 = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+
+	rt5575->component = component;
+
+	dev_info(dev, "Private ID: %llx\n", rt5575_get_priv_id(rt5575));
+
+	return 0;
+}
+
+#define RT5575_STEREO_RATES SNDRV_PCM_RATE_8000_192000
+#define RT5575_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8 | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver rt5575_dai[] = {
+	{
+		.name = "rt5575-aif1",
+		.id = RT5575_AIF1,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = RT5575_STEREO_RATES,
+			.formats = RT5575_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = RT5575_STEREO_RATES,
+			.formats = RT5575_FORMATS,
+		},
+	},
+	{
+		.name = "rt5575-aif2",
+		.id = RT5575_AIF2,
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = RT5575_STEREO_RATES,
+			.formats = RT5575_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF2 Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = RT5575_STEREO_RATES,
+			.formats = RT5575_FORMATS,
+		},
+	},
+	{
+		.name = "rt5575-aif3",
+		.id = RT5575_AIF3,
+		.playback = {
+			.stream_name = "AIF3 Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = RT5575_STEREO_RATES,
+			.formats = RT5575_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF3 Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = RT5575_STEREO_RATES,
+			.formats = RT5575_FORMATS,
+		},
+	},
+	{
+		.name = "rt5575-aif4",
+		.id = RT5575_AIF4,
+		.playback = {
+			.stream_name = "AIF4 Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = RT5575_STEREO_RATES,
+			.formats = RT5575_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF4 Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = RT5575_STEREO_RATES,
+			.formats = RT5575_FORMATS,
+		},
+	},
+};
+
+static const struct snd_soc_component_driver rt5575_soc_component_dev = {
+	.probe = rt5575_probe,
+	.controls = rt5575_snd_controls,
+	.num_controls = ARRAY_SIZE(rt5575_snd_controls),
+	.dapm_widgets = rt5575_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt5575_dapm_widgets),
+	.dapm_routes = rt5575_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt5575_dapm_routes),
+	.use_pmdown_time = 1,
+	.endianness = 1,
+};
+
+static const struct regmap_config rt5575_dsp_regmap = {
+	.name = "dsp",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 2,
+};
+
+static int rt5575_i2c_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct i2c_client *client = context;
+	struct rt5575_priv *rt5575 = i2c_get_clientdata(client);
+
+	regmap_read(rt5575->dsp_regmap, reg | RT5575_DSP_MAPPING, val);
+
+	return 0;
+}
+
+static int rt5575_i2c_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct i2c_client *client = context;
+	struct rt5575_priv *rt5575 = i2c_get_clientdata(client);
+
+	regmap_write(rt5575->dsp_regmap, reg | RT5575_DSP_MAPPING, val);
+
+	return 0;
+}
+
+static const struct regmap_config rt5575_regmap = {
+	.reg_bits = 16,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0xfffc,
+	.readable_reg = rt5575_readable_register,
+	.reg_read = rt5575_i2c_read,
+	.reg_write = rt5575_i2c_write,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static int rt5575_fw_load_by_spi(struct rt5575_priv *rt5575)
+{
+	struct i2c_client *i2c = rt5575->i2c;
+	struct spi_device *spi;
+	struct device *dev = &i2c->dev;
+	int ret;
+
+	spi = rt5575_spi_get_device(dev);
+	if (!spi) {
+		dev_warn(dev, "The spi-parent not described in the DTS\n"
+			      "The hardware configuration should be with built-in flash\n");
+
+		if (!IS_ENABLED(CONFIG_SND_SOC_RT5575_SPI))
+			dev_warn(dev, "If the spi-parent is set in the DTS and it is without built-in flash\n"
+				      "Please enable CONFIG_SND_SOC_RT5575_SPI\n");
+
+		return -ENXIO;
+	}
+
+	regmap_write(rt5575->dsp_regmap, 0xfafafafa, 0x00000004);
+	regmap_write(rt5575->dsp_regmap, 0x18008064, 0x00000000);
+	regmap_write(rt5575->dsp_regmap, 0x18008068, 0x0002ffff);
+
+	ret = rt5575_spi_fw_load(spi);
+	if (ret) {
+		dev_err(dev, "Load firmware failure: %d\n", ret);
+		return -ENODEV;
+	}
+
+	regmap_write(rt5575->dsp_regmap, 0x18000000, 0x00000000);
+	regmap_update_bits(rt5575->regmap, RT5575_SW_INT, 1, 1);
+
+	regmap_read_poll_timeout(rt5575->regmap, RT5575_SW_INT, ret, !ret, 100000, 10000000);
+	if (ret) {
+		dev_err(dev, "Run firmware failure: %d\n", ret);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int rt5575_i2c_probe(struct i2c_client *i2c)
+{
+	struct rt5575_priv *rt5575;
+	struct device *dev = &i2c->dev;
+	int ret, val;
+
+	rt5575 = devm_kzalloc(dev, sizeof(struct rt5575_priv), GFP_KERNEL);
+	if (!rt5575)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, rt5575);
+
+	rt5575->i2c = i2c;
+
+	rt5575->dsp_regmap = devm_regmap_init_i2c(i2c, &rt5575_dsp_regmap);
+	if (IS_ERR(rt5575->dsp_regmap)) {
+		ret = PTR_ERR(rt5575->dsp_regmap);
+		dev_err(dev, "Failed to allocate DSP register map: %d\n", ret);
+		return ret;
+	}
+
+	rt5575->regmap = devm_regmap_init(dev, NULL, i2c, &rt5575_regmap);
+	if (IS_ERR(rt5575->regmap)) {
+		ret = PTR_ERR(rt5575->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	regmap_read(rt5575->regmap, RT5575_ID, &val);
+	if (val != RT5575_DEVICE_ID) {
+		dev_err(dev, "Device with ID register %08x is not rt5575\n", val);
+		return -ENODEV;
+	}
+
+	regmap_read(rt5575->regmap, RT5575_ID_1, &val);
+	if (!val) {
+		dev_err(dev, "This is not formal version\n");
+		return -ENODEV;
+	}
+
+	if (rt5575_fw_load_by_spi(rt5575) == -ENODEV)
+		return -ENODEV;
+
+	return devm_snd_soc_register_component(dev, &rt5575_soc_component_dev, rt5575_dai,
+						ARRAY_SIZE(rt5575_dai));
+}
+
+static const struct i2c_device_id rt5575_i2c_id[] = {
+	{ "rt5575" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rt5575_i2c_id);
+
+static const struct of_device_id rt5575_of_match[] = {
+	{ .compatible = "realtek,rt5575" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5575_of_match);
+
+static struct i2c_driver rt5575_i2c_driver = {
+	.driver = {
+		.name = "rt5575",
+		.owner = THIS_MODULE,
+		.of_match_table = rt5575_of_match,
+	},
+	.probe = rt5575_i2c_probe,
+	.id_table = rt5575_i2c_id,
+};
+module_i2c_driver(rt5575_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC ALC5575 driver");
+MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/rt5575.h b/sound/soc/codecs/rt5575.h
new file mode 100644
index 000000000000..11149612274a
--- /dev/null
+++ b/sound/soc/codecs/rt5575.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * rt5575.h  --  ALC5575 ALSA SoC audio driver
+ *
+ * Copyright(c) 2025 Realtek Semiconductor Corp.
+ *
+ */
+
+#ifndef __RT5575_H__
+#define __RT5575_H__
+
+#define RT5575_DEVICE_ID	0x10ec5575
+#define RT5575_DSP_MAPPING	0x18000000
+
+#define RT5575_ID		0x8008
+#define RT5575_ID_1		0x800c
+#define RT5575_MIXL_VOL		0x8a14
+#define RT5575_MIXR_VOL		0x8a18
+#define RT5575_PROMPT_VOL	0x8a84
+#define RT5575_SPK01_VOL	0x8a88
+#define RT5575_SPK23_VOL	0x8a8c
+#define RT5575_MIC1_VOL		0x8a98
+#define RT5575_MIC2_VOL		0x8a9c
+#define RT5575_WNC_CTRL		0x80ec
+#define RT5575_MODE_CTRL	0x80f0
+#define RT5575_I2S_RATE_CTRL	0x80f4
+#define RT5575_SLEEP_CTRL	0x80f8
+#define RT5575_ALG_BYPASS_CTRL	0x80fc
+#define RT5575_PINMUX_CTRL_2	0x81a4
+#define RT5575_GPIO_CTRL_1	0x8208
+#define RT5575_DSP_BUS_CTRL	0x880c
+#define RT5575_SW_INT		0x0018
+#define RT5575_DSP_BOOT_ERR	0x8e14
+#define RT5575_DSP_READY	0x8e24
+#define RT5575_DSP_CMD_ADDR	0x8e28
+#define RT5575_EFUSE_DATA_2	0xc638
+#define RT5575_EFUSE_DATA_3	0xc63c
+#define RT5575_EFUSE_PID	0xc660
+
+enum {
+	RT5575_AIF1,
+	RT5575_AIF2,
+	RT5575_AIF3,
+	RT5575_AIF4,
+	RT5575_AIFS,
+};
+
+struct rt5575_priv {
+	struct i2c_client *i2c;
+	struct snd_soc_component *component;
+	struct regmap *dsp_regmap, *regmap;
+};
+
+#endif /* __RT5575_H__ */
-- 
2.52.0


