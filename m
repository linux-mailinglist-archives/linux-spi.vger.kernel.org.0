Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86F6A0E98
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBWRVC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWRVC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:21:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D112B55C15
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:20:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36A2F6175F
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56514C4339E;
        Thu, 23 Feb 2023 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172843;
        bh=3bbZc6GfrmW1NmWc6Pp71spy6au5cLDlsBo8niaEj6U=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=obsQdEPhbZu9DpMZidANyOoNNqV8v3A5PKHxkGkrWU4rloLruigFdmFOUaF62dulx
         oBPpteET2pibGRmnn3MrpbaQMzK1BP2dNvdBHjLUpn53nEU3Lj0xv/2HJ7mmsozL3h
         pdoJ621VRqHOeLD51QpP+9LBf8veeDu6DvuIALUJ7jmIbcXUfdO+EyKIoDupXrSnOy
         mMhqZEb2h4Ch6MieuZU+LFir9jYITzewhaoup3Ffy8AvYVkg6QXOwttvX41Y0ThU59
         dfRPqclJAl8ABkYoXlwrCFOt1gUAjiRjxXq9eHYMX/KdVjv4yV/IUGUiPCNaGe6BQI
         6Msc7pHzfXziA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Feb 2023 17:20:22 +0000
Subject: [PATCH 2/8] spi: rockchip: Add architecture dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-spi-arch-deps-v1-2-83d1566474cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=698; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3bbZc6GfrmW1NmWc6Pp71spy6au5cLDlsBo8niaEj6U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj96BdjSDy7nYkQ9eIgl9yjuydUzOSUa273q7xwy3z
 aIVO5sKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/egXQAKCRAk1otyXVSH0M4aB/
 4ylHBmsrsi6C85FZ7H0jYiF/kFw7SeyBy5PsYh394+HB43oTaQ9aKFZIb7e+kEi9qN3kIY/3ZMo+32
 f3h9FtwTDeRs9rxqp1fUtW5A4vztSVaIkURROUhZN7xoIWd9IM6Xwavha9859zth5gv61mBbVzW5In
 Rg3lO+YZTHl2EBtaZc1AKck1joq9AvW1XbkmiA5JzD1iLWRuMXFQ7G+cd/avzYEawlQguTmbi4eXIm
 QC3hgvK/x2AMcZOJ4g3/xbdFrykbz5L5/nkYPZxh7kill7M7UiYr4Heo14IfRKfa2k3gWAXpiVx4Mc
 nOV7xpbO8VDaRXBXYRySOY/YsyMrLV
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

If base support for Rockchip SoCs has been disabled then the SPI driver
won't be terribly useful, add a dependency on ARCH_ROCKCHIP || COMPILE_TEST
to avoid it appearing when not needed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d1ee27d55a5f..f765b4ce226d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -783,6 +783,7 @@ config SPI_PXA2XX_PCI
 
 config SPI_ROCKCHIP
 	tristate "Rockchip SPI controller driver"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  This selects a driver for Rockchip SPI controller.
 

-- 
2.30.2

