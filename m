Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8C458829
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 03:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhKVC74 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 21 Nov 2021 21:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhKVC7z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 21 Nov 2021 21:59:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EED5860E0C;
        Mon, 22 Nov 2021 02:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637549810;
        bh=12qddwFgdjfo94KuAKMW87RP0j4nfWnucSYYzWifX5Q=;
        h=Subject:From:Date:To:From;
        b=N5ZnbiaUiGYDXzF/9l/YwtGEtc8yJYimM4+eipdZcginNuTSTbUIqDXgw33CM+SHs
         5YRUl7m0+lTNYykBBB8drZEPO6XvDO5zR0lmwis/vRCoLXHdx86KNzYpaxBKjSY89c
         tw+dhMSr7d345PvQeC0zoPOWQ0OPawP9TOjtxUsLMXyvr/8zXuiz4NyjKBXfU1ij9Z
         PKv6nq3X6Qi1n2qC4nhvkvB0kT12QmKF/8XaTJI25tX0gryYICnNXLf3h4hiQL6Bs1
         pTf3TnpptWcP0pE3OYESL4CIJeI28ELLszvapYYiNAsrRlg+1ppopLH3gdlrj4Kg8a
         b/ybI0sSJCSsw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D84A760952;
        Mon, 22 Nov 2021 02:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163754980982.10955.17693567445880760180.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 22 Nov 2021 02:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add SPI control driver for Sunplus SP7021 SoC (2021-11-22T02:33:31)
  Superseding: [v2] Add SPI control driver for Sunplus SP7021 SoC (2021-11-09T09:01:26):
    [v2,1/2] SPI: Add SPI driver for Sunplus SP7021
    [v2,2/2] devicetree bindings SPI Add bindings doc for Sunplus SP7021


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

