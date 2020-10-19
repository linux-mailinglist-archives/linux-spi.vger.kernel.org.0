Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB73292AE9
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 17:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgJSP4I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 11:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbgJSP4I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Oct 2020 11:56:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603122967;
        bh=3bEodLi5qYzVKpGNbbjVSRy7zgHZoy1is862tAMAqv8=;
        h=Subject:From:Date:To:From;
        b=KlzsC8VjaDcD9NB26xnWxwxgAJMIYtyvQipJ7HqS97CjBTDKr/uAkB5XRZctrtPhm
         uPfQH1uafVBN//I0tRVQb86/OUSghlDQufGI6NIdnGjNzxWKsC2SmM2p4M10HkjR/Q
         cihbShsvtCEMX2CqGt+qtNlcbsLDdl7vLrJ4AHfo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160312296749.18812.7229956722538811565.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 19 Oct 2020 15:56:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-sun6i: implement DMA-based transfer mode (2020-10-19T14:58:33)
  Superseding: [v1] spi: spi-sun6i: implement DMA-based transfer mode (2020-10-15T15:47:40):
    spi: spi-sun6i: implement DMA-based transfer mode

Latest series: [v2] spi: spi-sun6i: enable autosuspend feature (2020-10-19T15:03:43)
  Superseding: [v1] spi: spi-sun6i: enable autosuspend feature (2020-10-16T08:38:26):
    spi: spi-sun6i: enable autosuspend feature


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

