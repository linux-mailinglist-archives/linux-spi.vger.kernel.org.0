Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D284A2BB0
	for <lists+linux-spi@lfdr.de>; Sat, 29 Jan 2022 05:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352411AbiA2E4Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jan 2022 23:56:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41160 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352399AbiA2E4P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jan 2022 23:56:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC8B60B52
        for <linux-spi@vger.kernel.org>; Sat, 29 Jan 2022 04:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48568C340E5;
        Sat, 29 Jan 2022 04:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643432174;
        bh=jgU8PA8ChOfvdAc8lKNmFWX2+9grvJCDj3nxr/P2eAs=;
        h=Subject:From:Date:To:From;
        b=jzZYo4W2zlfCFue20Do8C8VF/ee9P5aXKiuz+fFcX7ez4V++1/7QKyJjA7zrVrqHy
         GjYzGWbMi6p8npGmd7DiZUJQgZ+4ZeAfMbEIOhFckgV8kJyQgjVDu9MggrsFgBP4mr
         K7iTy3o9YXZYF1dqT96gYArOCmKCS4Cd7PHjE1JbFBV9aXxl46VK4moix1J5AGOLE6
         rNVmOEi8Vl7H35wbY6od5NULhtL2gTzpIBF/YZYGkFoT1EhHStgdYWkU5R+rhdEbjv
         zPm3Y/kK6WtZwlXeVO0m/KKqaPMfFAZ5Iwg8DeJVV0/Gi+7Cx9VL7JqGOSPhUTr6Sy
         VoEo3kdTnansQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3519FE5D084;
        Sat, 29 Jan 2022 04:56:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164343217421.31239.2901453163057092568.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 29 Jan 2022 04:56:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: ath79: add mem_ops for fast-read (2022-01-29T04:04:53)
  Superseding: [v1] spi: ath79: add mem_ops for fast-read (2022-01-29T03:40:47):
    [net-next] spi: ath79: add mem_ops for fast-read


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

