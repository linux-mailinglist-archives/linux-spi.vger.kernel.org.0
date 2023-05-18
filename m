Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1C707D66
	for <lists+linux-spi@lfdr.de>; Thu, 18 May 2023 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjERJ4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 May 2023 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjERJ4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 May 2023 05:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2ADE
        for <linux-spi@vger.kernel.org>; Thu, 18 May 2023 02:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0710B64D87
        for <linux-spi@vger.kernel.org>; Thu, 18 May 2023 09:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 634A6C433AC;
        Thu, 18 May 2023 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684403805;
        bh=TsyuF6HF2KMTk2lFtjUTs2ZBm1uyuhJfm02VRPVQQ7E=;
        h=Subject:From:Date:To:From;
        b=AwwJViiW3qXqDDE1nPTiRAF7rBFubIuPFUllgXXnwpk4AJL7xiGTjYCKm5EdPD5BV
         QxezO6YTDi3jSj9GAnE/Zn8YeYx3ELYzzMaKm/xpERZMAaW/j78PqKslUpFjur7Yeg
         sh+Mn1VVbAvWuexKHMBWWml3mMXBN1QpK+OGd36jOvs08+WOdqb78Ci67zeu0a5kfP
         DJrwAdjK28Mfy12GMhPSXhP+BDmFH5JydpQ/upl07S4rAdzdlXh4+a+QSdh/xyWh+K
         3WASJ/1+JtsWUW23/xJ9OjDz42x+V2p7iGMs0uDlTJiLaq+22QJAvxeCqSXB96EqD5
         Iq9a202jVmCvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AC72C41672;
        Thu, 18 May 2023 09:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168440380516.7688.9142796661391250388.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 18 May 2023 09:56:45 +0000
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

Latest series: [v1] spi: spi-cadence: Interleave write of TX and read of RX FIFO (2023-05-18T09:39:27)
  Superseding: [v1] spi: spi-cadence: Interleave write of TX and read of RX FIFO (2023-05-17T16:31:57):
    spi: spi-cadence: Interleave write of TX and read of RX FIFO


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

