Return-Path: <linux-spi+bounces-11446-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1462C769F5
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 00:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 916D72D844
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 23:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAAF2C3244;
	Thu, 20 Nov 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJfPo9i1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33431078B
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681412; cv=none; b=pcQXIgt86eIkug+7GMiVwCCulZyGeoObcQqn5v9Zwdkrl2Dv7Z4OQ1BCPg6GgqaDSBI8ea2Qv5aeWsG3Afoxj/YneRFNdyqWMd0SBC/LZLIYt+Omjp06TPW6liPulG+wCOmkE8UL7sxIeKjfmb6coWUzoZW44OwhPVeY8yqrThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681412; c=relaxed/simple;
	bh=7wsmpjx6s6TBK9AoAmTxYPcJ8LZdZSn+e23h8XqJ5u8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4izeSUWJjo1k/fjSFvoN6r2F8BiCpo2ZUmH8rxgApcQCtlDggZ144EUDgHLl+kVuzHX/oO6kdIX5LyACAOpYyKPW1v+4q/RBsndC98u2PNP6Kn35y450trmMIxxa5BseLsuvsygCsHjB2zCjezKIVhnnDg72DHTkbwMV5f+Fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJfPo9i1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso1201088f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763681405; x=1764286205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLJaX+QUmhNLvAV4eaLeTz4ZDTiiOclrraS0tnG0pXA=;
        b=DJfPo9i1wKTTRMFBIw23z9kBwi6JX4AcLhEj0OHcFtEoir3H8AuRbAdpkcrqW88twX
         lIl08GM2Gyl3hTSGdhvChQ0XjA9ih9YZ5a0UJjCM9rzBiL+mi9P+4glMo6jrjXfKTOfh
         QFnQZHjpyzW/nQa7ox8kao6k1umrDxOYiuJaMUfY3hp73rkuBo8QOcON2YOUZt5j1iM4
         pNkWr1zXz0uUNEpC2cWksEvEggyV7nxNl0HyIOhu0Ebj8g67ZuTG9cTeA2mG7NUzZN1/
         3hqTRefrSIwbTYAuE0iNxzwivEkG3SmpH5kifUY0PdWahV3tNgXiXlsDDPMmg8HENsHy
         GFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763681405; x=1764286205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VLJaX+QUmhNLvAV4eaLeTz4ZDTiiOclrraS0tnG0pXA=;
        b=BH3mIVEKQd8MOP2Jz2z75pI9NJOMv6QTp7QHEGKdakMNG9VGyiWzcB852Vt1WhNq8p
         M8hpw0SwPcqK3f4ftR1+yQ6uOpYHF0mxLbP1efRlvziaMuuvJE/jrWk2XuoqoTcrXXYh
         PT8OGiW/lKrfHXhVqTvtL9pKw6KQ0NTHegCphOtg1Y7Vaz3F0kp48qzWGDKJqTcZ31Tl
         ioPJiZGRE0mPgensfDhj1kmUE0k1K5tQ2L51GikbR2uHjYG8eixhHkXkWism0JOUJaAO
         oI5kDIFKr0BHQtxCgLKYu5cfTCN1ltgPvypWQe0ppRSlIHMcD6k2neMqidtZAb+lnExv
         GcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNld57IAE1MM0lEqXfHTpvcU7aJdgYVXGjNvWHEfXJ2PBgh2WgCBjpQ1TJR7dejnr30WTjcz2CThk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfl0I19fdA1NA4hRynftrpOd19omFu23U3nGYSxkn9t8F0IHKO
	PLQMwWWikSGQpSyY9g+7KpqwPNs8RbF7pHPM90HKFytaU3GWF9s/1RNQ
X-Gm-Gg: ASbGnct7TTZY5RbPaL8uAzg2bt1sZxfrEhYR/imqlKRYMnWk7mTL7c/415+HTA0zNTV
	DRaO+CEmZhsSjgxhEGbthemRGJCheeMoR8ruweMuu/SyduKjGLTNz0IoMB5hK/dneBaCQ65YWyl
	+8WaILdvpxOevdPJvfWrxEzfd8x74npa0Tt85YzQCxatJNtaMrk999uBSJbfNVGAFBsy0FsQcpK
	KGdnnul70XBqcMBmkVd/k/yjuOPOG/d08DYS+kclEDgXYOx7suxHHS2pSl3dxMHsP37DlKCb3oj
	2jz30+/KOb/iO3KfRH3a/659mcjZZsfDZ79tDv2mibhz44jiBylqvBQpJh4ez499+c+qFMTCQ20
	8TbtfPsdBwHCK6bmomQdCmvl+EvKZ2RuDZHevYlhIkRAQeWWZkRALDTc01IdVjuk4wZHtsxqV33
	Xu+vyRmYLhxtz3z4x6RKef6naUazlSi5RHpeY2aA6n
X-Google-Smtp-Source: AGHT+IHNzdSJTh6e0tWlW6qm0Vl63uiOZflNzJ1LboNvnKaccFAzBnOoa/f1csUbyeTeL+a4KPwcOg==
X-Received: by 2002:a5d:588c:0:b0:42b:3131:5438 with SMTP id ffacd0b85a97d-42cc1d22f29mr99058f8f.54.1763681404816;
        Thu, 20 Nov 2025 15:30:04 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm7776315f8f.36.2025.11.20.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:30:04 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cyril Chao <Cyril.Chao@mediatek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] ASoC: airoha: Add AFE and machine driver for Airoha AN7581
Date: Fri, 21 Nov 2025 00:29:12 +0100
Message-ID: <20251120232913.32532-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120232913.32532-1-ansuelsmth@gmail.com>
References: <20251120232913.32532-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Sound system present on Airoha AN7581 SoC. This is
based on the mediatek AFE drivers.

Also add the machine driver to create an actual sound card for the AFE.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                                   |  10 +-
 sound/soc/mediatek/Kconfig                    |  20 +
 sound/soc/mediatek/Makefile                   |   1 +
 sound/soc/mediatek/an7581/Makefile            |   9 +
 sound/soc/mediatek/an7581/an7581-afe-common.h |  39 ++
 sound/soc/mediatek/an7581/an7581-afe-pcm.c    | 456 ++++++++++++++++++
 sound/soc/mediatek/an7581/an7581-dai-etdm.c   | 371 ++++++++++++++
 sound/soc/mediatek/an7581/an7581-reg.h        |  61 +++
 sound/soc/mediatek/an7581/an7581-wm8960.c     | 170 +++++++
 9 files changed, 1136 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/mediatek/an7581/Makefile
 create mode 100644 sound/soc/mediatek/an7581/an7581-afe-common.h
 create mode 100644 sound/soc/mediatek/an7581/an7581-afe-pcm.c
 create mode 100644 sound/soc/mediatek/an7581/an7581-dai-etdm.c
 create mode 100644 sound/soc/mediatek/an7581/an7581-reg.h
 create mode 100644 sound/soc/mediatek/an7581/an7581-wm8960.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 48810529994a..13a2508f2905 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -766,13 +766,21 @@ F:	Documentation/devicetree/bindings/phy/airoha,en7581-pcie-phy.yaml
 F:	drivers/phy/phy-airoha-pcie-regs.h
 F:	drivers/phy/phy-airoha-pcie.c
 
+AIROHA SOUND DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-sound@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
+F:	sound/soc/mediatek/an7581/*
+
 AIROHA SPI SNFI DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 M:	Ray Liu <ray.liu@airoha.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
+F:	Documentation/devicetree/bindings/sound/airoha,an7581-afe.yaml
+F:	Documentation/devicetree/bindings/sound/airoha,an7581-wm8960.yaml
 F:	drivers/spi/spi-airoha-snfi.c
 
 AIRSPY MEDIA DRIVER
diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 3a1e1fa3fe5c..04d1f00fd980 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -5,6 +5,26 @@ config SND_SOC_MEDIATEK
 	tristate
 	select REGMAP_MMIO
 
+config SND_SOC_AN7581
+	tristate "ASoC support for Airoha AN7581 chip"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	select SND_SOC_MEDIATEK
+	help
+	  This adds ASoC platform driver support for Airoha AN7581 chip
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
+config SND_SOC_AN7581_WM8960
+	tristate "ASoc Audio driver for Airoha AN7581 with WM8960 codec"
+	depends on SND_SOC_AN7581 && I2C
+	select SND_SOC_WM8960
+	help
+	  This adds support for ASoC machine driver for Airoha AN7581
+	  boards with the WM8960 codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT2701
 	tristate "ASoC support for Mediatek MT2701 chip"
 	depends on ARCH_MEDIATEK
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 7cd67bce92e9..692d7a472ecc 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SND_SOC_MEDIATEK) += common/
+obj-$(CONFIG_SND_SOC_AN7581) += an7581/
 obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
 obj-$(CONFIG_SND_SOC_MT6797) += mt6797/
 obj-$(CONFIG_SND_SOC_MT7986) += mt7986/
diff --git a/sound/soc/mediatek/an7581/Makefile b/sound/soc/mediatek/an7581/Makefile
new file mode 100644
index 000000000000..f48cd0269bea
--- /dev/null
+++ b/sound/soc/mediatek/an7581/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# platform driver
+snd-soc-an7581-afe-y := \
+	an7581-afe-pcm.o \
+	an7581-dai-etdm.o
+
+obj-$(CONFIG_SND_SOC_AN7581) += snd-soc-an7581-afe.o
+obj-$(CONFIG_SND_SOC_AN7581_WM8960) += an7581-wm8960.o
diff --git a/sound/soc/mediatek/an7581/an7581-afe-common.h b/sound/soc/mediatek/an7581/an7581-afe-common.h
new file mode 100644
index 000000000000..fef1a7b4529e
--- /dev/null
+++ b/sound/soc/mediatek/an7581/an7581-afe-common.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * an7581-afe-common.h  --  Airoha AN7581 audio driver definitions
+ */
+
+#ifndef _AN7581_AFE_COMMON_H_
+#define _AN7581_AFE_COMMON_H_
+
+#include <sound/soc.h>
+#include <linux/list.h>
+#include <linux/regmap.h>
+#include "../../mediatek/common/mtk-base-afe.h"
+
+enum {
+	AN7581_MEMIF_DL1,
+	AN7581_MEMIF_UL1,
+	AN7581_MEMIF_NUM,
+	AN7581_DAI_ETDM = AN7581_MEMIF_NUM,
+	AN7581_DAI_NUM,
+};
+
+enum {
+	AN7581_IRQ_0,
+	AN7581_IRQ_1,
+	AN7581_IRQ_NUM,
+};
+
+struct an7581_afe_private {
+	/* dai */
+	void *dai_priv[AN7581_DAI_NUM];
+};
+
+unsigned int an7581_afe_rate_transform(struct device *dev,
+				       unsigned int rate);
+
+/* dai register */
+int an7581_dai_etdm_register(struct mtk_base_afe *afe);
+
+#endif
diff --git a/sound/soc/mediatek/an7581/an7581-afe-pcm.c b/sound/soc/mediatek/an7581/an7581-afe-pcm.c
new file mode 100644
index 000000000000..34ff0ca6cf4e
--- /dev/null
+++ b/sound/soc/mediatek/an7581/an7581-afe-pcm.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Airoha ALSA SoC AFE platform driver for AN7581
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+
+#include "an7581-afe-common.h"
+#include "an7581-reg.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-afe-fe-dai.h"
+
+enum {
+	ARH_AFE_RATE_8K = 0,
+	ARH_AFE_RATE_12K = 1,
+	ARH_AFE_RATE_16K = 2,
+	ARH_AFE_RATE_24K = 3,
+	ARH_AFE_RATE_32K = 4,
+	ARH_AFE_RATE_48K = 5,
+	ARH_AFE_RATE_96K = 6,
+	ARH_AFE_RATE_192K = 7,
+	ARH_AFE_RATE_384K = 8,
+	ARH_AFE_RATE_7K = 16,
+	ARH_AFE_RATE_11K = 17,
+	ARH_AFE_RATE_14K = 18,
+	ARH_AFE_RATE_22K = 19,
+	ARH_AFE_RATE_29K = 20,
+	ARH_AFE_RATE_44K = 21,
+	ARH_AFE_RATE_88K = 22,
+	ARH_AFE_RATE_176K = 23,
+	ARH_AFE_RATE_352K = 24,
+};
+
+unsigned int an7581_afe_rate_transform(struct device *dev, unsigned int rate)
+{
+	switch (rate) {
+	case 7350:
+		return ARH_AFE_RATE_7K;
+	case 8000:
+		return ARH_AFE_RATE_8K;
+	case 11025:
+		return ARH_AFE_RATE_11K;
+	case 12000:
+		return ARH_AFE_RATE_12K;
+	case 14700:
+		return ARH_AFE_RATE_14K;
+	case 16000:
+		return ARH_AFE_RATE_16K;
+	case 22050:
+		return ARH_AFE_RATE_22K;
+	case 24000:
+		return ARH_AFE_RATE_24K;
+	case 29400:
+		return ARH_AFE_RATE_29K;
+	case 32000:
+		return ARH_AFE_RATE_32K;
+	case 44100:
+		return ARH_AFE_RATE_44K;
+	case 48000:
+		return ARH_AFE_RATE_48K;
+	case 88200:
+		return ARH_AFE_RATE_88K;
+	case 96000:
+		return ARH_AFE_RATE_96K;
+	case 176400:
+		return ARH_AFE_RATE_176K;
+	case 192000:
+		return ARH_AFE_RATE_192K;
+	case 352800:
+		return ARH_AFE_RATE_352K;
+	case 384000:
+		return ARH_AFE_RATE_384K;
+	default:
+		dev_warn(dev, "%s(), rate %u invalid, using %d!!!\n",
+			 __func__, rate, ARH_AFE_RATE_48K);
+		return ARH_AFE_RATE_48K;
+	}
+}
+
+static const int an7581_memif_specified_irqs[AN7581_MEMIF_NUM] = {
+	[AN7581_MEMIF_DL1] = AN7581_IRQ_0,
+	[AN7581_MEMIF_UL1] = AN7581_IRQ_1,
+};
+
+static const struct snd_pcm_hardware an7581_afe_hardware = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		   SNDRV_PCM_FMTBIT_S24_LE |
+		   SNDRV_PCM_FMTBIT_S32_LE,
+	.period_bytes_min = 512,
+	.period_bytes_max = 128 * 1024,
+	.periods_min = 2,
+	.periods_max = 256,
+	.buffer_bytes_max = 256 * 1024,
+	.fifo_size = 0,
+};
+
+static int an7581_memif_fs(struct snd_pcm_substream *substream,
+			   unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	return an7581_afe_rate_transform(afe->dev, rate);
+}
+
+static int an7581_irq_fs(struct snd_pcm_substream *substream,
+			 unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	return an7581_afe_rate_transform(afe->dev, rate);
+}
+
+#define ARH_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver an7581_memif_dai_driver[] = {
+	/* FE DAIs: memory intefaces to CPU */
+	{
+		.name = "DL1",
+		.id = AN7581_MEMIF_DL1,
+		.playback = {
+			.stream_name = "DL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = ARH_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "UL1",
+		.id = AN7581_MEMIF_UL1,
+		.capture = {
+			.stream_name = "UL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = ARH_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+};
+
+static const struct snd_soc_component_driver an7581_afe_pcm_dai_component = {
+	.name = "an7581-afe-pcm-dai",
+};
+
+static const struct mtk_base_memif_data memif_data[AN7581_MEMIF_NUM] = {
+	[AN7581_MEMIF_DL1] = {
+		.name = "DL1",
+		.id = AN7581_MEMIF_DL1,
+		.reg_ofs_base = AFE_DL1_BASE,
+		.reg_ofs_cur = AFE_DL1_CUR,
+		.reg_ofs_end = AFE_DL1_END,
+		.fs_reg = -1,
+		.fs_shift = -1,
+		.fs_maskbit = -1,
+		.mono_reg = -1,
+		.mono_shift = -1,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = 17,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+	},
+	[AN7581_MEMIF_UL1] = {
+		.name = "UL1",
+		.id = AN7581_MEMIF_UL1,
+		.reg_ofs_base = AFE_UL1_BASE,
+		.reg_ofs_cur = AFE_UL1_CUR,
+		.reg_ofs_end = AFE_UL1_END,
+		.fs_reg = -1,
+		.fs_shift = -1,
+		.fs_maskbit = -1,
+		.mono_reg = -1,
+		.mono_shift = -1,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = 1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+	},
+};
+
+static const struct mtk_base_irq_data irq_data[AN7581_IRQ_NUM] = {
+	[AN7581_IRQ_0] = {
+		.id = AN7581_IRQ_0,
+		.irq_cnt_reg = -1,
+		.irq_cnt_shift = -1,
+		.irq_cnt_maskbit = -1,
+		.irq_en_reg = AFE_IRQ0_CON0,
+		.irq_en_shift = 0,
+		.irq_fs_reg = -1,
+		.irq_fs_shift = -1,
+		.irq_fs_maskbit = -1,
+		.irq_clr_reg = AFE_IRQ0_CON0,
+		.irq_clr_shift = 2,
+	},
+	[AN7581_IRQ_1] = {
+		.id = AN7581_IRQ_1,
+		.irq_cnt_reg = -1,
+		.irq_cnt_shift = -1,
+		.irq_cnt_maskbit = -1,
+		.irq_en_reg = AFE_IRQ1_CON0,
+		.irq_en_shift = 0,
+		.irq_fs_reg = -1,
+		.irq_fs_shift = -1,
+		.irq_fs_maskbit = -1,
+		.irq_clr_reg = AFE_IRQ1_CON0,
+		.irq_clr_shift = 2,
+	},
+};
+
+static const struct regmap_config an7581_afe_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = AFE_MAX_REGISTER,
+	.num_reg_defaults_raw = ((AFE_MAX_REGISTER / 4) + 1),
+};
+
+static irqreturn_t an7581_afe_irq_handler(int irq_id, void *dev)
+{
+	struct mtk_base_afe *afe = dev;
+	struct mtk_base_afe_irq *irq;
+	u32 status;
+	u32 reg;
+	int i;
+
+	regmap_read(afe->regmap, AFE_IRQ_STS, &status);
+
+	if (status & AFE_IRQ_STS_RECORD)
+		reg = AFE_IRQ0_CON0;
+	else
+		reg = AFE_IRQ1_CON0;
+
+	regmap_set_bits(afe->regmap, reg, BIT(2));
+	regmap_clear_bits(afe->regmap, reg, BIT(2));
+
+	regmap_set_bits(afe->regmap, reg, BIT(3));
+	regmap_clear_bits(afe->regmap, reg, BIT(3));
+
+	for (i = 0; i < AN7581_MEMIF_NUM; i++) {
+		struct mtk_base_afe_memif *memif = &afe->memif[i];
+
+		if (!memif->substream)
+			continue;
+
+		if (memif->irq_usage < 0)
+			continue;
+
+		irq = &afe->irqs[memif->irq_usage];
+
+		if (status & (1 << irq->irq_data->irq_clr_shift))
+			snd_pcm_period_elapsed(memif->substream);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int an7581_afe_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int an7581_afe_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int an7581_dai_memif_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = an7581_memif_dai_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(an7581_memif_dai_driver);
+
+	return 0;
+}
+
+typedef int (*dai_register_cb)(struct mtk_base_afe *);
+static const dai_register_cb dai_register_cbs[] = {
+	an7581_dai_etdm_register,
+	an7581_dai_memif_register,
+};
+
+static int an7581_afe_pcm_dev_probe(struct platform_device *pdev)
+{
+	struct mtk_base_afe *afe;
+	struct an7581_afe_private *afe_priv;
+	struct device *dev;
+	int i, irq_id, ret;
+
+	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
+	if (!afe)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, afe);
+
+	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
+					  GFP_KERNEL);
+	if (!afe->platform_priv)
+		return -ENOMEM;
+
+	afe_priv = afe->platform_priv;
+	afe->dev = &pdev->dev;
+	dev = afe->dev;
+
+	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(afe->base_addr))
+		return PTR_ERR(afe->base_addr);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
+					    &an7581_afe_regmap_config);
+
+	pm_runtime_put_sync(&pdev->dev);
+	if (IS_ERR(afe->regmap))
+		return PTR_ERR(afe->regmap);
+
+	mutex_init(&afe->irq_alloc_lock);
+
+	/* irq initialize */
+	afe->irqs_size = AN7581_IRQ_NUM;
+	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
+				 GFP_KERNEL);
+	if (!afe->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->irqs_size; i++)
+		afe->irqs[i].irq_data = &irq_data[i];
+
+	/* request irq */
+	irq_id = platform_get_irq(pdev, 0);
+	if (irq_id < 0)
+		return irq_id;
+
+	ret = devm_request_irq(dev, irq_id, an7581_afe_irq_handler,
+			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq for asys-isr\n");
+
+	/* init memif */
+	afe->memif_size = AN7581_MEMIF_NUM;
+	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
+				  GFP_KERNEL);
+	if (!afe->memif)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->memif_size; i++) {
+		int sel_irq = an7581_memif_specified_irqs[i];
+
+		afe->memif[i].data = &memif_data[i];
+		afe->memif[i].irq_usage = sel_irq;
+		afe->memif[i].const_irq = 1;
+		afe->irqs[sel_irq].irq_occupyed = true;
+	}
+
+	/* init sub_dais */
+	INIT_LIST_HEAD(&afe->sub_dais);
+
+	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
+		ret = dai_register_cbs[i](afe);
+		if (ret)
+			return dev_err_probe(dev, ret, "DAI register failed, i: %d\n", i);
+	}
+
+	/* init dai_driver and component_driver */
+	ret = mtk_afe_combine_sub_dai(afe);
+	if (ret)
+		return dev_err_probe(dev, ret, "mtk_afe_combine_sub_dai fail\n");
+
+	afe->mtk_afe_hardware = &an7581_afe_hardware;
+	afe->memif_fs = an7581_memif_fs;
+	afe->irq_fs = an7581_irq_fs;
+
+	afe->runtime_resume = an7581_afe_runtime_resume;
+	afe->runtime_suspend = an7581_afe_runtime_suspend;
+
+	/* register component */
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &mtk_afe_pcm_platform,
+					      NULL, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot register AFE component\n");
+
+	ret = devm_snd_soc_register_component(afe->dev,
+					      &an7581_afe_pcm_dai_component,
+					      afe->dai_drivers,
+					      afe->num_dai_drivers);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot register PCM DAI component\n");
+
+	return 0;
+}
+
+static void an7581_afe_pcm_dev_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		an7581_afe_runtime_suspend(&pdev->dev);
+}
+
+static const struct of_device_id an7581_afe_pcm_dt_match[] = {
+	{ .compatible = "airoha,an7581-afe" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an7581_afe_pcm_dt_match);
+
+static const struct dev_pm_ops an7581_afe_pm_ops = {
+	RUNTIME_PM_OPS(an7581_afe_runtime_suspend,
+		       an7581_afe_runtime_resume, NULL)
+};
+
+static struct platform_driver an7581_afe_pcm_driver = {
+	.driver = {
+		   .name = "an7581-audio",
+		   .of_match_table = an7581_afe_pcm_dt_match,
+		   .pm = pm_ptr(&an7581_afe_pm_ops),
+	},
+	.probe = an7581_afe_pcm_dev_probe,
+	.remove = an7581_afe_pcm_dev_remove,
+};
+module_platform_driver(an7581_afe_pcm_driver);
+
+MODULE_DESCRIPTION("Airoha SoC AFE platform driver for ALSA AN7581");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/mediatek/an7581/an7581-dai-etdm.c b/sound/soc/mediatek/an7581/an7581-dai-etdm.c
new file mode 100644
index 000000000000..fdf6ed0cce56
--- /dev/null
+++ b/sound/soc/mediatek/an7581/an7581-dai-etdm.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Airoha ALSA SoC Audio DAI eTDM Control
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "an7581-afe-common.h"
+#include "an7581-reg.h"
+
+#define HOPPING_CLK  0
+#define APLL_CLK     1
+#define MTK_DAI_ETDM_FORMAT_I2S   0
+#define MTK_DAI_ETDM_FORMAT_DSPA  4
+#define MTK_DAI_ETDM_FORMAT_DSPB  5
+
+enum {
+	MTK_ETDM_RATE_8K = 0,
+	MTK_ETDM_RATE_12K = 1,
+	MTK_ETDM_RATE_16K = 2,
+	MTK_ETDM_RATE_24K = 3,
+	MTK_ETDM_RATE_32K = 4,
+	MTK_ETDM_RATE_48K = 5,
+	MTK_ETDM_RATE_96K = 6,
+	MTK_ETDM_RATE_192K = 7,
+	MTK_ETDM_RATE_384K = 8,
+	MTK_ETDM_RATE_7K = 16,
+	MTK_ETDM_RATE_11K = 17,
+	MTK_ETDM_RATE_14K = 18,
+	MTK_ETDM_RATE_22K = 19,
+	MTK_ETDM_RATE_29K = 20,
+	MTK_ETDM_RATE_44K = 21,
+	MTK_ETDM_RATE_88K = 22,
+	MTK_ETDM_RATE_176K = 23,
+	MTK_ETDM_RATE_352K = 24,
+};
+
+struct mtk_dai_etdm_priv {
+	bool bck_inv;
+	bool lrck_inv;
+	bool slave_mode;
+	unsigned int format;
+};
+
+static unsigned int an7581_etdm_rate_transform(struct device *dev, unsigned int rate)
+{
+	switch (rate) {
+	case 7350:
+		return MTK_ETDM_RATE_7K;
+	case 8000:
+		return MTK_ETDM_RATE_8K;
+	case 11025:
+		return MTK_ETDM_RATE_11K;
+	case 12000:
+		return MTK_ETDM_RATE_12K;
+	case 14700:
+		return MTK_ETDM_RATE_14K;
+	case 16000:
+		return MTK_ETDM_RATE_16K;
+	case 22050:
+		return MTK_ETDM_RATE_22K;
+	case 24000:
+		return MTK_ETDM_RATE_24K;
+	case 29400:
+		return MTK_ETDM_RATE_29K;
+	case 32000:
+		return MTK_ETDM_RATE_32K;
+	case 44100:
+		return MTK_ETDM_RATE_44K;
+	case 48000:
+		return MTK_ETDM_RATE_48K;
+	case 88200:
+		return MTK_ETDM_RATE_88K;
+	case 96000:
+		return MTK_ETDM_RATE_96K;
+	case 176400:
+		return MTK_ETDM_RATE_176K;
+	case 192000:
+		return MTK_ETDM_RATE_192K;
+	case 352800:
+		return MTK_ETDM_RATE_352K;
+	case 384000:
+		return MTK_ETDM_RATE_384K;
+	default:
+		dev_warn(dev, "%s(), rate %u invalid, using %d!!!\n",
+			 __func__, rate, MTK_ETDM_RATE_48K);
+		return MTK_ETDM_RATE_48K;
+	}
+}
+
+static int get_etdm_wlen(unsigned int bitwidth)
+{
+	return bitwidth <= 16 ? 16 : 32;
+}
+
+/* dai ops */
+static int mtk_dai_etdm_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	return 0;
+}
+
+static void mtk_dai_etdm_shutdown(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+}
+
+static unsigned int get_etdm_ch_fixup(unsigned int channels)
+{
+	if (channels > 16)
+		return 24;
+	else if (channels > 8)
+		return 16;
+	else if (channels > 4)
+		return 8;
+	else if (channels > 2)
+		return 4;
+	else
+		return 2;
+}
+
+static int mtk_dai_etdm_config(struct mtk_base_afe *afe,
+			       struct snd_pcm_hw_params *params,
+			       struct snd_soc_dai *dai,
+			       int stream)
+{
+	struct an7581_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	unsigned int rate = params_rate(params);
+	unsigned int etdm_rate = an7581_etdm_rate_transform(afe->dev, rate);
+	unsigned int afe_rate = an7581_afe_rate_transform(afe->dev, rate);
+	unsigned int channels = params_channels(params);
+	unsigned int bit_width = params_width(params);
+	unsigned int wlen = get_etdm_wlen(bit_width);
+	unsigned int val = 0;
+	unsigned int mask = 0;
+
+	dev_dbg(afe->dev, "%s(), stream %d, rate %u, bitwidth %u\n",
+		__func__, stream, rate, bit_width);
+
+	/* CON0 */
+	mask |= ETDM_BIT_LEN;
+	val |= FIELD_PREP(ETDM_BIT_LEN, bit_width - 1);
+	mask |= ETDM_WRD_LEN;
+	val |= FIELD_PREP(ETDM_WRD_LEN, wlen - 1);
+	mask |= ETDM_FMT;
+	val |= FIELD_PREP(ETDM_FMT, etdm_data->format);
+	mask |= ETDM_CH_NUM;
+	val |= FIELD_PREP(ETDM_CH_NUM, get_etdm_ch_fixup(channels) - 1);
+	mask |= RELATCH_SRC;
+	val |= FIELD_PREP(RELATCH_SRC, APLL_CLK);
+
+	switch (stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		/* set ETDM_OUT1_CON0 */
+		regmap_update_bits(afe->regmap, ETDM_OUT1_CON0, mask, val);
+
+		/* set ETDM_OUT1_CON4 */
+		regmap_update_bits(afe->regmap, ETDM_OUT1_CON4, OUT_RELATCH,
+				   FIELD_PREP(OUT_RELATCH, afe_rate));
+		regmap_update_bits(afe->regmap, ETDM_OUT1_CON4, OUT_CLK_SRC,
+				   FIELD_PREP(OUT_CLK_SRC, APLL_CLK));
+		regmap_update_bits(afe->regmap, ETDM_OUT1_CON4, OUT_SEL_FS,
+				   FIELD_PREP(OUT_SEL_FS, etdm_rate));
+
+		/* set ETDM_OUT1_CON5 */
+		regmap_set_bits(afe->regmap, ETDM_OUT1_CON5, ETDM_CLK_DIV);
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		/* set ETDM_IN1_CON0 */
+		regmap_update_bits(afe->regmap, ETDM_IN1_CON0, mask, val);
+		regmap_set_bits(afe->regmap, ETDM_IN1_CON0, ETDM_SYNC);
+
+		/* set ETDM_IN1_CON2 */
+		regmap_update_bits(afe->regmap, ETDM_IN1_CON2, IN_CLK_SRC,
+				   FIELD_PREP(IN_SEL_FS, APLL_CLK));
+
+		/* set ETDM_IN1_CON3 */
+		regmap_update_bits(afe->regmap, ETDM_IN1_CON3, IN_SEL_FS,
+				   FIELD_PREP(IN_SEL_FS, etdm_rate));
+
+		/* set ETDM_IN1_CON4 */
+		regmap_update_bits(afe->regmap, ETDM_IN1_CON4, IN_RELATCH,
+				   FIELD_PREP(IN_RELATCH, afe_rate));
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	unsigned int rate = params_rate(params);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	switch (rate) {
+	case 8000:
+	case 12000:
+	case 16000:
+	case 24000:
+	case 32000:
+	case 48000:
+	case 96000:
+	case 192000:
+		mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_PLAYBACK);
+		mtk_dai_etdm_config(afe, params, dai, SNDRV_PCM_STREAM_CAPTURE);
+		return 0;
+	default:
+		dev_err(afe->dev,
+			"Sample rate %d invalid. Supported rates: 8/12/16/24/32/48/96/192 kHz\n",
+			rate);
+		return -EINVAL;
+	}
+}
+
+static int mtk_dai_etdm_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	dev_dbg(afe->dev, "%s(), cmd %d, dai id %d\n", __func__, cmd, dai->id);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		regmap_set_bits(afe->regmap, ETDM_IN1_CON0, ETDM_EN);
+		regmap_set_bits(afe->regmap, ETDM_OUT1_CON0, ETDM_EN);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		regmap_clear_bits(afe->regmap, ETDM_IN1_CON0, ETDM_EN);
+		regmap_clear_bits(afe->regmap, ETDM_OUT1_CON0, ETDM_EN);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_dai_etdm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct an7581_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_etdm_priv *etdm_data;
+	void *priv_data;
+
+	switch (dai->id) {
+	case AN7581_DAI_ETDM:
+		break;
+	default:
+		dev_warn(afe->dev, "%s(), id %d not support\n",
+			 __func__, dai->id);
+		return -EINVAL;
+	}
+
+	priv_data = devm_kzalloc(afe->dev, sizeof(struct mtk_dai_etdm_priv),
+				 GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	afe_priv->dai_priv[dai->id] = priv_data;
+	etdm_data = afe_priv->dai_priv[dai->id];
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		etdm_data->format = MTK_DAI_ETDM_FORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		etdm_data->format = MTK_DAI_ETDM_FORMAT_DSPA;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		etdm_data->format = MTK_DAI_ETDM_FORMAT_DSPB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		etdm_data->bck_inv = false;
+		etdm_data->lrck_inv = false;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		etdm_data->bck_inv = false;
+		etdm_data->lrck_inv = true;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		etdm_data->bck_inv = true;
+		etdm_data->lrck_inv = false;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		etdm_data->bck_inv = true;
+		etdm_data->lrck_inv = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
+		etdm_data->slave_mode = true;
+		break;
+	case SND_SOC_DAIFMT_CBC_CFC:
+		etdm_data->slave_mode = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_etdm_ops = {
+	.startup = mtk_dai_etdm_startup,
+	.shutdown = mtk_dai_etdm_shutdown,
+	.hw_params = mtk_dai_etdm_hw_params,
+	.trigger = mtk_dai_etdm_trigger,
+	.set_fmt = mtk_dai_etdm_set_fmt,
+};
+
+/* dai driver */
+#define MTK_ETDM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			  SNDRV_PCM_FMTBIT_S24_LE |\
+			  SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_etdm_driver[] = {
+	{
+		.name = "ETDM",
+		.id = AN7581_DAI_ETDM,
+		.capture = {
+			.stream_name = "ETDM Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_384000,
+			.formats = MTK_ETDM_FORMATS,
+		},
+		.playback = {
+			.stream_name = "ETDM Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_384000,
+			.formats = MTK_ETDM_FORMATS,
+		},
+		.ops = &mtk_dai_etdm_ops,
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+	},
+};
+
+int an7581_dai_etdm_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_etdm_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_etdm_driver);
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/an7581/an7581-reg.h b/sound/soc/mediatek/an7581/an7581-reg.h
new file mode 100644
index 000000000000..dba51ee5c6fe
--- /dev/null
+++ b/sound/soc/mediatek/an7581/an7581-reg.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * an7581-reg.h  --  Airoha AN7581 audio driver reg definition
+ */
+
+#ifndef _AN7581_REG_H_
+#define _AN7581_REG_H_
+
+#define AFE_DAC_CON0			0x0
+
+#define ETDM_IN1_CON0			0x5c
+#define   RELATCH_SRC			GENMASK(30, 28)
+#define   ETDM_CH_NUM			GENMASK(27, 23)
+#define   ETDM_WRD_LEN			GENMASK(20, 16)
+#define   ETDM_BIT_LEN			GENMASK(15, 11)
+#define   ETDM_FMT			GENMASK(8, 6)
+#define   ETDM_SYNC			BIT(1)
+#define   ETDM_EN			BIT(0)
+#define ETDM_IN1_CON1			0x60
+#define ETDM_IN1_CON2			0x64
+#define   IN_CLK_SRC			GENMASK(12, 10)
+#define ETDM_IN1_CON3			0x68
+#define   IN_SEL_FS			GENMASK(30, 26)
+#define ETDM_IN1_CON4			0x6c
+#define   IN_RELATCH			GENMASK(24, 20)
+#define   IN_CLK_INV			BIT(18)
+#define ETDM_IN1_CON5			0x70
+#define ETDM_IN1_CON6			0x74
+#define ETDM_OUT1_CON0			0x7c
+#define ETDM_OUT1_CON1			0x80
+#define ETDM_OUT1_CON2			0x84
+#define ETDM_OUT1_CON3			0x88
+#define ETDM_OUT1_CON4			0x8c
+#define   OUT_RELATCH			GENMASK(28, 24)
+#define   OUT_CLK_SRC			GENMASK(8, 6)
+#define   OUT_SEL_FS			GENMASK(4, 0)
+#define ETDM_OUT1_CON5			0x90
+#define   ETDM_CLK_DIV			BIT(12)
+#define   OUT_CLK_INV			BIT(9)
+#define ETDM_OUT1_CON6			0x94
+#define ETDM_OUT1_CON7			0x98
+
+#define AFE_DL1_BASE			0xa8
+#define AFE_DL1_END			0xb0
+#define AFE_DL1_CUR			0xac
+
+#define AFE_UL1_BASE			0xc4
+#define AFE_UL1_END			0xc8
+#define AFE_UL1_CUR			0xcc
+
+#define AFE_IRQ0_CON0			0xe4
+
+#define AFE_IRQ_STS			0xf8
+#define  AFE_IRQ_STS_PLAY		BIT(1)
+#define  AFE_IRQ_STS_RECORD		BIT(0)
+
+#define AFE_IRQ1_CON0			0x100
+
+#define AFE_MAX_REGISTER		AFE_IRQ1_CON0
+
+#endif
diff --git a/sound/soc/mediatek/an7581/an7581-wm8960.c b/sound/soc/mediatek/an7581/an7581-wm8960.c
new file mode 100644
index 000000000000..5d6c736aa6f2
--- /dev/null
+++ b/sound/soc/mediatek/an7581/an7581-wm8960.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Airoha ALSA SoC I2S platform driver for AN7581
+ *
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#include "an7581-afe-common.h"
+
+static const struct snd_soc_dapm_widget an7581_wm8960_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("AMIC", NULL),
+};
+
+static const struct snd_kcontrol_new an7581_wm8960_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("AMIC"),
+};
+
+SND_SOC_DAILINK_DEFS(playback,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(codec,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm8960-hifi")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static struct snd_soc_dai_link an7581_wm8960_dai_links[] = {
+	/* FE */
+	{
+		.name = "wm8960-playback",
+		.stream_name = "wm8960-playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST,
+			    SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 0,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback),
+	},
+	{
+		.name = "wm8960-capture",
+		.stream_name = "wm8960-capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST,
+			    SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 0,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture),
+	},
+	/* BE */
+	{
+		.name = "wm8960-codec",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBC_CFC |
+			SND_SOC_DAIFMT_GATED,
+		SND_SOC_DAILINK_REG(codec),
+	},
+};
+
+static struct snd_soc_card an7581_wm8960_card = {
+	.name = "an7581-wm8960",
+	.owner = THIS_MODULE,
+	.dai_link = an7581_wm8960_dai_links,
+	.num_links = ARRAY_SIZE(an7581_wm8960_dai_links),
+	.controls = an7581_wm8960_controls,
+	.num_controls = ARRAY_SIZE(an7581_wm8960_controls),
+	.dapm_widgets = an7581_wm8960_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(an7581_wm8960_widgets),
+};
+
+static int an7581_wm8960_machine_probe(struct platform_device *pdev)
+{
+	struct device_node *platform_dai_node, *codec_dai_node;
+	struct snd_soc_card *card = &an7581_wm8960_card;
+	struct device_node *platform, *codec;
+	struct snd_soc_dai_link *dai_link;
+	int ret, i;
+
+	card->dev = &pdev->dev;
+
+	platform = of_get_child_by_name(pdev->dev.of_node, "platform");
+
+	if (platform) {
+		platform_dai_node = of_parse_phandle(platform, "sound-dai", 0);
+		of_node_put(platform);
+
+		if (!platform_dai_node) {
+			dev_err(&pdev->dev, "Failed to parse platform/sound-dai property\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->platforms->name)
+			continue;
+		dai_link->platforms->of_node = platform_dai_node;
+	}
+
+	codec = of_get_child_by_name(pdev->dev.of_node, "codec");
+
+	if (codec) {
+		codec_dai_node = of_parse_phandle(codec, "sound-dai", 0);
+		of_node_put(codec);
+
+		if (!codec_dai_node) {
+			of_node_put(platform_dai_node);
+			dev_err(&pdev->dev, "Failed to parse codec/sound-dai property\n");
+			return -EINVAL;
+		}
+	} else {
+		of_node_put(platform_dai_node);
+		dev_err(&pdev->dev, "Property 'codec' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->codecs->name)
+			continue;
+		dai_link->codecs->of_node = codec_dai_node;
+	}
+
+	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to parse audio-routing: %d\n", ret);
+		goto err_of_node_put;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n", __func__);
+		goto err_of_node_put;
+	}
+
+	return 0;
+
+err_of_node_put:
+	of_node_put(platform_dai_node);
+	of_node_put(codec_dai_node);
+	return ret;
+}
+
+static const struct of_device_id an7581_wm8960_machine_dt_match[] = {
+	{ .compatible = "airoha,an7581-wm8960-sound" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an7581_wm8960_machine_dt_match);
+
+static struct platform_driver an7581_wm8960_driver = {
+	.driver = {
+		   .name = "an7581-wm8960",
+		   .of_match_table = an7581_wm8960_machine_dt_match,
+	},
+	.probe = an7581_wm8960_machine_probe,
+};
+module_platform_driver(an7581_wm8960_driver);
+
+MODULE_DESCRIPTION("Airoha SoC I2S platform driver for ALSA AN7581");
+MODULE_LICENSE("GPL");
-- 
2.51.0


