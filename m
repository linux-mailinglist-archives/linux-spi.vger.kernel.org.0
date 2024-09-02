Return-Path: <linux-spi+bounces-4510-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F076696882E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 15:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A30D1F22F75
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422C20FA93;
	Mon,  2 Sep 2024 13:00:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AE20013B;
	Mon,  2 Sep 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282002; cv=none; b=a0opLTJAWGdDclLIOIXlSvvzj1qI59eBd81ySyse+wfGUZZ2j8NWL6lPLliUXfJSxh+MNLX+MVQaEsRleMrA+n68IS4zQWAk+F/GcAxPeD0NFSM62Gzb+RDZNi8aJeXnlgxVI+879wvRrc7dGHBovL4RX8RNRF0yGkUGcM6/U/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282002; c=relaxed/simple;
	bh=klTdyquDM9KJWMg/8wM7V1JKEvd4iAs6lu/tmhgjilg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjpcszOdnRMycnr4nVCxHNN81hJAUZOGSLAgQdX4XvPiX1EM93jfuHb1MCThGyahI1yFFgGJ/y/Fch5vic/6qDljeJQkdjxU0B+Yi3ZqvqRKGLQVEHBAZY2moLhtMXwNvTKyLXdNBRjbabDJQV+MgF7ypNJHw/iUIabtCSeAg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wy83d3Lv9z4f3m6n;
	Mon,  2 Sep 2024 20:59:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 35F6B1A0568;
	Mon,  2 Sep 2024 20:59:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.85.165.202])
	by APP4 (Coremail) with SMTP id gCh0CgD3KsfEttVmOJPAAA--.25304S9;
	Mon, 02 Sep 2024 20:59:56 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	mchehab@kernel.org,
	Jonathan.Cameron@huawei.com,
	rmfrfs@gmail.com,
	vireshk@kernel.org,
	gregkh@linuxfoundation.org,
	deller@gmx.de,
	corbet@lwn.net,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH -next 5/7] video: fbdev: mmp: switch to use spi_alloc_host()
Date: Mon,  2 Sep 2024 20:59:45 +0800
Message-ID: <20240902125947.1368-6-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
References: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3KsfEttVmOJPAAA--.25304S9
X-Coremail-Antispam: 1UD129KBjvJXoWrtw17Gw17ZFy5Xry7uFy5twb_yoW8JF1Upa
	15XFy5tr90yr4UCw1Yka1kZFy3WFs3J3y8Zw4jga45u3WfXrZ8Wr4DGayIqFWrGay0yw4U
	Jryjq348CayxuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use modern name function spi_alloc_host().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/video/fbdev/mmp/hw/mmp_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_spi.c b/drivers/video/fbdev/mmp/hw/mmp_spi.c
index cf23650d7f0b..3f253f4271ac 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
@@ -140,9 +140,9 @@ int lcd_spi_register(struct mmphw_ctrl *ctrl)
 	void **p_regbase;
 	int err;
 
-	ctlr = spi_alloc_master(ctrl->dev, sizeof(void *));
+	ctlr = spi_alloc_host(ctrl->dev, sizeof(void *));
 	if (!ctlr) {
-		dev_err(ctrl->dev, "unable to allocate SPI master\n");
+		dev_err(ctrl->dev, "unable to allocate SPI host\n");
 		return -ENOMEM;
 	}
 	p_regbase = spi_controller_get_devdata(ctlr);
@@ -156,7 +156,7 @@ int lcd_spi_register(struct mmphw_ctrl *ctrl)
 
 	err = spi_register_controller(ctlr);
 	if (err < 0) {
-		dev_err(ctrl->dev, "unable to register SPI master\n");
+		dev_err(ctrl->dev, "unable to register SPI host\n");
 		spi_controller_put(ctlr);
 		return err;
 	}
-- 
2.33.0


