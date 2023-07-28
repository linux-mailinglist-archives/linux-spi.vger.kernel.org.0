Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB77676C6
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjG1UK2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjG1UK0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 16:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79A84487
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 13:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 415B4621B4
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 20:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A46C8C433C7;
        Fri, 28 Jul 2023 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690575023;
        bh=/w9uqAHWbm2lMvrEYotnhk5yStuMOOyA5sYxTtL14xA=;
        h=Subject:From:Date:To:From;
        b=QEcyiHvbOjB14kmHjJXvYD9jB3Kl55d4SO4qqWA6YKIuYtUJM7tbnEFYejqCf3cC8
         VnZfJznFKnKvYoJ9BbLT+Fua4jzTk4PrjIVhMRX9lENLVQERfy19YQhaqhI4NFGeZU
         lz2cqsyjOeZLDieIF480669QDt/iBw2QHNFONmzmpsVvC8qT3VXfL3D3svL2nGp8dQ
         P9HOzBmkWP9kACLDJ63zin3f3XyFrbM+RaSfkf+BbIVyzlqAZbRimOtI7+qm3a2hdm
         wlMlutr1Gh6/6MKPLoKG8QfI44Lj9Tb7aZeJ3ClOUhdCjlI93XfPTpJ2FpMpJdnV/P
         PJP0XUOEmvy8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BF29C43169;
        Fri, 28 Jul 2023 20:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169057502344.5371.14712933424632290219.git-patchwork-summary@kernel.org>
Date:   Fri, 28 Jul 2023 20:10:23 +0000
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

Patch: [1/1] spi: fspi: Add power-domains to the DT bindings
  Submitter: Alexander Stein <alexander.stein@ew.tq-group.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=770407
  Lore link: https://lore.kernel.org/r/20230728060804.22796-1-alexander.stein@ew.tq-group.com

Patch: [-next,v2] spi: microchip-core: Clean up redundant dev_err_probe()
  Submitter: Chen Jiahao <chenjiahao16@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=770448
  Lore link: https://lore.kernel.org/r/20230728075729.3451867-1-chenjiahao16@huawei.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


