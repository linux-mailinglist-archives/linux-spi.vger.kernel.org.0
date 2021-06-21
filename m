Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89A3AF5B7
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUS7G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 14:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhFUS7G (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Jun 2021 14:59:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EAFE560FF2;
        Mon, 21 Jun 2021 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301812;
        bh=t48HDk3uuzFNtQJOCFm/WULquyZrgoZo9Mhly/Ng6BU=;
        h=Subject:From:Date:To:From;
        b=GY4hk23hY0UzULtcc1fCehGc9ndj+FRZKndAugLJ1RLLiuvGvtcr2W5keFFD6rrfU
         rNZhSitTaUhE+hDH4249UeacJGtxHQd1vH72tWLDH6QSRVFpwT88Gz17KwMZjvmxYF
         HF5Hu/NwHumx9T2AFlMBcc7OnjG6CDtYs2E5OpdUsNhbwgoe8dBgB077L3kf9jQukK
         wW8hqOr898fFH/KC+eRMiSXZvxdRufEA0XFcZZJ1oGjF8uLhuxaVODyt0fmcso0Y2V
         i+73oOwtKQ6rMQl3+o/Ry3AEYo+53bBtUIngn8oGSEhaEt5UtLIgCScYmwYSyupkoi
         5uBXNRzFS1rew==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E2CE4609AC;
        Mon, 21 Jun 2021 18:56:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162430181192.26838.7592825110144622379.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Jun 2021 18:56:51 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-06-21T17:53:55)
  Superseding: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-06-09T15:12:30):
    [PATCHv4,1/6] spi: add ancillary device support
    [PATCHv4,2/6] spi: dt-bindings: support devices with multiple chipselects
    [PATCHv4,3/6] dt-bindings: misc: ge-achc: Convert to DT schema format
    [PATCHv4,4/6] ARM: dts: imx53-ppd: Fix ACHC entry
    [PATCHv4,5/6] misc: nxp-ezport: introduce EzPort support
    [PATCHv4,6/6] misc: gehc-achc: new driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

