Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 361233600A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2019 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfFEPOp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jun 2019 11:14:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfFEPOl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Jun 2019 11:14:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E056715BF;
        Wed,  5 Jun 2019 08:14:40 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 612923F246;
        Wed,  5 Jun 2019 08:14:39 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 07/13] drivers: Add generic match helper by ACPI_COMPANION device
Date:   Wed,  5 Jun 2019 16:13:44 +0100
Message-Id: <1559747630-28065-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a generic helper to match a device by the acpi device.

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

