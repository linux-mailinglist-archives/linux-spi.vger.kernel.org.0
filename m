Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC29A6165C6
	for <lists+linux-spi@lfdr.de>; Wed,  2 Nov 2022 16:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiKBPKY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Nov 2022 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiKBPKT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Nov 2022 11:10:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46555BF49
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 08:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC3BCB8233C
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 15:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93C94C433C1;
        Wed,  2 Nov 2022 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667401816;
        bh=bS64jYjmTEz6RmiPAhlQ8CJb6tPKSZqdRcEf9SwUcqk=;
        h=Subject:From:Date:To:From;
        b=QKPTA3JKcQw7HEf30etlDoUd0XZLIq8LrOvvm113FyJXt/ziVFa1hLD7is+wjIRNx
         sG9Y+VmXhY+4H9VeHvI0qOnhZMMHGoVldWxU66KtEbQJxJFNfDrYPIJZWtxze77cAX
         /1fkHXnEfjSnvK+6FLxpbNQd0zwVXiFQbqb65NozlcHIsGnqhXLf/RANMDrzltMM+y
         fm79STHeYOoFiv5psTO01qYgWaA9ceWZEPZxz/RgzHTFkCEogBptb1ASveYK/1Wy9/
         Q5kui1+8QYc01iUwPHcyuLHz2y4DZ+cyqFseKJDyT1LoC77myQDu8UzMuLfhNm62GF
         a+ZM+EHUHiP6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69C5AC41620;
        Wed,  2 Nov 2022 15:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166740181634.13625.1164756780730327702.git-patchwork-summary@kernel.org>
Date:   Wed, 02 Nov 2022 15:10:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [v2] spi: meson-spicc: fix do_div build error on non-arm64
  Submitter: Neil Armstrong <neil.armstrong@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=691113
  Lore link: https://lore.kernel.org/r/20221027-b4-spicc-burst-delay-fix-v2-0-8cc2bab3417a@linaro.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


