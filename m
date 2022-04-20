Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5550925C
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 23:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiDTVxP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 17:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357179AbiDTVxO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 17:53:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AE42ED6B
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 14:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1500F61993
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 21:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79610C385A0;
        Wed, 20 Apr 2022 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650491426;
        bh=fvaHBdxleNALBIqIWTOM+O8zIV2WxFDWk+0duJ2+EDU=;
        h=Subject:From:Date:To:From;
        b=Dl4NajETOh8L7Ia2UN110feNyImLe4k+ytXSHJusZNDc5Hq5OIVlMJ60sxSZE+/dD
         w8mWl4FT+wVyn6xwxqvOP0k+C53QFkj4PlpvUY7461t5hTVc4v3oYtnojdLkyFENLv
         HTWENAY4ORBVpbOo0jnnu2Pk4fFLOngO93rcozdPEQJRx1i8WzHlj5ZlyF4W39+IZX
         X73ufhnnejQOCZ1N1ez39+mRt680g4xAsDE/1F3fKcihepBSroiwczprTYVCvJ/OG0
         vg+ZYFsjiRUT4S1pWSNnbTNQW3b43qhXgBWmL1UyLAWLJpTQmeDpsNGleT/hf7GKjr
         g+fmNdN5uRktw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52282E7399D;
        Wed, 20 Apr 2022 21:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165049142628.27071.10205626903836117084.git-patchwork-summary@kernel.org>
Date:   Wed, 20 Apr 2022 21:50:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: MediaTek SPI controller cleanups and documentation
  Submitter: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=629992
  Lore link: https://lore.kernel.org/r/20220407114428.167091-1-angelogioacchino.delregno@collabora.com
    Patches: [v2,1/8] spi: mt65xx: Simplify probe function with devm_spi_alloc_master
             [v2,2/8] spi: mt65xx: Switch to device_get_match_data()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


