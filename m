Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117F456EB8
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 13:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhKSMOr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 07:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234774AbhKSMOr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 07:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637323905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mYODhovx0E6MMGnAGcc0cLeU5iWwi46oEcCmHIiD4G8=;
        b=Lb9ffPGMs5eIYrQQWB5h5TVUS9nOeWWsQs7uGhfsITy4LxRgwJZGn2IHwPPCNIIoS39716
        mBsdaO7r/2TX0N/UmXCs8NrqfOIHLNgyPoFE/CMWbblGJ5tFKy+GxiWH4KSXXBpONCj7vU
        SSoUm9xac0SVo/MT9/nE+O0sAVWEVW0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-8Uf3yPylPra8Q_6ySdoE5w-1; Fri, 19 Nov 2021 07:11:44 -0500
X-MC-Unique: 8Uf3yPylPra8Q_6ySdoE5w-1
Received: by mail-wm1-f71.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so4616992wms.8
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 04:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYODhovx0E6MMGnAGcc0cLeU5iWwi46oEcCmHIiD4G8=;
        b=4IItESKmPqoZVJMV3US7rY6c08Ggod3X0dqotRg9QQhLIoD2G7YHhjrXJLgECZfJwU
         sYpauQLUB+8kgozHOo9G+oVle5SDcaFgCoagQMnJ8ZPNqNOfPhMKVwLuj+2V7wzsY7yK
         uFnEtZWjmHgV+9dmLdvbgtS4Ze5nVhiqXc1rBJ3osWzV/DBgGEVA4oSrF2MjHLcVYuSP
         Z0qgNGVeQCdO8/0ag3RMHAqFVzXOSozGtZ5P5EiNXSb7R0PJ2kUSozqXrVY6qUypq3WK
         zKBqGRvA+Mw4GI5Z9s59uG8PbpgusNQjh2tWnzAnMMQrCuW5wMAJUJQ7Vs7nVo+tUnBP
         fgow==
X-Gm-Message-State: AOAM530wm6iCWKqeVva5qsKEYjDbEEApRG1+MyMcfIgY20DnDyI/b6Vc
        20dwnnMia/DpYqygt90WLvlenJ9D4BI7081fpo8FhVNSWN8/UKhXlqNmw/96CRyz5Mkyr4D2n/1
        lAA3CpifgF+RrkkNGOB3w
X-Received: by 2002:a05:6000:381:: with SMTP id u1mr6413310wrf.383.1637323902677;
        Fri, 19 Nov 2021 04:11:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzD+wBSVFzzMULh5tQAzgoFomke2v4u4GVEVKNDiXcaClcyRw8/fDTn66rzPB/URvDxm2rOew==
X-Received: by 2002:a05:6000:381:: with SMTP id u1mr6413275wrf.383.1637323902417;
        Fri, 19 Nov 2021 04:11:42 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e3sm2758261wrp.8.2021.11.19.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:11:42 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2] spi: docs: improve the SPI userspace API documentation
Date:   Fri, 19 Nov 2021 13:11:39 +0100
Message-Id: <20211119121139.2412761-1-javierm@redhat.com>
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

Changes in v2:
- Reword paragraph that explains the user-space spidev bind support
  using sysfs (Uwe Kleine-König).
- Also improve the paragraph that explains that the SPI device sysfs
  node will contain a "dev" attribute (Uwe Kleine-König).
- Explain that the matching tables can be extended and developers are
  encouraged to do so (Geert Uytterhoeven).

 Documentation/spi/spidev.rst | 58 ++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/Documentation/spi/spidev.rst b/Documentation/spi/spidev.rst
index f05dbc5ccdbc..369c657ba435 100644
--- a/Documentation/spi/spidev.rst
+++ b/Documentation/spi/spidev.rst
@@ -29,21 +29,49 @@ of the driver stack) that are not accessible to userspace.
 
 DEVICE CREATION, DRIVER BINDING
 ===============================
-The simplest way to arrange to use this driver is to just list it in the
-spi_board_info for a device as the driver it should use:  the "modalias"
-entry is "spidev", matching the name of the driver exposing this API.
-Set up the other device characteristics (bits per word, SPI clocking,
-chipselect polarity, etc) as usual, so you won't always need to override
-them later.
-
-(Sysfs also supports userspace driven binding/unbinding of drivers to
-devices.  That mechanism might be supported here in the future.)
-
-When you do that, the sysfs node for the SPI device will include a child
-device node with a "dev" attribute that will be understood by udev or mdev.
-(Larger systems will have "udev".  Smaller ones may configure "mdev" into
-busybox; it's less featureful, but often enough.)  For a SPI device with
-chipselect C on bus B, you should see:
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
+You are encouraged to add an entry for your SPI device name to relevant
+tables, if these don't already have an entry for the device. To do that,
+post a patch for spidev to the linux-spi@vger.kernel.org mailing list.
+
+It used to be supported to define an SPI device using the "spidev" name.
+For example, as .modalias = "spidev" or compatible = "spidev".  But this
+is no longer supported by the Linux kernel and instead a real SPI device
+name as listed in one of the tables must be used.
+
+Not having a real SPI device name will lead to an error being printed and
+the spidev driver failing to probe.
+
+Sysfs also supports userspace driven binding/unbinding of drivers to
+devices that do not bind automatically using one of the tables above.
+To make the spidev driver bind to such a device, use the following:
+
+    echo spidev > /sys/bus/spi/devices/spiB.C/driver_override
+    echo spiB.C > /sys/bus/spi/drivers/spidev/bind
+
+When the spidev driver is bound to a SPI device, the sysfs node for the
+device will include a child device node with a "dev" attribute that will
+be understood by udev or mdev (udev replacement from BusyBox; it's less
+featureful, but often enough).
+
+For a SPI device with chipselect C on bus B, you should see:
 
     /dev/spidevB.C ...
 	character special device, major number 153 with
-- 
2.33.1

