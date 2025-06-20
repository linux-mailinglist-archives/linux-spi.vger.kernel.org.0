Return-Path: <linux-spi+bounces-8698-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C2AE25AE
	for <lists+linux-spi@lfdr.de>; Sat, 21 Jun 2025 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115AB17B3BF
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3269C24EABD;
	Fri, 20 Jun 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t7hAizm5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFD2505CE
	for <linux-spi@vger.kernel.org>; Fri, 20 Jun 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458097; cv=none; b=sh/o+hBXkPsR4QoTXN0F6YXbp0QleaQHGeIbpbbbihBNI5Dd+QA0pt6pJYIJY0Nmxd81M4uevcz16bfB/T8ynFKBpRKPoEFdLtahamULrHcDupez73YFHG9OaKiGN4fY6APACrpn+NJsvQv+4WiQhzE9+sBpNwuyFPJI0dFhir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458097; c=relaxed/simple;
	bh=BwOGbOpYX21Ucam+bloAQXE+MG2uw4doa1iKJcVx3E8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlZHODe5YKYE2h2PLQ0+7cUNpSu60AjOrGEwjjiefwEhGco6g7cN/JPWQfMTEpCADekJEcuOl6+1j9s+/YpbMAhxtBHzlnl3oSAqhjCCt4oZ3JXUuhjq+wFhQVV2byIpZHooAxT11GQMTxWmzAW2TxNmo/oFg75NTxAXtHKWyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t7hAizm5; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2eaad5eb1easo1195453fac.3
        for <linux-spi@vger.kernel.org>; Fri, 20 Jun 2025 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458094; x=1751062894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+UAVQwWtySu3Zk+qmcMSCJQC906a/pI5jwVttXUTqw=;
        b=t7hAizm5KZjZ94mIDfS8HasjKUN7hVoZi91Vy9RWOuqGBHNtzu4Jab1/ryzybZiWfc
         hNK2fG0/sw/RPLgGb0IXluZe7RFGLfRKfrgq1Qat1g8KCDpgFgh5DZqkqSqsFwj0NBSr
         Zl9bnKb4Kd9dIk9U/11pMZwtVDzXMh0vYYaIb3/4XfHClW8fVoCKqA7RYLyRrLod4hbu
         b2PNa1/gUtlnpGpxvjbDF9X1wa+drBp0tS789TrlMf86+eGCDP46ug3tzL+ICexBRCMy
         23milim/3D0sVhqeHbwlh8dcldeQxQvjhx5MDTAIH60swcAbsmFcQGSBmh6ni0rKIIf7
         5HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458094; x=1751062894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+UAVQwWtySu3Zk+qmcMSCJQC906a/pI5jwVttXUTqw=;
        b=V27iFK2LFDj951N2sOSC1IAONARt1e4P+55Zb6akmGMCwW0zrApkAQEx/e7a/rZem+
         N4RIzXquSa7CYRVPfwrcCY0GMeqzpaxzRMMye3liWSnTkflBBSEShegMC6UWPrz2aYr2
         F58ffoqPT7cvNHFFce0AcsoWzj3O1DQXx8RM8dxPriy5lrbSbp+oEUcTDxImXBAevAOt
         ekclawyN7bh0J1S373CQkECU/1h8+QJvzZTY4U0t6ZjYUfUBQbYi/+RriVZnNlr5Y2Ia
         /A6GC9hnGo0n+YETpXQ947+3+jB/wSiBcvOmEx8VQ2zLlY2uTmuycSjciTREiR0gDigJ
         olTw==
X-Forwarded-Encrypted: i=1; AJvYcCUAA1gNJiifiz+P8NLG754iaryN9+zKUlIaP/edteT8+OC+9WclVwWPcOhdGn38mCWFAFtsxQ2lpPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqIE2lMT4r1lCm49OAhjELTALx4eKyDGeVymMVZAN2aRT9JCY
	N497U1xTkZgiVq5sHQa//zkiEA+TX5hLwyBfqnrmpY/bkehgpdsldr591ztFkY51BiM=
X-Gm-Gg: ASbGncssG6ngnURH1/PgE0YO55dMnUtWy4yQfVwlx14Cxr75zDXvB42/n4zSNl+StBN
	lRfaHrCTU2sbIFGyOBR0pg2ydF2STIMOs4yoN3ml9Iit1pphFRgphQaa3BJRJIgvnigAYl4qq7Z
	+Z62HJQ221UNw7p0WoIIRPB25mr3U8tyIYc6t+5gSXFzjL7YhT+pZyczvR5IHCiGsm3TxCAIq2n
	gLvIgT6v1CNeneofGPLkfKKB4V7EfE6zcNy9YE8TCjEUUnH2BREqOcvOdTBpiIjzklbUwjhy0US
	3PWvwa7UDX/1SccQ4Z7BImykMrOCGxuGrbShpu7a64PAATx6NQJOXW85gjf8+0ekMyGr
X-Google-Smtp-Source: AGHT+IGVhQ/Ygrt+I/n1VtjMi0eU63wKILJBqUt+HqZ6TRpY8gF1Tzp20x9EKk4Yh7WxzmQ7OeIS9w==
X-Received: by 2002:a05:6870:6391:b0:29d:c85f:bc8c with SMTP id 586e51a60fabf-2eeee659b1cmr3012485fac.36.1750458094166;
        Fri, 20 Jun 2025 15:21:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Jun 2025 17:20:13 -0500
Subject: [PATCH 7/9] spi: offload trigger: add ADI Util Sigma-Delta SPI
 driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-7-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4261; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=BwOGbOpYX21Ucam+bloAQXE+MG2uw4doa1iKJcVx3E8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd7KWtgTjPbi3YZhrvUDq6yz9ko4YaApYPN8R
 eK4qzisj4aJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXeygAKCRDCzCAB/wGP
 wEgoCACN3bes1vX7AMC+4MNdXRnYbEFoqA8WJVnkVD0Wx1WeMt5VbVMGgmEnDkcWbCThlGEABTf
 9MxzQgP+DopACd4sLshxxLkkZujWXbnPcLXMrzew18nifeQuON0xoay33Y7mHgXsJ1XDvLMW71H
 2zCqpnVO/WmJkp6C2mUVpot9j1y5MNZ7t/hOqcYqkQquCwdjSqRPuIe7+06GM2ebwkWrTuIRQNB
 +oM5uTBpp4l6UWSPh5fSII20PpG/MMdxm+eM8YQ0jho1P5cZdKAMKX1CLV/ywe1UVpaz67oiIu9
 NI313wXUtu0tSS8uMp02IGJI+VVnxbOYHhJIh3MlJ/hQYtFC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new driver for the ADI Util Sigma-Delta SPI FPGA IP core.

This is used to trigger a SPI offload based on a RDY signal from an ADC
while masking out other signals on the same line.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS                                        |  2 +-
 drivers/spi/Kconfig                                |  5 ++
 drivers/spi/Makefile                               |  1 +
 .../spi/spi-offload-trigger-adi-util-sigma-delta.c | 59 ++++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60ba572be7f5b48c0ab1d0d9724e19e335e8761b..4ed4977deb6ddc545be39b5c1d5e9959e9fe64cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23357,7 +23357,7 @@ F:	include/linux/mtd/spi-nor.h
 
 SPI OFFLOAD
 R:	David Lechner <dlechner@baylibre.com>
-F:	drivers/spi/spi-offload-trigger-pwm.c
+F:	drivers/spi/spi-offload-trigger-*.c
 F:	drivers/spi/spi-offload.c
 F:	include/linux/spi/offload/
 K:	spi_offload
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c51da3fc3604977b05388687e5e64a58370186c4..e69f060d3875c168a2dc701a372e47b8ffd33268 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1355,6 +1355,11 @@ if SPI_OFFLOAD
 
 comment "SPI Offload triggers"
 
+config SPI_OFFLOAD_TRIGGER_ADI_UTIL_SD
+	tristate "SPI offload trigger using ADI sigma-delta utility"
+	help
+	  SPI offload trigger from ADI sigma-delta utility FPGA IP block.
+
 config SPI_OFFLOAD_TRIGGER_PWM
 	tristate "SPI offload trigger using PWM"
 	depends on PWM
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4ea89f6fc531625060255ecff237470927e1f041..51f9f16ed734424ff10672a04f2ec166dc637e0b 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -170,3 +170,4 @@ obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
 
 # SPI offload triggers
 obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_PWM)	+= spi-offload-trigger-pwm.o
+obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_ADI_UTIL_SD) += spi-offload-trigger-adi-util-sigma-delta.o
diff --git a/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c b/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
new file mode 100644
index 0000000000000000000000000000000000000000..035d088d4d33d6d32146a340381bb167f080e085
--- /dev/null
+++ b/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Analog Devices Inc.
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/spi/offload/provider.h>
+
+static bool adi_util_sigma_delta_match(struct spi_offload_trigger *trigger,
+				       enum spi_offload_trigger_type type,
+				       u64 *args, u32 nargs)
+{
+	return type == SPI_OFFLOAD_TRIGGER_DATA_READY && nargs == 0;
+}
+
+static const struct spi_offload_trigger_ops adi_util_sigma_delta_ops = {
+	.match = adi_util_sigma_delta_match,
+};
+
+static int adi_util_sigma_delta_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_offload_trigger_info info = {
+		.fwnode = dev_fwnode(dev),
+		.ops = &adi_util_sigma_delta_ops,
+	};
+	struct clk *clk;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get clock\n");
+
+	return devm_spi_offload_trigger_register(dev, &info);
+}
+
+static const struct of_device_id adi_util_sigma_delta_of_match_table[] = {
+	{ .compatible = "adi,util-sigma-delta-spi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adi_util_sigma_delta_of_match_table);
+
+static struct platform_driver adi_util_sigma_delta_driver = {
+	.probe  = adi_util_sigma_delta_probe,
+	.driver = {
+		.name = "adi-util-sigma-delta-spi",
+		.of_match_table = adi_util_sigma_delta_of_match_table,
+	},
+};
+module_platform_driver(adi_util_sigma_delta_driver);
+
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("ADI Sigma-Delta SPI offload trigger utility driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0


