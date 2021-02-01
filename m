Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A449730A2E9
	for <lists+linux-spi@lfdr.de>; Mon,  1 Feb 2021 08:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBAH5U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Feb 2021 02:57:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhBAH5U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Feb 2021 02:57:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 00D5064D73;
        Mon,  1 Feb 2021 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612166200;
        bh=Ux6fuqsZPxFhpQXMA/qFaAmbA9Gc8+b86GC+ksLK1gQ=;
        h=Subject:From:Date:To:From;
        b=W8wkoqU6eLJP/OBRsr1/JbbY7GiAMCeNWT1kZt65XQp02xeVDkUKkdLE7R6hzkqJA
         6BV9WE7u/z+CCyTOrFyxh5eMGfMCKt6Cu3m+uLO365OWOr8Ztk42IXM0HgbYWFbmsF
         Pd1MEtmccNFq4PEWxkAACrTcy3Au5DJx9goClD7KwEnwevFFlPCg102P8CHCJuqjDb
         Dj9EAPOySepjkkOmfVMEP8umZqsczNyJRbTbbDTPQqbFmvYkofH2M1IPBJaLw1e/Qo
         zrDya7Rh4ii/Y2e42rAM56BoEDCY7D8OC6GG2xAZB0Y2a5GO2jjLbnICNL+mnalKX0
         68Iys6fzt8z8g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EB81960981;
        Mon,  1 Feb 2021 07:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161216619995.14126.15907261966634702688.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 01 Feb 2021 07:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-synquacer: fix set_cs handling (2021-02-01T07:31:09)
  Superseding: [v1] spi: spi-synquacer: fix set_cs handling (2021-01-24T22:17:55):
    spi: spi-synquacer: fix set_cs handling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

