Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD9604E7D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Oct 2022 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJSRU2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Oct 2022 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJSRU0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Oct 2022 13:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EFC157F5F
        for <linux-spi@vger.kernel.org>; Wed, 19 Oct 2022 10:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2669261973
        for <linux-spi@vger.kernel.org>; Wed, 19 Oct 2022 17:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DFE5C433D6;
        Wed, 19 Oct 2022 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666200024;
        bh=gcCqjvtKuSWmsXVts5KLj+v9Mwlu0rVZoKYCw6NDD7c=;
        h=Subject:From:Date:To:From;
        b=U22sUyOzzA3/QiU77Ar4PiU949Az+ggjoR+mPN/5VYjOWsN8w6071HbnD9yLbMqGb
         zXNF+fUPJbCEn00D3XJ8wu+Yz9wuoiyNPlT2ryg6yKsZTv2nPvdSdJ/UKDMfBtItk6
         0v2vGWRkg4QmAFTzYlv7oa75pTM8y3Bxbx9t1lL6GerYKU1OOkMhnjUYL82DI2eMnS
         uomrqPVvkeg+WsxwRguFn9lSiLNQl/7TcMR8NV6q3GUbJ1MEDIf/hQvwGKjsjtTSqj
         lVNj0S1ZLvE38F4lvX/yjmpyGLlycMjEQ6KiDr1SgkOlEjAvdj/SmZxlmWr+CCOdGp
         53RZeFXZ8pb1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52A23E29F37;
        Wed, 19 Oct 2022 17:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166620002425.19409.1807231181311266230.git-patchwork-summary@kernel.org>
Date:   Wed, 19 Oct 2022 17:20:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
  Submitter: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=680345
  Lore link: https://lore.kernel.org/r/20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com
    Patches: [RESEND,v3,1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
             [RESEND,v3,2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
             [RESEND,v3,3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
             [RESEND,v3,4/7] firmware: xilinx: Add qspi firmware interface
             [RESEND,v3,5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
             [RESEND,v3,6/7] dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
             [RESEND,v3,7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform

Series: spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
  Submitter: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=684406
  Lore link: https://lore.kernel.org/r/20221011062040.12116-1-amit.kumar-mahapatra@amd.com
    Patches: [v4,1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
             [v4,2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
             [v4,3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
             [v4,4/7] firmware: xilinx: Add qspi firmware interface
             [v4,5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
             [v4,6/7] spi: dt-bindings: zynqmp-qspi: Add support for Xilinx Versal QSPI
             [v4,7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform


Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


