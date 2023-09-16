Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263597A2CFF
	for <lists+linux-spi@lfdr.de>; Sat, 16 Sep 2023 03:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjIPBVJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Sep 2023 21:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIPBUj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Sep 2023 21:20:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA6106
        for <linux-spi@vger.kernel.org>; Fri, 15 Sep 2023 18:20:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D769EC433C7;
        Sat, 16 Sep 2023 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694827233;
        bh=qzs6OPkFIBnd0AKXHUMZPBpP+007659xHF++a1ZNpOI=;
        h=Subject:From:Date:To:From;
        b=dekXsivtbY40r6Q6qQrRD4554OGZVJv3UXewfcWkO1dGB3BZeKciYZh7qHji7Xd5V
         evddDQXAt9B8T8Mx6P7BmJDQVSCIK/f+QuiLMK5Kc8VBidztLLYA4FvxAYsc5pxa3j
         pWXH9iLvn0enJ96wxVqkKvB31L/gMSZU6RiOoTlPVx5GwI5alx1moNvtsCO7CJhphS
         RcWz3EDi7qz1SYufoflEV7PwYg6nyXxoqHEYEzliw9WnF5O6+6b04+uNBobQi0IH//
         Pi74SFLBqV7nsLWJqpK3hLOEURgb+u6rj0JE6w13+MenYtZCNga5vHRy/DRB1TdpjV
         otfqlL1KLtNRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA9D8E26880;
        Sat, 16 Sep 2023 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169482723363.10576.10998145929236816465.git-patchwork-summary@kernel.org>
Date:   Sat, 16 Sep 2023 01:20:33 +0000
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

Patch: spi: dt-bindings: arm,pl022: Move child node properties to separate schema
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=784306
  Lore link: https://lore.kernel.org/r/20230914190033.1852600-1-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


