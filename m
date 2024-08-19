Return-Path: <linux-spi+bounces-4224-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B5956ADB
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DC41C2389C
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21EF16CD0D;
	Mon, 19 Aug 2024 12:26:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A916CD02;
	Mon, 19 Aug 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070393; cv=none; b=bY124Rcg+rIzKf66fXVMBf9hi7ZnhzeSqVBzPnFh6Cr77XUQoHasrbldp143wzohW41As6lWWILXPLx3POsv9NuD3SUdSrpik3iDXL6e4MRTpkmNAgflJli9bwU6Y4gbwiW3Bnc94bV1ZRsbzAWSPVhBCIoNq1XN+4vYdGhmr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070393; c=relaxed/simple;
	bh=+NeEq+oX4D3bHvYU64Dvb7RzOVdWxOWs8QwWPhoaWMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMNn33GlQwg9CDto/1J27XxG6MQmT6pK82PrPr0dJNbb+Xl0pFMcKlQBfwycjTK0/EGDefpOuJMq7xnhmFJHzJr//QpG8WkypkaA++VbymK2TLN5f4B3RiD/C3CzXQrgMi0K9yzKoQxNcZEE8bIsvUHMne/d74qbmT2/u2+AZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnWy506JRzpSsv;
	Mon, 19 Aug 2024 20:25:01 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 603DE1800A5;
	Mon, 19 Aug 2024 20:26:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 20:26:28 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jonas.gorski@gmail.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 RESEND 0/2] spi: bcm63xx: Fix two bugs
Date: Mon, 19 Aug 2024 20:33:47 +0800
Message-ID: <20240819123349.4020472-1-ruanjinjie@huawei.com>
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

Fix module autoloading and missing pm_runtime_disable().

Chanegs in v2:
- Add Reviewed-by and Suggested-by.
- Cc stable.
- Change the fix way for the 2th patch.
- Update the commit message.

Jinjie Ruan (2):
  spi: bcm63xx: Fix module autoloading
  spi: bcm63xx: Fix missing pm_runtime_disable()

 drivers/spi/spi-bcm63xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.34.1


