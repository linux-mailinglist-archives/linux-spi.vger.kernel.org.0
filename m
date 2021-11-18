Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2016F456510
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 22:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhKRVfB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 16:35:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229795AbhKRVe7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Nov 2021 16:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637271118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=25DzKyi07nBwZwK9LVCZrjG6wh3BTTtMjwyVPHAQSG8=;
        b=WG1O3CDDLW0s82cxQ8WsWFN/R6UU6WaGJXMoHS3T+XM1SdbydpA2v40dRq19g+CmjHN/uM
        aj2WOxuKwQGVGEVqGwbiCOH5F8bowbM+uFkv0xPRUv7yt/F/wV2at3c1dRd/unEfoNZOgA
        vGEq4jPhtSWnZ2yq1MMB4CmECdpWWRw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-__bzpaUAPKqFa8ZPKTatGA-1; Thu, 18 Nov 2021 16:31:57 -0500
X-MC-Unique: __bzpaUAPKqFa8ZPKTatGA-1
Received: by mail-wm1-f69.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so3765964wmb.4
        for <linux-spi@vger.kernel.org>; Thu, 18 Nov 2021 13:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25DzKyi07nBwZwK9LVCZrjG6wh3BTTtMjwyVPHAQSG8=;
        b=6j04mMFk05+VXWEEKjvCKx7b0eGVxqI9QCTlwmtYIj+pUGwIPsp0PxzvG5IOssHvcQ
         1jA5lunpS0QNYEyH6Ydc2B4N5iSTPyYRlWz3//HWYSYZtIHuXmpDPVWJlpRzhsPZVvfL
         1V9JHBjshpMUGUzXblIcXP8hik4/WkEZn2osH5sp/yeYN3x9Kz6n16AWuIB88KucNU/Q
         H508dmzaMMkhSNRQKwCobYGfqpAcQ6ee4pmU0/7ZhtJebqgkC71tVADwgjBokNFAianN
         2aTlQYh7F7BE0NPxBbelpQ7PVZ/azP4lan3NJ139fRPGu/UGYmT74khSnMwhmYRijxd7
         bzrw==
X-Gm-Message-State: AOAM533UC3MKJzOe5WIoPXYBVOAB4OTOTYFCRGmivvUxrztR0+4SjOY2
        Md9L5iCUzdaOaLvVqGu8An1J9cPfSGcF6FWJzzrxOQ3ecR72+KSCOThm0aBngKHG6UMBu+eJGW9
        zTe8x9Ox64MXaUrMXSKSE
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr351626wmj.30.1637271116111;
        Thu, 18 Nov 2021 13:31:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwETgrT9BbFta3TwOfEknxoqtR++U7e85LkpGZXwgIG7y31mDTm+UZnOgdcK7w7nztesDRrkA==
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr351589wmj.30.1637271115872;
        Thu, 18 Nov 2021 13:31:55 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g13sm766870wmk.37.2021.11.18.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 13:31:55 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] spi: docs: improve the SPI userspace API documentation
Date:   Thu, 18 Nov 2021 22:31:43 +0100
Message-Id: <20211118213143.2345041-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This doc is fairly outdated and only uses legacy device instantiation
terminology. Let us update it and also mention the OF and ACPI device
tables, to make easier for users to figure out how should be defined.

Also, mention that devices bind could be done in user-space now using
the "driver_override" sysfs entry.

Suggested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 Documentation/spi/spidev.rst | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/spi/spidev.rst b/Documentation/spi/spidev.rst
index f05dbc5ccdbc..ec0986ae6170 100644
--- a/Documentation/spi/spidev.rst
+++ b/Documentation/spi/spidev.rst
@@ -29,15 +29,39 @@ of the driver stack) that are not accessible to userspace.
 
 DEVICE CREATION, DRIVER BINDING
 ===============================
-The simplest way to arrange to use this driver is to just list it in the
-spi_board_info for a device as the driver it should use:  the "modalias"
-entry is "spidev", matching the name of the driver exposing this API.
+
+The spidev driver contains lists of SPI devices that are supported for
+the different hardware topology representations.
+
+The following are the SPI device tables supported by the spidev driver:
+
+    - struct spi_device_id spidev_spi_ids[]: list of devices that can be
+      bound when these are defined using a struct spi_board_info with a
+      .modalias field matching one of the entries in the table.
+
+    - struct of_device_id spidev_dt_ids[]: list of devices that can be
+      bound when these are defined using a Device Tree node that has a
+      compatible string matching one of the entries in the table.
+
+    - struct acpi_device_id spidev_acpi_ids[]: list of devices that can
+      be bound when these are defined using a ACPI device object with a
+      _HID matching one of the entries in the table.
+
+NOTE: it used to be supported to define an SPI device using the "spidev"
+      name.  For example as .modalias = "spidev" or compatible = "spidev".
+      But this is no longer supported by the Linux kernel and instead a
+      real SPI device name as listed in one of the tables should be used.
+
 Set up the other device characteristics (bits per word, SPI clocking,
 chipselect polarity, etc) as usual, so you won't always need to override
 them later.
 
-(Sysfs also supports userspace driven binding/unbinding of drivers to
-devices.  That mechanism might be supported here in the future.)
+Sysfs also supports userspace driven binding/unbinding of drivers to
+devices.  The mechanism works by writing to the device "driver_overrride"
+entry.  For example:
+
+    echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
+    echo spiB.C > /sys/bus/spi/drivers/spidev/bind
 
 When you do that, the sysfs node for the SPI device will include a child
 device node with a "dev" attribute that will be understood by udev or mdev.
-- 
2.33.1

