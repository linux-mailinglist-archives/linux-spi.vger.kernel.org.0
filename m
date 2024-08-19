Return-Path: <linux-spi+bounces-4220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9A5956ACB
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6245B2556E
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763D516B38F;
	Mon, 19 Aug 2024 12:24:46 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372516BE1D;
	Mon, 19 Aug 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070286; cv=none; b=uoZEoMqy7xHtNMqvKF0Wa44KqKXgPZ2CZj7JZIZRCun09LocvXYmb2cmA4mfj2dIvHO9+Gvx2A58p3zUIt02OC8/Iu/g2K6BoKITIK2cX4MlKVtCjoFQ9lKpT+TcrStr9Led7hOfuPba3eAWXX6MDD3xHA+0L8EyGGiKJpEcWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070286; c=relaxed/simple;
	bh=+NeEq+oX4D3bHvYU64Dvb7RzOVdWxOWs8QwWPhoaWMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CnYZ9xxR6ae6BW8Xy2s+cH38tvwhawRFnBWTZKETJqhj9C4bSKilfOM4QyMBsI6JjlkypG5QgR7qbxhlS5BJeYTj+gUvaQ3JOgPZMYpD7LYuQAGWQNQ8ha+AFGTzzeVE5P1AyqJZkYoSp7FM1D+AZ3ceiZ2gegW3/0HTSJFaEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WnWvX34yHz1xvWr;
	Mon, 19 Aug 2024 20:22:48 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 090EF1A016C;
	Mon, 19 Aug 2024 20:24:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 20:24:41 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jonas.gorski@gmail.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/2] spi: bcm63xx: Fix two bugs
Date: Mon, 19 Aug 2024 20:31:54 +0800
Message-ID: <20240819123156.4020377-1-ruanjinjie@huawei.com>
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


