Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE795204DB
	for <lists+linux-spi@lfdr.de>; Mon,  9 May 2022 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbiEITAj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 May 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiEITAb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 May 2022 15:00:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DE54BE3
        for <linux-spi@vger.kernel.org>; Mon,  9 May 2022 11:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0D5B6118F
        for <linux-spi@vger.kernel.org>; Mon,  9 May 2022 18:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51F04C385B2;
        Mon,  9 May 2022 18:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652122594;
        bh=LQGcV40m8jzAV+NYC5z+SWJts0hXPqS4/IQIbdQ8fWc=;
        h=Subject:From:Date:To:From;
        b=iAihAypJ5FIH7dkM6ZrzsYvUXrcWruFEIz6veOFgBICXRXua4msA7gZesLl0fTX3y
         C0iUtcZDXsQkaWn6EJK4c2/WUx7m7j8wGfYdCsyclgHltLMpr/f5rFax5A7HCZOQvF
         e9AA6oUIGAQ9Rt4HLIVYsWVuvLZ6s4ymSor4Y7Xv5PigoxGIYURKEyF9pVIdybxq9w
         rOG69BcvghLt9MqH2ya+Jd0l0iXz1GFqqwDMoy49lj21NxgMqw9g0L+QlhS66yfiFc
         MO4QPJUBxqc0bC/sxpiafJ4PIlQ8Tpn7g3BHewQP6yN3JDEPwgxL9zSOKv59a2ut1t
         /2wqG79BmcQ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36B9DF03876;
        Mon,  9 May 2022 18:56:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165212259421.15038.10684250453830515366.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 09 May 2022 18:56:34 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] spi: spi-mem: Convert Aspeed SMC driver to spi-mem (2022-05-09T17:56:05)
  Superseding: [v6] spi: spi-mem: Convert Aspeed SMC driver to spi-mem (2022-05-03T06:06:23):
    [v6,01/11] ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
    [v6,02/11] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
    [v6,03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
    [v6,04/11] spi: aspeed: Add support for direct mapping
    [v6,05/11] spi: aspeed: Adjust direct mapping to device size
    [v6,06/11] spi: aspeed: Workaround AST2500 limitations
    [v6,07/11] spi: aspeed: Add support for the AST2400 SPI controller
    [v6,08/11] spi: aspeed: Calibrate read timings
    [v6,09/11] ARM: dts: aspeed: Enable Dual SPI RX transfers
    [v6,10/11] ARM: dts: aspeed-g4: Set spi-max-frequency for all flashes
    [v6,11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

