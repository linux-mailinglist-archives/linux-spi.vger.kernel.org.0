Return-Path: <linux-spi+bounces-4919-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9694797E51B
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 05:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482BB1F21706
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 03:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47EDF59;
	Mon, 23 Sep 2024 03:50:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7003FE4;
	Mon, 23 Sep 2024 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727063423; cv=none; b=LYr9ShCJznee6Ra2hwlRjMQ9k67XRqZgMLFs2kPyk9+yqtJZbjTjeV9RpGob7BfuCnICmjDz82ZpyE2CaJuHHJqw89+yf+dp6uNa7c8hTOrUiQw1zdarQOcSBT2H1XHuhFsgMcYNeVUbgptcj3FRbvKnVkubwM3cZ3i4/LR1m9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727063423; c=relaxed/simple;
	bh=wgow8dZQUl9IVhTZyaZQEeQ275kA+8KwqwszuahwwFI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ne6oD/887RDhbOJ5rSdRAnqxt6XxLpacsTlxiBEUBudCluY5LuzZfWJh9X9DqERj9RhbedQ5/QxbGMVt/V/+dX3s3osa6plZBIRBXREn6mzk5w8Tu017ClH/64/71YInCGi5ilW8y9s3oMUnJ4/kRg4IiKTdGdgU5Uaqs9oiVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XBps95ghdz2DcPq;
	Mon, 23 Sep 2024 11:49:33 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3066E1400E8;
	Mon, 23 Sep 2024 11:50:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 11:50:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
	<kernel@pengutronix.de>, <festevam@gmail.com>,
	<shubhrajyoti.datta@xilinx.com>, <srinivas.goud@amd.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 0/3] spi: Fix pm_runtime_set_suspended() with runtime pm enabled
Date: Mon, 23 Sep 2024 12:00:12 +0800
Message-ID: <20240923040015.3009329-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Fix pm_runtime_set_suspended() with runtime pm enabled, and fix the missing
check for spi-cadence.

Jinjie Ruan (3):
  spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
  spi: spi-cadence: Fix pm_runtime_set_suspended() with runtime pm
    enabled
  spi: spi-cadence: Fix missing spi_controller_is_target() check

 drivers/spi/spi-cadence.c | 8 +++++---
 drivers/spi/spi-imx.c     | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.34.1


