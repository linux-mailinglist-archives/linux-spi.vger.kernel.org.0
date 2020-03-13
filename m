Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD1184795
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 14:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCMNNL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 09:13:11 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64044 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgCMNNK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Mar 2020 09:13:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584105190; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=IyOU3O6vZkvClFfdzNJ2tEJ6rtPVF6loCCxH7MpU/9I=; b=EEBO0k60NuS5P5epef3VK6XtbKKJ2gVdX1ETluGKRuS521eVanhi9k4nXnwhcEdZsHcgt+z4
 uH0h8pGHmBO4iieuG8vRUUCbobxPF0SokRywd1hAX0uOCOBRrzHTJ+S5okr0cKRd/rIsjZzZ
 DRu37Dipm0TwSzMWmuzeVcyqAXE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b86cd.7f69cf52f260-smtp-out-n01;
 Fri, 13 Mar 2020 13:12:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F53FC433BA; Fri, 13 Mar 2020 13:12:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EFFBC433D2;
        Fri, 13 Mar 2020 13:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EFFBC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@chromium.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V2 1/8] interconnect: Add devm_of_icc_get() as exported API for users
Date:   Fri, 13 Mar 2020 18:42:07 +0530
Message-Id: <1584105134-13583-2-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Users can use devm version of of_icc_get() to benefit from automatic
resource release.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
 drivers/interconnect/core.c  | 25 +++++++++++++++++++++++++
 include/linux/interconnect.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2c6515e..f5699ed 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -350,6 +350,31 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	return node;
 }
 
+static void devm_icc_release(struct device *dev, void *res)
+{
+	icc_put(*(struct icc_path **)res);
+}
+
+struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
+{
+	struct icc_path **ptr, *path;
+
+	ptr = devres_alloc(devm_icc_release, sizeof(**ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	path = of_icc_get(dev, name);
+	if (!IS_ERR(path)) {
+		*ptr = path;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return path;
+}
+EXPORT_SYMBOL_GPL(devm_of_icc_get);
+
 /**
  * of_icc_get() - get a path handle from a DT node based on name
  * @dev: device pointer for the consumer device
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index d70a914..7706924 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -28,6 +28,7 @@ struct device;
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
+struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 void icc_set_tag(struct icc_path *path, u32 tag);
@@ -46,6 +47,12 @@ static inline struct icc_path *of_icc_get(struct device *dev,
 	return NULL;
 }
 
+static inline struct icc_path *devm_of_icc_get(struct device *dev,
+						const char *name)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
