Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FACB34E80F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhC3M4i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhC3M4h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 30 Mar 2021 08:56:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4DAAE619B4;
        Tue, 30 Mar 2021 12:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617108997;
        bh=hsaN2NphpJ0YTFC5nJH3mUtw2ND6DRtMWCr/slzoWMs=;
        h=Subject:From:Date:To:From;
        b=mGPUDHLxMUHypEqljTqU3Lz3yIFJWA7Wu50DsioIqc7wBenTBubu12jFzRB1eH6Px
         XsSCwH/6YMS+YU8LEk7N1nNypTSP4eGH9F87YYF1NBOj66a4ybsNrVr4sXrtbUlP2e
         I5PRkBYNAHh5Eo6zpNgu68OWUyCCaVv5RCz1qRtWWzGc4LJbnXQIrxY4greY4Xo4V1
         WPros6A0cfVNua1gH/EYsDAq66RbGI+xoa3/7NjwlVslNJg90chqrneATPlvrMvwMT
         PREDJGe5CUJDOVmm9x69PCndb2uupYMC1pbvZJIWt55PII0HJsoi3pi7DvlnnlezUF
         CpJLoBf7iXIPA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 418D260A56;
        Tue, 30 Mar 2021 12:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161710899725.3595.16029364692384657914.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 30 Mar 2021 12:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: davinci: Use of_device_get_match_data() helper (2021-03-30T12:31:14)
  Superseding: [v1] spi: davinci: Use of_device_get_match_data() helper (2021-03-29T08:58:36):
    spi: davinci: Use of_device_get_match_data() helper


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

