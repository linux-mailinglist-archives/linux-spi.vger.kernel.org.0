Return-Path: <linux-spi+bounces-4745-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19797971AA8
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3051C2228A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D251B86E3;
	Mon,  9 Sep 2024 13:19:20 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A41B7908;
	Mon,  9 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887960; cv=none; b=csTcgYT+gMqgHURLFcAQylNvb6OVWwy9JYsagkokzMoAq8/YhItdVpig9IIL8xVbP0t2XTUFzUQpsT9kkbGs/leFyfvCvpTi43VWJXJb4NHZPrRYiXXS/tgtYQkr7cM49R0dX6q0a+fFGa9NSrYiFfWBDI1li/bPB7yEv+pLwG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887960; c=relaxed/simple;
	bh=77Ni89lzjyGYZMHKR/SGf/LTZvAQZtxs/EGmmTAWy7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5/eUwkMtuM8Q9pRX//dgLko5uU01Hh+JGUvVeX2u9CLBwuhPNkjWa4JrjRuTj3hTdVbYwH7OVDw34MBdziR9gHlUoFMJ1cMiSEwQjdK+bWAVHLbEUx8OZHTxcFbZJXNeXTVRGE9IXuDl2jGt65eLIwHx+9HkriWMu8aJAHzdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X2S8769dpzyRg2;
	Mon,  9 Sep 2024 21:18:31 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 804251400FD;
	Mon,  9 Sep 2024 21:19:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:19:14 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <dianders@chromium.org>, <akashast@codeaurora.org>,
	<vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 0/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
Date: Mon, 9 Sep 2024 21:28:07 +0800
Message-ID: <20240909132810.1296786-1-ruanjinjie@huawei.com>
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
 kwepemh500013.china.huawei.com (7.202.181.146)

Fix two bugs for geni-qcom and use dev managed function
to simplify code.

Compile-tested only.

Changes in v4:
- Correct the "data" of devm_add_action_or_reset().
- Add reviewed-by.
- Update the commit message.

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


