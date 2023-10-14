Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7C7C9667
	for <lists+linux-spi@lfdr.de>; Sat, 14 Oct 2023 22:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJNUyS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Oct 2023 16:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNUyR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Oct 2023 16:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683BDC
        for <linux-spi@vger.kernel.org>; Sat, 14 Oct 2023 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697316805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVXuRZ43Xjf843BgeSpJhYSd1chgRygz5RuSbmD9+7Q=;
        b=QH/9vuvqbTn2pmFSitz5mSbYk99fvfHBctIzqQUmsZdpQZieMUwVcSA9ISaDar7jtONuED
        XF/dJbMo2qnK1+qkx7skYEhTgs+rLRjXiAvRXnM5a4yyrGydLpHbIEEOXZnNxjeFk3Pk+M
        GYDErUAuFNZqWjLIWIvDv+d7YdFO8F4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-f_G26kRvMhqO5SmTNSEseQ-1; Sat, 14 Oct 2023 16:53:22 -0400
X-MC-Unique: f_G26kRvMhqO5SmTNSEseQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC32C185A78E;
        Sat, 14 Oct 2023 20:53:21 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB1B425C0;
        Sat, 14 Oct 2023 20:53:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: x86-android-tablets: Add audio codec info for Lenovo Yoga Tab 3 Pro YT3-X90F
Date:   Sat, 14 Oct 2023 22:53:14 +0200
Message-ID: <20231014205314.59333-5-hdegoede@redhat.com>
In-Reply-To: <20231014205314.59333-1-hdegoede@redhat.com>
References: <20231014205314.59333-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI attached WM5102 codec on the Lenovo Yoga Tab 3 Pro YT3-X90F
is not described in the ACPI tables.

Add info to instantiate the SPI device for the codec manually.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../platform/x86/x86-android-tablets/lenovo.c | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 585f10a57810..d5d815940ce1 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -12,6 +12,8 @@
 
 #include <linux/efi.h>
 #include <linux/gpio/machine.h>
+#include <linux/mfd/arizona/pdata.h>
+#include <linux/mfd/arizona/registers.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/machine.h>
@@ -677,6 +679,89 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 	}
 };
 
+/*
+ * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
+ * Function A Play/Pause:           0 ohm
+ * Function D Voice assistant:    135 ohm
+ * Function B Volume Up           240 ohm
+ * Function C Volume Down         470 ohm
+ * Minimum Mic DC resistance     1000 ohm
+ * Minimum Ear speaker impedance   16 ohm
+ * Note the first max value below must be less then the min. speaker impedance,
+ * to allow CTIA/OMTP detection to work. The other max values are the closest
+ * value from extcon-arizona.c:arizona_micd_levels halfway 2 button resistances.
+ */
+static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
+	{ .max =  11, .key = KEY_PLAYPAUSE },
+	{ .max = 186, .key = KEY_VOICECOMMAND },
+	{ .max = 348, .key = KEY_VOLUMEUP },
+	{ .max = 752, .key = KEY_VOLUMEDOWN },
+};
+
+/* YT3 WM5102 arizona_micd_config comes from Android kernel sources */
+static struct arizona_micd_config lenovo_yt3_wm5102_micd_config[]={
+	{ 0, 1, 0 },
+	{ ARIZONA_ACCDET_SRC, 2, 1 },
+};
+
+static struct arizona_pdata lenovo_yt3_wm5102_pdata = {
+	.irq_flags = IRQF_TRIGGER_LOW,
+	.micd_detect_debounce = 200,
+	.micd_ranges = arizona_micd_aosp_ranges,
+	.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges),
+	.hpdet_channel = ARIZONA_ACCDET_MODE_HPL,
+
+	/* Below settings come from Android kernel sources */
+	.micd_bias_start_time = 1,
+	.micd_rate = 6,
+	.micd_force_micbias = 1,
+	.micd_configs = lenovo_yt3_wm5102_micd_config,
+	.num_micd_configs = ARRAY_SIZE(lenovo_yt3_wm5102_micd_config),
+        .micbias={
+           [0]={ /*MICBIAS1*/
+                 .mV =2800 ,
+                 .ext_cap=1,
+                 .discharge =1 ,
+                 .soft_start =0,
+                 .bypass =0,
+           },
+           [1]={ /*MICBIAS2*/
+                 .mV =2800 ,
+                 .ext_cap=1,
+                 .discharge =1 ,
+                 .soft_start =0,
+                 .bypass =0,
+           },
+           [2]={ /*MICBIAS3*/
+                 .mV =2800 ,
+                 .ext_cap=1,
+                 .discharge =1 ,
+                 .soft_start =0,
+                 .bypass =0,
+           },
+        },
+};
+
+static const struct x86_spi_dev_info lenovo_yt3_spi_devs[] __initconst = {
+	{
+		/* WM5102 codec */
+		.board_info = {
+			.modalias = "wm5102",
+			.platform_data = &lenovo_yt3_wm5102_pdata,
+			.max_speed_hz = 5000000,
+		},
+		.ctrl_path = "\\_SB_.PCI0.SPI1",
+		.irq_data = {
+			.type = X86_ACPI_IRQ_TYPE_GPIOINT,
+			.chip = "INT33FF:00",
+			.index = 91,
+			.trigger = ACPI_LEVEL_SENSITIVE,
+			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "wm5102_irq",
+		},
+	}
+};
+
 static int __init lenovo_yt3_init(void)
 {
 	int ret;
@@ -720,14 +805,28 @@ static struct gpiod_lookup_table lenovo_yt3_hideep_gpios = {
 	},
 };
 
+static struct gpiod_lookup_table lenovo_yt3_wm5102_gpios = {
+	.dev_id = "spi1.0",
+	.table = {
+		GPIO_LOOKUP("INT33FF:00", 75, "wlf,spkvdd-ena", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FF:00", 81, "wlf,ldoena", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FF:00", 82, "reset", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("arizona", 2, "wlf,micd-pol", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static struct gpiod_lookup_table * const lenovo_yt3_gpios[] = {
 	&lenovo_yt3_hideep_gpios,
+	&lenovo_yt3_wm5102_gpios,
 	NULL
 };
 
 const struct x86_dev_info lenovo_yt3_info __initconst = {
 	.i2c_client_info = lenovo_yt3_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(lenovo_yt3_i2c_clients),
+	.spi_dev_info = lenovo_yt3_spi_devs,
+	.spi_dev_count = ARRAY_SIZE(lenovo_yt3_spi_devs),
 	.gpiod_lookup_tables = lenovo_yt3_gpios,
 	.init = lenovo_yt3_init,
 };
-- 
2.41.0

