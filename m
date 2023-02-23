Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097056A0E9A
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBWRVK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBWRVJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:21:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74EB55C2A
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:20:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 200566170B
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41257C433A0;
        Thu, 23 Feb 2023 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172849;
        bh=ziAuI48GFaqv/DZiLVrk2Vz0Yhhm5PgD8SQLslzjrIA=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=TWiX8cf2Pqdl0SXqNwQRH/C1IbpWcvK/CVtzr1hebkxzAHfvpdhXVA8BffuHiagyD
         Y0WUTfrEsI+0T7f8hBGwmV8SRhPRDDj5f5m6SoNeAv31dw6G+GhPosEiM3b9EZ7Hg7
         DtvYpMFh1IaKZCHxX2P54pElQonJEhUKL4bGFHrFCjBfMMdPiyRaAILux3FRUw9rhs
         mNKWrB/oxCzxQAASe7zho6IeQebn5hsEngWu6GbbzTYop0vCFJAuLCqizlYwGs9bHM
         KRg1cQxEhtr6H+jSfdsbtk+jisaVoM1cIDZ9dpgV6i64eOXfnmKifcSnqn2htnHOdD
         WColAUrQkbqHQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Feb 2023 17:20:24 +0000
Subject: [PATCH 4/8] spi: davinci: Make available for build test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-spi-arch-deps-v1-4-83d1566474cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ziAuI48GFaqv/DZiLVrk2Vz0Yhhm5PgD8SQLslzjrIA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj96BfRLwnMXEVx/RWiFxOI94ELwGeqbO7/+a9psP8
 F44Y+pOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/egXwAKCRAk1otyXVSH0CXMB/
 wNgUCD2o/IQwuFZKx3RQSx1jXT4rDHWnA9k0ya4yWLn75PwYEAes6iMnE+HfIJeCWJjbNboMWSYcmJ
 gbwEekAeC+ztVK1b3kNibbYj7CXCcbTlUpmvyfoDZV/NTPf2i4Kpp0WQ6F1fC3YIRZRn8zKSydYUGJ
 3TiJpH63fF6HoFE8xDFg7nncYA5kqdYgsglRb7B949q6C/YHr3ISrZHDCr480gG9FC0RXErV6nuiZh
 mEaPSk7SJc3g+ur6ajuxYskXJtDfhdULJRSyNARRRdcRWRgGhtwLNbVPdqCcOjHWt04CXDf5mDX0gA
 Sgmij7Czx2zzUaglDVU1UsmPPNxvW/
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

There is no build time dependency on the DaVicni or Keystone architecture
support so add an || COMPILE_TEST so we've got better build coverage of the
driver.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 714c9089272a..00c6c41d2df7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -276,7 +276,7 @@ config SPI_COLDFIRE_QSPI
 
 config SPI_DAVINCI
 	tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI controller"
-	depends on ARCH_DAVINCI || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  SPI master controller for DaVinci/DA8x/OMAP-L/AM1x SPI modules.

-- 
2.30.2

