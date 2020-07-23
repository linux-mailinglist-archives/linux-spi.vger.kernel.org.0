Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9066522A41F
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jul 2020 03:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGWBAT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 21:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgGWBAT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 21:00:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595466019;
        bh=9bmCwnddyC3BQExaGAJRrYWFQos7oDMKTjXgLa2jpw4=;
        h=Subject:From:Date:To:From;
        b=JZdkDAr8OoLtqVBpxQn+1sS24+bIqyOIp2ibaGKaSQqv1G30zfIgM1L76cbESD0JI
         csa9FotKU28WmtIXP76z65l4rJcq2Fny7IC8amFtdJ5nKfDLLoknfZF5V4ciYpj7mi
         K8Ts6a+r8VJQ4+ztv6ND2lbtiPqLsGqjyF7BzqVE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159546601929.19640.16589000639023511075.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 23 Jul 2020 01:00:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: rockchip: Config spi rx dma burst size depend on xfer length (2020-07-23T00:43:54)
  Superseding: [v2] spi: rockchip: Config spi rx dma burst size depend on xfer length (2020-07-22T08:37:37):
    [v2,1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
    [v2,2/3] spi: rockchip: Support 64-location deep FIFOs
    [v2,3/3] spi: rockchip: Fix error in SPI slave pio read


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
