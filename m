Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24C249C922
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 12:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiAZL4P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 06:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiAZL4P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 06:56:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C6AC06161C
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 03:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46256B81CB7
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 11:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13573C340E3;
        Wed, 26 Jan 2022 11:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643198173;
        bh=uMdHu9zVXlP9K9XZNX+9z1taG6PqnsTGsjIK4cZMdJ8=;
        h=Subject:From:Date:To:From;
        b=Q2Zi5l4HjSGAGl8rT1Qm7b1zqGlzG+Cq/HnaI6ZiKj67JTPdcbZTz2Cgv0HMElWgo
         9Qx+iSMwriWDAE/bLUo/bGYl/pdGhAj3ht4ggh6ysfNNoAL796cMku6rPjXrD0UHNn
         zwhfKny98Od2UrXWagGcSi1+JTVGf69l6zlvwCWgC1vArQ5exb5jWJg4SqxP38xh+n
         Wo/ApAdpJs1LZuN7mDu2wWlRLDjYTNhhj8O0GH4Z1U//JH4Veq7/9PAYjgLr0JmQNg
         ToQbVCJ1DMSpj52UDr9vqnjW2dRLVsjHduAWYyKG+tO/C4EkyHZGJHl2V4zjK5fPEy
         fOo2WHNInmTZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF522F60797;
        Wed, 26 Jan 2022 11:56:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164319817282.14924.3245635065114050751.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 26 Jan 2022 11:56:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Stacked/parallel memories bindings (2022-01-26T11:26:04)
  Superseding: [v5] Stacked/parallel memories bindings (2021-12-21T17:00:55):
    [v5,1/3] dt-bindings: mtd: spi-nor: Allow two CS per device
    [v5,2/3] spi: dt-bindings: Describe stacked/parallel memories modes
    [v5,3/3] spi: dt-bindings: Add an example with two stacked flashes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

