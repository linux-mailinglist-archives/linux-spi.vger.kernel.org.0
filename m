Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8CD33236C
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 11:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCIK4Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 05:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhCIK4Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Mar 2021 05:56:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E80F56522B;
        Tue,  9 Mar 2021 10:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615287384;
        bh=eS1ezS+pUdjVy4QFIJBGzaBiTrKqFAXKfFEmJ2Wr0Dw=;
        h=Subject:From:Date:To:From;
        b=Ib4ecHZga4pGXNfyPCzVrbqy+Ddstmr6iixkoSXefSkeZPq0yQ8rvD01puyCzH1m9
         dbA9vkK/Jy7bAmHwDXHGg4bEO7Faw318mc+Mj7NwazcIuMh/RuWRyREJOGFVdMjjRw
         vag4kCcdC6nvA5M2oLsX575xbRUQ383Kr8daDc9SZrBZLzDYETk0I07T1XY+P1FNG5
         dh73VAVA/oIOMl+s/BQvb3xE06fQngSvew1cyohUlJI4ReQwVdJk+Xi1bqrzaQDlId
         l9+rz4WKGrKfu8veWlXfiLk99CaMudXqWkQH9/+Bt00SBasILm8xfAYKiyjTVy5kj8
         wJEzSX3u7FlNw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D73B160952;
        Tue,  9 Mar 2021 10:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161528738487.31773.11614601203521686000.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 09 Mar 2021 10:56:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] dt-bindings: spi: Convert NXP flexspi to json schema (2021-03-09T10:35:28)
  Superseding: [v1] dt-bindings: spi: Convert NXP flexspi to json schema (2021-03-01T10:04:06):
    dt-bindings: spi: Convert NXP flexspi to json schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

