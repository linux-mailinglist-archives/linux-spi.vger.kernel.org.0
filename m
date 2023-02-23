Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727666A0E99
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBWRVJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBWRVI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:21:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2C52DE0
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:20:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D834B8198C
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508A8C433EF;
        Thu, 23 Feb 2023 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172846;
        bh=wcvqKNkspYwlagqVvOHfXZLMH0ae03tonNORwXGCGz4=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=HrKL0xTEbb6Doob/0BQQ1PRMU615k/3ZUn+lbxfxnS3f2TxrkQUQl+Mrwi3wsJmMI
         7gnRmj4HguJVkjvwf7e2ULiWLs1G7TgmPrkRccVYDekLTO69/lZbntV/Ibs0Z5YGLI
         GQBolpUvg9S55veL45RJxTz0IYdyFbpyTv+8fQ/yrTw2krpWXLi52DqF0Z0wfTFqOI
         QNja981oI3rvmPCn43efg+KxIOfEM4p7cMHWMCYnydfKHeLNuLWg+x+TGrAWaNHmGU
         LYhJXglNNlwf1jzWyd9tADeoQfS686icSt/vIl+dNNwWB7NCekE2I++JftNJf0Tix/
         w5ABizTyduvQQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Feb 2023 17:20:23 +0000
Subject: [PATCH 3/8] spi: nxp-flexspi: Fix ARCH_LAYERSCAPE dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-spi-arch-deps-v1-3-83d1566474cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wcvqKNkspYwlagqVvOHfXZLMH0ae03tonNORwXGCGz4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj96BezfsmQpbUbZNKujj70AoM4kYPipuDDj3FO96H
 pBM1hvmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/egXgAKCRAk1otyXVSH0K88B/
 90piFFLbFr7KbAACARx4qDnhv7OMapUbVvctOsYYLPV7zBx/yGNemkJAoYoGMWDKvzKiaGIP69lBMs
 yCjB9/Uzvm1viEOTom/gTUzrvbUUwW/ZH0uWP1El1KVVKbmOT+TvvCbYx+Q5DHPIPUXbiktdK6rNdL
 /nDch/gAM+R8eqK+Gh2D45zFpgdL0DXMSLk8Jd4KedeAl9YZgsIiQ7B1hZS4x2LIUkIV29wSAE0nWB
 nk14KQ6dt2sNna+KTpDxWEAZ4Y6EBt2vlo43QDfKz4LLPta5YbjEKGFa5qdxf6rbLbWN8QafIWj9zz
 HpgTdJxBoDqD8PddCI5fMDxk7Etcj/
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

Currently the NXP Flex SPI driver has a dependency on ARCH_LAYERSCAPE ||
HAS_IOMEM which means that the dependency is almost always true and the
driver available. Really these should be two separate dependencies, with
an || COMPILE_TEST dependency for the architecture to ensure build coverage
is maintained.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f765b4ce226d..714c9089272a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -406,7 +406,8 @@ config SPI_HISI_SFC_V3XX
 
 config SPI_NXP_FLEXSPI
 	tristate "NXP Flex SPI controller"
-	depends on ARCH_LAYERSCAPE || HAS_IOMEM
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the Flex SPI controller in master mode.
 	  Up to four slave devices can be connected on two buses with two

-- 
2.30.2

