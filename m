Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7CE739DE4
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jun 2023 11:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFVJ6Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 05:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFVJ6B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 05:58:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48D82704
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 02:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41D2E617BE
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 09:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0BBBC433C0;
        Thu, 22 Jun 2023 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687427811;
        bh=n3ES5lFm2pqN6u96RFHQGEWOXkZvjtF8oQMjffw5cjU=;
        h=Subject:From:Date:To:From;
        b=jpHtaH+nJxbsoSuDHnEXwdaEZMxEbjsDHYaIptuuQoadNzLtC0aaOZPx5JeWBwkpU
         1EXfNikIIUiEE7qXbB16hhxBEAKfabIPIocAxM30fmPEYH+VTftco3jAKImfZOWWJn
         4z9yQht57w7LCNGS+f5KHUy7tp2LsT8fiF5V4xRN3Sg80uS8CET84sGxbqTFaGj5lT
         /IoNCh+BxX6339lr31gfFSoLHOc05g2LmlXGYppYHyj+BtEEiyU48w6GcZd9Vuo0s2
         8oTxdNk07U6YRSwGuFESEO83Xlrrw/DAtTZtCMF4S9YFQsy+rZacyQuVlrLWnhbhIP
         YxAO8uyfB9xbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 818DAC691EE;
        Thu, 22 Jun 2023 09:56:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168742781152.10613.17847993331407730518.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 22 Jun 2023 09:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: Helper for deriving timeout values (2023-06-22T09:06:31)
  Superseding: [v2] spi: Helper for deriving timeout values (2023-06-19T15:53:46):
    [v2,1/3] spi: Create a helper to derive adaptive timeouts
    [v2,2/3] spi: atmel: Prevent false timeouts on long transfers
    [v2,3/3] spi: sun6i: Use the new helper to derive the xfer timeout value


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

