Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03C7AEBF6
	for <lists+linux-spi@lfdr.de>; Tue, 26 Sep 2023 13:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjIZL46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Sep 2023 07:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjIZL46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Sep 2023 07:56:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0BDE
        for <linux-spi@vger.kernel.org>; Tue, 26 Sep 2023 04:56:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C085EC433C7;
        Tue, 26 Sep 2023 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695729411;
        bh=rr8F6FFThuuvcZ1uak6UPKOFuqWD+rkHxo1m2KbObFM=;
        h=Subject:From:Date:To:From;
        b=ib6vNabmJWeTNdEWkA4pYyovW7/w6QYX7J2dSU7B7ElnAdf60rKMeLW7oOl2OP6j0
         lJE7UDcsM70NPcd/1FpdD7kfo2qCwZfYMkM6wD4o/aB0/QRU+j677X43JaeZ9mPzFp
         7DWz6lEQDDSzq+f2FuElZ2XiKrbjJgBoQ8YyfRx02xJ+Qz93pqY67gu8KtltypdBNq
         HoSGLx6oNw3K4a7GgqBgCSVd2cz8HN3UrN4aFCphiIEU7Nfchpp0uPnKky2mJ7xgCT
         5Wy15Fld7yejs4nnxxHJfzE6mILIudv6Jqy2qmBaITnPZOpemM6PG+paMe3KBuClC0
         /JdWNv5xtn3uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1507C6445B;
        Tue, 26 Sep 2023 11:56:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169572941165.2418.3468164342851393508.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 26 Sep 2023 11:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: omap2-mcspi: Fix hardcoded reference clock (2023-09-26T11:38:12)
  Superseding: [v1] spi: omap2-mcspi: Fix hardcoded reference clock (2023-09-12T10:03:28):
    spi: omap2-mcspi: Fix hardcoded reference clock


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

