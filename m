Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3D5B5774
	for <lists+linux-spi@lfdr.de>; Mon, 12 Sep 2022 11:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiILJuT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Sep 2022 05:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiILJuS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Sep 2022 05:50:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BF21276
        for <linux-spi@vger.kernel.org>; Mon, 12 Sep 2022 02:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C749CB80B9F
        for <linux-spi@vger.kernel.org>; Mon, 12 Sep 2022 09:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77495C433C1;
        Mon, 12 Sep 2022 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662976214;
        bh=lqRbwZFIrwG7wMF7s3qbbGFNJJQNnKEStB8XyozSvk0=;
        h=Subject:From:Date:To:From;
        b=BssxoRDpXQEYZcUIlMnJvrX9+m83qPzr06KzIBxDnNvLv42hc/vBu7O8ffUPpq3nF
         cxZZcZrPtetCHEuMkUAgMqUgQZyzSu/PXtxC9sHEmMxMxbroWpOXRV94BFOBU4qlrP
         x2DFTlYlTC1/0BZAO0KFlmqRMLiP0crXdkDyJdGInkD8hqenxdhOx3wFogy9dt5mGL
         0I1YaGd7JoAtnaqwiw+ApxQThGkH6d/dKY3v/41JQsMP8Ryiwzl57BZ9pmE3WYeAfU
         FiHlcFiNFSqFh/mM9GX+KVLbIkx1v2xAw0is9RWKf5axWISHlJRrP9VRgC8NeXu+fW
         LY5eLw9xdemZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48D61C04E59;
        Mon, 12 Sep 2022 09:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166297621421.17069.4168581668171414468.git-patchwork-summary@kernel.org>
Date:   Mon, 12 Sep 2022 09:50:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [v2] dt-bindings: spi: rockchip: add power-domains property
  Submitter: Johan Jonker <jbx6244@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=676053
  Lore link: https://lore.kernel.org/r/12af4fe6-4d35-cb4a-f5f6-06e3aba990cb@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


