Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717B540F3A3
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbhIQH6O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 03:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240123AbhIQH6N (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Sep 2021 03:58:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2357E60F4A;
        Fri, 17 Sep 2021 07:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631865412;
        bh=kM6fC4xAUx01OFSkIN+RTwJX5L5KJvXc8ZcSz86RUOA=;
        h=Subject:From:Date:To:From;
        b=GWrGmacjkLn0EFYgFEYo6zX2taldAWlBpyVfU3GERHohZOYeS1Ufcj5PDXGf9Bks0
         2jgrz2JplF/33HKmlruTgF7RIOh1Ct+0kmno+JeDa6e+TcJJL4gxcto5a6aKG7emYx
         uM9ywvpF6ybMRhKNZ6znO8lFTa9Dd+otXQYzC9717F0rN6uDimjIGAki7GhTOopogB
         KG/xrIEsThWCK8iq5dLkhAE3nwD7wjj3OkNYSprZV19OVDWoKvuqI0bJJFbmq/KgG0
         ihWjgekonxs3jBdRHtCyAxRADsc+1jADp8BjGZZceBeLRm9Bxrk5/6cfsezZK3Tv54
         MRrEdyyceKvDA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0FB4060965;
        Fri, 17 Sep 2021 07:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163186541200.25942.7988972678915938052.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 17 Sep 2021 07:56:52 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: atmel: Fix PDC transfer setup bug (2021-09-17T07:46:11)
  Superseding: [v1] spi: atmel: Fix PDC transfer setup bug (2021-09-16T15:16:31):
    spi: atmel: Fix PDC transfer setup bug


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

