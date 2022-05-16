Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E29528D42
	for <lists+linux-spi@lfdr.de>; Mon, 16 May 2022 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiEPSkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 May 2022 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbiEPSkR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 May 2022 14:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631033E5DF
        for <linux-spi@vger.kernel.org>; Mon, 16 May 2022 11:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C480B815AC
        for <linux-spi@vger.kernel.org>; Mon, 16 May 2022 18:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3B71C385AA;
        Mon, 16 May 2022 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652726413;
        bh=y2GqindnCRb0h1irXlPlmXKX8898igQuc8woJgkDCIc=;
        h=Subject:From:Date:To:From;
        b=IpSGKTkNNtG5qONTR6cDXpMNUXvHYaLaORFLLrfM1Q7MZqtKS5CfbLWGs61CtgBJV
         gORb0aMM7LaleDkoSn9G0YgSsc0LjoBO/hGevK/4WZk1nnPscUwHlmzspxgQfcWwOy
         OWp1YAidN/GuTupa9B2LKDTEBYp/wecGjfYnjsbz+qWKFwyrVRUrbAl6hbZyS4FSm/
         cqH5KiTZeeJBRSP3RVY39imCnBuycO5kzQh51l+8uo5/iVQAkka7SxoFRCAUdX6MFK
         bBW5YWEfzng2qq4W2skAt+sM192VukT8RV762Ueb+7ZUoIdDQQOq8Lg5KxRkly51XK
         wxw0JmR5kQ30g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB41EE8DBBF;
        Mon, 16 May 2022 18:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165272641364.16991.6767036569998046417.git-patchwork-summary@kernel.org>
Date:   Mon, 16 May 2022 18:40:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-mem: Convert Aspeed SMC driver to spi-mem
  Submitter: Cédric Le Goater <clg@kaod.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=639867
  Lore link: https://lore.kernel.org/r/20220509175616.1089346-1-clg@kaod.org
    Patches: [v7,01/11] ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
             [v7,03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
             [v7,04/11] spi: aspeed: Add support for direct mapping
             [v7,05/11] spi: aspeed: Adjust direct mapping to device size
             [v7,06/11] spi: aspeed: Workaround AST2500 limitations
             [v7,07/11] spi: aspeed: Add support for the AST2400 SPI controller
             [v7,08/11] spi: aspeed: Calibrate read timings
             [v7,11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600

Series: spi: spi-mem: Add driver for Aspeed SMC controllers
  Submitter: Cédric Le Goater <clg@kaod.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=620287
  Lore link: https://lore.kernel.org/r/20220304083643.1079142-1-clg@kaod.org
    Patches: [v3,01/11] mtd: spi-nor: aspeed: Rename Kconfig option
             [v3,06/11] spi: aspeed: Adjust direct mapping to device size
             [v3,07/11] spi: aspeed: Workaround AST2500 limitations


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


