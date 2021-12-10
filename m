Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17232470C1D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Dec 2021 21:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbhLJVBI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Dec 2021 16:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbhLJVBI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Dec 2021 16:01:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAEAC061746
        for <linux-spi@vger.kernel.org>; Fri, 10 Dec 2021 12:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00919CE2D35
        for <linux-spi@vger.kernel.org>; Fri, 10 Dec 2021 20:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28EA2C00446;
        Fri, 10 Dec 2021 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639169849;
        bh=BpkdKXdG76dssLJHIzsajWMdzbAm0TSfu9dGC+2g3/Q=;
        h=Subject:From:Date:To:From;
        b=BUguRwBxs1OySCsZFqFYS27P9rE4t8Fjh/x2Wlka00vS7OZYq3BQ7JxIRzXRJcp+q
         7rtpXhM6Ziz7vX62OECnpnyNo/R4DXrr0SfGilX6iHTt8Z5RYmWUtRjlWZy9oxhRV0
         oxnaosJ2Zh4ro1nPAex5LXvt17zf3F0J/DCpunHg7WHKuLBa4NqU/oJHOqjSgxGpF6
         1MpEK6D9TzHCfrBYohXrXz14bOUPaXBUOCjJZlO04ktuVY60gh6GO7ymwSxMXhsP/D
         h+EbqJnlyEgdEM4iY4Uhgtz4OvNoM5bL+3HFsraSetiB5qD57EayJb99A2nHVwAyHv
         MtQSlvEmB3klg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 116ED60A39;
        Fri, 10 Dec 2021 20:57:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163916984906.22142.8886474130803000112.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 10 Dec 2021 20:57:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Stacked/parallel memories bindings (2021-12-10T20:10:36)
  Superseding: [v3] Stacked/parallel memories bindings (2021-12-06T09:59:18):
    [v3,1/3] dt-bindings: mtd: spi-nor: Allow two CS per device
    [v3,2/3] spi: dt-bindings: Describe stacked/parallel memories modes
    [v3,3/3] spi: dt-bindings: Add an example with two stacked flashes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

