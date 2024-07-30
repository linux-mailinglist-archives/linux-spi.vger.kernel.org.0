Return-Path: <linux-spi+bounces-4074-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6C9405C2
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 05:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E98E1C20EA7
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 03:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79042EB02;
	Tue, 30 Jul 2024 03:20:52 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331C1854;
	Tue, 30 Jul 2024 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309652; cv=none; b=ACyMqfCPqgzeJTUS0htxQT5dtF+hY9RyDLvNarVnYP2NDWuYEWO2FzDGobzP4Iatvos4NybXumIxgD15B/P/SgwIowkB3gKNTthiPM+SYTyRJiAvzV1pXOAMsRc3CCqR3bW+jbXVwGaSiIy2Eabu+s10IaQ126+r6WxOYdxTqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309652; c=relaxed/simple;
	bh=tdoD4uHVjnuSZ6gIsaKJasSt28EnX8TfA8PXN0KJ9H4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B71d8kpGF8sCtex+9okRfDnBxB9dkeOirF9ms0xEk72UNBEa0yrKFsx3dO1xu16LograLLuZE5bDWcz62zhBgDTRj1Ev8rBm5p91MAJCbNq/criLIv+9+Ayqkob4BMBqlYzr9Ubfco5ce8wxjPqTsoAt3WDr+ab7V9jbQbFv1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WY0k20KDBz28fsh;
	Tue, 30 Jul 2024 11:16:10 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 20C531A0188;
	Tue, 30 Jul 2024 11:20:42 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 11:20:41 +0800
From: Devyn Liu <liudingyuan@huawei.com>
To: <f.fangjian@huawei.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <shiju.jose@huawei.com>,
	<liuyonglong@huawei.com>, <yangyicong@huawei.com>, <yisen.zhuang@huawei.com>,
	<kong.kongxinwei@hisilicon.com>, <liudingyuan@huawei.com>
Subject: [PATCH 0/2] spi: hisi-kunpeng: Set verification for speed_hz and max_frequency
Date: Tue, 30 Jul 2024 11:20:38 +0800
Message-ID: <20240730032040.3156393-1-liudingyuan@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600002.china.huawei.com (7.193.23.29)

The speed_hz is specified by user, while the max_frequency is a
firmware-provided parameter for the SPI controller. Both are used
in the calculation of clk_div. To avoid calculation results outside
of a reasonable range and to prevent division by zero errors,
configuration for validation of speed_hz and max_frequency is added
in the code.

Devyn Liu (2):
  spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
  spi: hisi-kunpeng: Add verification for the max_frequency provided by
    the firmware

 drivers/spi/spi-hisi-kunpeng.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.33.0


