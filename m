Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7304D4C710F
	for <lists+linux-spi@lfdr.de>; Mon, 28 Feb 2022 16:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiB1P5F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Feb 2022 10:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiB1P5E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Feb 2022 10:57:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3386513F97
        for <linux-spi@vger.kernel.org>; Mon, 28 Feb 2022 07:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C28C161137
        for <linux-spi@vger.kernel.org>; Mon, 28 Feb 2022 15:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 376B9C340E7;
        Mon, 28 Feb 2022 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646063785;
        bh=zu2WWqch4ZJD2EvotHq/eD9bVmGn9sEUG9fuzSfMQ4g=;
        h=Subject:From:Date:To:From;
        b=idApx73Mvyelee28d/sycqznRgWWS/lVdEBd2DVddElY5ZlGubUeSIYe4B/71ocSk
         giaRzBbWINMnoyg9ywJoYrrLMw4b1I8GIVcGIYmeQ+i1UbjMTUYbHeen9cDsx6+Soy
         neS/3m8nDbHgjFk27He1HuuTqLoCsiMjKMgRN8rMr7p6AcB6dTFBW59xiNE7P+ofNJ
         f4QLtGoXYXGnMkid1ZtsodgL1TtvHUHVp3s875Xn0qb2s8VkKGBoL+HiDyAHnYU02w
         juOwfKczlB8aklFrzez0g4IAHIUinUaw0Nr6W7MMkvp2Egqtum/YUn0SKSFwc/k1C/
         AkPsNDsWc+csA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14D02E6D4BB;
        Mon, 28 Feb 2022 15:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164606378502.32200.18046201322133493644.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 28 Feb 2022 15:56:25 +0000
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

Latest series: [v2] Add support for components requiring trailing clock after transfer (2022-02-28T15:15:46)
  Superseding: [v1] Add support for components requiring trailing clock after transfer (2022-02-27T10:00:33):
    [v1,1/2] spi: Add new mode to generate additional clock cycles
    [v1,2/2] spi: fsl-spi: Implement trailing clock mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

