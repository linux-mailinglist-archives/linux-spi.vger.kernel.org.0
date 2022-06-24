Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C4855A404
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jun 2022 23:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiFXV4g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jun 2022 17:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXV4g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jun 2022 17:56:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E987B7A
        for <linux-spi@vger.kernel.org>; Fri, 24 Jun 2022 14:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15443CE2ACD
        for <linux-spi@vger.kernel.org>; Fri, 24 Jun 2022 21:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 542E2C34114;
        Fri, 24 Jun 2022 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656107792;
        bh=DORMR/zB06Zk/Q1dMWUmzX5W/HWouKyDAo9U2p0xKlk=;
        h=Subject:From:Date:To:From;
        b=YLsV4K3YgJPCSGEuo6BLSaYS923mXVGptLFRc9243rDrkDOmNwv2cp2msKaru0bh8
         2z2XSEcfIAOpFAFTarwOIl9tDEtdsYQd5nFjdgI7VkUoDKZtjpsgQzVVCe93ipilY/
         1wNIJIlvv3flgAvT4ZU3dF4zKiLb8r3hLvrtPpgl2OjmugN5H74fECmud51ztR15B2
         vbqWWCkoPQxVLHbbVmbkBFZoGJhYQReL3WkfrmHCoxSHXb2JVQVXK4OE7wEhqWGZA5
         RpxuVFKeB8d1yi91FZ0PbmuOv7ke4Gj/InQAjbfV38bvIbRb1IjSdWIYGsuFgzQS3k
         +nBn9aqQC2boA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B80AE574DA;
        Fri, 24 Jun 2022 21:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165610779208.3820.2400567844583216723.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Jun 2022 21:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dw: Add deferred DMA-channels setup support (2022-06-24T21:06:23)
  Superseding: [v1] spi: dw: Add deferred DMA-channels setup support (2022-06-10T07:50:06):
    spi: dw: Add deferred DMA-channels setup support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

