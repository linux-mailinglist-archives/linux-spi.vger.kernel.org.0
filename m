Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0521672ECCB
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jun 2023 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbjFMUUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jun 2023 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbjFMUU1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jun 2023 16:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F82102
        for <linux-spi@vger.kernel.org>; Tue, 13 Jun 2023 13:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10FDA602F9
        for <linux-spi@vger.kernel.org>; Tue, 13 Jun 2023 20:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72D52C116B6;
        Tue, 13 Jun 2023 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686687619;
        bh=UbVGpDIVjnS6xDcx6RBFMYbtNQ4FvDfIrQ4UUCtXOxU=;
        h=Subject:From:Date:To:From;
        b=c1OT54OM0D54iiHkG2+y4GtYrxPJfzNDfhrfZncmVNg0Y8p/UhYsYwguOBKbEhT0C
         AEkhBMGzdMZgcl33kWzM65BvdH8l9I7dkSkOX0L6RGS0WsL/gGzFxsax9n75i89vGi
         xeJqbi0Ne56+pNNFCXjbt+40+CMVIFDsvGFdsVrX9U3e+dMQFpvWbKLG3rPy+ftAFI
         z6T52J++OSepbCdm0ZZ9opFGjSl4FaULu4SLZQ4Q+6aiDTLo9QmC4AqUCrnYc1JlRF
         leY6nmts+BMtsbdZ2Sqjud8V9kXODsdGJZni9QwAwX7iqAedx0x1I5HbsoELCF7xji
         nn3Oa158yMZow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B0DEC00446;
        Tue, 13 Jun 2023 20:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168668761923.25733.12460117024411508668.git-patchwork-summary@kernel.org>
Date:   Tue, 13 Jun 2023 20:20:19 +0000
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

Patch: spi: dw: Replace incorrect spi_get_chipselect with set
  Submitter: Abe Kohandel <abe.kohandel@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=756813
  Lore link: https://lore.kernel.org/r/20230613162103.569812-1-abe.kohandel@intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


