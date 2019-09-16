Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F440B35D6
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfIPHmJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 03:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbfIPHkI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Sep 2019 03:40:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568619607;
        bh=RRSr1Btof3Jlc40ekRnmXbwwwns0BwMl6vdP2Qy4N10=;
        h=Subject:From:Date:To:From;
        b=qpX2SnPx4+kLDOIXH96kKRQAdaWp7FMTJ2NZp5ntyIJNWP6HhFpM0gowRcUawBoM2
         xAmjVW4R8/kvo1GceyyovFsIWJfm9RQjOOFhaTPvDtTyA0OPaP2jg1MYHCMX9kgrbj
         LCkcrjws6W6mcPWZt3AUkYKdvuH5rqueFG/jX5Ug=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156861960792.2133.9043895874074552440.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 16 Sep 2019 07:40:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: cadence-qspi: Add cadence-qspi support for Intel LGM SoC (2019-09-16T07:38:41)
  Superseding: [v3] spi: cadence-qspi: Add cadence-qspi support for Intel LGM SoC (2019-09-16T07:23:23):
    [v3,1/2] dt-bindings: spi: Add support for cadence-qspi IP Intel LGM SoC
    [v3,2/2] spi: cadence-qspi: Add QSPI support for Intel LGM SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
