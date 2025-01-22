Return-Path: <linux-spi+bounces-6428-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9ADA19384
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 15:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3B61882ECB
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B9D21421D;
	Wed, 22 Jan 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="g9MK4xlI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732F2139A6;
	Wed, 22 Jan 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555213; cv=none; b=VeKWfvi6h0hMJqa44Q8NR/YNS3bStP+w2jHKVosXSAl4qJSkESyYMDAXLC++eEq8e1cjXAc8n7SCFZX/9tvHyDIxwz2fAMFePtdZsHFdSrplFnSR1rL92GBMtzdPKKJFY7/nHLpsIvPiJT5Fq+nqfOyk3rGTYrK5bSAhECj2wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555213; c=relaxed/simple;
	bh=OSgPk495ZlNTMLdxZ5ZedxV7pqWaumdQ7VX3vrgOtF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pi4/Tlh1103rzfklYwJ0uUiqMoVg8pjR4C91mgQeu1UEP8JhDS/qgaZSSyfi4IBwG0mApkwgPzvybx8nWBWgaC1/iLVOQbct55SmVZz/yNax/DTEYizsk6LXtUMtWL3CPRnEtc6A0tiIy45/2HHxzVchEDuyLWrbTh+xMJnthrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=g9MK4xlI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9O3Za030596;
	Wed, 22 Jan 2025 15:12:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	KY4FbpfB4k51CItTSkUmvWf7FP6qBekgr/79vLqfXQg=; b=g9MK4xlIru897oN3
	muQ5ZRuj0V5vzqWUstMKwp6u85VnNHpzJ9yhKrj3Lg6GqIfMV2x/G0wzD792bEOP
	G+p7GrmnJJAtvXTrXkz/LH0/I67Yks4tFQMH7gBw1nif0aW0efxyYPIcP1W0OJEQ
	MEKXDs9GMKda6/BUtg+RR7/lwPMdf3mSck39rTTKswG+1rGLHsElYJEZdlI10R6L
	eMaHU0BS7OU0LXdhDaAnSc17DsPWk+16QL/JHUW1reLQvZZiZpLaD822edaTCHf9
	js5+r/BMsLN+k0hfkON0IPqLlGmZF2f69PFnWsQYZX8BYRdvX41EZwHpgz6lEQ4q
	DKvEgg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44aex0umah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:12:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3484040056;
	Wed, 22 Jan 2025 15:11:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6077029947A;
	Wed, 22 Jan 2025 15:10:42 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 22 Jan
 2025 15:10:42 +0100
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
Subject: [PATCH 4/9] misc: Add STM32 Octo Memory Manager driver
Date: Wed, 22 Jan 2025 15:10:32 +0100
Message-ID: <20250122141037.953934-5-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122141037.953934-1-patrice.chotard@foss.st.com>
References: <20250122141037.953934-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01

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
 drivers/misc/Kconfig     |  17 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/stm32_omm.c | 510 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 528 insertions(+)
 create mode 100644 drivers/misc/stm32_omm.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 56bc72c7ce4a..a6be09505ee5 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -467,6 +467,23 @@ config DW_XDATA_PCIE
 
 	  If unsure, say N.
 
+config STM32_OMM
+	bool "STM32 Octo Memory Manager"
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
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 545aad06d088..a20c1cb6e663 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -75,3 +75,4 @@ lan966x-pci-objs		:= lan966x_pci.o
 lan966x-pci-objs		+= lan966x_pci.dtbo.o
 obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
+obj-$(CONFIG_STM32_OMM)		+= stm32_omm.o
diff --git a/drivers/misc/stm32_omm.c b/drivers/misc/stm32_omm.c
new file mode 100644
index 000000000000..3a064c4b30f1
--- /dev/null
+++ b/drivers/misc/stm32_omm.c
@@ -0,0 +1,510 @@
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
+	struct reset_control *reset;
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
+	static const char * const mm_name[] = { "mm_ospi1", "mm_ospi2" };
+	u32 amcr_base, amcr_mask;
+	int ret, i, idx;
+	unsigned int amcr, read_amcr;
+
+	for (i = 0; i < omm->nb_child; i++) {
+		idx = of_property_match_string(dev->of_node,
+					       "memory-region-names",
+					       mm_name[i]);
+		if (idx < 0)
+			continue;
+
+		/* res1 only used on second loop iteration */
+		res1.start = res.start;
+		res1.end = res.end;
+
+		node = of_parse_phandle(dev->of_node, "memory-region", idx);
+		ret = of_address_to_resource(node, 0, &res);
+		if (ret) {
+			dev_err(dev, "unable to resolve memory region\n");
+			return ret;
+		}
+
+		/* check that memory region fits inside OMM memory map area */
+		if (!resource_contains(omm->mm_res, &res)) {
+			dev_err(dev, "%s doesn't fit inside OMM memory map area\n",
+				mm_name[i]);
+			dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
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
+				dev_err(dev, "OMM memory-region %s overlaps memory region %s\n",
+					mm_name[0], mm_name[1]);
+				dev_err(dev, "[0x%llx-0x%llx] overlaps [0x%llx-0x%llx]\n",
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
+						  &req2ack);
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
+	u8 i;
+	int ret;
+
+	for (i = 0; i < omm->nb_child; i++) {
+		ret = clk_prepare_enable(omm->child[i].clk);
+		if (ret) {
+			dev_err(dev, "Can not enable clock\n");
+			return ret;
+		}
+
+		/* reset OSPI to ensure CR_EN bit is set to 0 */
+		reset_control_assert(omm->child[i].reset);
+		udelay(2);
+		reset_control_deassert(omm->child[i].reset);
+
+		reset_control_put(omm->child[i].reset);
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
+	int ret;
+	u8 child_access_granted = 0;
+	u8 i, j;
+	bool child_access[OMM_CHILD_NB];
+
+	omm = devm_kzalloc(dev, sizeof(*omm), GFP_KERNEL);
+	if (!omm)
+		return -ENOMEM;
+
+	omm->io_base = devm_platform_ioremap_resource_byname(pdev, "omm");
+	if (IS_ERR(omm->io_base))
+		return PTR_ERR(omm->io_base);
+
+	omm->mm_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "omm_mm");
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
+		omm->child[omm->nb_child].clk = of_clk_get(child, 0);
+		omm->child[omm->nb_child].reset = of_reset_control_get_exclusive(child, 0);
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
+	return 0;
+
+err_clk_release:
+	for (i = 0; i < omm->nb_child; i++) {
+		clk_put(omm->child[i].clk);
+		reset_control_put(omm->child[i].reset);
+	}
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
+	for (i = 0; i < omm->nb_child; i++) {
+		clk_put(omm->child[i].clk);
+		reset_control_put(omm->child[i].reset);
+	};
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


