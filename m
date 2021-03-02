Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1A32B4F6
	for <lists+linux-spi@lfdr.de>; Wed,  3 Mar 2021 06:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhCCFrV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 00:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241889AbhCBN5P (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Mar 2021 08:57:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A468664EE4;
        Tue,  2 Mar 2021 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614693386;
        bh=yL22Xjzx/LSZxI9GKqJZob7d0zLc7rHmryI6SX+PYJg=;
        h=Subject:From:Date:To:From;
        b=BEieweuIi+g9+pxPyAvk0BngfNYe3agO1GJvNZwHMJA/Z4eJmprU2w12330YasQN3
         6jGUcKl2seZOnjZLLfI1B9JslItJRcxqv80rozlHRCWqASXTmsDsddSDzE6DratKEw
         Gx3WUv63bibrEhNvCX5CpXCEciKIwAyOa+5IRgD1X1pYhSO58Nky1Wx0yadd0OaOTt
         VGigxNRrIsf/XiuIfgMe7ByhKavLeecXXLdSPq2RYe5SLu9WnlnCKSZ1mISsYv5x2g
         /VJLhsj9fIqb8SRdp8mhP0Ad9uUchdIiqt3zDnZv1X9oCjIMhc5iFTf3XVt8flYXTo
         HNX0mvX8FvMnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 900EE60191;
        Tue,  2 Mar 2021 13:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161469338658.11356.18168011186034104626.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 02 Mar 2021 13:56:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] NXP Flexspi driver patches (2021-03-02T12:49:32)
  Superseding: [v1] NXP Flexspi driver patches (2021-03-01T10:32:27):
    [1/3] spi: spi-nxp-fspi: Add support for IP read only
    [2/3] spi: spi-nxp-fspi: Add driver support for imx8dxl
    [3/3] spi: spi-nxp-fspi: Implement errata workaround for LS1028A


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

