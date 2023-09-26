Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339F97AEEBB
	for <lists+linux-spi@lfdr.de>; Tue, 26 Sep 2023 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjIZN5F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Sep 2023 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZN5F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Sep 2023 09:57:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7A8FC
        for <linux-spi@vger.kernel.org>; Tue, 26 Sep 2023 06:56:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A14CC433C8;
        Tue, 26 Sep 2023 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695736618;
        bh=zt4GNQqqbgr9/gfM/KNVVH4UydrjqkLQXhhgUmL9b78=;
        h=Subject:From:Date:To:From;
        b=cd7pfiFs+Uj8iTD7Z5yT+60nlQQh3dnrkZ4zmhHZ/bcbCBrMGODvgz9Xmp0WOyOEw
         fdbYp9SaLYbPqJJqCrKBYnUk0ZlotKd8y3/F2lh3QgcKeHSOvsil7xQLrYygVQUtg7
         tC9isanPODUY65YCFw1mJ7izT11gBYjIM1EsRBbQ3WYb4a1sbcLmys95uaD9M9z1Tf
         dRoCUxpi5GmqZPuGaiYbijsHgDeRQPiB1P/hdZ2aYsVWogBC8JXuRVJnhFR/mEbCOL
         H22xWBzrTsI6oFBASovm0T43Cxc9FN4b9OSCQhh6kZJowMbhnkSzUgwShw6F62xgad
         YBHMxpHAM8hjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46AC2C64459;
        Tue, 26 Sep 2023 13:56:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169573661823.3478.12396087069542636744.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 26 Sep 2023 13:56:58 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-cadence-quadspi: Fix missing unwind goto warnings (2023-09-26T13:09:27)
  Superseding: [v2] spi: spi-cadence-quadspi: Fix missing unwind goto warnings (2023-09-19T07:46:59):
    [V2] spi: spi-cadence-quadspi: Fix missing unwind goto warnings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

