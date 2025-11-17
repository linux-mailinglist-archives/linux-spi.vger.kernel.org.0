Return-Path: <linux-spi+bounces-11259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C80C65127
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21B674EB375
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B802C026C;
	Mon, 17 Nov 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k89CbDUN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACE2C3242
	for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395976; cv=none; b=IJerkDk84diwxuNfDilvr2b/kJ4CJ2spGKRfxoZ1hV3zISUPykEzIUbfzc9SuUGa3U9X1BxIgYYzDiz7qBb3U+84Njj3FroVNIa+xC1Nk9D3EvfFFZ9qgPWYzr0jkEZXvFKfttxfjL8ik4f8FZ/P8vaOmD+g1Z6l1jtwt4nFfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395976; c=relaxed/simple;
	bh=irhKvUY6luUQYQCjfUO79QZdoddqpn0XAk946ikRMGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jRbUNHIZWyMDas0ze205JxghgexxXeA2Bt11Hu2PoTNDShZhsUtspV2UO2Z0hsOtZGaCclFB2Ny6/eGzjMGBVxvxOj9rPAws8p1jk6L8V0PBLtAbzmMiEbB/M7Pp3ZsCP/4GFw44APjiPxF3dIM006zCfotqy1cSz7gPYmbLCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k89CbDUN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso12172205e9.3
        for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763395973; x=1764000773; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+SE0fYOezsu8aNKbnzhAj9VZ6llsp+abwdEMUWBzyQ=;
        b=k89CbDUNgQqB4+5sXTMxLxv9TSdgV4rH+GPO/+WH+SFxbfQut33U2UWNHEStERUyNt
         BpoZLfMGyKw0qTmtIHV8J1bzlquDE8GWFoBo95HLuPwku80skGdFnWBl8ToPrPZkUZ43
         LNlQQsLxL0E7nFq/rdqEkasTUYm4kzav6HPNWJ/kQ1zxJS6yhdn9JX/n4tXhhe1g7mHT
         Gzki9jaCDyBIRDa5GnWvcm2Ele/saTf3c6VihDApd5eTzABpk1GOkMZdRSNj0CoLhDNS
         6op91kf9dBR5A/rpbGDofDkIft5iZ9rfZig2eaDSJm43S/rhgpfb/vMUr5hvuxfvf6V/
         NJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395973; x=1764000773;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+SE0fYOezsu8aNKbnzhAj9VZ6llsp+abwdEMUWBzyQ=;
        b=uk+O2Md0QvKtjhbk1uEnjGy9juc+L+0pHs5Pu2nry9w5UH5z5YCw/b+lKN2G1Na2QE
         BDrem0WwG+35MRBQykr/2UHCZwySwEz957IXi/DVa4pER/SwViHdQzNsc11UTTjP/B6O
         xR1k8f/mQ4N3OehuN2ir0o2vntb+fUgDbQdxe46UhyX6DZG4sHBmkXKsFtS02ZIyYjuc
         yPeN8P7i7ixfO5I3wwHPS3FeHry+uUJu8rSsh7LQrLCH7p8nTL0q9DpDAosFX+09PFh1
         zq2Y2igkasrKd1baXmSRE1XoWi1FjBr3bH7q+AeUn3NXPBEYkgC6zEuzwSrPTGjKpOFL
         Aj8w==
X-Forwarded-Encrypted: i=1; AJvYcCVsk4p0eyMGzivPPVvIWGJnDG+0X7aOiYYjJIFY/aaGQKj9cEGUmHuWrpD7XYnO4v3Chh0dIJ9Tt94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3PajvzdBmw9qcGnfj2Ta4/P0hJfFG1i/oyBX+S+SjPz17RxmF
	5H94f/XcD/9GkMuBGzhwNw+4+qn4zRt+ZXvKch2r8qCsGwGJb3xcDmeCC4d96NiXMlc=
X-Gm-Gg: ASbGncsjmENKh2QLzNkDE5XjsFWASseaJsLQpxm6Pt2ntj8rDA1AekOP0jmxjN6gOmy
	vKvYRamAbzO3sPmX7nAJZUx/tkzDGpMltZxfvgfUMhi9CZABjc8PfFfFpy5nq+5jmowklz7LkvI
	hMB++jaisDikXB2fOxJSNV8ahVWUXNkE/tjBBM7HU15vcch99p1EiJ2i8h0dZzU+kimyjIMKKI9
	arbq4wAYRao8IMAgAzOfXammarSBdmMk2CNNDIx8mllmaL1a+1r6bL3Oar1JMXCQhV85i+C//Th
	7zE80ABwjSMYKXFYbylA1KJzLmWvR+ODbV9/9YA0UXo+/gG6coyJXZQoT4ObDZpa5nQOL7cNiiN
	SxMWUStF6ZKQoC+umDZlW+CqnBhebHrlmo9K4gXXFSTFvN9usqfuET0PG+9vTO6V90b4dWASi3+
	/7WlZU
X-Google-Smtp-Source: AGHT+IFGb1o2W6QYlDDv0rwbgLGbPsAz5AYJmXa/hsVKUFgwfWOK9i6RIVG8MJdF0ff6tmkMN7Tgdw==
X-Received: by 2002:a05:600c:a47:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-4778fea84cemr143485895e9.31.1763395972799;
        Mon, 17 Nov 2025 08:12:52 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:36dc:12ef:ca32:1a1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787daab3fsm341218575e9.0.2025.11.17.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:12:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 17 Nov 2025 17:12:47 +0100
Subject: [PATCH v2] spi: davinci: remove platform data header
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-davinci-spi-v2-1-cd799d17f04a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH5JG2kC/23MQQ7CIBCF4as0sxbjULTYlfcwXSAM7SQGGjBE0
 3B3sWuX/0vet0GmxJRh7DZIVDhzDC3koQO7mDCTYNca5EmeEVEJZwoHyyKvLPzF0aDVQNIbaI8
 1kef3rt2n1gvnV0yfHS/4W/87BQWKB169VtL3tte3JweT4jGmGaZa6xdKI8I0pwAAAA==
X-Change-ID: 20251114-davinci-spi-f6de7847e2fa
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6629;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=86z0jBSHZcsTCcwlfViR6MY7DgeQAb3XF58fAhXiqRA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpG0mA2exUdNXHVj4aC5h+2PeMVLbsoPzeea+EJ
 xkF/nTgcp2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaRtJgAAKCRAFnS7L/zaE
 w4ekD/wLnwm6weOibrpniNACjYS6naFo0QF20HA3WUrdU6kxPa6c6FxtnZe8q91za/rignSw44+
 PKNtO965urxzwPJPg84bkcNhsvX3tM4VWKE3m+clZV4zyU3cUgyd7C2+/yESk7sAwv9uenfDv+D
 pgPBw014U80i42hmb+liQREYD0/4lnbqQU6LWOv0+Dw7d21aecot/XfkIQGy1yF2XGDfgYNpbno
 TzxeMV/fI6qpfoQZmE5Pb0IreKZJc/9nS4FANfc8JwTyplp5uVMesBqBUNe7NieCg456p53uusp
 D0qM+7qrepRowart1ZjxitZY3IU5Ib2fftujA5y/Gb5tY9V4LnDTw/TdKCM+amEGgwwQaiEqJYP
 0E6DvGKcusNMga2Gfzi9zrr+S18fPd9McpnX2HVR/O/k6tvhxoXNQ/7sLZiW1dJ16NySjgDdZoq
 MOPPujVDx3T9Hr2lJksfX9/GWZPgGNJnyn4xPcOUEWZ7cgA5+NaE9B6L4ohE37RqPlklWioUGbI
 BZxFkj6aRjp2hiLfC9Ix7P7DEX5Dnh4GfNlFSFeJhXTdYfMAPLefs5fpXHV/zvh3pkp0pjWoLLk
 UiznPr2QP2eePOswMX9Z2AHxb/jVNLdFXiSgd5tN+BsmRqiuPN8K3TQ9sGHCNNIDCPkhU6w32WU
 HmpZHez2wrYagzA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no longer any board files including the DaVinci SPI platform
data header. Let's move the bits and pieces that are used in the driver
into the driver .c file itself and remove the header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- Fix kernel doc warnings
- Link to v1: https://lore.kernel.org/r/20251114-davinci-spi-v1-1-b19f842f3c38@linaro.org
---
 drivers/spi/spi-davinci.c                 | 64 ++++++++++++++++++++++++++-
 include/linux/platform_data/spi-davinci.h | 73 -------------------------------
 2 files changed, 62 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index a29934422356b6b6d4043c0f0b43b91e5ccd894b..21a14e800eedc7ec41ade3187ddca79265b6e143 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -9,6 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/platform_data/edma.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -19,8 +20,6 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/slab.h>
 
-#include <linux/platform_data/spi-davinci.h>
-
 #define CS_DEFAULT	0xFF
 
 #define SPIFMT_PHASE_MASK	BIT(16)
@@ -98,8 +97,69 @@
 #define SPIDEF		0x4c
 #define SPIFMT0		0x50
 
+#define SPI_IO_TYPE_POLL	1
+#define SPI_IO_TYPE_DMA		2
+
 #define DMA_MIN_BYTES	16
 
+enum {
+	SPI_VERSION_1, /* For DM355/DM365/DM6467 */
+	SPI_VERSION_2, /* For DA8xx */
+};
+
+/**
+ * struct davinci_spi_platform_data - Platform data for SPI master device on DaVinci
+ *
+ * @version:	version of the SPI IP. Different DaVinci devices have slightly
+ *		varying versions of the same IP.
+ * @num_chipselect: number of chipselects supported by this SPI master
+ * @intr_line:	interrupt line used to connect the SPI IP to the ARM interrupt
+ *		controller withn the SoC. Possible values are 0 and 1.
+ * @prescaler_limit: max clock prescaler value
+ * @cshold_bug:	set this to true if the SPI controller on your chip requires
+ *		a write to CSHOLD bit in between transfers (like in DM355).
+ * @dma_event_q: DMA event queue to use if SPI_IO_TYPE_DMA is used for any
+ *		device on the bus.
+ */
+struct davinci_spi_platform_data {
+	u8			version;
+	u8			num_chipselect;
+	u8			intr_line;
+	u8			prescaler_limit;
+	bool			cshold_bug;
+	enum dma_event_q	dma_event_q;
+};
+
+/**
+ * struct davinci_spi_config - Per-chip-select configuration for SPI slave devices
+ *
+ * @wdelay:	amount of delay between transmissions. Measured in number of
+ *		SPI module clocks.
+ * @odd_parity:	polarity of parity flag at the end of transmit data stream.
+ *		0 - odd parity, 1 - even parity.
+ * @parity_enable: enable transmission of parity at end of each transmit
+ *		data stream.
+ * @io_type:	type of IO transfer. Choose between polled, interrupt and DMA.
+ * @timer_disable: disable chip-select timers (setup and hold)
+ * @c2tdelay:	chip-select setup time. Measured in number of SPI module clocks.
+ * @t2cdelay:	chip-select hold time. Measured in number of SPI module clocks.
+ * @t2edelay:	transmit data finished to SPI ENAn pin inactive time. Measured
+ *		in number of SPI clocks.
+ * @c2edelay:	chip-select active to SPI ENAn signal active time. Measured in
+ *		number of SPI clocks.
+ */
+struct davinci_spi_config {
+	u8	wdelay;
+	u8	odd_parity;
+	u8	parity_enable;
+	u8	io_type;
+	u8	timer_disable;
+	u8	c2tdelay;
+	u8	t2cdelay;
+	u8	t2edelay;
+	u8	c2edelay;
+};
+
 /* SPI Controller driver's private data. */
 struct davinci_spi {
 	struct spi_bitbang	bitbang;
diff --git a/include/linux/platform_data/spi-davinci.h b/include/linux/platform_data/spi-davinci.h
deleted file mode 100644
index 2cb5cc70fd9d22bd00c85beb5b9a8cb74547e9f4..0000000000000000000000000000000000000000
--- a/include/linux/platform_data/spi-davinci.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright 2009 Texas Instruments.
- */
-
-#ifndef __ARCH_ARM_DAVINCI_SPI_H
-#define __ARCH_ARM_DAVINCI_SPI_H
-
-#include <linux/platform_data/edma.h>
-
-#define SPI_INTERN_CS	0xFF
-
-enum {
-	SPI_VERSION_1, /* For DM355/DM365/DM6467 */
-	SPI_VERSION_2, /* For DA8xx */
-};
-
-/**
- * davinci_spi_platform_data - Platform data for SPI master device on DaVinci
- *
- * @version:	version of the SPI IP. Different DaVinci devices have slightly
- *		varying versions of the same IP.
- * @num_chipselect: number of chipselects supported by this SPI master
- * @intr_line:	interrupt line used to connect the SPI IP to the ARM interrupt
- *		controller withn the SoC. Possible values are 0 and 1.
- * @cshold_bug:	set this to true if the SPI controller on your chip requires
- *		a write to CSHOLD bit in between transfers (like in DM355).
- * @dma_event_q: DMA event queue to use if SPI_IO_TYPE_DMA is used for any
- *		device on the bus.
- */
-struct davinci_spi_platform_data {
-	u8			version;
-	u8			num_chipselect;
-	u8			intr_line;
-	u8			prescaler_limit;
-	bool			cshold_bug;
-	enum dma_event_q	dma_event_q;
-};
-
-/**
- * davinci_spi_config - Per-chip-select configuration for SPI slave devices
- *
- * @wdelay:	amount of delay between transmissions. Measured in number of
- *		SPI module clocks.
- * @odd_parity:	polarity of parity flag at the end of transmit data stream.
- *		0 - odd parity, 1 - even parity.
- * @parity_enable: enable transmission of parity at end of each transmit
- *		data stream.
- * @io_type:	type of IO transfer. Choose between polled, interrupt and DMA.
- * @timer_disable: disable chip-select timers (setup and hold)
- * @c2tdelay:	chip-select setup time. Measured in number of SPI module clocks.
- * @t2cdelay:	chip-select hold time. Measured in number of SPI module clocks.
- * @t2edelay:	transmit data finished to SPI ENAn pin inactive time. Measured
- *		in number of SPI clocks.
- * @c2edelay:	chip-select active to SPI ENAn signal active time. Measured in
- *		number of SPI clocks.
- */
-struct davinci_spi_config {
-	u8	wdelay;
-	u8	odd_parity;
-	u8	parity_enable;
-#define SPI_IO_TYPE_INTR	0
-#define SPI_IO_TYPE_POLL	1
-#define SPI_IO_TYPE_DMA		2
-	u8	io_type;
-	u8	timer_disable;
-	u8	c2tdelay;
-	u8	t2cdelay;
-	u8	t2edelay;
-	u8	c2edelay;
-};
-
-#endif	/* __ARCH_ARM_DAVINCI_SPI_H */

---
base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
change-id: 20251114-davinci-spi-f6de7847e2fa

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


