Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE76A0E9B
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBWRVK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBWRVJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:21:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B669A5652A
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1893161764
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AA7C4339E;
        Thu, 23 Feb 2023 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172852;
        bh=2Tzp+QAdnR/5so6m6ZGB37VwP0fckV01TwbH6+eDm2M=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=hRVdpQT/6ztXRk0OdGz3nkkjrgCXp7YzdPKPERLsOByyUn7ENvfeYsMaMX76aEmxk
         qnkc4Tiz4HdsH4r/zFBc84DnNtZQ5sL7r1n7qFflQzn/nuJw+EeyJPT9Hfn0SSR5D7
         qTOvH2muc/PrByG0TK0D1ISWLL0DCIznWnRI5HvJghEiojq02RH1ozwE7hOgeXZJt2
         NWVmLZFdUouhtEloiLTqRAAfdAFzpelIhHHKbp+LqH8lZN7Yn15R8gEH3/AJxWuyGq
         jTjx0c938LnzGfXh6pe0xs4raQsuZRU/dV/INQKGv7ZV2fXy9DoMQExiLaCd+b4GIy
         QZV8Eft06dXUQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Feb 2023 17:20:25 +0000
Subject: [PATCH 5/8] spi: fsi: Make available for build test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-spi-arch-deps-v1-5-83d1566474cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=668; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2Tzp+QAdnR/5so6m6ZGB37VwP0fckV01TwbH6+eDm2M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj96BgnxM8Vz0D4q2Y9dgG5HnPYuzLrjzUJwy4mw0F
 +/SVBmeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/egYAAKCRAk1otyXVSH0NjWB/
 0ee1fzrbr+lqCZgTUhx27Y+1y6arxVFsVSqWqPPi8ECubT3FRUCIBZuYOGNS33XD3RF9uG4O43+7t5
 FK6e7M/bUF0f8ztpx5t+qy9sHNgLz0+Q3VsWUgPw6oqE/KgSvC3x+sX4v0tZDse6If22U7qbDizTlE
 gtj9+DUpYDU9/s6FCEE254L0HJCnKkts9Wf1iP7VA5qJGEz2Bed/dyeHJTGfzrtGDt6N1ieIZ6FTOt
 RR8Ux1U1q6tmyUL6YCM0XlV+XXamLa6V4mZE05Vxmh8sfK88BqJNcrGNpVUlKY4+1/xev63MPhrjKp
 rrw2GqqAf3ev87f6rW4SGfLYXUL8DF
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

There is no build time dependency on the platform support so add an
|| COMPILE_TEST so we've got better build coverage of the driver.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 00c6c41d2df7..753d006f8217 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -357,7 +357,7 @@ config SPI_FALCON
 
 config SPI_FSI
 	tristate "FSI SPI driver"
-	depends on FSI
+	depends on FSI || COMPILE_TEST
 	help
 	  This enables support for the driver for FSI bus attached SPI
 	  controllers.

-- 
2.30.2

