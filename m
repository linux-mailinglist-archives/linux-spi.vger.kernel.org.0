Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494647BBACE
	for <lists+linux-spi@lfdr.de>; Fri,  6 Oct 2023 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjJFOu3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Oct 2023 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjJFOu2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Oct 2023 10:50:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E14A6
        for <linux-spi@vger.kernel.org>; Fri,  6 Oct 2023 07:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A57AC433C8;
        Fri,  6 Oct 2023 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696603826;
        bh=qzzNHmLNyRs+tgIm2ZWv+Iy6SPEHAETVhBDxZkLm4BE=;
        h=Subject:From:Date:To:From;
        b=QzpNXTLl7sqfAKBt4DrXmEDPCq10P69Dhf+BWxtgShRfu7/BGidhmRpbrvwtocHsr
         xUMs4OIA9xQmAI5Zgj03UYddBuD2N+EhDjorPg6w4d16YRgm9D6spEKClgSVAeo8kp
         Q0DqsYi3Q5yYrHWqjKxLMEFMwNTrla8n1h4cYlfcUi/M4fEMPzf7RsvCA6jxxUUc4M
         1MO0Q3dBOkYvtbaR8ChwVW6bLVgsOWJWJSGwbsWlB09M8CgizCVG3AxF9xKwEYwVmI
         SD+8D6zIv6ePhvNVJ90mUI2H2sJtUlfljv3fvSDCi2jBSyTrI/JiqRgqIU10eifwPk
         pIH2vRN+3OQSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 582A4E632D2;
        Fri,  6 Oct 2023 14:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169660382627.23174.11763953068373634735.git-patchwork-summary@kernel.org>
Date:   Fri, 06 Oct 2023 14:50:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mpc52xx-psc: Make mpc52xx_psc_spi_transfer_one_message() static
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=790584
  Lore link: https://lore.kernel.org/r/20231006112945.1491265-1-geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


