Return-Path: <linux-spi+bounces-3632-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1791ACCF
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40891F26F30
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254E119AA70;
	Thu, 27 Jun 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="pf/N52Ok"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C719AA5E
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505770; cv=none; b=JRWZNk0aaKM6/aOmOUqOCzyONgJuzyDrfKjufS8sfA8YMUz8NMgaAgDrbg2I4hw63+dntO1SjtApOuH5Ka512N8WSzBLlIHxTVHWaAiUNNeIPQbkUoQpPnSliOCLJk08p5jgVox/e5fZxhY9v5dUkAjiULM3wnQe987XVsbksCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505770; c=relaxed/simple;
	bh=WoVhoW5NvKUcUTYxClHtsBC4qaRwvpudUw/hgpnVaAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOC7ac5Jklg/x9daTiJtsvfvcrtJEi0mP2T2akTAf8wk5g0yGAqcet2ZThid20VUn49hBprFHMwZ4cBxnO8/i0pegxvyUU5W9IfqL12RqIN35vvABCwxvmwHVD5wQC6px/cQ+Z7jq324D9AgJf6gBid3weXqyuC/Q3I6EMOxoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=pf/N52Ok; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3745eeedc76so3200935ab.0
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719505766; x=1720110566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bfrOPZFpalSMaAS4PqOt0l9wak2sxgz4QQtL4YtP3I=;
        b=pf/N52OkwjcT0qO6Da/+NqmukBGiqcYZzyrxm6YLvD+PS6hyZQHx/UqrfPB82aXHXn
         aV5l/8vcveIDGXgTtTi+F56cMZ7CaNfxac/qa6LCf0pQSJi33zTw9hrq6EQLD0tWbFHo
         b6E2n8PCon5Ru6Qp8C/9CnJDVEWrZqmlJq/VE/UH7yGkETYHV5CZobGIraPwvBq7ecC6
         bYfPS5EYgv/9gR28EWxnlcXWGO8Wa9YJWUe1O3aQGNWgs6P14G6r19cjgaHyGB1+Dekl
         pNGGYGXwBblE87uTkkR6dkhokB+P40mZ7HfpKTcp0MDX/kYxmlAblwjj6AySBuVP2Hj2
         uwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505766; x=1720110566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bfrOPZFpalSMaAS4PqOt0l9wak2sxgz4QQtL4YtP3I=;
        b=PooHexZdgtrdIQsG3oqCdATDRivFEWbCc1KnzoV/+yZoUH5zeONrDZDEWvf2MdgWQx
         InfxlLJPuC+Qm57lsKJogSVyGyyhBN6LWo+d29KW3mcRmPZOwO9s6ORujQb5qO349Tin
         gjwhXIySEkvmIk2jSXtDudpJ+2nfeQJyLKD/4RUF7hDYnWf9JnHG388dxdWg8ISp50Mb
         Q7n+lAhTuJbIhlj1uR1gp/95d5gJjwoHZQQEGlS+2Ty9lBYN5lMfFHZKl6WMOnuqERFH
         8XCvd7WSVJlRZBtsMZ3GXuBqSDqcNUDZsk8awRnbKNKgey8rg0go7auSK5iff1BLN+dD
         DwnQ==
X-Gm-Message-State: AOJu0YwhBYqPPQBgE5v3AehZd2Gy4mGFpKWoAoqSKge3qdpFqggKe5QE
	87n2OURxYQeNWh4o+w0hk+arIbq6K5xRYQHvBpJAANYj+ToqsuW2MNlh6NUlXg==
X-Google-Smtp-Source: AGHT+IFGYU63T/oSxgM+A/eQpByDC/Ouyy7zftKpv3HGC+fCi8ImTDpADN0e5OgU0x+zSxAjYtwXCA==
X-Received: by 2002:a05:6e02:1303:b0:376:38c5:5cf2 with SMTP id e9e14a558f8ab-37638c55fcfmr140649355ab.1.1719505765939;
        Thu, 27 Jun 2024 09:29:25 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:1f3e:18b0:e4e6:ed1:4c03:dcec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58dbdsm1560739b3a.198.2024.06.27.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:29:25 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 27 Jun 2024 21:56:16 +0530
Subject: [PATCH v5 6/7] mikrobus: Add mikroBUS driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-mikrobus-scratch-spi-v5-6-9e6c148bf5f0@beagleboard.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
To: Mark Brown <broonie@kernel.org>, 
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11731;
 i=ayush@beagleboard.org; h=from:subject:message-id;
 bh=WoVhoW5NvKUcUTYxClHtsBC4qaRwvpudUw/hgpnVaAc=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmfZM4R0dGTAnMs7uGqJCgVYKtNuon/Ak3JVoC9
 m7HsTKtHP6JAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZn2TOAAKCRAFzvXHieVa
 dDM2EADlgFfHuVhxzRAUFXYWHUVshXFxWppVaI2v5v3WGzmcm7zvWzdbsomUorOAM4w2QFCwsDN
 PJZej/v53j1864dRgzEt//OCLG0Aml64rVd+A18JSeWFilp2+8IqsCWCC49xieiGaKAjnR9/FXi
 GAk11s6XWPPCFd1vEnja3OE1Kp6TZcNaIf9jsYW6LKRYYDEh89rEqiLAWf0agyxJQMO+1OavFx+
 6Hdtkf/HlsY+H73meaETjIVWM1AXvt988Yu0kvkhida8VG4/+kVWKijsCtx+cdXkWOTD1BsGftQ
 euSOSzywcmO2/KIiLCmKxBxbHjB1dbmh4af3EJsLGPfn+TYpVjzl8cD0XKPs1lihcKpBDZ37uQC
 2CIdQtSUaEAhEyT1+/HGqKcy+dh+yOaUSS4ZhBLQqzJ57Xay5MdPdJaXqoTwgW25EC+zhNvHZHH
 8nmOg2DG2sX/x4efwlJREEYyn3xyI/qJwrtAcGnq+pUcH3p2uMkw8HZZ7lbSk6VSPdkV70BARQB
 HDZJn9s81iYNlOXQ9jIs0G6/PdCGpDKccBo+YhRrTQs3TxT40N42FRHWkGVw4+AmwQyMx5hzg7c
 P+KRXpRdpDc7U2qHN//R/Fhmgo1UKO0Mys4bonya867dRAYlX/GsHCjVMOzi6a6d7nhxWhgrEaH
 4XGDW5tOTotTdbg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Adds support for SPI mikroBUS addon boards with configuration based on
device tree. The goal is to get a minimal version in mainline to sort
out the device tree structure that should be used.

A mikroBUS board can use any combination of the following based protocols:
I2C, SPI, UART, PWM, Analog, GPIO with possibility of all pins being used
as GPIO instead of their original purpose. This requires the driver to be
flexible and identify the type of board based on the compatible string.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 MAINTAINERS             |   1 +
 drivers/misc/Kconfig    |  16 +++
 drivers/misc/Makefile   |   1 +
 drivers/misc/mikrobus.c | 361 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 379 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88f2b3adc824..01a0ac261e6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15115,6 +15115,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
 F:	Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
 F:	Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml
+F:	drivers/misc/mikrobus.c
 
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index faf983680040..320f408cc612 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -585,6 +585,22 @@ config NSM
 	  To compile this driver as a module, choose M here.
 	  The module will be called nsm.
 
+menuconfig MIKROBUS
+	tristate "Module for instantiating devices on mikroBUS ports"
+	depends on GPIOLIB
+	help
+	  This option enables the mikroBUS driver. mikroBUS is an add-on
+	  board socket standard that offers maximum expandability with
+	  the smallest number of pins. The mikroBUS driver instantiates
+	  devices on a mikroBUS port described mikroBUS manifest which is
+	  passed using a sysfs interface.
+
+
+	  Say Y here to enable support for this driver.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called mikrobus.ko
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 153a3f4837e8..f10f1414270b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
+obj-$(CONFIG_MIKROBUS)		+= mikrobus.o
diff --git a/drivers/misc/mikrobus.c b/drivers/misc/mikrobus.c
new file mode 100644
index 000000000000..bf160a0e8903
--- /dev/null
+++ b/drivers/misc/mikrobus.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0:
+/*
+ * Copyright 2024 Ayush Singh <ayush@beagleboard.org>
+ */
+
+#define pr_fmt(fmt) "mikrobus:%s: " fmt, __func__
+
+#include <linux/device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/spi/spi.h>
+
+struct mikrobus_spi_cs_item {
+	const char *cs_name;
+	u32 cs;
+};
+
+/**
+ * struct mikrobus_port - MikroBUS Driver
+ *
+ * @dev: underlying platform_device
+ * @board_ocs: board device tree changeset
+ * @pinctrl: mikroBUS pinctrl
+ * @mikrobus_spi_cs: list of supported chipselect address and name
+ * @mikrobus_spi_cs_count: length of mikrobus_spi_cs
+ * @spi_ctrl: spi controller of mikroBUS connector
+ * @spi_dev: spi mikroBUS board
+ */
+struct mikrobus_port {
+	struct platform_device *dev;
+	struct of_changeset board_ocs;
+	struct pinctrl *pctrl;
+
+	struct mikrobus_spi_cs_item *spi_cs;
+	int spi_cs_count;
+	struct spi_controller *spi_ctrl;
+	struct spi_device *spi_dev;
+};
+
+/*
+ * mikrobus_pinctrl_select: Select pinctrl state for mikrobus pin
+ *
+ * @port: mikrobus port
+ * @pinctrl_selected: pinctrl state to be selected
+ */
+static int mikrobus_pinctrl_select(struct device *dev,
+				   const char *pinctrl_selected)
+{
+	int ret;
+	struct pinctrl_state *state;
+	struct mikrobus_port *mb = dev_get_drvdata(dev);
+
+	state = pinctrl_lookup_state(mb->pctrl, pinctrl_selected);
+	if (IS_ERR(state))
+		return dev_err_probe(dev, PTR_ERR(state),
+				     "failed to find state %s",
+				     pinctrl_selected);
+
+	ret = pinctrl_select_state(mb->pctrl, state);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to select state %s",
+				     pinctrl_selected);
+
+	dev_dbg_ratelimited(dev, "setting pinctrl %s", pinctrl_selected);
+
+	return 0;
+}
+
+/*
+ * mikrobus_lookup_cs - lookup mikroBUS SPI chipselect by name
+ *
+ * @mb: mikroBUS port
+ * @cs_name: chipselect name
+ */
+static int mikrobus_lookup_cs(const struct mikrobus_port *mb,
+			      const char *cs_name)
+{
+	for (int i = 0; i < mb->spi_cs_count; ++i) {
+		if (strcmp(cs_name, mb->spi_cs[i].cs_name) == 0)
+			return mb->spi_cs[i].cs;
+	}
+
+	return -1;
+}
+
+static int mikrobus_spi_set_cs(struct device *dev, struct device_node *np)
+{
+	struct mikrobus_port *mb = dev_get_drvdata(dev);
+	const char *temp_str;
+	int reg_len;
+	int ret, i;
+	u32 *reg = NULL;
+
+	reg_len = of_property_count_strings(np, "spi-cs");
+	/* Use default cs if spi-cs property not present */
+	if (reg_len <= 0) {
+		reg_len = 1;
+		reg = devm_kmalloc_array(dev, reg_len, sizeof(*reg),
+					 GFP_KERNEL);
+		if (!reg)
+			return -ENOMEM;
+
+		ret = mikrobus_lookup_cs(mb, "default");
+		if (ret < 0)
+			goto free_reg;
+
+		reg[0] = ret;
+	} else {
+		reg = devm_kmalloc_array(dev, reg_len, sizeof(*reg),
+					 GFP_KERNEL);
+		if (!reg)
+			return -ENOMEM;
+
+		for (i = 0; i < reg_len; ++i) {
+			ret = of_property_read_string_index(np, "spi-cs", i,
+							    &temp_str);
+			if (ret < 0)
+				goto free_reg;
+
+			ret = mikrobus_lookup_cs(mb, temp_str);
+			if (ret < 0)
+				goto free_reg;
+
+			reg[i] = ret;
+		}
+	}
+
+	ret = of_changeset_add_prop_u32_array(&mb->board_ocs, np, "reg", reg,
+					      reg_len);
+	if (ret < 0)
+		goto free_reg;
+
+	ret = of_changeset_apply(&mb->board_ocs);
+	if (ret < 0)
+		goto free_reg;
+
+	devm_kfree(dev, reg);
+	return 0;
+
+free_reg:
+	devm_kfree(dev, reg);
+	return ret;
+}
+
+static int of_register_mikrobus_device(struct mikrobus_port *mb,
+				       struct device_node *np)
+{
+	const char *temp_str;
+	int i, pinctrl_count, ret;
+	struct spi_device *spi_dev;
+	struct device *dev = &mb->dev->dev;
+
+	pinctrl_count = of_property_count_strings(np, "pinctrl-apply");
+	if (pinctrl_count < 0)
+		return dev_err_probe(dev, pinctrl_count,
+				     "Missing required property pinctrl-apply");
+
+	for (i = 0; i < pinctrl_count; ++i) {
+		ret = of_property_read_string_index(np, "pinctrl-apply", i,
+						    &temp_str);
+		if (ret < 0)
+			return ret;
+
+		ret = mikrobus_pinctrl_select(dev, temp_str);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Failed to set pinctrl");
+	}
+
+	if (mb->spi_ctrl && !mb->spi_dev &&
+	    of_device_is_compatible(np, "mikrobus-spi")) {
+		ret = mikrobus_spi_set_cs(dev, np);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to set SPI chipselect");
+
+		spi_dev = of_register_spi_device(mb->spi_ctrl, np);
+		if (IS_ERR(spi_dev))
+			return dev_err_probe(dev, PTR_ERR(spi_dev),
+					     "Failed to register SPI device");
+		mb->spi_dev = spi_dev;
+	}
+
+	return 0;
+}
+
+static int of_register_mikrobus_board(struct mikrobus_port *mb)
+{
+	struct device *dev = &mb->dev->dev;
+	int board_len, i, ret;
+	struct device_node *np;
+
+	board_len = of_count_phandle_with_args(dev->of_node, "board", NULL);
+	for (i = 0; i < board_len; ++i) {
+		np = of_parse_phandle(dev->of_node, "board", i);
+		if (!np) {
+			ret = dev_err_probe(dev, -ENODEV, "Board not found");
+			goto free_np;
+		}
+
+		ret = of_register_mikrobus_device(mb, np);
+		if (ret < 0)
+			goto free_np;
+
+		of_node_put(np);
+	}
+
+	return 0;
+free_np:
+	of_node_put(np);
+	return ret;
+}
+
+static int mikrobus_port_probe(struct platform_device *pdev)
+{
+	int ret, i;
+	struct mikrobus_port *mb;
+	struct device_node *np;
+	struct device *dev = &pdev->dev;
+
+	mb = devm_kmalloc(dev, sizeof(*mb), GFP_KERNEL);
+	if (!mb)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, mb);
+
+	of_changeset_init(&mb->board_ocs);
+	mb->dev = pdev;
+	mb->pctrl = NULL;
+	mb->spi_ctrl = NULL;
+	mb->spi_dev = NULL;
+	mb->spi_cs = NULL;
+	mb->spi_cs_count = 0;
+
+	mb->pctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(mb->pctrl))
+		return dev_err_probe(dev, PTR_ERR(mb->pctrl),
+				     "failed to get pinctrl [%ld]",
+				     PTR_ERR(mb->pctrl));
+
+	np = of_parse_phandle(dev->of_node, "spi-controller", 0);
+	if (np) {
+		mb->spi_ctrl = of_find_spi_controller_by_node(np);
+		if (mb->spi_ctrl) {
+			ret = of_property_count_u32_elems(dev->of_node,
+							  "spi-cs");
+			if (ret < 0) {
+				dev_err(dev, "Missing property spi-cs");
+				goto free_np;
+			}
+
+			mb->spi_cs_count = ret;
+
+			ret = of_property_count_strings(dev->of_node,
+							"spi-cs-names");
+			if (ret < 0) {
+				dev_err(dev, "Missing property spi-cs-names");
+				goto free_np;
+			}
+
+			if (mb->spi_cs_count != ret) {
+				ret = dev_err_probe(
+					dev, -EINVAL,
+					"spi-cs and spi-cs-names out of sync");
+				goto free_np;
+			}
+
+			mb->spi_cs = devm_kmalloc_array(dev, mb->spi_cs_count,
+							sizeof(*mb->spi_cs),
+							GFP_KERNEL);
+			if (!mb->spi_cs) {
+				ret = -ENOMEM;
+				goto free_np;
+			}
+
+			for (i = 0; i < mb->spi_cs_count; ++i) {
+				of_property_read_u32_index(dev->of_node,
+							   "spi-cs", i,
+							   &mb->spi_cs->cs);
+				of_property_read_string_index(
+					dev->of_node, "spi-cs-names", i,
+					&mb->spi_cs->cs_name);
+			}
+		}
+	}
+	of_node_put(np);
+
+	ret = of_register_mikrobus_board(mb);
+	if (ret < 0)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to register mikrobus board");
+
+	return 0;
+
+free_np:
+	of_node_put(np);
+	return ret;
+}
+
+static void mikrobus_port_remove(struct platform_device *pdev)
+{
+	struct mikrobus_port *mb = dev_get_drvdata(&pdev->dev);
+
+	spi_unregister_device(mb->spi_dev);
+
+	of_changeset_revert(&mb->board_ocs);
+}
+
+static const struct of_device_id mikrobus_port_of_match[] = {
+	{ .compatible = "mikrobus-connector" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mikrobus_port_of_match);
+
+static struct platform_driver mikrobus_port_driver = {
+	.probe = mikrobus_port_probe,
+	.remove = mikrobus_port_remove,
+	.driver = {
+		.name = "mikrobus",
+		.of_match_table = mikrobus_port_of_match,
+	},
+};
+
+static const struct bus_type mikrobus_bus_type = {
+	.name = "mikrobus",
+};
+
+static int mikrobus_init(void)
+{
+	int ret;
+
+	ret = bus_register(&mikrobus_bus_type);
+	if (ret) {
+		pr_err("bus_register failed (%d)", ret);
+		return ret;
+	}
+
+	ret = platform_driver_register(&mikrobus_port_driver);
+	if (ret)
+		pr_err("driver register failed [%d]", ret);
+
+	return 0;
+}
+
+module_init(mikrobus_init);
+
+static void mikrobus_exit(void)
+{
+	platform_driver_unregister(&mikrobus_port_driver);
+	bus_unregister(&mikrobus_bus_type);
+}
+
+module_exit(mikrobus_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ayush Singh <ayush@beagleboard.org>");
+MODULE_DESCRIPTION("mikroBUS driver for linux");
+MODULE_VERSION("0.1");

-- 
2.45.2


