Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FB477C205
	for <lists+linux-spi@lfdr.de>; Mon, 14 Aug 2023 23:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjHNVCN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Aug 2023 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjHNVBy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Aug 2023 17:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D271981
        for <linux-spi@vger.kernel.org>; Mon, 14 Aug 2023 14:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C3B62B79
        for <linux-spi@vger.kernel.org>; Mon, 14 Aug 2023 21:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FA04C433C8;
        Mon, 14 Aug 2023 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692046823;
        bh=cGhXCHHOsdNFtLratWI1ghvPh82dbqOGf4ZWmNGa6FI=;
        h=Subject:From:Date:To:From;
        b=BySjbXMzg0UGtEh/oq1e0ba4UR/YaZFfM9cXrxh3n3wxfiCsoHXy6nP+YR02JWJuG
         MVzqTMm6qrvPJx9aW2aJbsQFlgXX3ZgkPdxWyuh4V0CVcY9UUjbiEv5neSBhNxHO9s
         66hshMbwilZ7zPp68mPWVn7Aur9a0H0OJk3QV0wRW0nQ0o9GiNsS/oqxDQl1xUqCqx
         b0o0qUa+NQhf8c8VFskRQXwuiiJMmAncHCXxklZuvIKurpM5+LsgQ4vWqvHaRmwhSo
         dVB7YHkDztUOetMdoertNWS0o6F9DUPJmcgvCB++TbS64NA/qaAlfVDZiauWslutit
         10b5sZhZsLWPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2AC3E93B32;
        Mon, 14 Aug 2023 21:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169204682287.11406.1783333844480873040.git-patchwork-summary@kernel.org>
Date:   Mon, 14 Aug 2023 21:00:22 +0000
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

Series: [net-next,1/3] spi: sc18is602: fix Wvoid-pointer-to-enum-cast warning
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=774856
  Lore link: https://lore.kernel.org/r/20230810091247.70149-1-krzysztof.kozlowski@linaro.org
    Patches: [net-next,1/3] spi: sc18is602: fix Wvoid-pointer-to-enum-cast warning
             [net-next,2/3] spi: pxa2xx: fix Wvoid-pointer-to-enum-cast warning
             [net-next,3/3] spi: amd: fix Wvoid-pointer-to-enum-cast warning


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


