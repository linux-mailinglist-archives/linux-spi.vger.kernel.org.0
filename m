Return-Path: <linux-spi+bounces-4309-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BEF95F0D1
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F611F24988
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE7E16C69F;
	Mon, 26 Aug 2024 12:06:38 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960D155CAF;
	Mon, 26 Aug 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673998; cv=none; b=fHDot2d8jgmz2vnKfFJWzr+1dFib+WWvQ+SQ2sLOPyS+1HIqK9n2BFRay44/AHLxnQowoqBQDYKYAvb6IvCr/sO4hYw81eSqAoMmqPBi41RhxxYdOvhmZtH5pYLu+NRfs8o60VzVYz6qnrZkZ/snO3bpkJyjYExIwpRVgZYOiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673998; c=relaxed/simple;
	bh=o5G+oxXHcVEc3jzxNkyPO+8RKjQPLvP5aoaFHYhMWxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=npEgG/mtZDNYeHE4jBKQyr0yHLIfLiO+6ScIVWGFlfHRfVDHWfEotSZCA9TU2oAPiF7vn3ljSrwI1QIXMPowpBIY79Qvf2eNrP1VRpC0lCXKFEz8udLWsWEiVOBgy3aYfn5RpB/6EQv2zSMP0RnVhAX67Qrz2D9n4YP4SIE1apM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WsqBh2hkRzyQKs;
	Mon, 26 Aug 2024 20:05:48 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 329081800D0;
	Mon, 26 Aug 2024 20:06:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:06:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/2] Use devm_spi_alloc_host() to simplfy code
Date: Mon, 26 Aug 2024 20:14:19 +0800
Message-ID: <20240826121421.3384792-1-ruanjinjie@huawei.com>
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

Use devm_spi_alloc_host() and dev_err_probe() to simplfy code.

Jinjie Ruan (2):
  spi: zynqmp-gqspi: Use devm_spi_alloc_host()
  spi: zynqmp-gqspi: Simplify with dev_err_probe()

 drivers/spi/spi-zynqmp-gqspi.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

-- 
2.34.1


