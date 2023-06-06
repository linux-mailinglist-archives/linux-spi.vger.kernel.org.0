Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBF724925
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jun 2023 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbjFFQaX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Jun 2023 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbjFFQaW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Jun 2023 12:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F662E40
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 09:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A93086358D
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C9CAC433D2;
        Tue,  6 Jun 2023 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686069021;
        bh=Z2fynfsz9mcbFkMLZeA5ZINqdEQaFXed9+q4MYdxUfs=;
        h=Subject:From:Date:To:From;
        b=B4snJwUV1PYfTVPNZfPoQI7Cz5h/Nzl+5NLil+sS7aRqWSFc5buVqEWYAONqr4X+V
         diIHz9wB3i19oINE0asYHSw3RrzcOVuP7mOSkbQkwcunMZpVpplqaucpQtoGZPewEa
         dkKQ87YAOq95u3Rb9TLJtRhIVvU6bC6Al+oO1Q5m0TgyAZ4PDiFeq8WTiIKvo5uNSo
         xrHBPRSH5/7lj28swjLEd1OQ92ULmXsIVxk0aXSqDk3qKk+ll9pV13RZzYGlqK1Thp
         tphqyXG/1Sl7SxHQEW4eSXKb+5mgZfF5s3a2eWmtnZr29u10xTpW5AAH+0OWWB68UX
         u1aNonVm41l7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCA7DE8722F;
        Tue,  6 Jun 2023 16:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168606902082.20943.7335328532061920589.git-patchwork-summary@kernel.org>
Date:   Tue, 06 Jun 2023 16:30:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Series: spi: dw: Add compatible for Intel Mount Evans SoC
  Submitter: Abe Kohandel <abe.kohandel@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=754506
  Lore link: https://lore.kernel.org/r/20230606145402.474866-1-abe.kohandel@intel.com
    Patches: [1/2] spi: dw: Add compatible for Intel Mount Evans SoC
             [2/2] dt-bindings: spi: snps,dw-apb-ssi: Add compatible for Intel Mount Evans SoC


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


