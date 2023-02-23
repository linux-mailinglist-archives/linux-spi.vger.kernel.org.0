Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD06A0E97
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBWRVA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWRU7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:20:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A905940F
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:20:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E00EB81AB0
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68334C433A1;
        Thu, 23 Feb 2023 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172840;
        bh=KpZrMcf7ixkUooTm4ZJyR62JzSP4YNfIBSe808okMR4=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=T6zlzhxNMqcQ6OpbwnkyG1unzp5im9uVORZz7fzloFWK6s3E6+PXfpEcVmi/ubUkP
         rUFv32yeCJnFt0kyFUDWMraP0UycnnkdUo9KL8y1u6atmrOuK4Wg1JOg38+fa/bzZk
         ZPqL45NIbpGWn5hVLYSVqnTkbCmvlcVvYfc14Z4Jz4p7DliQ9KjGJgIin8s+P1mbJO
         eR9fPz42QcAEj7JoA00stVazCbBLr9S5Kb3fVE4iE7/ExZIkERypEdTc458PAsB/6R
         Q9eK7FkA9NfRSQyJRLCAlMj63bh+qUclvKKSRFW9zCDVgyqFiKDji1n8Q/6EigPq9l
         VcEwQQivExFgg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Feb 2023 17:20:21 +0000
Subject: [PATCH 1/8] spi: s3c24xx: Fix dependencies when FIQ support is
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-spi-arch-deps-v1-1-83d1566474cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KpZrMcf7ixkUooTm4ZJyR62JzSP4YNfIBSe808okMR4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj96BcKttCoHtav+/JByjKeMwfRBh5mKLLMWAxRiSO
 DWadwzqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/egXAAKCRAk1otyXVSH0JAfB/
 4pIPpUC1cU073QEzoVrJR7jn8nvBe/TzQn5WGvZ2tvT+unjpeZO8I6VZGUdOEmvI05pJHSTJPBRWn/
 LpW2PAJ8FJD9KZIodG0H6qOCBsmpAx5uSJKQAVJh9mFd4tg4UpZpi/VusHsmB7o2rouAbHdgtB82GO
 FJo02j0cwZM7C5CpofG7bimsthfQ+jKRxhELb+vMfoJYPBLmkalPsqadpxnuPvseigX3EWTU4Psd8y
 6p8xYo8PCYa+VkSbwovxYmc2nRk/0dunx3kF95qWbb0acNheemEbWqcQtp23KxYuscRfpq/FTrIwkE
 HDGzcPKwPGN/X8tKhb170UuJZS8mqA
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

The FIQ APIs aren't exported symbols so can't be used from modules, meaning
that the s3c24xx driver can only have FIQ support enabled when it's built
in.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6fb17efb35f0..d1ee27d55a5f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -862,7 +862,7 @@ config SPI_S3C24XX
 
 config SPI_S3C24XX_FIQ
 	bool "S3C24XX driver with FIQ pseudo-DMA"
-	depends on SPI_S3C24XX
+	depends on SPI_S3C24XX=y
 	select FIQ
 	help
 	  Enable FIQ support for the S3C24XX SPI driver to provide pseudo

-- 
2.30.2

