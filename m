Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD25326472
	for <lists+linux-spi@lfdr.de>; Fri, 26 Feb 2021 15:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBZO5O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Feb 2021 09:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBZO5L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Feb 2021 09:57:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E93664E4B;
        Fri, 26 Feb 2021 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614351391;
        bh=PPJZAQ4QQ5OYqp0RP94k38iy1+YvjTYEPwJJtfNXpzQ=;
        h=Subject:From:Date:To:From;
        b=jN8Wi7a/LI8P3Vz3/0jP1EAsU4UtaAf6YiaXHOWY/QUNCGpOMAd0zZUqA8hGk5vCk
         QlqnUIIaBv/KKL4EtEMoxQqMh6KdfoZWTCa9h84KRqDnT4W5DrDzTECugh2FskNk8w
         i+O9+ChPOlD7UL9vhXEuM84c7EX3dxRIToTa8tKwMlYuVcbAUmiLpuTBLwlTCI+abU
         NrapvPKeYqIyUHdBeDZdWf6VpqRYuzkWni1IQ8GrEOfY2RLnd8nBgmafW3QgyDPZvK
         RYQvi7YuDvuYZxn4sUH1yqa3iglVxFWXoTMse2JV9efuZLNXZEAELE97kytCldGx7U
         MEdpU/4nSlunw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1A07660A0E;
        Fri, 26 Feb 2021 14:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161435139105.7828.14069610643341097740.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 26 Feb 2021 14:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: rockchip: avoid objtool warning (2021-02-26T14:00:48)
  Superseding: [v1] spi: rockchip: avoid objtool warning (2021-02-25T12:55:34):
    spi: rockchip: avoid objtool warning


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

