Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4E3FDD8A
	for <lists+linux-spi@lfdr.de>; Wed,  1 Sep 2021 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhIAN5x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Sep 2021 09:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhIAN5x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Sep 2021 09:57:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B613C60FD7;
        Wed,  1 Sep 2021 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630504614;
        bh=+Hzf1IQEiX9OhnqUcaDgyVjX3UwT97cWpP91aB9BeY8=;
        h=Subject:From:Date:To:From;
        b=XRQDPnMfKGUWcPWnpJJu7VPv3TM33D+hmD31Epvq/uUSOEdvZ11LT/4sIjYpN1V0D
         9pk2kNQR5NFDmYMqtHFnQxrOEyz+CmgMmYg0+46jlKiIlf0hz1Y+o3uOVV07ed/N44
         OERg44ApscHDAnO9Ts525ZUEB8WKjmwthGUfjKFkMk5elYEB9KSueimPWe1HKa/DVU
         wdY0GpubPXtrLg0Lh0g5+Sya/lxuFtVRTmp8fvCziTNCBerpQJjWn1vJabMLRgq4MD
         PD9aT3X2NJZWM8MBwei4nDcT9K/bEuvqI3ZIvXTonMJxYeT0Qo9WCBTYFO1VR1JVMg
         narGA/Gz4M3fA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A95D1600AB;
        Wed,  1 Sep 2021 13:56:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163050461468.26717.15911094382233286268.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 01 Sep 2021 13:56:54 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] add support for Cadence's XSPI controller (2021-09-01T12:35:55)
  Superseding: [v2] add support for Cadence's XSPI controller (2021-07-21T08:11:58):
    [v2,1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
    [v2,2/2] spi: cadence: add support for Cadence XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

