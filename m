Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145B131CA40
	for <lists+linux-spi@lfdr.de>; Tue, 16 Feb 2021 12:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBPL5S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Feb 2021 06:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhBPL5P (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Feb 2021 06:57:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DD3FC64DA5;
        Tue, 16 Feb 2021 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613476592;
        bh=67+8COe+caumVthDbzYNFVQoxdnTUi2UJhrqsx2zgz4=;
        h=Subject:From:Date:To:From;
        b=moZitv/EbcJELJMk4mFATtndimD10SYr1qCMxb0btxhbazz+0SpaYVMkuSiZe0++4
         IBdnsgDwAC0gnUgVafVzzn6OQkAPepggn6SWz9s4gzHJGV+yYcVYwC00GBx1qibqE4
         he3IjKoTIYzojbYDoPxg5pZxCSeYCpSTIUTqo5K5AjsSmQSRnzod6KzxbpQpFJ27Q9
         V1flj6eXvVCJ661RYdLCCVnvncG/rDDbv9x9MIBc19uc4xKsefyqmRHyw3fijasWZi
         befSliDeLnTesQDbnhSeuZBzVPd4zAAxCdwl+vKxJxN++rfbHpIJxbwJ7kruoFFRha
         6ftftGcPYib4g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CA32A609F8;
        Tue, 16 Feb 2021 11:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161347659282.25148.5046725233263921155.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Feb 2021 11:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] parport: Introduce module_parport_driver() helper macro (2021-02-16T11:07:40)
  Superseding: [v1] parport: Introduce module_parport_driver() helper macro (2021-02-15T20:23:51):
    [v1,1/3] parport: Introduce module_parport_driver() helper macro
    [v1,2/3] spi: butterfly: Switch to use module_parport_driver()
    [v1,3/3] spi: lm70llp: Switch to use module_parport_driver()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

