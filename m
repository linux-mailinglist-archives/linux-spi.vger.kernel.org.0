Return-Path: <linux-spi+bounces-4312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B32F95F1A9
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3E128158F
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B41885AA;
	Mon, 26 Aug 2024 12:41:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4CD186603;
	Mon, 26 Aug 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676081; cv=none; b=cfnGG2GHqlZAYfdZIATfucuxS36zF6nR1TPlnj9bXqIrebrOty333vq/9eb268tL2I6sDSEe3R31AiKwUGONsEn4VqO5g0nVN+B1PSip9P825ub2NZcJSEbvn32bs5tBxnEfllc0w8fJ9r/LpP04192gy4vkQt20ZVaxyql7kbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676081; c=relaxed/simple;
	bh=MFLXzHhzQtmaPzcBgKiOFv643ZaWNpRNcho6FTTbIsE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5pwao97bUDlcipS31tIO/dOKO7BzqZa3xSKgf8sUetWoLNgP72evw22ccRjC4NStSv+GscOfWz9ixPcT7VF+4CaZwRBE/O2lXkVBwzPBFPiiv9Ct3ct/iaecsLhJVQc70eESbGhOp0fs8lH/d37IU1O8f78Vo2uULrt36T4Lf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wsqxj1w3QzpTfX;
	Mon, 26 Aug 2024 20:39:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 489931800A5;
	Mon, 26 Aug 2024 20:41:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:41:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <william.zhang@broadcom.com>, <kursad.oney@broadcom.com>,
	<jonas.gorski@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<broonie@kernel.org>, <anand.gore@broadcom.com>,
	<florian.fainelli@broadcom.com>, <rafal@milecki.pl>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/2] spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
Date: Mon, 26 Aug 2024 20:49:01 +0800
Message-ID: <20240826124903.3429235-1-ruanjinjie@huawei.com>
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

Fix missing pm_runtime_disable().

Jinjie Ruan (2):
  spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
  spi: bcmbca-hsspi: Use devm_spi_alloc_host()

 drivers/spi/spi-bcmbca-hsspi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.34.1


