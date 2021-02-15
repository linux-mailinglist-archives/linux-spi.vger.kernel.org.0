Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14E231BC3B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 16:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhBOPYG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 10:24:06 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:59642 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhBOPYA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Feb 2021 10:24:00 -0500
X-Greylist: delayed 1543 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 10:23:56 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2u28/
        RAEUFHNKG6HiuW32yeDuQc7WB7a627x1KD2BKU=; b=XwLokUvt0TMajRGlNpxGU
        HfR4JWCNyVMEY3efPI3uZyp1VMIvmxJrzMP47bc+4+U6pH+F2kltIqzDSxsE42xq
        uW8yG+yIfKr6V+ah6sWKXHrWotSRi6fSoug9wf0+KqC1Wqmy3hhCuMab4C9th1Oo
        0v+JQTdN334J1pEGWuK4Ig=
Received: from yangjunlin.ccdomain.com (unknown [119.137.55.63])
        by smtp4 (Coremail) with SMTP id HNxpCgDXSVxSVSpgL8h0Aw--.36796S2;
        Mon, 15 Feb 2021 19:04:51 +0800 (CST)
From:   angkery <angkery@163.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] spi: cadence-quadspi: add missing of_node_put
Date:   Mon, 15 Feb 2021 19:04:25 +0800
Message-Id: <20210215110425.1012-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDXSVxSVSpgL8h0Aw--.36796S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1kur15GryDZw1kCryUZFb_yoWktFb_CF
        n29F9rGFs8KF43ZF12q34UZF9Fga15urWfGFn7tFW3XryDAw17CFn5ZFyDG34jy3yj9r93
        Cr47C3Z3Cr13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU13C75UUUUU==
X-Originating-IP: [119.137.55.63]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBFBM6I1aD+ZcgKwAAsu
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

Fix OF node leaks by calling of_node_put in
for_each_available_child_of_node when the cycle returns.

Generated by: scripts/coccinelle/iterators/for_each_child.cocci

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/spi/spi-cadence-quadspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 442cc7c..14a7120 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1389,11 +1389,13 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		ret = of_property_read_u32(np, "reg", &cs);
 		if (ret) {
 			dev_err(dev, "Couldn't determine chip select.\n");
+			of_node_put(np);
 			return ret;
 		}
 
 		if (cs >= CQSPI_MAX_CHIPSELECT) {
 			dev_err(dev, "Chip select %d out of range.\n", cs);
+			of_node_put(np);
 			return -EINVAL;
 		}
 
@@ -1402,8 +1404,10 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		f_pdata->cs = cs;
 
 		ret = cqspi_of_get_flash_pdata(pdev, f_pdata, np);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
1.9.1

