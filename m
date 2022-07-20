Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7689757BD31
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiGTRuS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiGTRuR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 13:50:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D8F38BA
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 10:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D650CB8217B
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 17:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70D87C3411E;
        Wed, 20 Jul 2022 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658339413;
        bh=CFZywnW3tH4OzWrmdltZR5Cox3mSfNtpUjrqXAGtTFA=;
        h=Subject:From:Date:To:From;
        b=BJLUJYu2n52NDKQInvDkQQl8SzWvnInX+vJUM/eOQMI4PARRVYOwplgKMVuadrSiF
         if+IDB+F0l9sO+QmgSp8r5oEFKUyXowGddr8knXABNMKXYFuvwKcSLFTPB7+AJGdtO
         neC/MpYf4XCW5qHxvrw0nLjFxauICQnaKTDLsC2Vg71zsuKQETSWLEJ17vB8hfcqrt
         Xjz/BIgRE6ndjKwOn/Du/i83TcxDMsmVMkEaEOc2kdgn4L1b15TZv+S4AJ0pqBt2IW
         ChRPlgCvX/PX265IMGHn/vmfeZ5R3q6KB4nIoZ1LmyiyQLfpSRudhqWudCSHPbvL9u
         aIoztwxTVrqfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 503C4E451AD;
        Wed, 20 Jul 2022 17:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165833941327.27180.18189207148634524353.git-patchwork-summary@kernel.org>
Date:   Wed, 20 Jul 2022 17:50:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [v2] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers
  Submitter: Marc Kleine-Budde <mkl@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=661468
  Lore link: https://lore.kernel.org/r/20220720133416.3342229-1-mkl@pengutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


