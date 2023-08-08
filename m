Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3D773E6B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Aug 2023 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjHHQaD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Aug 2023 12:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjHHQ2p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Aug 2023 12:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E11252F
        for <linux-spi@vger.kernel.org>; Tue,  8 Aug 2023 08:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8975625B8
        for <linux-spi@vger.kernel.org>; Tue,  8 Aug 2023 15:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C223C433C7;
        Tue,  8 Aug 2023 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691509222;
        bh=bZ4aQl+5XfDCKIWnC6CkMnisB02yUwdVK/pGxDIXZYE=;
        h=Subject:From:Date:To:From;
        b=rPA+3b/PbyB9ZmAxwKcrFHe0r/24tiJAd6h/nyU7xMqKTWr21GpGpc3TvImJ6XoY0
         3an/rZWG7/YMa1ez0puYl4HmLONiRZ6V5RYM7AEWLMWgHSxtHK3Ekq4FzZ9j74L3fL
         4wS/3pd3UF40W1qrzf+fTiCZmfXErPUknBCavpxee94vaylPvFfDai/TAyFqrUYbhM
         hxRTn9NninpkBAUH+FBvUnTzcontU4T3Hb51/PpHaZ1pBLFkEF2tFZgc8SXb3AmF3O
         7CNMjUJQlFKC40nQs+swaW7Ud88tesrBeu6ED+9YQgpMslqHmJiImJ9viqMI/69lPS
         Gzz1UT7b7cLOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 147C7C395C5;
        Tue,  8 Aug 2023 15:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169150922198.10043.4222912116839578283.git-patchwork-summary@kernel.org>
Date:   Tue, 08 Aug 2023 15:40:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dw: Set default value if reg-io-width isn't specified
  Submitter: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=773457
  Lore link: https://lore.kernel.org/r/20230807001621.196776-1-hayashi.kunihiko@socionext.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


