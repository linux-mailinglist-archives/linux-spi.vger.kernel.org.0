Return-Path: <linux-spi+bounces-6521-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0339A20609
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 09:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D1B3A7696
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E31DF98C;
	Tue, 28 Jan 2025 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3RJBuetC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36721DED5D;
	Tue, 28 Jan 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052531; cv=none; b=PYluee9y4Uei4HItQr6I131IWZVMqenOAX1gbNVmKQnOwxNcNrRxe6GG/H4kM1Of0/A18W+KV2tv1pKcxWLeFsEns/XmQ92gUkO+ltjjCj/6Cn0jwXaT4XWg2F4oxot8IS8ydtTxEEjmkDjHUcla9/qx4Yz+vp57jP7WpHsUY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052531; c=relaxed/simple;
	bh=cljcFPfk+Rm8NLsMmL1c6w7WUIu97uvE6PG8NQvJPXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNJD0w6/TCXLPGx55WNMxDHeav3JqowbVOfDX2tgwSEzxkfP9LCyBkIPA3ukZAwzICH0NsuCYjkeOWhnRr1vEpGqlkdpdoO0q8tmxrcaeNn0sfaFnnny7tfET6RZq36MjqEO4KKvDmIqOjNavrneIEJsJZmowVTM1TKJ2FV0XNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3RJBuetC; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S212Sk011553;
	Tue, 28 Jan 2025 09:21:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9bW6T0XmzevZ5PtuoP0R5z1bc37Om4XzrPFzM+nPJFI=; b=3RJBuetC49+egafF
	t6lxgtnNLalnmY6W2ajmqkpw4uQEMiKGBbXvnEUjgpIb0BNvYEyZWd1Pjnfj3qns
	nsUmzod/DDgJWvEgL2dOaym/KMq3hpSlQhfECTJHtZ/rLytGRk+XoMjtzQKFwb47
	zyT97cls2Y1M77hyfKN2ixg+FFnOG7Bh7x+RdVj5B6H6DIhpHkzV796ImqDWmZkr
	cyBZl+7mv0f+T5veR5OVA7C40idUArAxnKfDuhUJPC3Gwl0iy/YK0XQZ1/p3Wzgl
	bjIcjF9YMQI3JjWCrJBE0NfTYFMKgt9JvnThh71TtjOKVmz2LudzzJRPAsOAsNMe
	BrZzzg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44enjbs0ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:21:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 28FA240058;
	Tue, 28 Jan 2025 09:20:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57FAA29C5F8;
	Tue, 28 Jan 2025 09:17:45 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 28 Jan
 2025 09:17:45 +0100
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>
Subject: [PATCH v2 4/9] memory: Add STM32 Octo Memory Manager driver
Date: Tue, 28 Jan 2025 09:17:26 +0100
Message-ID: <20250128081731.2284457-5-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

Octo Memory Manager driver (OMM) manages:
  - the muxing between 2 OSPI busses and 2 output ports.
    There are 4 possible muxing configurations:
      - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
        output is on port 2
      - OSPI1 and OSPI2 are multiplexed over the same output port 1
      - swapped mode (no multiplexing), OSPI1 output is on port 2,
        OSPI2 output is on port 1
      - OSPI1 and OSPI2 are multiplexed over the same output port 2
  - the split of the memory area shared between the 2 OSPI instances.
  - chip select selection override.
  - the time between 2 transactions in multiplexed mode.
  - check firewall access.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/memory/Kconfig     |  17 ++
 drivers/memory/Makefile    |   1 +
 drivers/memory/stm32_omm.c | 509 +++++++++++++++++++++++++++++++++++++
 3 files changed, 527 insertions(+)
 create mode 100644 drivers/memory/stm32_omm.c

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index c82d8d8a16ea..80c44a6d5bdb 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -225,6 +225,23 @@ config STM32_FMC2_EBI
 	  devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
 	  SOCs containing the FMC2 External Bus Interface.
 
+config STM32_OMM
+	tristate "STM32 Octo Memory Manager"
+	depends on SPI_STM32_OSPI || TEST_COMPILE
+	help
+	  This driver manages the muxing between the 2 OSPI busses and
+	  the 2 output ports. There are 4 possible muxing configurations:
+	  - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
+	       output is on port 2
+	  - OSPI1 and OSPI2 are multiplexed over the same output port 1
+	  - swapped mode (no multiplexing), OSPI1 output is on port 2,
+	       OSPI2 output is on port 1
+	  - OSPI1 and OSPI2 are multiplexed over the same output port 2
+	  It also manages :
+	    - the split of the memory area shared between the 2 OSPI instances.
+	    - chip select selection override.
+	    - the time between 2 transactions in multiplexed mode.
+
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
 
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index d2e6ca9abbe0..c1959661bf63 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
 obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
 obj-$(CONFIG_RENESAS_RPCIF)	+= renesas-rpc-if.o
 obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
+obj-$(CONFIG_STM32_OMM)		+= stm32_omm.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/stm32_omm.c b/drivers/memory/stm32_omm.c
new file mode 100644
index 000000000000..6f20fe0183ec
--- /dev/null
+++ b/drivers/memory/stm32_omm.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL
+/*
+ * Copyright (C) STMicroelectronics 2024 - All Rights Reserved
+ * Author(s): Patrice Chotard <patrice.chotard@foss.st.com> for STMicroelectronics.
+ */
+
+#include <linux/bus/stm32_firewall_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define OMM_CR			0
+#define CR_MUXEN		BIT(0)
+#define CR_MUXENMODE_MASK	GENMASK(1, 0)
+#define CR_CSSEL_OVR_EN		BIT(4)
+#define CR_CSSEL_OVR_MASK	GENMASK(6, 5)
+#define CR_REQ2ACK_MASK		GENMASK(23, 16)
+
+#define OMM_CHILD_NB		2
+
+struct ospi_child {
+	struct device *dev;
+	struct device_node *node;
+	struct clk *clk;
+};
+
+struct stm32_omm {
+	struct ospi_child child[OMM_CHILD_NB];
+	struct resource *mm_res;
+	struct clk *clk;
+	void __iomem *io_base;
+	u32 cr;
+	u8 nb_child;
+	bool restore_omm;
+};
+
+static int stm32_omm_set_amcr(struct device *dev, bool set)
+{
+	struct stm32_omm *omm = dev_get_drvdata(dev);
+	struct regmap *syscfg_regmap;
+	struct device_node *node;
+	struct resource res, res1;
+	resource_size_t mm_ospi2_size = 0;
+	u32 amcr_base, amcr_mask;
+	int ret, i;
+	unsigned int amcr, read_amcr;
+
+	for (i = 0; i < omm->nb_child; i++) {
+		/* res1 only used on second loop iteration */
+		res1.start = res.start;
+		res1.end = res.end;
+
+		node = of_parse_phandle(dev->of_node, "memory-region", i);
+		if (!node)
+			continue;
+
+		ret = of_address_to_resource(node, 0, &res);
+		if (ret) {
+			dev_err(dev, "unable to resolve memory region\n");
+			return ret;
+		}
+
+		/* check that memory region fits inside OMM memory map area */
+		if (!resource_contains(omm->mm_res, &res)) {
+			dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside OMM memory map area [0x%llx-0x%llx]\n",
+				res.start, res.end,
+				omm->mm_res->start, omm->mm_res->end);
+
+			return -EFAULT;
+		}
+
+		if (i == 1) {
+			mm_ospi2_size = resource_size(&res);
+
+			/* check that OMM memory region 1 doesn't overlap memory region 2 */
+			if (resource_overlaps(&res, &res1)) {
+				dev_err(dev, "[0x%llx-0x%llx] overlaps OMM memory map area [0x%llx-0x%llx]\n",
+					res1.start, res1.end, res.start, res.end);
+
+				return -EFAULT;
+			}
+		}
+	}
+
+	syscfg_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "st,syscfg-amcr");
+	if (IS_ERR(syscfg_regmap)) {
+		dev_err(dev, "Failed to get st,syscfg-amcr property\n");
+		return PTR_ERR(syscfg_regmap);
+	}
+
+	ret = of_property_read_u32_index(dev->of_node, "st,syscfg-amcr", 1,
+					 &amcr_base);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(dev->of_node, "st,syscfg-amcr", 2,
+					 &amcr_mask);
+	if (ret)
+		return ret;
+
+	amcr = mm_ospi2_size / SZ_64M;
+
+	if (set)
+		regmap_update_bits(syscfg_regmap, amcr_base, amcr_mask, amcr);
+
+	/* read AMCR and check coherency with memory-map areas defined in DT */
+	regmap_read(syscfg_regmap, amcr_base, &read_amcr);
+	read_amcr = read_amcr >> (ffs(amcr_mask) - 1);
+
+	if (amcr != read_amcr) {
+		dev_err(dev, "AMCR value not coherent with DT memory-map areas\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int stm32_omm_enable_child_clock(struct device *dev, bool enable)
+{
+	/* As there is only 2 children, remember first child in case of error */
+	struct clk *first_child_clk = NULL;
+	struct stm32_omm *omm = dev_get_drvdata(dev);
+	u8 i;
+	int ret;
+
+	for (i = 0; i < omm->nb_child; i++) {
+		if (enable) {
+			ret = clk_prepare_enable(omm->child[i].clk);
+			if (ret) {
+				if (first_child_clk)
+					clk_disable_unprepare(first_child_clk);
+
+				dev_err(dev, "Can not enable clock\n");
+				return ret;
+			}
+		} else {
+			clk_disable_unprepare(omm->child[i].clk);
+		}
+
+		first_child_clk = omm->child[i].clk;
+	}
+
+	return 0;
+}
+
+static int stm32_omm_configure(struct device *dev)
+{
+	struct stm32_omm *omm = dev_get_drvdata(dev);
+	struct reset_control *rstc;
+	unsigned long clk_rate, clk_rate_max = 0;
+	int ret;
+	u8 i;
+	u32 mux = 0;
+	u32 cssel_ovr = 0;
+	u32 req2ack = 0;
+
+	omm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(omm->clk)) {
+		dev_err(dev, "Failed to get OMM clock (%ld)\n",
+			PTR_ERR(omm->clk));
+
+		return PTR_ERR(omm->clk);
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	/* parse children's clock */
+	for (i = 0; i < omm->nb_child; i++) {
+		clk_rate = clk_get_rate(omm->child[i].clk);
+		if (!clk_rate) {
+			dev_err(dev, "Invalid clock rate\n");
+			goto err_clk_disable;
+		}
+
+		if (clk_rate > clk_rate_max)
+			clk_rate_max = clk_rate;
+	}
+
+	rstc = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(rstc)) {
+		ret = dev_err_probe(dev, PTR_ERR(rstc), "reset get failed\n");
+		goto err_clk_disable;
+	}
+
+	reset_control_assert(rstc);
+	udelay(2);
+	reset_control_deassert(rstc);
+
+	omm->cr = readl_relaxed(omm->io_base + OMM_CR);
+	/* optional */
+	ret = of_property_read_u32(dev->of_node, "st,omm-mux", &mux);
+	if (!ret) {
+		if (mux & CR_MUXEN) {
+			ret = of_property_read_u32(dev->of_node, "st,omm-req2ack-ns",
+						   &req2ack);
+			if (!ret && !req2ack) {
+				req2ack = DIV_ROUND_UP(req2ack, NSEC_PER_SEC / clk_rate_max) - 1;
+
+				if (req2ack > 256)
+					req2ack = 256;
+			}
+
+			req2ack = FIELD_PREP(CR_REQ2ACK_MASK, req2ack);
+
+			omm->cr &= ~CR_REQ2ACK_MASK;
+			omm->cr |= FIELD_PREP(CR_REQ2ACK_MASK, req2ack);
+
+			/*
+			 * If the mux is enabled, the 2 OSPI clocks have to be
+			 * always enabled
+			 */
+			ret = stm32_omm_enable_child_clock(dev, true);
+			if (ret)
+				goto err_clk_disable;
+		}
+
+		omm->cr &= ~CR_MUXENMODE_MASK;
+		omm->cr |= FIELD_PREP(CR_MUXENMODE_MASK, mux);
+	}
+
+	/* optional */
+	ret = of_property_read_u32(dev->of_node, "st,omm-cssel-ovr", &cssel_ovr);
+	if (!ret) {
+		omm->cr &= ~CR_CSSEL_OVR_MASK;
+		omm->cr |= FIELD_PREP(CR_CSSEL_OVR_MASK, cssel_ovr);
+		omm->cr |= CR_CSSEL_OVR_EN;
+	}
+
+	omm->restore_omm = true;
+	writel_relaxed(omm->cr, omm->io_base + OMM_CR);
+
+	ret = stm32_omm_set_amcr(dev, true);
+
+err_clk_disable:
+	pm_runtime_put_sync_suspend(dev);
+
+	return ret;
+}
+
+static int stm32_omm_check_access(struct device *dev, struct device_node *np)
+{
+	struct stm32_firewall firewall;
+	int ret;
+
+	ret = stm32_firewall_get_firewall(np, &firewall, 1);
+	if (ret)
+		return ret;
+
+	return stm32_firewall_grant_access(&firewall);
+}
+
+static int stm32_omm_disable_child(struct device *dev)
+{
+	struct stm32_omm *omm = dev_get_drvdata(dev);
+	struct reset_control *reset;
+	int ret;
+	u8 i;
+
+	for (i = 0; i < omm->nb_child; i++) {
+		ret = clk_prepare_enable(omm->child[i].clk);
+		if (ret) {
+			dev_err(dev, "Can not enable clock\n");
+			return ret;
+		}
+
+		reset = of_reset_control_get_exclusive(omm->child[i].node, 0);
+		if (IS_ERR(reset)) {
+			dev_err(dev, "Can't get child reset\n");
+			return PTR_ERR(reset);
+		};
+
+		/* reset OSPI to ensure CR_EN bit is set to 0 */
+		reset_control_assert(reset);
+		udelay(2);
+		reset_control_deassert(reset);
+
+		reset_control_put(reset);
+		clk_disable_unprepare(omm->child[i].clk);
+	}
+
+	return 0;
+}
+
+static int stm32_omm_probe(struct platform_device *pdev)
+{
+	struct platform_device *vdev;
+	struct device *dev = &pdev->dev;
+	struct stm32_omm *omm;
+	struct clk *clk;
+	int ret;
+	u8 child_access_granted = 0;
+	u8 i, j;
+	bool child_access[OMM_CHILD_NB];
+
+	omm = devm_kzalloc(dev, sizeof(*omm), GFP_KERNEL);
+	if (!omm)
+		return -ENOMEM;
+
+	omm->io_base = devm_platform_ioremap_resource_byname(pdev, "regs");
+	if (IS_ERR(omm->io_base))
+		return PTR_ERR(omm->io_base);
+
+	omm->mm_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory_map");
+	if (IS_ERR(omm->mm_res))
+		return PTR_ERR(omm->mm_res);
+
+	/* check child's access */
+	for_each_child_of_node_scoped(dev->of_node, child) {
+		if (omm->nb_child >= OMM_CHILD_NB) {
+			dev_err(dev, "Bad DT, found too much children\n");
+			ret = -E2BIG;
+			goto err_clk_release;
+		}
+
+		if (!of_device_is_compatible(child, "st,stm32mp25-ospi")) {
+			ret = -EINVAL;
+			goto err_clk_release;
+		}
+
+		ret = stm32_omm_check_access(dev, child);
+		if (ret < 0 && ret != -EACCES)
+			goto err_clk_release;
+
+		child_access[omm->nb_child] = false;
+		if (!ret) {
+			child_access_granted++;
+			child_access[omm->nb_child] = true;
+		}
+
+		omm->child[omm->nb_child].node = child;
+
+		clk = of_clk_get(child, 0);
+		if (IS_ERR(clk)) {
+			dev_err(dev, "Can't get child clock\n");
+			ret = PTR_ERR(clk);
+			goto err_clk_release;
+		};
+
+		omm->child[omm->nb_child].clk = clk;
+		omm->nb_child++;
+	}
+
+	if (omm->nb_child != OMM_CHILD_NB) {
+		ret = -EINVAL;
+		goto err_clk_release;
+	}
+
+	platform_set_drvdata(pdev, omm);
+
+	pm_runtime_enable(dev);
+
+	/* check if OMM's resource access is granted */
+	ret = stm32_omm_check_access(dev, dev->of_node);
+	if (ret < 0 && ret != -EACCES)
+		goto err_clk_release;
+
+	if (!ret && child_access_granted == OMM_CHILD_NB) {
+		/* Ensure both OSPI instance are disabled before configuring OMM */
+		ret = stm32_omm_disable_child(dev);
+		if (ret)
+			goto err_clk_release;
+
+		ret = stm32_omm_configure(dev);
+		if (ret)
+			goto err_clk_release;
+	} else {
+		dev_dbg(dev, "Octo Memory Manager resource's access not granted\n");
+		/*
+		 * AMCR can't be set, so check if current value is coherent
+		 * with memory-map areas defined in DT
+		 */
+		ret = stm32_omm_set_amcr(dev, false);
+		if (ret)
+			goto err_clk_release;
+	}
+
+	/* for each child, if resource access is granted and status "okay", probe it */
+	for (i = 0; i < omm->nb_child; i++) {
+		if (!child_access[i] || !of_device_is_available(omm->child[i].node))
+			continue;
+
+		vdev = of_platform_device_create(omm->child[i].node, NULL, NULL);
+		if (!vdev) {
+			dev_err(dev, "Failed to create Octo Memory Manager child\n");
+			for (j = i; j > 0; --j) {
+				if (omm->child[j].dev)
+					of_platform_device_destroy(omm->child[j].dev, NULL);
+			}
+
+			ret = -EINVAL;
+			goto err_clk_release;
+		}
+		omm->child[i].dev = &vdev->dev;
+	}
+
+err_clk_release:
+	for (i = 0; i < omm->nb_child; i++)
+		clk_put(omm->child[i].clk);
+
+	return ret;
+}
+
+static void stm32_omm_remove(struct platform_device *pdev)
+{
+	struct stm32_omm *omm = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < omm->nb_child; i++)
+		if (omm->child[i].dev)
+			of_platform_device_destroy(omm->child[i].dev, NULL);
+
+	if (omm->cr & CR_MUXEN)
+		stm32_omm_enable_child_clock(&pdev->dev, false);
+
+	pm_runtime_disable(&pdev->dev);
+}
+
+static const struct of_device_id stm32_omm_of_match[] = {
+	{ .compatible = "st,stm32mp25-omm", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_omm_of_match);
+
+static int __maybe_unused stm32_omm_runtime_suspend(struct device *dev)
+{
+	struct stm32_omm *omm = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(omm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_omm_runtime_resume(struct device *dev)
+{
+	struct stm32_omm *omm = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(omm->clk);
+}
+
+static int __maybe_unused stm32_omm_suspend(struct device *dev)
+{
+	struct stm32_omm *omm = dev_get_drvdata(dev);
+
+	if (omm->restore_omm && omm->cr & CR_MUXEN)
+		stm32_omm_enable_child_clock(dev, false);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int __maybe_unused stm32_omm_resume(struct device *dev)
+{
+	struct stm32_omm *omm = dev_get_drvdata(dev);
+	int ret;
+
+	pinctrl_pm_select_default_state(dev);
+
+	if (!omm->restore_omm)
+		return 0;
+
+	/* Ensure both OSPI instance are disabled before configuring OMM */
+	ret = stm32_omm_disable_child(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	writel_relaxed(omm->cr, omm->io_base + OMM_CR);
+	ret = stm32_omm_set_amcr(dev, true);
+	pm_runtime_put_sync_suspend(dev);
+	if (ret)
+		return ret;
+
+	if (omm->cr & CR_MUXEN)
+		ret = stm32_omm_enable_child_clock(dev, true);
+
+	return ret;
+}
+
+static const struct dev_pm_ops stm32_omm_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_omm_runtime_suspend,
+			   stm32_omm_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_omm_suspend, stm32_omm_resume)
+};
+
+static struct platform_driver stm32_omm_driver = {
+	.probe	= stm32_omm_probe,
+	.remove = stm32_omm_remove,
+	.driver	= {
+		.name = "stm32-omm",
+		.of_match_table = stm32_omm_of_match,
+		.pm = &stm32_omm_pm_ops,
+	},
+};
+module_platform_driver(stm32_omm_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics Octo Memory Manager driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


