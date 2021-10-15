Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA0E42EAC4
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhJOH7B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 03:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236397AbhJOH7B (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Oct 2021 03:59:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E8E8A60BD3;
        Fri, 15 Oct 2021 07:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634284614;
        bh=zhLXD2TrgdHkgkmigmJ/QdvW/5MgixcGAteUwoLAfM0=;
        h=Subject:From:Date:To:From;
        b=Nxv/SAi0pAAQPaVcQLeRVCFWAckv4BRX7FRInithli9nCq0bzD3kiI94cok8nbjfx
         l1chUqXNmEnm55ap+G3QA2uT2tKjKP2DkpUAa19VRS8m+0VuuC6l/+oGmHOt+Ea+vv
         m8FM158XzC/sIMYHrNJ0Up1ncaawVtq97LDWyliDmYvjLXJbK0Lf8bGFIcoAx30hpT
         H8eFKNdldFj41hTCXWrBxhWa2GdNFnMq/1DM2HucugQjsb+kuyQQhjtzlvCrS168A5
         F9NwMSHBvPKjtBEQBNj+FFTvTFeVIBKPNeu61dx7BaeVFcsGnElukfGlcm3RZlkK7j
         JaiiA+PBLo4BA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DD42B60A4D;
        Fri, 15 Oct 2021 07:56:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163428461490.9855.4569687416413631563.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 15 Oct 2021 07:56:54 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Let spi drivers return 0 in .remove() (2021-10-15T06:56:15)
  Superseding: [v1] Let spi drivers return 0 in .remove() (2021-10-14T14:13:40):
    [1/2] net: ks8851: Make ks8851_remove_common() return void
    [2/2] net: w5100: Make w5100_remove() return void


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

