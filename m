Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC17C9666
	for <lists+linux-spi@lfdr.de>; Sat, 14 Oct 2023 22:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjJNUyP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Oct 2023 16:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNUyO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Oct 2023 16:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD1CC
        for <linux-spi@vger.kernel.org>; Sat, 14 Oct 2023 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697316806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDU841zmqN4EViFwHwGtrWm81faZ2V8ThMs0U5gsSfg=;
        b=UWzLn7FbxDWoGcKP3UHDQoB2uIwC4VtsZNI6DelLYXHng7fkCN9WCjQ61KXOw8dfGeFtkR
        7EfV09AUo71D2LnCkP8MpnDeogLEL0T8Kv5icfxjKuXG1bKEKE7MJ244h8iT41tx5HtW3Y
        pmwsvE+T/JcD/94G8Al/6CXIIK8XtK0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-boqgT2qmMUu5cyR4pnJ96g-1; Sat, 14 Oct 2023 16:53:19 -0400
X-MC-Unique: boqgT2qmMUu5cyR4pnJ96g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D4A21C0634B;
        Sat, 14 Oct 2023 20:53:19 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D110325C0;
        Sat, 14 Oct 2023 20:53:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 2/4] ACPI: scan: Add LNXVIDEO HID to ignore_serial_bus_ids[]
Date:   Sat, 14 Oct 2023 22:53:12 +0200
Message-ID: <20231014205314.59333-3-hdegoede@redhat.com>
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

The I2C-core already has filtering to skip i2c_client instantiation for
LNXVIDEO acpi_device-s with I2cSerialBus resources, since LNXVIDEO devices
are not i2c_client-s and are handled by the acpi_video driver.

This filtering was added to i2c-core-acpi.c in commit 3a4991a9864c ("i2c:
acpi: Do not create i2c-clients for LNXVIDEO ACPI devices").

Now a similar problem has shown up where the SPI-core is instantiating
an unwanted SPI-device for a SpiSerialBus resource under a LNXVIDEO
acpi_device. On a Lenovo Yoga Tab 3 YT3-X90F this unwanted SPI-device
instanstantiation causes the SPI-device instanstantiation for the WM5102
audio codec to fail with:

[   21.988441] pxa2xx-spi 8086228E:00: chipselect 0 already in use

Instead of duplicating the I2C-core filtering in the SPI-core code, push
the filtering of SerialBus resources under LNXVIDEO acpi_device-s up into
the ACPI-core by adding the LNXVIDEO HID to ignore_serial_bus_ids[].

Note the filtering in the I2C-core i2c_acpi_do_lookup() function is still
necessary because this not only impacts i2c_client instantiation but it
also makes the I2C-core ignore the I2cSerialBus resource when checking what
the maximum speed is the I2C bus supports, which is still necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 691d4b7686ee..4b6faa2350f5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1727,6 +1727,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * Some ACPI devs contain SerialBus resources even though they are not
 	 * attached to a serial bus at all.
 	 */
+		{ACPI_VIDEO_HID, },
 		{"MSHW0028", },
 	/*
 	 * HIDs of device with an UartSerialBusV2 resource for which userspace
-- 
2.41.0

