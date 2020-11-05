Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802D92A7F24
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 13:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgKEM4K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 07:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbgKEM4J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:09 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604580968;
        bh=Rbs/MHUd4lPbCitOsaOTUzoqvs1TbxkkSOwTO3WJND8=;
        h=Subject:From:Date:To:From;
        b=H1rIEpJAxZneK+0uizXmQarD5k/WMHMCgZgbfvoz8QRHPTUw6zE/K1l+keNQRKOXH
         EW0HX9D+r0yveBFP5nrWLJC4fFlBsHGymKniqVPXWFrnUI4DZC7JVimVyAmLziobDA
         8vDJRGq/xfjn14AJZK+G3/+WFbDckdY6PxaspRRk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160458096880.28452.10910451926774968421.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 05 Nov 2020 12:56:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Porting ASPEED FMC/SPI memory controller driver (2020-11-05T12:03:27)
  Superseding: [v2] Porting ASPEED FMC/SPI memory controller driver (2020-11-03T07:21:58):
    [v2,1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory controller
    [v2,2/4] ARM: dts: aspeed: ast2600: Update FMC/SPI controller setting for spi-aspeed.c
    [v2,3/4] ARM: dts: aspeed: ast2600-evb: Adjust SPI flash configuration
    [v2,4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

