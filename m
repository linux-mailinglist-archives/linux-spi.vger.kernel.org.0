Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35FE65FF35
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jan 2023 11:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjAFK4Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Jan 2023 05:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjAFK4P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Jan 2023 05:56:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E29643E67
        for <linux-spi@vger.kernel.org>; Fri,  6 Jan 2023 02:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B01E61D9C
        for <linux-spi@vger.kernel.org>; Fri,  6 Jan 2023 10:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CED3C433D2;
        Fri,  6 Jan 2023 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673002573;
        bh=S2pFPNSDjfO+r+w7ELg65uPNGp1Lkt1lXx/MNOCj+Y8=;
        h=Subject:From:Date:To:From;
        b=XreA+431gjUJalJaY16EVMh9LE0HtT4+zwYi3mKFWOUkc2boLvtGTh0v4N7Ulq0B1
         8d5L2IcyTfqLw8kJEpzkUa18lbm7RsGFr8YQ7aPTL3IQKvBYGOwS/dM/B45quREOzt
         8Tw+5nayAuczdya9Dk5kOEp6tmrSsGHkXOO6PrpFfkNBzU7CuoAJ8KBNl4m5TIeV+t
         DYqnCjx8zH1/U1bbTbCf4MGkQDKQsjN1glt0BFqka+DWygkLZ+aAW+JvlZ0KvxxhRM
         OaXteOAW5UsHhGKxqVxFnhzWx+Ze2fvg7PalaoxMb1pk3sUCWxjviUYhIMO3z38iDJ
         qvtxZY87wUrPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58109E5724D;
        Fri,  6 Jan 2023 10:56:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167300257335.9172.18369710809432392354.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 06 Jan 2023 10:56:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spidev: fix a race condition when accessing spidev->spi (2023-01-06T10:07:19)
  Superseding: [v1] spi: spidev: fix a race condition when accessing spidev->spi (2023-01-05T12:40:59):
    [1/2] spi: spidev: fix a race condition when accessing spidev->spi
    [2/2] spi: spidev: remove debug messages that access spidev->spi without locking


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

