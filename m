Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E03DC817
	for <lists+linux-spi@lfdr.de>; Sat, 31 Jul 2021 21:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhGaT4t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 31 Jul 2021 15:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhGaT4t (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 31 Jul 2021 15:56:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9045060F35;
        Sat, 31 Jul 2021 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627761402;
        bh=Q5WJnh9PL+WxmgYFhCF3V2qmKI+Ewg57M2MIk7zVkGM=;
        h=Subject:From:Date:To:From;
        b=EZG+tQJ61j0QNJppGmdHRtsqHjLaF3sGa+Cyg0tM6ewqqYmLgSs5paFMqyGegZDoF
         z6BS2up7y/v9uZVb3+CUuENpJsN1Xd4TQ7f7Nlbz2Ogh7eUYoApDp8TAyuqnG9aSfO
         4hsfpQ7R7uSx40KcQoOayaapHHcTjSZeeTMr5gabunOQiq9015lsWMvgnyZI32zA51
         8UWDxiEeH4pHFTEA2A9FaTSJOwxg7RHiGf+ugmNP3t9mu9AU9hDnW9nDrIxz4xRXib
         eB1BNh+bz8/fROZF1wWUgWjFllcyQenffjqhJ+96nIX2QpQ3dp5qXbgZu3P43kwDy6
         7Pi61qIGHl+xA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8979560963;
        Sat, 31 Jul 2021 19:56:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162776140255.16142.17040165416324546814.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 31 Jul 2021 19:56:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: tegra20-slink: Improve runtime PM usage (2021-07-31T19:27:31)
  Superseding: [v1] spi: tegra20-slink: Improve runtime PM usage (2021-07-31T19:14:57):
    [v1,1/2] spi: tegra20-slink: Improve runtime PM usage
    [v1,2/2] spi: tegra20-slink: Don't use resource-managed spi_register helper


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

