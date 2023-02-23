Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DEC6A0E9C
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBWRVQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBWRVP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:21:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF657082
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:20:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0482E61765
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A371C433A0;
        Thu, 23 Feb 2023 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172855;
        bh=/t1gEIzS6G+njPfiVhgZ/+WqI9Tp5RD9j8xJCtkfGY8=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=cFyJRrJQFV+F9bWKX4Iyd3Xv7FRxFa4rzz8U04RUSHG/p/lNPtpOcPfA1BZ0p5HRh
         ErHibNLpEzMP3N+Nln0Yb1nE+mfBwNTWyezmsTB9CkC80LzuusOmH/YB25r2/fHJir
         pUjrwt2HwAzGM0JzR5ZpNsNg/u3xJh4VA68OqlfAFy9XFLCOSDLgSiHx6CF+AnFcjt
         2/ACPVUkEnS9GDO/404r9zroTGdk9AsGS33FjyFQDh9Fn4sJNGN9z0DW8XiGzHTOCh
         u5uONdtVQ7G/cW2C/2Zzx9xail1p95sMepLUtMFNvBH8mW+tbEZOipuV/lLnmwe8vi
         dS3SCVUIMKOeA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Feb 2023 17:20:26 +0000
Subject: [PATCH 6/8] spi: qcom-qspi: Make available for build test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-spi-arch-deps-v1-6-83d1566474cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=674; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/t1gEIzS6G+njPfiVhgZ/+WqI9Tp5RD9j8xJCtkfGY8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj96BgSbujV7cSVDsgcOzPlSgj2vpFdEmqNPKoqKKi
 gQJQ5ZSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/egYAAKCRAk1otyXVSH0Ho/B/
 9mKDC7cEpPoUWVjcoPkiC5U9NeSH578xtp9oV7ZCboWApiXaej9omb8jpFVVKNp4V/iB5nyTSN0/Em
 g7fQF+1H1O4aLnUTb28pZW/NMxiDi4GVXqFU3S1xq+YAJ6qjLuDJnex2zD0hglkkAkaO2s6FlxRYwE
 BvnWH9ScWqCFudWiHpHvqafUwgaJF3vvAJFUx8/84Cn57HNe3OYXF7wlO/XZZaK/CO/V7jdjSmvsMY
 4SKUPHnDiM7IAsl1oqpgBZjJxkYe0/4A3WRpEdjnEtfO3LMxJfwIWt5XAO29ecy/hrEWLeNKIT/foB
 qaxZWxQJ8nTMgCl/V7Pfv1Bpcwyu8d
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no build time dependency on the Qualcomm platform support so add
an || COMPILE_TEST so we've got better build coverage of the driver.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 753d006f8217..c7ae712ff954 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -826,7 +826,7 @@ config SPI_RSPI
 
 config SPI_QCOM_QSPI
 	tristate "QTI QSPI controller"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
 

-- 
2.30.2

