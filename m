Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161E977650C
	for <lists+linux-spi@lfdr.de>; Wed,  9 Aug 2023 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHIQaY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Aug 2023 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjHIQaX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Aug 2023 12:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F561FCC
        for <linux-spi@vger.kernel.org>; Wed,  9 Aug 2023 09:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0998563642
        for <linux-spi@vger.kernel.org>; Wed,  9 Aug 2023 16:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EB96C433C9;
        Wed,  9 Aug 2023 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691598621;
        bh=HtqTh0P5XmZg8cek9zvDMfc8KHpUUHMYjtFK2Tosloo=;
        h=Subject:From:Date:To:From;
        b=pSTbtE04MW5fP7xefvdGgzo3oWSpg5RzLYklq571E6SHVlhu3SyoptILw2DY6fjr6
         qxzCZ4jMY1JNqPSWIxdMuno78Svlirru9trtJDV5b1dcw4P0/pn7GAep7MAqsVQfmw
         /xYB/3DSC9LIUWjti3tetfpfM28XLB/VQvGA0t5tgvUIhjj2zA0nVDWcNzN7bEjMZH
         sTphSItsEteMk+HAHreSCi7h5jToYWVJ/yC7yFE8Dz/bfzjYM+HH6v6PqyiVeEs33q
         J4WcNLxtd7bFM3CBlRhjJNGgt8Xwkf8bsh/cIxvSutGjgNzP8llKZw7L1NW8IxrEH8
         xb1x/bF63o8eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A875E505D5;
        Wed,  9 Aug 2023 16:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169159862125.16090.8353773747150324224.git-patchwork-summary@kernel.org>
Date:   Wed, 09 Aug 2023 16:30:21 +0000
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

Patch: spi: fsl-cpm: Properly define and use IO pointers
  Submitter: Christophe Leroy <christophe.leroy@csgroup.eu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=774441
  Lore link: https://lore.kernel.org/r/18a65dca9134f6fc35932408066d4a8284cbfa65.1691571190.git.christophe.leroy@csgroup.eu


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


