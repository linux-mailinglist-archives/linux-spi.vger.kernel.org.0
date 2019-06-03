Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DCC33432
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2019 17:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfFCPvM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 11:51:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53598 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbfFCPvK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D9D169E;
        Mon,  3 Jun 2019 08:51:10 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 558303F246;
        Mon,  3 Jun 2019 08:51:09 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: [RFC PATCH 08/57] drivers: spi: Use bus_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:49:34 +0100
Message-Id: <1559577023-558-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to using the bus_find_device_by_of_node helper

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944..ecdd602 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3538,16 +3538,11 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_OF)
-static int __spi_of_device_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /* must call put_device() when done with returned spi_device device */
 struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 {
-	struct device *dev = bus_find_device(&spi_bus_type, NULL, node,
-						__spi_of_device_match);
+	struct device *dev = bus_find_device_by_of_node(&spi_bus_type, NULL, node);
+
 	return dev ? to_spi_device(dev) : NULL;
 }
 EXPORT_SYMBOL_GPL(of_find_spi_device_by_node);
-- 
2.7.4

