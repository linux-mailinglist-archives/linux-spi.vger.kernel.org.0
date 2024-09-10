Return-Path: <linux-spi+bounces-4759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A458397272A
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 04:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5801C218C9
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 02:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B43514D710;
	Tue, 10 Sep 2024 02:26:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2761FE1;
	Tue, 10 Sep 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935191; cv=none; b=jr//xJKXtnu6mqocNQoN3EJ2XUcZgz1eLGfNpn0zTTdBu5m2cUzqNWFgKqPa9wftz6jouIxOaDd+uZ9qrVETAm/b96fcPjuDrZmDSbiRUqOu1QOykRXC+s6u/j87GFNATe0pYg9nbb5WlFsgfRTY6+4XjAaT1icbQYTyrOCqphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935191; c=relaxed/simple;
	bh=LvPlV6zaDIZLwFQs+QHBBo9llDMM2gzg9rT8GQc7wQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa8vnWb5+qzrru5/17/28voaMZ+G4HAkZ3NWi/LdxVBEynKoML0LLlxgk4goWocTO2rD9PJFwevvl5o47cOyDT4xAbkcBGdnvw3+Bq4jEbI5vIjJIhVcO+to830N1GxzgtYJ79eiMRqcM5VEcw5Bgmj/2LcNVlZc+9uAUl3CYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X2nd01QKNz4f3jsG;
	Tue, 10 Sep 2024 10:26:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 848971A058E;
	Tue, 10 Sep 2024 10:26:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.0.27])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8dKrt9m1gKTAw--.13967S9;
	Tue, 10 Sep 2024 10:26:27 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	matthias.bgg@gmail.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH -next 5/7] spi: slave-mt27xx: switch to use target_abort
Date: Tue, 10 Sep 2024 10:26:15 +0800
Message-ID: <20240910022618.1397-6-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
References: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8dKrt9m1gKTAw--.13967S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrKrykWFW3CrykAryxKrg_yoW8Kr18pF
	47Wry3trWrArsavr9rJF4DuFZ0kF4fXry7Kw1rtw4fWr4YqryDGF4rtr92vF1YvayfKw1U
	ZF40k3sIgayIkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use modern name target_abort.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-slave-mt27xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 98cbc0c30e45..00d455dad135 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -69,7 +69,7 @@ struct mtk_spi_slave {
 	struct clk *spi_clk;
 	struct completion xfer_done;
 	struct spi_transfer *cur_transfer;
-	bool slave_aborted;
+	bool target_aborted;
 	const struct mtk_spi_compatible *dev_comp;
 };
 
@@ -118,7 +118,7 @@ static void mtk_spi_slave_disable_xfer(struct mtk_spi_slave *mdata)
 static int mtk_spi_slave_wait_for_completion(struct mtk_spi_slave *mdata)
 {
 	if (wait_for_completion_interruptible(&mdata->xfer_done) ||
-	    mdata->slave_aborted) {
+	    mdata->target_aborted) {
 		dev_err(mdata->dev, "interrupted\n");
 		return -EINTR;
 	}
@@ -286,7 +286,7 @@ static int mtk_spi_slave_transfer_one(struct spi_controller *ctlr,
 	struct mtk_spi_slave *mdata = spi_controller_get_devdata(ctlr);
 
 	reinit_completion(&mdata->xfer_done);
-	mdata->slave_aborted = false;
+	mdata->target_aborted = false;
 	mdata->cur_transfer = xfer;
 
 	if (xfer->len > mdata->dev_comp->max_fifo_size)
@@ -314,11 +314,11 @@ static int mtk_spi_slave_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int mtk_slave_abort(struct spi_controller *ctlr)
+static int mtk_target_abort(struct spi_controller *ctlr)
 {
 	struct mtk_spi_slave *mdata = spi_controller_get_devdata(ctlr);
 
-	mdata->slave_aborted = true;
+	mdata->target_aborted = true;
 	complete(&mdata->xfer_done);
 
 	return 0;
@@ -402,7 +402,7 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	ctlr->prepare_message = mtk_spi_slave_prepare_message;
 	ctlr->transfer_one = mtk_spi_slave_transfer_one;
 	ctlr->setup = mtk_spi_slave_setup;
-	ctlr->slave_abort = mtk_slave_abort;
+	ctlr->target_abort = mtk_target_abort;
 
 	of_id = of_match_node(mtk_spi_slave_of_match, pdev->dev.of_node);
 	if (!of_id) {
-- 
2.33.0


