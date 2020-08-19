Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B29249F79
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgHSNVx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgHSNUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Aug 2020 09:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597843217;
        bh=NOaZzwfwL2S4+MGer2LKS20kh67l8Lh2b2GLa2kgxOE=;
        h=Subject:From:Date:To:From;
        b=e3Z7Zn5vWa7anDAJCI4rtVNAvtVawPt3obmNl40C9EabfbShDUzhDx9OI5KYFV4HQ
         cg4EL5Uao7ANnRP24vNZ61i+ANCoa9R1j7yRlaVDAbjO2YF4g6h4RZexoRrojHLyaU
         8yrn/TcfUiCpE0g5tkHB+yKjTrY02ka0TW5Y1zak=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159784321735.4613.12688607643735375068.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 19 Aug 2020 13:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: rspi: Bit rate improvements (2020-08-19T12:59:04)
  Superseding: [v1] spi: rspi: Bit rate improvements (2020-06-08T09:59:40):
    [1/8] spi: rspi: Remove useless .set_config_register() check
    [2/8] spi: rspi: Use requested instead of maximum bit rate
    [3/8] spi: rspi: Clean up Bit Rate Division Setting handling
    [4/8] spi: rspi: Increase bit rate accuracy on RZ/A
    [5/8] spi: rspi: Increase bit rate range for RSPI on SH
    [6/8] spi: rspi: Increase bit rate range for QSPI
    [7/8] spi: rspi: Fill in spi_transfer.effective_speed_hz
    [8/8] spi: rspi: Fill in controller speed limits


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
