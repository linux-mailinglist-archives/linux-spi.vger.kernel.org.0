Return-Path: <linux-spi+bounces-4219-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5EA9569ED
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 13:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714971C22CE3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB30166F3E;
	Mon, 19 Aug 2024 11:53:15 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A715ADB3;
	Mon, 19 Aug 2024 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068395; cv=none; b=W6C15tlvjXPXmwkFa464b01yZViTYgKdBPS4aj7K1krkk3FQ9NVIE8ATD3RxtBcefmeFwnVBR+g/XtnYfdxX4D6GgGYMw5zV0nwL9GfnHSD70nl4VOWBNuZdZykGqF09Gx0Bl0qv3l3urULUIpCVb15Ndq5JlDZ7EEwcobYuu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068395; c=relaxed/simple;
	bh=K44eLExsrDbu7HZsCO8GrQP3RF9hqXewLM32he0uN+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6z/E7CfZA9xoI3MVrKNxeMovntZKlO8bCfbHsij5Ta4jOvIwxlUPmEc0v+byBu/RsUt8agJoNEgxYM3TlXXGDEXTtH/UFoRV5QeVRJzIsfVBpDSyiocN4z1VX+ufKJNM5gikVi8rv3KUjailaY6GpW5QOjURoxu5OCyZ08k+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WnWDf4zRKzyPvk;
	Mon, 19 Aug 2024 19:52:34 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AF0C140159;
	Mon, 19 Aug 2024 19:53:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:53:10 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 5/8] spi: cadence: Make cdns_mrvl_xspi_clk_div_list static
Date: Mon, 19 Aug 2024 20:00:31 +0800
Message-ID: <20240819120031.3884913-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/spi/spi-cadence-xspi.c:334:11: warning:
	symbol 'cdns_mrvl_xspi_clk_div_list' was not declared. Should it be static?

This symbol is not used outside spi-cadence-xspi.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-cadence-xspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 695a9bc1969a..aed98ab14334 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -331,7 +331,7 @@ static struct cdns_xspi_driver_data cdns_driver_data = {
 	.mrvl_hw_overlay = false,
 };
 
-const int cdns_mrvl_xspi_clk_div_list[] = {
+static const int cdns_mrvl_xspi_clk_div_list[] = {
 	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
 	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
 	8,	//0x2 = Divide by 8.   SPI clock is 100 MHz.
-- 
2.34.1


