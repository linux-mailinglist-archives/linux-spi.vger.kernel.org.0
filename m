Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCEE44D394
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 09:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKKI7q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 03:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhKKI7q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 03:59:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4D2A361884;
        Thu, 11 Nov 2021 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636621017;
        bh=kUJ4kRtfw6oT5glL/N28p/AOLKqvzvcQhEFtA5G/ot8=;
        h=Subject:From:Date:To:From;
        b=Ud4BQpHsBoeCtp5MYXdIeCxDttgaTMavILsS6nH/jRFvAxnFfssYUZmRkWexi0AlX
         XlwJW8PLkenwuG5Z/lhwky4STlz/fAiFXmLJyDXBVIhodRG6YVqRNG7bHJPE/dcr+1
         bbIPSBP2h2yjT4QuU5MnazVXm307LvEQJeNiNznsVWstFmlOrhvoYq5UTlCcM7JYlj
         92YkwCyHv+xGp5AXVK8LpLkbHgtGiUPoJ7nQwXQXaRZzoUigdvVD3Rh3ZbHhRQe7q4
         WmlVtRns3Bp7VqCHB3ISK4E6vKBY/0cbnmWpB4YJfvQ+x2t1Nd7Ji8F33JHgviEZ/l
         6KxhqARUm1Rlw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4118860726;
        Thu, 11 Nov 2021 08:56:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163662101726.19262.15981380141034499880.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 11 Nov 2021 08:56:57 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: fix use-after-free of the add_lock mutex (2021-11-11T08:37:13)
  Superseding: [v1] spi: fix use-after-free of the add_lock mutex (2021-11-10T16:08:36):
    [RFC] spi: fix use-after-free of the add_lock mutex


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

