Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B597AED84
	for <lists+linux-spi@lfdr.de>; Tue, 26 Sep 2023 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjIZNAb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Sep 2023 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjIZNAb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Sep 2023 09:00:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D0116
        for <linux-spi@vger.kernel.org>; Tue, 26 Sep 2023 06:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BF4BC433C7;
        Tue, 26 Sep 2023 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733224;
        bh=1uPAMXRH3NXDazFln7a5yJ9jv2PDRiQw1+bePdS8ufo=;
        h=Subject:From:Date:To:From;
        b=WIVCGuSSPyoq3w/c7BLc/C5FYid3V1hkjUw8lKiLRhFdJ6zz81UcoThPVf3741qdl
         FP61aZyCJdQX+8j9W07NUePy6vgWI25tnxEaPxvoEbLS2hLvlhCdVuOHXTn5lDjIEj
         96IYzX3vsvuAeDnUeGf+OK8/mfNz8K44axTLNsEiJ5pB3H4sKkgilDqHcFAu+xO4y4
         zpYV4El24LLSqAywMkaRQ6F4D4B4NG8ji07lDVlf5SpeewEFL+EnfBuBFfbcsVJGvr
         N07hMGMvIUnzPB596HVZIUIF6W1w/e76vlQZDApkK4wNIRxwzvA9I25SWBvacT9Rwg
         082k3wL06gfvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46441E29AFF;
        Tue, 26 Sep 2023 13:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169573322423.5908.3132383456923126124.git-patchwork-summary@kernel.org>
Date:   Tue, 26 Sep 2023 13:00:24 +0000
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

Patch: spi: dt-bindings: Make "additionalProperties: true" explicit
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=787433
  Lore link: https://lore.kernel.org/r/20230925212614.1974243-1-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


