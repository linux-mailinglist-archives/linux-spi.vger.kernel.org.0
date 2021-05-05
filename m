Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3E37477C
	for <lists+linux-spi@lfdr.de>; Wed,  5 May 2021 20:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhEER6A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 May 2021 13:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhEER5o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 May 2021 13:57:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0C2D2613C3;
        Wed,  5 May 2021 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620237408;
        bh=QKuqCq2rp2rA/n9sdleMb9bXmShxVTnmSxiELcg6CBw=;
        h=Subject:From:Date:To:From;
        b=lp+VsGtDc/sf8LqRGxFD4ZIot9UtgHj3LWuQD6dHEb7BKU4G9BwzDVNVbU6riaqEh
         2Hn6h3Dy9m9hSGAp0j94pG6MZXnvg/9xXkV/q3qfHGj1X3ow2vdm3lkeMTApjT03wD
         e4R2OlnYz4v3YrZRr3ZTjFW4p/jKw4aQ8O7HKBVZPvI6EbFw3FHC5K+E+rVuScfm4o
         JBHwC7pQ45EdpDdwpUbxf0MVGjwaGJfynPhtYJV8RZCB0OkGY9vABivH/udP3Gq6KH
         sMG/I1Iwt1/9qYRQIHCb3zlCdsz+ekAAbLWuhfg8jpPvX7VlJinM2kj9Gqny5rbP17
         UND7yLn1jT4DA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F23A4609AC;
        Wed,  5 May 2021 17:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162023740798.898.8102206225185315688.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 05 May 2021 17:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Don't have controller clean up spi device before driver unbind (2021-05-05T16:47:34)
  Superseding: [v1] spi: Don't have controller clean up spi device before driver unbind (2021-05-05T03:14:16):
    [v1] spi: Don't have controller clean up spi device before driver unbind


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

