Return-Path: <linux-spi+bounces-4315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9195F221
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE701C22BD3
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67FA19306D;
	Mon, 26 Aug 2024 12:51:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AF17D8A6;
	Mon, 26 Aug 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676689; cv=none; b=qyGT9NdMTEOgngFERYYVyfZrVbQwhdNzsUPjRwUiEMrluNllwWP91uVETHPT2M6E5yN8lL44L0gjZQs54D9aVFcj1dpeHMy7zaUzq0J5phBjUD3WySGztISlpwQpnk+u8vpBrJhT8zMvebALVlG4DKEPCbcJOEaQjxL+wuaOKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676689; c=relaxed/simple;
	bh=H6fTxGpiPLgBEAfJEQEY3Vu5D5JpYiG7QQbbJrNAbos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lzi5AQc6SyOi9u8IxJHr4EPqb0CChyu6/UltKOqRZPxE+PrwA0HgLlWhrUlwRfIKoOiFZeWCAiu9pElKfa7yKS9q4vAULkAsQs2V4ZGjaX7hiyYVTej4LR/wt8+NtTyqhqjzb/PEmAWIRCxZVCLhqLZ77tZeXBuR5o1kbBkUaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WsrBP5N6fzyNtY;
	Mon, 26 Aug 2024 20:50:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 98FC91800A5;
	Mon, 26 Aug 2024 20:51:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:51:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/2] spi: atmel-quadspi: Fix uninitialized res
Date: Mon, 26 Aug 2024 20:59:11 +0800
Message-ID: <20240826125913.3434305-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Fix uninitialized res in probe function.

Jinjie Ruan (2):
  spi: atmel-quadspi: Fix uninitialized res
  spi: atmel-quadspi: Simplify with dev_err_probe()

 drivers/spi/atmel-quadspi.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

-- 
2.34.1


