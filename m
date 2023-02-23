Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2756A0E9F
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBWRVS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBWRVR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:21:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2F157D2E
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:21:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1E0AB81AAC
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12815C433A0;
        Thu, 23 Feb 2023 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172861;
        bh=pZHYiOKAlU3jp3ytGsA+zpepU7C4RLJZP++3Rf3sokY=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=X1tZhzWpY8w6Ndc953PQ/7JjnfII9iPfvMMaHOhT/CBix9OxjDVzgJWmzklsVS2SK
         q22YxQkeFnXvvHKXh58b50cmLHqm+AUE9pMGhlARTperUBEGLQan7Kog33vnLksy2o
         h5sJs9YNzGlPqLSVFiMNMsuq0lJUKZ7lQAexxtPUJb7Xokb8hMvEkiPQORVrC7G8Ez
         ALY8GQQq/EfQq4XZnJxFYVO/gPlI+xracaMg5OJCGTXDXkpSY4JolclVop0It5Lhgk
         1kC87Ij+70Q1AcqzAwE+tVow8SJgODST9gcUalDRvqwl8O9FVeTwX2Z4O1NBgUYlri
         MpwJcvOc+GKPQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Feb 2023 17:20:28 +0000
Subject: [PATCH 8/8] spi: s3c24xx: Allow build test coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-spi-arch-deps-v1-8-83d1566474cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pZHYiOKAlU3jp3ytGsA+zpepU7C4RLJZP++3Rf3sokY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj96BizagrvgMSr7j/zysHJ8MCQPb+naPBopUPn4t0
 YAaOpTSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/egYgAKCRAk1otyXVSH0MvhB/
 9H09RVEGx2fcsRpePoh6UVhGw1LpdjIuB2GOiR9K6VR0i8rLv5o0IqH5qgo90X29Bg38JgJXL1K0jQ
 9mo8TlhAs1Qp+FlloeiiDHTQO5XHflqTyiUdcuTmgPVZ0Hp5XVcdPIRcLJlaHIXESM5e+L7m3UAyhB
 H1Ca0yfQePVWUCq1RkB56neg3XSvzND0lOEc433EzwcJkhVZW4CvdgPZoemtUi/gbVUdbkkCk+CK5Y
 v90aGQIiZeOcx1HIJrZvqKPQ7kcVwfVKFvZnl1T/UJSLtRk1u+8fWo0iMHlsxPCMYOzkNgQTLwKyhQ
 FZFtAEZaAvLgdycs8HP0hb1z6empnf
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

Other than the FIQ code the driver has no platform dependencies so we can
include it in compile test coverage, the FIQ code will only build on arm.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c7ae712ff954..8e910cb2d21c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -857,7 +857,7 @@ config SPI_QCOM_GENI
 
 config SPI_S3C24XX
 	tristate "Samsung S3C24XX series SPI"
-	depends on ARCH_S3C24XX
+	depends on ARCH_S3C24XX || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  SPI driver for Samsung S3C24XX series ARM SoCs
@@ -865,6 +865,7 @@ config SPI_S3C24XX
 config SPI_S3C24XX_FIQ
 	bool "S3C24XX driver with FIQ pseudo-DMA"
 	depends on SPI_S3C24XX=y
+	depends on ARM
 	select FIQ
 	help
 	  Enable FIQ support for the S3C24XX SPI driver to provide pseudo

-- 
2.30.2

