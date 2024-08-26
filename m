Return-Path: <linux-spi+bounces-4318-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C470C95F2AE
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024D91C21C1A
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E71185B41;
	Mon, 26 Aug 2024 13:17:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF46185948;
	Mon, 26 Aug 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678279; cv=none; b=hoQlofQzY7GQT1sNI7IxzDtQerauO48O0mIv5eEHbRI8qKqDvbV703PGYmB4qnRnub5sIiZ5pI9uYuWcNnbzkxi0TL+5ExCAZf4aLYF4ApEHWRy6p0R0OUl1GlwM8QGhnPAY8OvK+HMu4CjNCysTAwbi2PniVpgTXpjZgc6dp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678279; c=relaxed/simple;
	bh=C1OQJvYUqHz/dWNOrDMEbCb7PEYW396uCrigkeZ0Qog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oGDlJ3fmdenqXv+50F09x1nndFwskFnJHKtWdSe5VHYFU6b6OIys1s/norHFSsKgCQ8t0suQADJdcJ6fjM+pf0gtT9D7j0ZxY3saSAJMtwzZ2m1tDB1zjp1zJUQiX+Ldhjiy6mUyByI/hBuTdcgwgOwxGjG2j7JaWbxzLO4nKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wsrmz59wWzyQKr;
	Mon, 26 Aug 2024 21:17:07 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 970341800F2;
	Mon, 26 Aug 2024 21:17:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 21:17:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <j.neuschaefer@gmx.net>, <broonie@kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/2] spi: wpcm-fiu: Fix uninitialized res
Date: Mon, 26 Aug 2024 21:25:42 +0800
Message-ID: <20240826132544.3463616-1-ruanjinjie@huawei.com>
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

Fix uninitialized res in probe function.

Jinjie Ruan (2):
  spi: wpcm-fiu: Fix uninitialized res
  spi: wpcm-fiu: Simplify with dev_err_probe()

 drivers/spi/spi-wpcm-fiu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.34.1


