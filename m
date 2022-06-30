Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EE7561C40
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jun 2022 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiF3Ny6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jun 2022 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiF3Ny3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 09:54:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C7558FC5
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 06:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB3E6B82AF5
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 13:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E02CC3411E;
        Thu, 30 Jun 2022 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656597015;
        bh=7DYYAMY40II0eSZ3Yt3rIXv/sVwjolFL1o+kePvRncE=;
        h=Subject:From:Date:To:From;
        b=XEbC1CKGGCXWiYYIClPCgB+0YPrK8bdyJpICfVzTNfLVzssrub4sGV/gZ1e58iIgd
         AgGn2nbOUmLU4kzwSLp/cRlSPdGKH5iJpSQFUhnXlD0sutydfWKNgPLpiamo3lRRiw
         wv26M29p/xo3Kgb6puIuBT/Osl0JiPkeXDD+DBqY3Gn4ztsODTmyHo7lO7usnujhfk
         vw9Q1QqzuVNxuOxoOxh2RahZkXix5/cTaEpVGLe1hQTdxdLCZdgmSa/Z0yxQ3ZvcxS
         MhKavGxkatu1JlcyEIIiwf5Yo/W2K8WOI6WMdtRi80J8T2zfKStUymjfFwJptlMd6n
         RDOaSyblFo28g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21A53E49BBA;
        Thu, 30 Jun 2022 13:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165659701505.22307.11511595273413522325.git-patchwork-summary@kernel.org>
Date:   Thu, 30 Jun 2022 13:50:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Patch: spi: pxa2xx: Add support for Intel Meteor Lake PCH-P
  Submitter: Jarkko Nikula <jarkko.nikula@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=654991
  Lore link: https://lore.kernel.org/r/20220629120700.620108-1-jarkko.nikula@linux.intel.com

Patch: [v2] spi: pxa2xx: Add support for Intel Meteor Lake-P
  Submitter: Jarkko Nikula <jarkko.nikula@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=655290
  Lore link: https://lore.kernel.org/r/20220630073305.632850-1-jarkko.nikula@linux.intel.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


