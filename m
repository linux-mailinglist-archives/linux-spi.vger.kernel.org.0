Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE9631863
	for <lists+linux-spi@lfdr.de>; Mon, 21 Nov 2022 02:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKUB4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Nov 2022 20:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiKUB4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Nov 2022 20:56:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC381572B
        for <linux-spi@vger.kernel.org>; Sun, 20 Nov 2022 17:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3DDEB80D09
        for <linux-spi@vger.kernel.org>; Mon, 21 Nov 2022 01:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8925CC433B5;
        Mon, 21 Nov 2022 01:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668995779;
        bh=wEepm28YZpZcxU/YD9WzMlN8cryCjtS1f8JPQ+vviXQ=;
        h=Subject:From:Date:To:From;
        b=Z03S8Nk0GqZcVwio0MDXlCpyJOcjBUT8J9gi/QvlGjDD2GhtqqE+d/RebokrzdpmX
         8/2aB4MMSnTX4lpKZQDqdnPZjT3uWgwWjXsd8hWStyk2nq7QFqjYFK/9OlZ73ZyKq6
         C5ywBQpmYfxotBM8rvQVA2vXmltzo5lq6dzHQyeaXkAU8EziHT0s1A2UW4ldhD4o/W
         jlqQywz4meTv9XKHS/BR755FFVrKencElaUURseVgeLhK7WIWQpdH+qDhQ8XrKuC1d
         4CWeUsXRpfbKabaapwyJgDtG7UHrKQmr476vs+jPr9hFMVGSTGXEq9rqJiodbpZ66B
         njWhtxkicnZWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69F67C395F0;
        Mon, 21 Nov 2022 01:56:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166899577942.4906.13338126083032750257.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Nov 2022 01:56:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Introduce Socionext F_OSPI SPI flash controller (2022-11-21T01:47:58)
  Superseding: [v1] Introduce Socionext F_OSPI SPI flash controller (2022-11-18T00:59:02):
    [1/2] dt-bindings: spi: Add Socionext F_OSPI controller bindings
    [2/2] spi: Add Socionext F_OSPI SPI flash controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

