Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61C2E8F4C
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 02:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbhADB5U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Jan 2021 20:57:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbhADB5U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 3 Jan 2021 20:57:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 96D0120771;
        Mon,  4 Jan 2021 01:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609725399;
        bh=NdWn5Hh/jllnWcGWiT3/gx5LVzhMfSwuKe9FJf9Qwfc=;
        h=Subject:From:Date:To:From;
        b=s0L6/SqFz3iYrFeZjX4IKd+TjFK5CameJ6FxBYUYzed4yrevczv75NAHx2hMY3wxL
         uuY0ncUarzI/A/ysdEWsbEYno0LSsfUbNZOlVQZVySMYHRH5mD1NlH1iMB/W+n677Y
         cT32MaEVE+9I05RRh6wthNO3jzIvMNhgbeheWQi4ZKgF/W8adH+mE3uSOwk2akRthB
         TJ3VLqzaauy6vGbBWzwEDBQQ5lZSplmekcmIX/sVTFqqOdPlK3SCHdWMizQ3SvzAdA
         GVXtsaEwjFFvPIIymcfUQfp/jqNvIAGA+yjVCS8I4EBJiGQl7jav5S7M5NiZxiiug/
         014s284On4AwQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 8167660387;
        Mon,  4 Jan 2021 01:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160972539945.5770.6342375627861976552.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Jan 2021 01:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: fix the divide by 0 error when calculating xfer waiting time (2021-01-04T01:29:09)
  Superseding: [v2] spi: fix the divide by 0 error when calculating xfer waiting time (2021-01-02T02:59:46):
    [v2] spi: fix the divide by 0 error when calculating xfer waiting time


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

