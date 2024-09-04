Return-Path: <linux-spi+bounces-4585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0196AE6F
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 04:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80856286EF5
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 02:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B776FBF0;
	Wed,  4 Sep 2024 02:11:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E82CCC2;
	Wed,  4 Sep 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415881; cv=none; b=rGopSOF4m5NN2Svwlp+3tMJ8JjsgFJfFja3dhntrUGV7bed/RtFh5LaKTx71+fT2RU0yvWAJNHFAM/6Pyf4XHydbFgXWRafCNAUevmWZAt1nU9AVJqBM+i1qILIvnKAg8BNRCM72HG/3IuLAWZGWH8uYlp7C1csIHL+PxTHpNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415881; c=relaxed/simple;
	bh=thdlDey7wmqT50DoIMovEwQsWaiuWYmtOTuAgb580G8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=emhX3Dknz6vq4LQmM0PDg//9sbHFMbh65o3hrU3fy87mGLin/+PIhlxLxwEwpIVvP+/ntwxUVmiKgCYdib3Jr6lEFi9eIczXHg/srwfPjXmo/QYDexdXevE6Iazws5vKSO0WtSXdqgLUARV+BOTvMkeaPbPYvKEwg+gMoPIlQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wz5XL62F6zpVL7;
	Wed,  4 Sep 2024 10:09:22 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D94E91402CC;
	Wed,  4 Sep 2024 10:11:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Sep
 2024 10:11:14 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
Date: Wed, 4 Sep 2024 10:19:40 +0800
Message-ID: <20240904021943.2076343-1-ruanjinjie@huawei.com>
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

Undo runtime PM changes at driver exit time and simplify the code using
managed functions.

Jinjie Ruan (3):
  spi: geni-qcom: Use devm_request_irq() helper
  spi: geni-qcom: Undo runtime PM changes at driver exit time
  spi: geni-qcom: Use devm_spi_register_controller()

 drivers/spi/spi-geni-qcom.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

-- 
2.34.1


