Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4942CC028
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 15:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgLBO5U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 09:57:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgLBO5U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 09:57:20 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606920999;
        bh=AqwDbHV6pFmyn18lGtNot1uyKd/xDQjZwY9FcP0yLFE=;
        h=Subject:From:Date:To:From;
        b=OUEAdUWOYLetnBvgCvuwkBFO0RHphRYHUE2vLznULpG6l9NdUU3iey+YiG1PJ5CYV
         0lhuZ2KOeWGu+JyNhugNX1ZZUwDdKAbhzU4003sXUtLNt9W1N9y3LgXRCDiD8FH3mg
         l9QJLu+YMR1d9T0WQEDjdsNWuXhrhsZzxripicK4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160692099980.20315.17860552458464183026.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 02 Dec 2020 14:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR (2020-12-02T14:25:52)
  Superseding: [v1] spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR (2020-12-01T08:59:16):
    spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

