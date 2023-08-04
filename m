Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCB2770A28
	for <lists+linux-spi@lfdr.de>; Fri,  4 Aug 2023 22:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjHDU4y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Aug 2023 16:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHDU4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Aug 2023 16:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD324C2F
        for <linux-spi@vger.kernel.org>; Fri,  4 Aug 2023 13:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECFA2620E3
        for <linux-spi@vger.kernel.org>; Fri,  4 Aug 2023 20:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C0CBC433C9;
        Fri,  4 Aug 2023 20:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691182606;
        bh=uA1HnYs/IHNQE+jG276etV8C7KICsdxX8ycZ8x8GcEw=;
        h=Subject:From:Date:To:From;
        b=lRDwpFsOidk2NvFgpf47vrjN3uL8GLRavu/V1lrLlOdu0Gh46BCsvnKIHmypiO/f5
         xDfxpJKuFrScoxo8ux6MQMifh2hyx3Dv/Hw88i1ZxvpbwqEJ8hE6Qu5zbYTVuazFXC
         8kICo2bg+wMVlECP4QVlwhwZwP/XM87D6UAi4n+h267KKievGIgoXgYmmZ9BEyDbD7
         fLzvRnBW1hIkxg0k5VpwZeK2+Kk9gQp40wZ1Gzh2hzDi6GssDRMUHpm0SrOAi+2YTt
         YpAByh454wF+DLe9TGAVeRNAWuQneN/pSXAp90/UziOc9yH6vrbHWEyV0WjVLdmxPT
         rc1mOgucTBQSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2318DC41620;
        Fri,  4 Aug 2023 20:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169118260613.12741.11157447619159245933.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 04 Aug 2023 20:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] fixes warning (2023-08-04T20:07:11)
  Superseding: [v1] fixes warning (2023-08-04T11:51:20):
    [1/2] fixes warning
    [2/2] fixes warning
  Superseding: [v2] fixes warning (2023-08-04T20:07:10):
    [v2] fixes warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

