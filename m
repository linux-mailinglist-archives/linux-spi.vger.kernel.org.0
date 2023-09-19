Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F077A63F5
	for <lists+linux-spi@lfdr.de>; Tue, 19 Sep 2023 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjISM4y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Sep 2023 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjISM4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Sep 2023 08:56:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1BBF4
        for <linux-spi@vger.kernel.org>; Tue, 19 Sep 2023 05:56:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6107C433CC;
        Tue, 19 Sep 2023 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695128206;
        bh=B/eiG+GwS7fyqBSPIfkrMvxe3VTw9Y+8gqMVlBBy3d0=;
        h=Subject:From:Date:To:From;
        b=MYJpOarDg8jJrSvuqfilUG69XFkqq8ZLgquMo1pfWJS27sJy5U2ubt1/6f91TIK4K
         PTFBaXnlSuk0sYSpFquXOhD/GftFAGoPNj7b5wGjXj3RqjlEsjvwef4+yheLxoNS8l
         O2FnGbqz0bFUB4gi+3k2oFhXs1Oi9guvApWQhKgwa9z71ZdC8ubWPgyTTNnct2SAc+
         rTgPTj8Z4pyuS+pI3CvWq5HIwWhh99pUbimzgsUoeXJaEL0oD0SRqjfwVvDU5zz1hA
         AW5Z8mVOnE4LC/AjE1fWoMF99LtFBBvLpidp2QfExVzgtZy8gfiGASJrg5kmS5tJeH
         trgKZWdG+g97A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFEEDE11F42;
        Tue, 19 Sep 2023 12:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169512820678.1496.17411753934919684021.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 19 Sep 2023 12:56:46 +0000
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

Latest series: [v2] spi: qup: Allow scaling power domains and interconnect (2023-09-19T11:59:48)
  Superseding: [v1] spi: qup: Allow scaling power domains and interconnect (2023-09-12T14:30:36):
    [1/4] spi: dt-bindings: qup: Document power-domains and OPP
    [2/4] spi: qup: Parse OPP table for DVFS support
    [3/4] spi: dt-bindings: qup: Document interconnects
    [4/4] spi: qup: Vote for interconnect bandwidth to DRAM


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

