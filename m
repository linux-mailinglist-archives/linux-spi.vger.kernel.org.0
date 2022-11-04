Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F250461971E
	for <lists+linux-spi@lfdr.de>; Fri,  4 Nov 2022 14:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKDNKT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Nov 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiKDNKT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Nov 2022 09:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8920F6C
        for <linux-spi@vger.kernel.org>; Fri,  4 Nov 2022 06:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F19856219A
        for <linux-spi@vger.kernel.org>; Fri,  4 Nov 2022 13:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C025C433C1;
        Fri,  4 Nov 2022 13:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667567417;
        bh=9Q+kxnN9YwfWX2+Q60f1I87hx51hYv4/iK1r314CVYc=;
        h=Subject:From:Date:To:From;
        b=YQqT7qw8EKsiY1IXOjPdOsvGQUz2fW69RIvx/3jr44llfHC5WCIi95P/WlUmVRqlU
         QMgH7YNSX5WmpmDp67cgeG5c6Ds8x6yAxb4pwodC+hp0Ypiv/2vLsy5cma0BGIV3dK
         j4e/y/V8eSo+QyeeeHCwsX+6VNfsSVER+KlYUzGDyNsYSdV5RrO3Ji4ISS2zrZR0dg
         GjesTk0Fv39WPXv85pENjVQvZwVt/4yLtuG1t2Yrw8vHQIq8tFJ0v+G0UzkTcn30o8
         IQsoi44XLrIV1Z0ddAO0SaTI1LczJzR1iMIgk/74bEPnbMvlfAvJx/Cvc+CTFh3aan
         k5r1Ym5RZCCIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30864E270FB;
        Fri,  4 Nov 2022 13:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166756741713.15917.2395337141287567759.git-patchwork-summary@kernel.org>
Date:   Fri, 04 Nov 2022 13:10:17 +0000
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

Patch: spi: hisi-sfc-v3xx: Fix a typo ("duall")
  Submitter: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=691795
  Lore link: https://lore.kernel.org/r/20221103190052.915755-1-j.neuschaefer@gmx.net


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


