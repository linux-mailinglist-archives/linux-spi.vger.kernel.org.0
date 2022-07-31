Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3458617C
	for <lists+linux-spi@lfdr.de>; Sun, 31 Jul 2022 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiGaU4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 31 Jul 2022 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaU4f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 31 Jul 2022 16:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AEE95B5
        for <linux-spi@vger.kernel.org>; Sun, 31 Jul 2022 13:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F9226108E
        for <linux-spi@vger.kernel.org>; Sun, 31 Jul 2022 20:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0645BC433C1;
        Sun, 31 Jul 2022 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659300993;
        bh=jEhXs9qq7ktd/OKkzhVJhQa+HL/p6KQGhjWQZoJQ+9A=;
        h=Subject:From:Date:To:From;
        b=EfqAZeB6uA8t0HfJ5JsTAklj0tihRJkLtkxsNnG+YJfOPfhZLSujvhrTHIeqcxfkw
         CvhpUIefe3ibQTHuuvltkdRCFxrK6HHBFYJ2yOFeYDS64nEJ3DsilGvV3cjRPlq6qJ
         ZH1amh4UDfU6+XT1MidX2NmtoTrKXt5SJ83hSHylh0SNTphbyW0wyEQUCDzSQ5pXXD
         lfFjZpwm1VyqJA4M0Z+d/Czy2gjuK/OxJO9Xa36G5I/OVOw84KfwQp8nl1Xi/8hMOL
         w6qE631R2QXRud5GK2j7Ma7JlUZhiRREstlg8yx1pk/UoJ/nvE7QG+diLO8r7paXZK
         CUZsRk+ksHHyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D409EC43140;
        Sun, 31 Jul 2022 20:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165930099281.23606.18423219801062865047.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 31 Jul 2022 20:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: realtek-rtl: two small improvements (2022-07-31T20:21:50)
  Superseding: [v2] spi: realtek-rtl: two small improvements (2022-07-28T15:21:16):
    [v2,1/2] spi: realtek-rtl: Add compile testing support
    [v2,2/2] spi: realtek-rtl: Improve readability when clearing the size mask


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

