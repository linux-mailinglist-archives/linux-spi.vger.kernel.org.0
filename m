Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85CB63216E
	for <lists+linux-spi@lfdr.de>; Mon, 21 Nov 2022 12:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKUL4Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Nov 2022 06:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKUL4X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Nov 2022 06:56:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154CB4E42A
        for <linux-spi@vger.kernel.org>; Mon, 21 Nov 2022 03:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C59E7B80ED0
        for <linux-spi@vger.kernel.org>; Mon, 21 Nov 2022 11:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9340BC433D6;
        Mon, 21 Nov 2022 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669031780;
        bh=AAgNCin8o+KiZiGG9t3FFumz2g2L9cuK+Q1gE5wCRzk=;
        h=Subject:From:Date:To:From;
        b=oqVpgsPr8TlKpYQnxuA19Gy6t+O9C/z31wcW1Gl0tNcprupNnwvDyRHRTYzpm685A
         LIIuvg64pMjTnI27ZpQx05naCsuT9J5fWuQKbP0fXGH6m3+K8HNTs68+uJAQlSVvG0
         mOSJ/1TcK2hVp1mfsZRS+VGykzpt6Kv6Gr3mQsWZaezC6fjjRadOe1qiDYHdnWOtph
         /gLu6SKaMdZZJcTn8BVtucL4GrjdWu3TG14lR6NpRjLF0PSKS4imZpr6h2ivPYpd2a
         e0hOtYF5zHu8ZHgA/QdRZyYlXoibdCWxNDgeMlHh21heQZd9YnOGcKc3UBym1OF8ED
         L5DhhCYht7ZTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74CD3E29F3E;
        Mon, 21 Nov 2022 11:56:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166903178047.24835.11328581434984995760.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Nov 2022 11:56:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: cleanup titles (2022-11-21T11:06:06)
  Superseding: [v1] dt-bindings: cleanup titles (2022-11-17T12:38:42):
    [RFC,1/9] dt-bindings: drop redundant part of title of shared bindings
    [RFC,2/9] dt-bindings: memory-controllers: ti,gpmc-child: drop redundant part of title
    [RFC,3/9] dt-bindings: clock: st,stm32mp1-rcc: add proper title
    [RFC,4/9] dt-bindings: drop redundant part of title (end)
    [RFC,5/9] dt-bindings: drop redundant part of title (end, part two)
    [RFC,6/9] dt-bindings: drop redundant part of title (end, part three)
    [RFC,7/9] dt-bindings: drop redundant part of title (beginning)
    [RFC,8/9] dt-bindings: clock: drop redundant part of title
    [RFC,9/9] dt-bindings: drop redundant part of title (manual)


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

