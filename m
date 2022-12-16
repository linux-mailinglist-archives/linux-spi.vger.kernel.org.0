Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2821564EFD7
	for <lists+linux-spi@lfdr.de>; Fri, 16 Dec 2022 17:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLPQ40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Dec 2022 11:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPQ4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Dec 2022 11:56:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FCE2AC7
        for <linux-spi@vger.kernel.org>; Fri, 16 Dec 2022 08:56:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1FF51CE1EA9
        for <linux-spi@vger.kernel.org>; Fri, 16 Dec 2022 16:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30A65C433D2;
        Fri, 16 Dec 2022 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671209781;
        bh=2vFEjau0QHq2hj2hBzn6Q1N/3FMQwRxPKr8dIkUamzA=;
        h=Subject:From:Date:To:From;
        b=RJXlPXL8sG1FwZQAAJWvs0kwZGJpuoL2GaPZjt1Mcxu1AcMd/cgNlofziYAU8TLpR
         J6OYL+ap2Gfh5igBhfUBNSXgAQG/bUdFnBx9LDnn/Fdlj+R/G8Hrp9OnXulkSSUDr0
         wKsEGGD2SLyWWkUoa5QIxpf39UZ6+CGAI1JZButHPKRTU0GR60n0hytPnij21ljDxE
         AipnQY+ZgLbeSTWfN/RLseBKJeGb5JVQaoT+K6jaRJAQZIupKy27s+lxIf0PEItpDd
         Bikha0puihtIF1JhCFdw+wc+LfXEgnRlhmZGSLjS+3pEU4Pa5sWGsQmD8KvC9jVNY0
         uJ64lFSLvbzvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15330E21EF8;
        Fri, 16 Dec 2022 16:56:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167120978108.4987.9246097438629403939.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 16 Dec 2022 16:56:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] dt-bindings: cleanup titles (2022-12-16T16:38:06)
  Superseding: [v2] dt-bindings: cleanup titles (2022-11-21T11:06:06):
    [v2,1/9] dt-bindings: drop redundant part of title of shared bindings
    [v2,2/9] dt-bindings: memory-controllers: ti,gpmc-child: drop redundant part of title
    [v2,3/9] dt-bindings: clock: st,stm32mp1-rcc: add proper title
    [v2,4/9] dt-bindings: drop redundant part of title (end)
    [v2,5/9] dt-bindings: drop redundant part of title (end, part two)
    [v2,6/9] dt-bindings: drop redundant part of title (end, part three)
    [v2,7/9] dt-bindings: drop redundant part of title (beginning)
    [v2,8/9] dt-bindings: clock: drop redundant part of title
    [v2,9/9] dt-bindings: drop redundant part of title (manual)


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

