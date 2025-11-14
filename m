Return-Path: <linux-spi+bounces-11222-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DB1C5EF09
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47E5A34C21B
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E52DECD8;
	Fri, 14 Nov 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ObRChzVe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28F18EFD1
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145907; cv=none; b=kSZHtJFxr+fCJAxCeDdTAgte+MGWgLzwSTpAXT3JEVEVdXePVJqSQKhiZNK8hPWAlOlch8FfzNbqe31DQxkDcM4lxeH+hALVx94OIXcCC6SSHjbC/x99pD97Kmts/uEBvxWLFnQXXqG/aSQ5aXfT0rwS4t5aDVaRZPMrFN5BoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145907; c=relaxed/simple;
	bh=Pn3F9WH1cS9+bY5opga+rHds2LeuFrjSat93vmvaCAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PrRJYufkEybOk8OjlWLimQL3SJSQBaC7lIA+c0nzpApl393//FnkCM5uUzSSCOhosEbRgIK8oRyDpmoucwTIcBxLxty1bedxIXLu57wJCD6YJYYwZExq0LHJq9QvUEhCE2+vFQ9c+wgD/+5w9B1HQ2yfK8XLMyu6ynxFYEanypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ObRChzVe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b31c610fcso2018951f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763145899; x=1763750699; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ3SQ+JmFJrdV7k1wCE6vl3PDiKzRteuguYr9grOle0=;
        b=ObRChzVeCOHhaP3ueG4DR0gEjZou3I6RwB5vo3PNDyQmmN1xoFiQrCIoglKO1mqMQ3
         j0NugUzO/0d5nAk6McgNnmD+RGqaKF+GduAJtWw+k3wYln/MwVPZERtga7WagSfR5OpJ
         vZ4icoSi78znCRaZjKjDbHdBPAMxBwiVD7vm+rDT1gfwcRKOEFa2QwHx3QRcH35B+AQl
         D6IOI4PPfuLuAzXMH2GBAbhTf0RRIOhF7UuT0Fnc6YGUqe6O0L4h17jZGUk3nQ6S5gnQ
         ENuHV56LmrV2uJ/Gnybd53PeN/eiWmd8dHYKARB/sAbqdA4tAiSuBJKT5IV0S6vdm5wY
         saDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763145899; x=1763750699;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ3SQ+JmFJrdV7k1wCE6vl3PDiKzRteuguYr9grOle0=;
        b=oC8T4M1dVWK8azdM57fmKVoDNH1csP+OTQcbyNV2OkPaj1v1Lp49M4Fcn6cjtKQGFs
         HIyHEh7KZCDMrXGq9lahX4sd3ci+hkUg9FwVweLiU53qNBzCrLtU4GLlHnJY7E+b/YJo
         ls+aae8DP2DVlaJVtDaW5vAinOHrq5f8kpFQop3Sy7GzL/p2crT+uX8ucp4AR6l0HvMa
         feB94YV6cUkCf0NemaQYmmy4zxLxqeJe9+M1cKeyj5ttNsJJrWrCmcoSI6F3qvN/osDC
         T/yQBqUcgrQehM9oLG2ssVQTrgfNTbJ7ymdd2dLk6JPb0FuteFFnZoNnpIwYbmRBDJ2b
         H2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUzyCIJoMofnvQNaMeZdHlMvhw7WfeIKkQ15M1shg4OopV4uDZmQeXOlG4EB77X2IwsBFQvkfxrvUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysX+5jTUWaTaWmKZPNCw5QX1S5XcraOtnxW+HribOxKeprJLsk
	XblMWUA9vdxrRcqQ6dLg2BB+q7ayWH2fVQgKdGrVVbAxP3Glu8wd9k6cSjgCPWNtJUk=
X-Gm-Gg: ASbGncv0rzAw0BAoGn2gNGYQLeyCu1P9ryfVyQ8UT7YdudqWru2ZLT5EvFmuMjTsd+1
	RYl9OlW2HxQ0ULkC+nnSx1ELf5kPV4t7fDfbl8/76mv8HlaxAH6ByoszNZpaH+PO84ikhrSv/mS
	LfteGYX1577Pqd86wi16Rb7EQ/4KB9UoYC1HgPkIu1tu8tej3xZdEusvK22D0liBtT5n5LHaGdN
	z5wwXvlQlbvcYD2XMrOKoKmjeOMhCbGuSfO+jHhj0l/1iFtc+j/CtXLwAqhJxFpq9tiqNMbeOlr
	Ydd3YRz7AL+sxAXL5UvlvGSP1cih7LvewxyWmDynR5jX3QB0C9Todv528uwv+kqlEMzNpe0cZl8
	q9D/mTbFebpoLcp4Nf3Cjpqi6hYqrz1wlJgkHKGXZ22WhSgIAItir5taurGABlSkMajALUZMB/N
	BCtNTA8oHaW0LZBds=
X-Google-Smtp-Source: AGHT+IGH2HnEI+t7XE26uAkzEaBgG8azXpo75OaSuiZemULV0cJ4+yvJ5x1RG9218nZCaeZbAEiYxw==
X-Received: by 2002:a05:6000:188e:b0:42b:3ad7:fdd3 with SMTP id ffacd0b85a97d-42b5934da44mr3971954f8f.18.1763145898892;
        Fri, 14 Nov 2025 10:44:58 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:326d:9344:48bd:e2fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm11565678f8f.39.2025.11.14.10.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:44:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Nov 2025 19:44:54 +0100
Subject: [PATCH] spi: davinci: remove platform data header
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-davinci-spi-v1-1-b19f842f3c38@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKV4F2kC/x3MQQqAIBBA0avIrBtIsYyuEi1Ex5qNiYIE4t2Tl
 m/xf4NCmanALhpkqlz4iQNyEuBuGy9C9sOgZrVIKTV6Wzk6xpIYw+rJbNqQChZGkTIFfv/bcfb
 +AY72UKVdAAAA
X-Change-ID: 20251114-davinci-spi-f6de7847e2fa
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6426;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=a0vRuhwxVH8rsPSazycJBYCdFTwjepP7tYPyCm7FGJ4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpF3io7tUavthZXz7t0DI18NOrxA73l62+id54T
 qHHywGAqJiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaRd4qAAKCRAFnS7L/zaE
 wxXvD/9EkA5ruAOLm1TS2Ts0xN8tvOv0A7MuMf/Deal5JbaWukKfxTJ4o7FfPxSmpCQAmkq/tT1
 mRMZJ3iDLveQpuz1ew76CAX5ndIFJ3R9AAXn0MrW9QmqfPISAQWcyJ4Hl7uSoGNSQAZooPpg25x
 vx+mOcvJZkrRbBbiTeNakVvWN4L3rSsEaSfalBgB6CNmKtgIBuMPLqGczyOEDyf6PsLdN/TpFfc
 R8THl/ey00oVY3SJMCl4/aqozxEvjHxMFbXe1//l17POm6D3LNbha0XhpAYxa8+JL5pgvN7BM0h
 02eBnfydCkZWJtqaYWPDAouiZHtmAwA8WoKmBoIfIEw2qJuOA5OnFI6cTOs4ITGa51RTYGFcjl5
 AHKRhbMGFDqIn9eah+wCMDym1CfUN6Q7kYgCQmN9/9K85XbNIqjwDenQVcVD2gPABJ68M/nEUQE
 5HoZKzWQwFIeobvVpq1AgQape8XC6CeNNTDgIOClF74HR+uNXbtPMui8ukwbEvfTxgVMaCfc0/Q
 lTBVQv+hlo2YUcHJxTTR4X8gdG6dInwsyFsZESGjrI1Ucst8bgBmLL9aRpAw4nK2njfEAnnUBXR
 q1Tm5ejgxjv4MDU9A9vgwGLK49h9jcj53VcSTkBYBd++DFtT+3yWFKpCcHfGeKqnf3v7fBqxcoE
 r70uoqOZ+dxeaJA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no longer any board files including the DaVinci SPI platform
data header. Let's move the bits and pieces that are used in the driver
into the driver .c file itself and remove the header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spi-davinci.c                 | 63 +++++++++++++++++++++++++-
 include/linux/platform_data/spi-davinci.h | 73 -------------------------------
 2 files changed, 61 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index a29934422356b6b6d4043c0f0b43b91e5ccd894b..9edd299ecd49076b4f16e66ecb33224e6b4422fc 100644
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
@@ -98,8 +97,68 @@
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
+ * davinci_spi_platform_data - Platform data for SPI master device on DaVinci
+ *
+ * @version:	version of the SPI IP. Different DaVinci devices have slightly
+ *		varying versions of the same IP.
+ * @num_chipselect: number of chipselects supported by this SPI master
+ * @intr_line:	interrupt line used to connect the SPI IP to the ARM interrupt
+ *		controller withn the SoC. Possible values are 0 and 1.
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
+ * davinci_spi_config - Per-chip-select configuration for SPI slave devices
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


