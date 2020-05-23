Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A081DF755
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 15:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgEWNAP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 May 2020 09:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgEWNAO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 23 May 2020 09:00:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590238814;
        bh=u3NIIbyhH0S0uxqVe5V3+E1//3Xg2REimJF5+/PD1R0=;
        h=Subject:From:Date:To:From;
        b=mkCWa7YeV80yGuX3Av01vw1BWHa19Y5/Cqca9SDayu0MjE8ZFOwTGGzUN/M1G2NSE
         YVzteUDIBbIBqEHx/2Z0d7wMzGGC6lwc7CtbIVOO6T+IoBbOWVCHBzx5k3psWV7MO8
         BaMTid1/+ToCiU8dU2bU37JsiN6L1cfs11eTXn/Y=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159023881471.30199.17555217426423788696.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 23 May 2020 13:00:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: tegra20-sflash: Fix runtime PM imbalance on error (2020-05-23T12:47:58)
  Superseding: [v1] spi: tegra20-sflash: Fix runtime PM imbalance on error (2020-05-21T07:52:20):
    spi: tegra20-sflash: Fix runtime PM imbalance on error

Latest series: [v2] spi: tegra114: Fix runtime PM imbalance on error (2020-05-23T12:57:04)
  Superseding: [v1] spi: tegra114: Fix runtime PM imbalance on error (2020-05-21T07:58:07):
    spi: tegra114: Fix runtime PM imbalance on error


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
