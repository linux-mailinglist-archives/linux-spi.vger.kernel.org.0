Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE238257A45
	for <lists+linux-spi@lfdr.de>; Mon, 31 Aug 2020 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHaNUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Aug 2020 09:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgHaNUO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 31 Aug 2020 09:20:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598880014;
        bh=qqRMl07TblncPVGM3WHF+6pI43fWrte5kuMY58JeBIE=;
        h=Subject:From:Date:To:From;
        b=gpjAAvksOfECKi40brjxPBnE04ND34LSHNPf7j8Wmgaxw15qZVaZhLLOQ70VHKujN
         Z660iS+s9skO3SXkLG5qDSgV+h69v+L4wpYs7reptQZScUdwDY0+iXuCBBZEQJuRi1
         pSOIM/3yw6Qo/qepqbNBoDXQY6bkuTQUHFYoX7X0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159888001402.30411.12295766006154825332.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 31 Aug 2020 13:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads (2020-08-31T13:07:20)
  Superseding: [v1] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads (2020-08-28T07:47:26):
    spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
