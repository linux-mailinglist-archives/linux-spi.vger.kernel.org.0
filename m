Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8282CC49
	for <lists+linux-spi@lfdr.de>; Tue, 28 May 2019 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfE1Qkr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 May 2019 12:40:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52831 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1Qkr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 May 2019 12:40:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so3705070wmm.2
        for <linux-spi@vger.kernel.org>; Tue, 28 May 2019 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ej81fOB8PClma2q551Mc3W9H8PCahAPhKY1SnLKkbyI=;
        b=OulgYt0n8ruauMW/L6BJZJFgRbD8bKzL5B4LXPshMIERSdxYW3kgAKV/lvlHlC8UY7
         2YQyuxCX+sraQBkubdedG46TkyGY1QzkU8S0/gcktNhPcajaHioM3YddSlHo/I7zoNIw
         DBl/UoNeJ9cSsKNQRWc7dyyDJZxUIuq2/pk3WfQzR6ZueIHtZ3Oio2/xTqyHwZrwY89A
         zmfurxN2HREHG8E0mm/7P5qXvBUFjpp3aVq/2MUnj15kDTSTFhkIf7dGuViUwKbqOAiG
         lxINfNuQ0gYYLeeBQsMH72hqhJr7B4bJd5MFUCOU/dn5m3Y3F03knpUCKLCXB2qF4S7z
         dm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ej81fOB8PClma2q551Mc3W9H8PCahAPhKY1SnLKkbyI=;
        b=dKl+Oe3ejmQFiwgSKPgcn0Ymj+2pqvCcvgNhQACOEBt7EHsdt8sMZvTMTEoe2aioIB
         zMq5704ifbg8mbWXZWHT07jMTTT7LNt57TpZUV37TLUvatUWVdHqKPO8ySXrGmM5x3Ey
         e4tKBYNvn+KtXCpmKqg+iFatIu/uiZjp62j4g69NUWwSwUodALDpaCuvYnlnDFCO8njS
         bEFjfL8TMKxX1CT8fk2u9qW6DxFtvwEnVnMWyczHFSZv9nZEnQ5WqAPrpOsSJwvmXgla
         5yPSBkZouYTR8TOcmlfu/8L4EeKZSIe42frF37zTQpi3LXfvZ2GUWteHZiwdIPVzS+PQ
         0bkQ==
X-Gm-Message-State: APjAAAUgSN4PiS7sBuVlK2s21j6ylupkBGhDjhq7KELUuvhvbyUNMZqy
        05glTBYBAdqB2ZcLbJccLrreJH0LY3bbUg==
X-Google-Smtp-Source: APXvYqzaUnxT3HH3oiidlS7spobYVkrvfWnz1P7OVnEuLkckwwfEyqXGZc2qyiCrYxIEaBJEWOClEQ==
X-Received: by 2002:a1c:e183:: with SMTP id y125mr3860136wmg.152.1559061643779;
        Tue, 28 May 2019 09:40:43 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:c8c7:f81b:b165:1aa7])
        by smtp.gmail.com with ESMTPSA id q11sm3503196wmc.15.2019.05.28.09.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 09:40:42 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, mika.westerberg@linux.intel.com,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH] spi/acpi: enumerate all SPI slaves in the namespace
Date:   Tue, 28 May 2019 18:40:40 +0200
Message-Id: <20190528164040.6781-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently, the ACPI enumeration that takes place when registering a
SPI master only considers immediate child devices in the ACPI namespace,
rather than checking the ResourceSource field in the SpiSerialBus()
resource descriptor.

This is incorrect: SPI slaves could reside anywhere in the ACPI
namespace, and so we should enumerate the entire namespace and look for
any device that refers to the newly registered SPI master in its
resource descriptor.

In order to prevent potential regressions, retain the old code and run
it first. Only then, enumerate the entire namespace. Note that this
could result in child devices wrongly being associated with a SPI master
but this can only occur if a SPI master has a child device representing
a SPI slave that is connected to another master.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/spi/spi.c | 75 ++++++++++++++++++--
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944ad5d1..d2f4332d9cc3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1882,10 +1882,6 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	struct spi_device *spi;
 	int ret;
 
-	if (acpi_bus_get_status(adev) || !adev->status.present ||
-	    acpi_device_enumerated(adev))
-		return AE_OK;
-
 	spi = spi_alloc_device(ctlr);
 	if (!spi) {
 		dev_err(&ctlr->dev, "failed to allocate SPI device for %s\n",
@@ -1927,18 +1923,64 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	return AE_OK;
 }
 
+static acpi_status acpi_spi_add_child_device(acpi_handle handle, u32 level,
+					     void *data, void **return_value)
+{
+	struct spi_controller *ctlr = data;
+	struct acpi_device *adev;
+
+	if (acpi_bus_get_device(handle, &adev) ||
+	    acpi_bus_get_status(adev) ||
+	    !adev->status.present ||
+	    acpi_device_enumerated(adev))
+		return AE_OK;
+
+	return acpi_register_spi_device(ctlr, adev);
+}
+
+static int acpi_spi_check_parent(struct acpi_resource *ares, void *data)
+{
+	struct acpi_resource_spi_serialbus *sb;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
+
+	sb = &ares->data.spi_serial_bus;
+
+	/* check whether this resource refers our controller */
+	acpi_get_handle(NULL, sb->resource_source.string_ptr, data);
+	return 1;
+}
+
 static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
 				       void *data, void **return_value)
 {
 	struct spi_controller *ctlr = data;
+	acpi_handle parent_handle = NULL;
+	struct list_head resource_list;
 	struct acpi_device *adev;
+	int ret;
 
-	if (acpi_bus_get_device(handle, &adev))
+	if (acpi_bus_get_device(handle, &adev) ||
+	    acpi_bus_get_status(adev) ||
+	    !adev->status.present ||
+	    acpi_device_enumerated(adev))
+		return AE_OK;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     acpi_spi_check_parent,
+				     &parent_handle);
+	acpi_dev_free_resource_list(&resource_list);
+
+	if (ret < 0 || ACPI_HANDLE(ctlr->dev.parent) != parent_handle)
 		return AE_OK;
 
 	return acpi_register_spi_device(ctlr, adev);
 }
 
+#define SPI_ACPI_ENUMERATE_MAX_DEPTH		32
+
 static void acpi_register_spi_devices(struct spi_controller *ctlr)
 {
 	acpi_status status;
@@ -1948,10 +1990,31 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
 	if (!handle)
 		return;
 
+	/*
+	 * Enumerate child nodes of this controller. This logic is retained to
+	 * prevent potential regressions on systems where the ResourceSource of
+	 * a device's SpiSerialBus() resource does not refer to the parent SPI
+	 * controller device.
+	 */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+				     acpi_spi_add_child_device, NULL, ctlr,
+				     NULL);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(&ctlr->dev, "failed to enumerate SPI children\n");
+		return;
+	}
+
+	/*
+	 * Walk the entire namespace and enumerate all devices containing a
+	 * SpiSerialBus() resource whose ResourceSource argument refers to this
+	 * SPI controller device.
+	 */
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     SPI_ACPI_ENUMERATE_MAX_DEPTH,
 				     acpi_spi_add_device, NULL, ctlr, NULL);
 	if (ACPI_FAILURE(status))
-		dev_warn(&ctlr->dev, "failed to enumerate SPI slaves\n");
+		dev_warn(&ctlr->dev,
+			 "failed to enumerate SPI slaves in the ACPI namespace\n");
 }
 #else
 static inline void acpi_register_spi_devices(struct spi_controller *ctlr) {}
-- 
2.20.1

