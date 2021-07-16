Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61453CB82A
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbhGPN55 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 09:57:57 -0400
Received: from first.geanix.com ([116.203.34.67]:35096 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240075AbhGPN54 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 09:57:56 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id A96064C7C4D;
        Fri, 16 Jul 2021 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1626443698; bh=7FPJrZ/vc//a1g81kBzJBiuhi1vN8Gb+Td0CoisXuw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Oya0hSHOCs5mDO23p+oyFhpxZj39msLzd/UPviDjvzNq8EqHmpCkw/DsorWep6yG/
         GyOgJiBz9CpHuc4dDB2+sL+fJ6Ng4kM/eLjY1Kk40Ok037o/BNv7D0hVLi2Q3MDp8/
         kK8dNsg4NUmfOCFKvXugMLSZ7b/u0X8wnOJbQ9oU+LBWyYPBgix6u4bWKtlzpX1xa1
         HZTWoF+jKeeEY6d+jZL3YGaQrO7sHwXOcen13Ku/oozeaKtktCQZO6HlRq2s/G7Q2o
         FndMtxrXTjEPXIIWCH/fpakh+GPyzzvSkf2r/g50muDL+bP2JRC0G9FVX2LSaDgnw1
         967FbqklaNcVw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v5 3/3] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
Date:   Fri, 16 Jul 2021 15:54:41 +0200
Message-Id: <20210716135441.3235863-4-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210716135441.3235863-1-martin@geanix.com>
References: <20210716135441.3235863-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Hundebøll <mhu@silicom.dk>

Add the list of sensors supported by the Silicom n5010 PAC, and enable
the drivers as a subtype of the intel-m10-bmc multi-function driver.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---

Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * Added Yilun's Reviewed-by
 * Added Moritz' Reviewed-by
 * Added Guenter's Reviewed-by

Changes since v1:
 * Patch split out to separate hwmon changes

 drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index bd7ed2ed3a1e..7a08e4c44a4b 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -228,6 +228,118 @@ static const struct m10bmc_hwmon_board_data d5005bmc_hwmon_bdata = {
 	.hinfo = d5005bmc_hinfo,
 };
 
+static const struct m10bmc_sdata n5010bmc_temp_tbl[] = {
+	{ 0x100, 0x0, 0x104, 0x0, 0x0, 1000, "Board Local Temperature" },
+	{ 0x108, 0x0, 0x10c, 0x0, 0x0, 1000, "FPGA 1 Temperature" },
+	{ 0x110, 0x0, 0x114, 0x0, 0x0, 1000, "FPGA 2 Temperature" },
+	{ 0x118, 0x0, 0x0, 0x0, 0x0, 1000, "Card Top Temperature" },
+	{ 0x11c, 0x0, 0x0, 0x0, 0x0, 1000, "Card Bottom Temperature" },
+	{ 0x128, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 1.2V Temperature" },
+	{ 0x134, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 5V Temperature" },
+	{ 0x140, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 0.9V Temperature" },
+	{ 0x14c, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 0.85V Temperature" },
+	{ 0x158, 0x0, 0x0, 0x0, 0x0, 1000, "AUX 12V Temperature" },
+	{ 0x164, 0x0, 0x0, 0x0, 0x0, 1000, "Backplane 12V Temperature" },
+	{ 0x1a8, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-1 Temperature" },
+	{ 0x1ac, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-2 Temperature" },
+	{ 0x1b0, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-3 Temperature" },
+	{ 0x1b4, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-4 Temperature" },
+	{ 0x1b8, 0x0, 0x0, 0x0, 0x0, 1000, "CVL1 Internal Temperature" },
+	{ 0x1bc, 0x0, 0x0, 0x0, 0x0, 1000, "CVL2 Internal Temperature" },
+};
+
+static const struct m10bmc_sdata n5010bmc_in_tbl[] = {
+	{ 0x120, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.2V Voltage" },
+	{ 0x12c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 5V Voltage" },
+	{ 0x138, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.9V Voltage" },
+	{ 0x144, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.85V Voltage" },
+	{ 0x150, 0x0, 0x0, 0x0, 0x0, 1, "AUX 12V Voltage" },
+	{ 0x15c, 0x0, 0x0, 0x0, 0x0, 1, "Backplane 12V Voltage" },
+	{ 0x16c, 0x0, 0x0, 0x0, 0x0, 1, "DDR4 1.2V Voltage" },
+	{ 0x17c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.8V Voltage" },
+	{ 0x184, 0x0, 0x0, 0x0, 0x0, 1, "QDR 1.3V Voltage" },
+	{ 0x18c, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 0.8V Voltage" },
+	{ 0x194, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 1.05V Voltage" },
+	{ 0x19c, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 1.05V Voltage" },
+	{ 0x1a4, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 0.8V Voltage" },
+};
+
+static const struct m10bmc_sdata n5010bmc_curr_tbl[] = {
+	{ 0x124, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.2V Current" },
+	{ 0x130, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 5V Current" },
+	{ 0x13c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.9V Current" },
+	{ 0x148, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.85V Current" },
+	{ 0x154, 0x0, 0x0, 0x0, 0x0, 1, "AUX 12V Current" },
+	{ 0x160, 0x0, 0x0, 0x0, 0x0, 1, "Backplane 12V Current" },
+	{ 0x168, 0x0, 0x0, 0x0, 0x0, 1, "DDR4 1.2V Current" },
+	{ 0x178, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.8V Current" },
+	{ 0x180, 0x0, 0x0, 0x0, 0x0, 1, "QDR 1.3V Current" },
+	{ 0x188, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 0.8V Current" },
+	{ 0x190, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 1.05V Current" },
+	{ 0x198, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 1.05V Current" },
+	{ 0x1a0, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 0.8V Current" },
+};
+
+static const struct hwmon_channel_info *n5010bmc_hinfo[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL),
+	NULL
+};
+
+static const struct m10bmc_hwmon_board_data n5010bmc_hwmon_bdata = {
+	.tables = {
+		[hwmon_temp] = n5010bmc_temp_tbl,
+		[hwmon_in] = n5010bmc_in_tbl,
+		[hwmon_curr] = n5010bmc_curr_tbl,
+	},
+
+	.hinfo = n5010bmc_hinfo,
+};
+
 static umode_t
 m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
 			u32 attr, int channel)
@@ -438,6 +550,10 @@ static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
 		.name = "d5005bmc-hwmon",
 		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
 	},
+	{
+		.name = "n5010bmc-hwmon",
+		.driver_data = (unsigned long)&n5010bmc_hwmon_bdata,
+	},
 	{ }
 };
 
-- 
2.31.0

