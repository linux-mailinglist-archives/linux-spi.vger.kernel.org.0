Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0166A0E96
	for <lists+linux-spi@lfdr.de>; Thu, 23 Feb 2023 18:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBWRUt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Feb 2023 12:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBWRUp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Feb 2023 12:20:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7A580F0
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 09:20:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5357B61768
        for <linux-spi@vger.kernel.org>; Thu, 23 Feb 2023 17:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72488C433EF;
        Thu, 23 Feb 2023 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172838;
        bh=gUCiOzbK+aIjnXKothUbHhcc+6jqPM8lYzv50HQoTdk=;
        h=From:Subject:Date:To:From;
        b=ZJ/i2faRItipWVz+UT91ljhDFXuz1igU6lZxBEeJI3HJpPM103IbLVMazXcvsk4yg
         1uY04FfrCu/odV9bsiMKaUqITEMIJa4zwiqORuBuRwqN1XgjwRG2msa3ltOBqRf/eE
         G0/3+S+qutjJeBYC9U0eQPDmangL87NdpRJiy/1ezw+/IUh7UN+qvyHI/QyQ5yAyNf
         qjabJyQFy4LFv/Qacs9i+LdW/XtKevIWpYWt4K0nKpssnN9hV8LbnDa6JFe1KSNyAF
         c1mqPeFmQG/M/WJmFb17V0IcnNP5HbZSu/pPX1PhTigwMIFlaZVCGFetI6MP/IYFKq
         Y9gGqewZhVm4g==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/8] spi: Build coverage cleanups and improvements
Date:   Thu, 23 Feb 2023 17:20:20 +0000
Message-Id: <20230221-spi-arch-deps-v1-0-83d1566474cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFWg92MC/x2N0QrCMAwAf2Xk2cBSmTB/RXxI22iD0JUEdDD27
 3Z7vIPjNnAxFYf7sIHJV12X2oEuA6TC9S2ouTOEMVzHEAi9KbKlglmaY45MdOOZJpmhN5FdMBr
 XVI7qt9jn0M3kpeu5eTz3/Q/XLzdadgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gUCiOzbK+aIjnXKothUbHhcc+6jqPM8lYzv50HQoTdk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj96BcD2KcSgl2wyf1QMdg7t1/2hyILlcuHLC7k0FA
 A9IVbpuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/egXAAKCRAk1otyXVSH0PUoB/
 9xvprgJSfksJJe5Z20P+tKWdypt7s0TSeYcYWEnDavkLt5CKep3k/FWQRfA8r+VWme48GkLEsgV4HX
 M/+L7ZL1MMPwfkhU66gcEZOpGcayAwNsuy4uKKQuWCaLsPU/z00m6vj0ugecDQBySwc9ymSJiG//OR
 YdYNsjC71VAEcgIXSIwBceifEf2lY9c0770Gxqk/jUufSdLSLZUpKTIvKEeJNshGG4Fatry1foX65j
 55fZQ7WwFPOk8VIpE3eRa3mXvSaxORZ9jp0J3nHCSfYQqF8bdtYfWt2mOTXdGoRQ8vBc+CWqOX+n65
 T+gj4KnaX8VD1ECeHPoKjFtY9N9Gnf
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

This series opens up build coverage of a bunch of SPI drivers by
allowing build under COMPILE_TEST where possible, while also adding
appropriate architecture specific dependencies to a couple of drivers
that didn't have them so they don't show up in builds when they're not
useful.  We also have one fix for the dependencies of the s3c24xx driver
which was turned up in the process of doing this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (8):
      spi: s3c24xx: Fix dependencies when FIQ support is enabled
      spi: rockchip: Add architecture dependency
      spi: nxp-flexspi: Fix ARCH_LAYERSCAPE dependency
      spi: davinci: Make available for build test
      spi: fsi: Make available for build test
      spi: qcom-qspi: Make available for build test
      spi: s3c24xx: Only have compile time references to FIQ when building it
      spi: s3c24xx: Allow build test coverage

 drivers/spi/Kconfig       | 15 +++++++++------
 drivers/spi/spi-s3c24xx.c |  4 ++++
 2 files changed, 13 insertions(+), 6 deletions(-)
---
base-commit: 7234d746a8339066313518bfa024fa03f363a55e
change-id: 20230221-spi-arch-deps-dba116a915e9

Best regards,
-- 
Mark Brown <broonie@kernel.org>

