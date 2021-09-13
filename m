Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0710408B68
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhIMM6F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 08:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhIMM6F (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Sep 2021 08:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 57ED960F4A;
        Mon, 13 Sep 2021 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631537809;
        bh=rwpr11zQYny110HzwaGnI6jEOzXUOsUDDTJmS5gTU6w=;
        h=Subject:From:Date:To:From;
        b=MVl07+ODuHQzNH19pMaMrEPunRHmxQB7foFBDSxWcNEVG5zxh3PdIh3QDxvBrdttf
         hQoleqcFUBJOeulzV54nAmVIWV28CNtUmtQp841x32rkfin91tCnvsGWODuzKkTmEJ
         bhxtNw55YlCYuKks+Y0zUJIG4Na/1mJw7BWmEKZ2XX/ncAwwNNEooNyyGtv1iYXreq
         Esl9yDHLyzR3QsoO28hX1Px8QFgComdB212OCOF3Np1AoGjqQ9QRxkpi7htspY2J3r
         c7dDHF7ZsjhGv4ZZj9MnU8J6LMSWiagWj17Bl/4g1Pl3i50L9omFAGZpiQ7SKmdorY
         XMd5PXaXEvlpw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 44A7960A47;
        Mon, 13 Sep 2021 12:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163153780922.18392.13469567553597215591.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 13 Sep 2021 12:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] add support for Cadence's XSPI controller (2021-09-13T12:02:38)
  Superseding: [v3] add support for Cadence's XSPI controller (2021-09-01T12:35:55):
    [v3,1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
    [v3,2/2] spi: cadence: add support for Cadence XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

