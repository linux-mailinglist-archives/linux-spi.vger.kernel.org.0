Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433EE5811D0
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jul 2022 13:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiGZLUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Jul 2022 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiGZLUQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Jul 2022 07:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7A6547
        for <linux-spi@vger.kernel.org>; Tue, 26 Jul 2022 04:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A258F612F3
        for <linux-spi@vger.kernel.org>; Tue, 26 Jul 2022 11:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09C02C341C8;
        Tue, 26 Jul 2022 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658834414;
        bh=aTWJkxxzzEvYHp0AWpCFXrt0lmeffUccOQTDZobx7Rc=;
        h=Subject:From:Date:To:From;
        b=NJl8cn6wxaYnnL1ul0EvzFZjDWI0yBJWfGdMKfav96IsGlm+TPS0QYPRHDseNC0Kc
         iCnqyUHi7G1BDz5vt8Lo6wMhcpGhl7bqMAi3hmLw18/iaKEqr8+15dRoxqT1TG6Xhj
         OqQJ8iBiU5ePPBJU4ZRO8DnHF279AXsnYVbNoAMJbRmv6Q0NlCmZgrJIL+NsG3TdiZ
         OJRuhrxsYwvhu0+nU2/23xRzeI0cIcq/q64l/JPep5PDMLHaIAP7E65eX6UuIWDEqe
         xAh9vTnvIZTWLIMpkw3JyqcUCo/l17OTyFp2P9/e6BzeY7G+ez68grH9xU17sLr2OY
         XDpDTjEWZVafg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5D50E4481D;
        Tue, 26 Jul 2022 11:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165883441383.20862.14675762774691328992.git-patchwork-summary@kernel.org>
Date:   Tue, 26 Jul 2022 11:20:13 +0000
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

Patch: [v2] spi: bcm2835: enable shared interrupt support
  Submitter: Marc Kleine-Budde <mkl@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=661021
  Lore link: https://lore.kernel.org/r/20220719105305.3076354-1-mkl@pengutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


