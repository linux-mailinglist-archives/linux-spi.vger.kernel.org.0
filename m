Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62153B71D8
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 14:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhF2MO5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 08:14:57 -0400
Received: from first.geanix.com ([116.203.34.67]:56690 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233112AbhF2MO4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Jun 2021 08:14:56 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id C400A4C46B7;
        Tue, 29 Jun 2021 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624968747; bh=y+jgh+N4MBiEfP7vPaagjhhfUXAC/hQHZjg9vYF+QjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y9UaZnJhonCeoVzCkjAbZHA2cXFll1V9MOoe8AcJJ2veHS5wCh8VvfVN4TugWIiDE
         +7zg3cBvZpmlNTXHLnVUM10HTDk921d5FV1zgR+L3PByIcE2ekWU8WxCENDPobSHjF
         P1UlO+Dzi2C4pkeVfjLW5SCBZecJhwCTBUKYCkONH/J7tzvPGy7C8UYr73vQQeti2a
         yUpuoltxhABhFpdWFX6KReLt3VF/6Wz6D5YzjFGpbAGVJBiVp0rGJf66q5k4FbNS/q
         blh9CBJ1BseTIFp2kpxGUz+Cy/Il723Clt0OfsY5nr4UPimlHY9ZeU2lCW6kW/fw7N
         x8lPq0bLrm2Nw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 1/4] fpga: dfl: expose feature revision from struct dfl_device
Date:   Tue, 29 Jun 2021 14:12:11 +0200
Message-Id: <20210629121214.988036-2-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210629121214.988036-1-martin@geanix.com>
References: <20210629121214.988036-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Hundebøll <mhu@silicom.dk>

DFL device drivers have a common need for checking feature revision
information from the DFL header, as well as other common DFL information
like the already exposed feature id and type.

This patch exposes the feature revision information directly via the DFL
device data structure.

Since the DFL core code has already read the DFL header, this this patch
saves additional mmio reads from DFL device drivers too.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---

Changes since v2:
 * Reworded commit message as per Hao's suggestion

Changes since v1:
 * This patch replaces the previous patch 2 and exposes the feature
   revision through struct dfl_device instead of a helper reading from
   io-mem

 drivers/fpga/dfl.c  | 27 +++++++++++++++++----------
 drivers/fpga/dfl.h  |  1 +
 include/linux/dfl.h |  1 +
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 511b20ff35a3..9381c579d1cd 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -381,6 +381,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
 
 	ddev->type = feature_dev_id_type(pdev);
 	ddev->feature_id = feature->id;
+	ddev->revision = feature->revision;
 	ddev->cdev = pdata->dfl_cdev;
 
 	/* add mmio resource */
@@ -717,6 +718,7 @@ struct build_feature_devs_info {
  */
 struct dfl_feature_info {
 	u16 fid;
+	u8 rev;
 	struct resource mmio_res;
 	void __iomem *ioaddr;
 	struct list_head node;
@@ -796,6 +798,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 		/* save resource information for each feature */
 		feature->dev = fdev;
 		feature->id = finfo->fid;
+		feature->revision = finfo->rev;
 
 		/*
 		 * the FIU header feature has some fundamental functions (sriov
@@ -910,19 +913,17 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 	devm_kfree(binfo->dev, binfo);
 }
 
-static inline u32 feature_size(void __iomem *start)
+static inline u32 feature_size(u64 value)
 {
-	u64 v = readq(start + DFH);
-	u32 ofst = FIELD_GET(DFH_NEXT_HDR_OFST, v);
+	u32 ofst = FIELD_GET(DFH_NEXT_HDR_OFST, value);
 	/* workaround for private features with invalid size, use 4K instead */
 	return ofst ? ofst : 4096;
 }
 
-static u16 feature_id(void __iomem *start)
+static u16 feature_id(u64 value)
 {
-	u64 v = readq(start + DFH);
-	u16 id = FIELD_GET(DFH_ID, v);
-	u8 type = FIELD_GET(DFH_TYPE, v);
+	u16 id = FIELD_GET(DFH_ID, value);
+	u8 type = FIELD_GET(DFH_TYPE, value);
 
 	if (type == DFH_TYPE_FIU)
 		return FEATURE_ID_FIU_HEADER;
@@ -1021,10 +1022,15 @@ create_feature_instance(struct build_feature_devs_info *binfo,
 	unsigned int irq_base, nr_irqs;
 	struct dfl_feature_info *finfo;
 	int ret;
+	u8 rev;
+	u64 v;
+
+	v = readq(binfo->ioaddr + ofst);
+	rev = FIELD_GET(DFH_REVISION, v);
 
 	/* read feature size and id if inputs are invalid */
-	size = size ? size : feature_size(binfo->ioaddr + ofst);
-	fid = fid ? fid : feature_id(binfo->ioaddr + ofst);
+	size = size ? size : feature_size(v);
+	fid = fid ? fid : feature_id(v);
 
 	if (binfo->len - ofst < size)
 		return -EINVAL;
@@ -1038,6 +1044,7 @@ create_feature_instance(struct build_feature_devs_info *binfo,
 		return -ENOMEM;
 
 	finfo->fid = fid;
+	finfo->rev = rev;
 	finfo->mmio_res.start = binfo->start + ofst;
 	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
 	finfo->mmio_res.flags = IORESOURCE_MEM;
@@ -1166,7 +1173,7 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
 {
 	if (!is_feature_dev_detected(binfo)) {
 		dev_err(binfo->dev, "the private feature 0x%x does not belong to any AFU.\n",
-			feature_id(binfo->ioaddr + ofst));
+			feature_id(readq(binfo->ioaddr + ofst)));
 		return -EINVAL;
 	}
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2b82c96ba56c..422157cfd742 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -243,6 +243,7 @@ struct dfl_feature_irq_ctx {
 struct dfl_feature {
 	struct platform_device *dev;
 	u16 id;
+	u8 revision;
 	int resource_index;
 	void __iomem *ioaddr;
 	struct dfl_feature_irq_ctx *irq_ctx;
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 6cc10982351a..431636a0dc78 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -38,6 +38,7 @@ struct dfl_device {
 	int id;
 	u16 type;
 	u16 feature_id;
+	u8 revision;
 	struct resource mmio_res;
 	int *irqs;
 	unsigned int num_irqs;
-- 
2.31.0

