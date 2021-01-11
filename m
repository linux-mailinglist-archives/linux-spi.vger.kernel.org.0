Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673582F10A5
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 11:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbhAKK50 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 05:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbhAKK50 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 05:57:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0075B224D3;
        Mon, 11 Jan 2021 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610362606;
        bh=iAMofg0vSyL4UVDFO4ukRUmmd/CNpDli2THXZAJVLjU=;
        h=Subject:From:Date:To:From;
        b=uq47CBEHGA3iXtubfD2ONA2Pi/w465r5Ttmrq/MqMOXRgCYDRtDGfujgqf7e/cjvT
         PxEgqJFgj3qoGu8IJMlr4ufMsJfqgY7+/B2nM0nEEIs+jTP2r1W+3J71GzeAIyOkcj
         C+U1/L1DdHTZRX0aRU4mcwHPeajgJf/oB8bt+vsECfQ94kdJjaxgKY/TaivUG04kY8
         IAXBCRLSbuziUfhKZhq69ArdoFdIFauVqdvZgmHHIPAwXTvdxqM40gPKKXcUnwmzsd
         5a+/z6RCRnE8SsABGdVcZj5CteiT5BWUJHN0sI6wK6sSex42qkjszsGVXFrwoulySJ
         NqMCf16wypEWQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id EDF8160188;
        Mon, 11 Jan 2021 10:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161036260596.6052.16715988070469489963.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 11 Jan 2021 10:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-bcm-qspi: style: Simplify bool comparison (2021-01-11T09:54:48)
  Superseding: [v1] spi: spi-bcm-qspi: style: Simplify bool comparison (2021-01-11T09:26:29):
    spi: spi-bcm-qspi: style: Simplify bool comparison


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

