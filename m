Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B662A3E1E
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 08:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCH4L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 02:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCH4L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Nov 2020 02:56:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604390170;
        bh=f9MGc7DsfEC/RlaHlZncDuVH0SYhyXx7+f6/+8OxH/g=;
        h=Subject:From:Date:To:From;
        b=HLJeF0kTiHQtaYZ/yHrBwluR4Fmklj9yJ+BRO308LCkmM1UKNlFcaGqliFVDttI8j
         IY5ilNj8YW920tg+ZaJLmVfFRv3bCsCA/+LP4F1pCBGHUo2g96/1ggU9fSoD6aamsa
         A0cs+5kjIVr2fdxJ/iF/3Fiho+0cI9VXz2l7Uhdw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160439017088.10876.772840517420386178.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 03 Nov 2020 07:56:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Porting ASPEED FMC/SPI memory controller driver (2020-11-03T07:21:58)
  Superseding: [v1] Porting ASPEED FMC/SPI memory controller driver (2020-11-02T07:52:11):
    [1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory controller
    [2/4] ARM: dts: aspeed: ast2600: Update FMC/SPI controller setting for spi-aspeed.c
    [3/4] ARM: dts: aspeed: ast2600-evb: Adjust SPI flash configuration
    [4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

