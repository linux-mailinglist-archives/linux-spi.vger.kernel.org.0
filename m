Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA80469485
	for <lists+linux-spi@lfdr.de>; Mon,  6 Dec 2021 11:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbhLFLAq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Dec 2021 06:00:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43454 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbhLFLAq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Dec 2021 06:00:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFD2EB8104F
        for <linux-spi@vger.kernel.org>; Mon,  6 Dec 2021 10:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EF27C341C2;
        Mon,  6 Dec 2021 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638788235;
        bh=ivGnOeTJWYqhZu8su3d1rVvm8yPFfXyx5U+Y2z5z7X0=;
        h=Subject:From:Date:To:From;
        b=FOiji+RgLQGBkKAXT6Irxjt/Q0h4AqMZDrdF+xYZrLh1JNts1EfJmQUPGO5bkBlWn
         mFvBnpWi/yW05rSXtiauRLf97UmT+D0jjg87hBu+3Ne0hH3A2bxRwgz/BaaVgVklE0
         r7p376yVw1033uTafpaEr6wpcRD2QYqDIXj3UrwMVRRWE/fa2Tg9nIfJYcQclYAbm9
         FwNPIHCOfGIdnBiVo8UFvrhMIisx1z6hcweQitVJk/q5wYjwf9dlNw/erXshhsR90L
         RKUPcLCpmCZEpM9TAQEfNgyjp18AoGZdQaaWuuHkvP1AXZFvOkNr6qBl+znPlNRWkV
         PWs6KP/j9qaHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5F3A6604EB;
        Mon,  6 Dec 2021 10:57:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163878823538.14642.11348410235993983363.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 06 Dec 2021 10:57:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Stacked/parallel memories bindings (2021-12-06T09:59:18)
  Superseding: [v2] Stacked/parallel memories bindings (2021-11-26T16:34:45):
    [v2,1/5] spi: dt-bindings: Allow describing flashes with two CS
    [v2,2/5] dt-bindings: mtd: spi-nor: Allow external properties
    [v2,3/5] dt-bindings: mtd: spi-nor: Allow two CS per device
    [v2,4/5] spi: dt-bindings: Describe stacked/parallel memories modes
    [v2,5/5] spi: dt-bindings: Add an example with two stacked flashes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

