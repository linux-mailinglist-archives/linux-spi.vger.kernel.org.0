Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D76F7F70
	for <lists+linux-spi@lfdr.de>; Fri,  5 May 2023 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEEI47 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 May 2023 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjEEI46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 May 2023 04:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B69EE5
        for <linux-spi@vger.kernel.org>; Fri,  5 May 2023 01:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 299A361212
        for <linux-spi@vger.kernel.org>; Fri,  5 May 2023 08:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C080C433EF;
        Fri,  5 May 2023 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683277016;
        bh=G3Sljn0qnhzhv3Bh9mr04g4nIK+G3uVnj4idZlttpZQ=;
        h=Subject:From:Date:To:From;
        b=BYqnQRC9s8rMhNokowj/2dg0lk6F/Hapl/LwoQUWnjju5/KFJFGlPGyxKvAUM4foF
         tj0YTyp4CcT+klroku/mM6WnF3cmO2rhvtBHsDQHhFCcHrDCylV4PpBDaaOAE0r832
         Q6m7q41WUrABZfhWICGBHGY+ned4hGV/uZFZ6XAUwT96XyZvKOHaf7JaAIkg+gfnuj
         fLnRqUNwK1nwKeA8y9t5ivJZ/xbYfoSf1rDVdM91UQ8p39qO3WdvzMNKlrpN/Zx0no
         UmHqz7HQ0HHDILs9SoA+DYD/rO0VqspYz6nELBKd2oo8qd6W2TLsudHrCe7l8NMF71
         Be8UzRVfZNkhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 602ABC43158;
        Fri,  5 May 2023 08:56:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168327701639.18648.14616916438410183481.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 05 May 2023 08:56:56 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Fix up Nokia 770 regression (2023-05-05T08:22:59)
  Superseding: [v1] Fix up Nokia 770 regression (2023-04-30T09:22:15):
    [1/4] Input/ARM: ads7846: Get pendown IRQ from descriptors
    [2/4] fbdev/ARM: Fix up LCD MIPID GPIO usage
    [3/4] ARM/mmc: Convert old mmci-omap to GPIO descriptors
    [4/4] ARM: omap1: Fix up the Nokia 770 board device IRQs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

