Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C724E24898
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfEUHAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 03:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfEUHAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 May 2019 03:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558422008;
        bh=/D3wc4dbymeY7CT++OeLC149UU5hiPGoIl8imqbAdOc=;
        h=Subject:From:Date:To:From;
        b=rfFV53+fTnDErgeTrCn79kqwdqBaR0r1FYcpMVE4T59FwPxvl4+ZJ61Llp7BeSCuY
         xiP/yAVkmJfNDqBKC0pkYqnCqBkpsRxA87ByMIdxjEmSLcUAAseKDOMkhqm/lb+1FB
         aEIE3cJqQ82L+CcJRwlXal29Oy/iqRjuCZR+HrV8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155842200848.8357.13739739424264512064.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 21 May 2019 07:00:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v13] mfd: Add Renesas R-Car Gen3 RPC-IF MFD & SPI driver (2019-05-21T07:19:32)
  Superseding: [v12] mfd: Add Renesas R-Car Gen3 RPC-IF MFD & SPI driver (2019-04-24T07:55:33):
    [v12,1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD driver
    [v12,2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
    [v12,3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF MFD bindings


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
