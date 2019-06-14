Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3636F46688
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jun 2019 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFNRzE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jun 2019 13:55:04 -0400
Received: from foss.arm.com ([217.140.110.172]:39438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfFNRzD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFBB9346;
        Fri, 14 Jun 2019 10:55:02 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D20023F718;
        Fri, 14 Jun 2019 10:55:01 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 09/28] drivers: Add generic match helper by ACPI_COMPANION device
Date:   Fri, 14 Jun 2019 18:54:04 +0100
Message-Id: <1560534863-15115-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a generic helper to match a device by the ACPI_COMPANION device.
This will be later used for providing wrappers for
(bus/class/driver)_find_device().

Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c    | 6 ++++++
 include/linux/device.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b827ca1..597095b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3346,3 +3346,9 @@ int device_match_devt(struct device *dev, const void *pdevt)
 	return dev->devt == *(dev_t *)pdevt;
 }
 EXPORT_SYMBOL_GPL(device_match_devt);
+
+int device_match_acpi_dev(struct device *dev, const void *adev)
+{
+	return ACPI_COMPANION(dev) == adev;
+}
+EXPORT_SYMBOL(device_match_acpi_dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index f315692..a03b50d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -166,6 +166,7 @@ void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 int device_match_of_node(struct device *dev, const void *np);
 int device_match_fwnode(struct device *dev, const void *fwnode);
 int device_match_devt(struct device *dev, const void *pdevt);
+int device_match_acpi_dev(struct device *dev, const void *adev);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
-- 
2.7.4

