Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F75918DA
	for <lists+linux-spi@lfdr.de>; Sat, 13 Aug 2022 06:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiHME4g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Aug 2022 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHME4f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Aug 2022 00:56:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8F61DB5
        for <linux-spi@vger.kernel.org>; Fri, 12 Aug 2022 21:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9DADB80EE6
        for <linux-spi@vger.kernel.org>; Sat, 13 Aug 2022 04:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6829AC433C1;
        Sat, 13 Aug 2022 04:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660366588;
        bh=cbWMvQo9TQ+3fHPo3t5O5rB5v4PQupt8jdEFKiz+xWs=;
        h=Subject:From:Date:To:From;
        b=Oe/ygHAwOGCaItnYDvE0GaF1H77bWd8u6tBnADvmIlhGb2BiriCBfAT7BHBCfPodw
         Ro8YGANMwRTiGgFPAX2dE6ft9M1yOa+WtMeieIYMlvspGiXb39zgzqRlOXd1em2L8K
         2KHJ3e2oZADHN5NmA/wABWeLBHCgRF3j9cLXXVysy5DKUlblm9GeRx7nxF9YkF52Ap
         tgPCjBQMgAUB9vicaU809vjsCK0kYbZVKPW+tRUl+7oxp1ZSTBRsagkNMjRxj2XLnx
         ZrZVYwijS1810gyP/rYu9tZ+sHRnLN9db6I/Qfg5QGIbhU4KiosqQj2lH17yC4uRzD
         L0xoP/gWnGHWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B6A6C43142;
        Sat, 13 Aug 2022 04:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166036658814.3680.6699003452705299828.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 13 Aug 2022 04:56:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: cadence-quadspi: Disable irqs during indirect reads (2022-08-13T04:27:36)
  Superseding: [v1] spi: cadence-quadspi: Disable irqs during indirect reads (2022-08-13T04:09:28):
    spi: cadence-quadspi: Disable irqs during indirect reads
  Superseding: [v2] spi: cadence-quadspi: Disable irqs during indirect reads (2022-08-13T04:26:16):
    [v2] spi: cadence-quadspi: Disable irqs during indirect reads


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

