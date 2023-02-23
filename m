Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D936A0E9D
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBWRVR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBWRVQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:21:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954CB570A4
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1FF6176A
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3E3C4339E;
        Thu, 23 Feb 2023 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172858;
        bh=Y2GyiOCT/zyy58alkE7pqvNhZY84ln34N+1Q9gY+dVQ=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=UdsxFu3JfhOz0MAwzcAgcK+d9x1teN2qfd+1/pxIn88plyUCsjWJ61G/XMOW+EpAX
         4LJSiOyp+5Y/JevJBM1mtarW3HOnKFwh8vMPBTipKTBi0PM9LWYu39JcpJzv2J27CJ
         RJq95fUxUijWCnYMiioO4U7oivwI1sxLvwFcPisQwBflWeXSp1I0ZIUJFMOEtr5nip
         hzpKwmU8m8ytT4rsFzDAPk8bseK2hEmMTWQNjx8jj6c+aez51csTENKZcnSJLSKSd1
         TmSHShuRWojBZPQlzY1lXEaJoeGNnmiGZPHL7L3uLL3bt+LF3zG4Z/ghElgZy4pqIj
         fTw0vJk8XQMBA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Feb 2023 17:20:27 +0000
Subject: [PATCH 7/8] spi: s3c24xx: Only have compile time references to FIQ
 when building it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-spi-arch-deps-v1-7-83d1566474cf@kernel.org>
References: <20230221-spi-arch-deps-v1-0-83d1566474cf@kernel.org>
In-Reply-To: <20230221-spi-arch-deps-v1-0-83d1566474cf@kernel.org>
To:     linux-spi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Eddie James <eajames@linux.ibm.com>, Han Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Y2GyiOCT/zyy58alkE7pqvNhZY84ln34N+1Q9gY+dVQ=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhuTvCxJDlmssM9wVfrI4t/2duqPqJM7jEZFpq+dG7C2ydPtm
 mKvRyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBM5FI2+z/ttYWneE7k/2f8NI3pys
 ycXeZ/fvu/9vDeIZP3QumoUZ247CK3+drZGo1hGfsSo1LSJ+asjYtz/VjZkyTUm/xO3zdhXVHKEWv7
 vQraaUujl8+UvLbQbtOO+xyLvfK+GGmv4S0u+Ghl7GAqU5JtqykeXiZ6u6tkU88P9jJNZnv5P3d/eV
 bcYq/ub9/Qlfl1QzOXVHTS+TD2TYx7d/rbywuKKZZYOW06kxmkN0n4QIjFlGfe+cxbf+daMHn8vZqi
 0VKUa9l95/4Tzi9fvuw6f1VaeXaat+jCf7EZesUWjXyGV8RY+9/f+CNpZWP+4fTxVfJ8y4NStyqIH5
 y5ZOYD2zV9Hx+4sn1ImWHXsSIRAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is a config option which allows the FIQ code in the s3c24xx driver
to be disabled but it does not cover the inclusion of the API header or the
variables added to the driver data. Add some ifdefs protecting these so
that we can improve build coverage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c24xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index ef25b5e93900..ad13c6004d40 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -21,7 +21,9 @@
 #include <linux/spi/s3c24xx-fiq.h>
 #include <linux/module.h>
 
+#ifdef CONFIG_SPI_S3C24XX_FIQ
 #include <asm/fiq.h>
+#endif
 
 #include "spi-s3c24xx-regs.h"
 
@@ -56,10 +58,12 @@ struct s3c24xx_spi {
 	int			 len;
 	int			 count;
 
+#ifdef CONFIG_SPI_S3C24XX_FIQ
 	struct fiq_handler	 fiq_handler;
 	enum spi_fiq_mode	 fiq_mode;
 	unsigned char		 fiq_inuse;
 	unsigned char		 fiq_claimed;
+#endif
 
 	/* data buffers */
 	const unsigned char	*tx;

-- 
2.30.2

