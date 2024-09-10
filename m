Return-Path: <linux-spi+bounces-4757-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC7972725
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 04:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0AB1F24A7F
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 02:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19517149DFD;
	Tue, 10 Sep 2024 02:26:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB661FE1;
	Tue, 10 Sep 2024 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935190; cv=none; b=Bm4c0Ep+i4deT8jAJsgKoeRd2Gn7q1L8lI0QJIFKgan5bG5bIq1MWI/UplrO3wrR+YR2JE4cbnzgUveDVYzUyNWlKC6Fb49rBljFNe9oz0spPooqYaiDsdV12e3mH33Ejr5rErLB9EwH/6NqG+WeBF+gQFbb8LxQCXYuRsfqfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935190; c=relaxed/simple;
	bh=e1RaqJ6OHjhJr44fQc1svj2UgSK4SS3mdHscWAQBFEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3hbdBjxvxs4zjWhUf65faYV+GefT4T64tF7pLaCp/41Tavpg8y5JHHYYANaAhzqIWaDbrwpecQx+u/G/RZYXlJXlUBfixCaGzZyXg0kSf590FJmBUqHjPAlokp1jC8njPLQRjD4znVgSUC8o+2WsOEcfTLJXlDatKsxDnTcYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X2ncw1tN8z4f3jdT;
	Tue, 10 Sep 2024 10:26:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 964EC1A0568;
	Tue, 10 Sep 2024 10:26:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.0.27])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8dKrt9m1gKTAw--.13967S5;
	Tue, 10 Sep 2024 10:26:23 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	matthias.bgg@gmail.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH -next 1/7] spi: switch to use spi_controller_is_target()
Date: Tue, 10 Sep 2024 10:26:11 +0800
Message-ID: <20240910022618.1397-2-yangyingliang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDH+8dKrt9m1gKTAw--.13967S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1kury7CFWDGrWkXryrJFb_yoW8Aw4fpa
	17Gr47Jr1rAF4YyF15ta18WF1aqFZ2yrW7Gws7K34fJw1Sq3s8Wr18ur1rJFyrXFZ2yF42
	9ay0y3WIqa1UCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb8n5UUUUU=
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use modern name function spi_controller_is_target().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2000bce240a6..03032bb7397c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1440,7 +1440,7 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 	u32 speed_hz = xfer->speed_hz;
 	unsigned long long ms;
 
-	if (spi_controller_is_slave(ctlr)) {
+	if (spi_controller_is_target(ctlr)) {
 		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
 			dev_dbg(&msg->spi->dev, "SPI transfer interrupted\n");
 			return -EINTR;
@@ -2425,7 +2425,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
-	if (spi_controller_is_slave(ctlr)) {
+	if (spi_controller_is_target(ctlr)) {
 		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
 				nc);
@@ -3321,7 +3321,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 */
 	dev_set_name(&ctlr->dev, "spi%u", ctlr->bus_num);
 
-	if (!spi_controller_is_slave(ctlr) && ctlr->use_gpio_descriptors) {
+	if (!spi_controller_is_target(ctlr) && ctlr->use_gpio_descriptors) {
 		status = spi_get_gpio_descs(ctlr);
 		if (status)
 			goto free_bus_id;
@@ -3349,7 +3349,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status < 0)
 		goto free_bus_id;
 	dev_dbg(dev, "registered %s %s\n",
-			spi_controller_is_slave(ctlr) ? "slave" : "master",
+			spi_controller_is_target(ctlr) ? "target" : "host",
 			dev_name(&ctlr->dev));
 
 	/*
-- 
2.33.0


