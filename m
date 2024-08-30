Return-Path: <linux-spi+bounces-4453-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1596590E
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 09:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CE21F223EA
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 07:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34213AA47;
	Fri, 30 Aug 2024 07:50:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDA12F59C
	for <linux-spi@vger.kernel.org>; Fri, 30 Aug 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004200; cv=none; b=HIuEgPIdsfqLapLAUJB1iutyu6NcOwHJjQXYMMi37WWcvxSKTV+vxRrMhg7NyTNBE6p47gVHZihLaeu382C0KGyDEEJxceHx/71+shQp45yzdUe1r8iDlvq3qEhngXGkB7LGdqJsohmzTwjiCrRUrlQqu35Cps3iA1GvFA0jkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004200; c=relaxed/simple;
	bh=89RlPA3ik/POB8xCPJLowKleax8HNTJIUCwHCAKKLOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jQGQqJVybyeVWlEZv2Is2cd2HOAyj7ebi289l/IhFq2XEKMLBs5jNhmUX8yAyqOuoRuIIR2hFlRcl6DVmEpFNch4VV3p+cuUAtNPT4zUw8M5NZv7zQwFpyc8TnnK3o3v0lnlFOUYrDiED0ex76UM+712+xnTH8GWTNc+wWaCNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ww9JW0vh9z18MyL;
	Fri, 30 Aug 2024 15:48:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C1018140360;
	Fri, 30 Aug 2024 15:49:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 15:49:49 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] spi: spi-ppc4xx: Remove duplicate included header file linux/platform_device.h
Date: Fri, 30 Aug 2024 15:58:00 +0800
Message-ID: <20240830075800.3541646-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The header file linux/platform_device.h is included
twice. Remove the last one.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/spi/spi-ppc4xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 6071f83dd9c8..36722fa6c8bf 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -30,7 +30,6 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-- 
2.34.1


