Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CFD54034A
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jun 2022 18:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbiFGQCz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jun 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbiFGQCs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 12:02:48 -0400
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 09:02:47 PDT
Received: from smtp.ruc.edu.cn (m177126.mail.qiye.163.com [123.58.177.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E5224BF8
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 09:02:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp.ruc.edu.cn (Hmail) with ESMTPSA id 9F862800A3;
        Tue,  7 Jun 2022 23:52:38 +0800 (CST)
From:   Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] spi: fix use after free in of_spi_notify
Date:   Tue,  7 Jun 2022 23:52:33 +0800
Message-Id: <20220607155233.27235-1-xiaohuizhang@ruc.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJLThlWSUxJShlPT09CTU
        5JVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6Nhw5FT00FxccMzcTDTwN
        MVEwCQFVSlVKTU5PTUpMSk5CT05PVTMWGhIXVQMSGhQTDhIBExoVHDsJDhhVHh8OVRgVRVlXWRIL
        WUFZSUtJVUpKSVVKSkhVSUpJWVdZCAFZQUpOT0I3Bg++
X-HM-Tid: 0a813ede34902c20kusn9f862800a3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We can't use "ctlr->dev" after it has been freed.

Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b9e2c7e7c580..dadfcdc6c38f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4198,14 +4198,15 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		}
 
 		spi = of_register_spi_device(ctlr, rd->dn);
-		put_device(&ctlr->dev);
 
 		if (IS_ERR(spi)) {
 			pr_err("%s: failed to create for '%pOF'\n",
 					__func__, rd->dn);
+			put_device(&ctlr->dev);
 			of_node_clear_flag(rd->dn, OF_POPULATED);
 			return notifier_from_errno(PTR_ERR(spi));
 		}
+		put_device(&ctlr->dev);
 		break;
 
 	case OF_RECONFIG_CHANGE_REMOVE:
-- 
2.17.1

