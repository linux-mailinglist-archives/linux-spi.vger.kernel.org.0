Return-Path: <linux-spi+bounces-4719-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C402970F82
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C25328278A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB371AF4F9;
	Mon,  9 Sep 2024 07:23:08 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6191AED44;
	Mon,  9 Sep 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866588; cv=none; b=NaUoS6FtJayeFg4DYqB1OL5lB4OPcc2SBbZnCHQQwdHDVej9sFqwyMDSv/DLOKrI5Ynoxm1AsbdrAuD2wzvTIdTOs3ClIiF5O4k1rfjtiXByGybvng4rrR06Dt1Wetv3dX7qNWmNvtQVOpQocxjPsfkY9vQhtPAhU6htmqODI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866588; c=relaxed/simple;
	bh=7X9Hx7N3k9laO7oD2yz2oEvxhXOT4cjuIME9xKxLlvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WsTng/NQh15tE3k5ajCyA4GPTmLxGkJnpJpGqtL2p7tGDJkelHm0ZujSa4JirQjESOimTi8ebP1yUM5jR2hkDm2/Mez6BlEdkKT3vv4W7xSBj45CMoybvmRXM2oBblSR8ckDeoo08bCu40F3GAGwUKVdLqYDn3sSHkv//AYHRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2JFS6myyz2Dbw2;
	Mon,  9 Sep 2024 15:22:36 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8370C1A0188;
	Mon,  9 Sep 2024 15:23:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 15:23:03 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 0/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
Date: Mon, 9 Sep 2024 15:31:38 +0800
Message-ID: <20240909073141.951494-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Fix two bugs for geni-qcom and use dev managed function
to simplify code.

Changes in v3:
- Adjust the runtime PM patch to be the first.
- Use devm_pm_runtime_enable() to undo runtime PM changes.
- Land the rest of the cleanups afterwards.
- Update the commit message.

Changes in v2:
- Split out the device managed cleanup patch.
- PATCH -next -> PATCH
- Also fix the incorrect free_irq() sequence.

Jinjie Ruan (3):
  spi: geni-qcom: Undo runtime PM changes at driver exit time
  spi: geni-qcom: Fix incorrect free_irq() sequence
  spi: geni-qcom: Use devm functions to simplify code

 drivers/spi/spi-geni-qcom.c | 50 ++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

-- 
2.34.1


