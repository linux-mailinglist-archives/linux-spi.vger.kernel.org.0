Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C155CEEC
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiF0UkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 16:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiF0UkQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 16:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0695AD
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 13:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A700B81B8B
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 20:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1060EC3411D;
        Mon, 27 Jun 2022 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656362413;
        bh=NxAiTqfLXZQnzcWddoDfJfUo+sKvJZTJGi8wXwgbORI=;
        h=Subject:From:Date:To:From;
        b=WdsS+hMijaSi+QcVMcBHrlX41bwwi8LGlD7W0ibrOuTLJcGa+e3Ga/4Y77ATaBOC+
         Gc3TEstqFF91cYt7r40UTR9O3oGp3WL2FqUckyReieU+aT89FwBJGRzJ14Dr8W/md2
         fx4eLdBEbMVZUraLhFDdawTgdubHA/wW5drn6ffl8B4BVHyRAAeDjDjYQVLgAknj0A
         cqMYwJ6YlkJSNt7jRt/dTt0SNueQBVkkFpLxyniTzk0dMPX8OTrSo+VIwsowGAoqBe
         HnpNNaU6to4CEqYQQvU08nnIbDrFQMLuQv3KwLo6sO4nBe26KwdLmi4dxKORLrj0vz
         ZnnAsfn/ken/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7EA6E49BBA;
        Mon, 27 Jun 2022 20:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165636241280.10202.11554899131752602503.git-patchwork-summary@kernel.org>
Date:   Mon, 27 Jun 2022 20:40:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Patch: [RESEND,v2] spi: dw: Add deferred DMA-channels setup support
  Submitter: Serge Semin <Sergey.Semin@baikalelectronics.ru>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=653733
  Lore link: https://lore.kernel.org/r/20220624210623.6383-1-Sergey.Semin@baikalelectronics.ru


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


