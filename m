Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F8703190
	for <lists+linux-spi@lfdr.de>; Mon, 15 May 2023 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbjEOPa3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 May 2023 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjEOPa2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 May 2023 11:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0273519AA
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 08:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A576213D
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03D71C433EF;
        Mon, 15 May 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684164626;
        bh=EisaXchlIQI37uW9vgEISFyq3BU8cLyRqpMbg4D2sW0=;
        h=Subject:From:Date:To:From;
        b=lGmm3VY41N9ojlw9kzmE2Udt5T5Ojn8SeMcEb5L8potCer4TglGbQurE1JeO/dphu
         nZDGdIMJ9INr0dj2OXf5wHmAOzFH9Vw+GsPvf6nidtEqbPLwVqu1yqzy2vL92F+sN4
         GwFPtVMv/t2ltnwS6nZskZ+ufqBvzYI7H9VBo1w3KZJIijWMDUwvrvV+gf94CekqB+
         T2iN2+r7GOIiNOYjykFo0qWfB9gP/K98aoH0JyVRyA+AJz4WWV4mFNaZGPGKdK6jyR
         xSlquyS1CDxOcZgMgCVOS5KEbGlEJkgQBfdZwpS0XTkXDcXPISPo0c9FgJF0lnvBRY
         KewRt1Dh1vT6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D45E3E5421B;
        Mon, 15 May 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168416462579.6135.6245240022118119254.git-patchwork-summary@kernel.org>
Date:   Mon, 15 May 2023 15:30:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: dw: DW SPI DMA Driver updates
  Submitter: Joy Chakraborty <joychakr@google.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=747064
  Lore link: https://lore.kernel.org/r/20230512104746.1797865-1-joychakr@google.com
    Patches: [v11,1/3] spi: dw: Add DMA directional capability check
             [v11,2/3] spi: dw: Add DMA address widths capability check
             [v11,3/3] spi: dw: Round of n_bytes to power of 2


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


