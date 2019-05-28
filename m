Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F322C367
	for <lists+linux-spi@lfdr.de>; Tue, 28 May 2019 11:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE1JkK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 May 2019 05:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfE1JkJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 May 2019 05:40:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559036409;
        bh=yR9kIR0T0QNZbQJmsatd+vaNzpPfrVJ03dI2uZkTN0c=;
        h=Subject:From:Date:To:From;
        b=Rljyy9k7ahF1ikQ39+ijIzcezAhI63WKQBZV3jc+qYUD9tIgYmI6jo4wS7cGekzua
         TUFDmCDQLt5Znn7TDROx4KCInYA1SIuKyc4SuuvyzlfjqkUbVKyAd83WOLGgb7Vegm
         XBm+9r/tu0l/ckNnWJmzuSxZWOvyDrWNSWedOm3U=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155903640944.13077.12082088755709248343.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 28 May 2019 09:40:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: support for Socionext Synquacer platform (2019-05-28T09:27:10)
  Superseding: [v5] spi: support for Socionext Synquacer platform (2019-05-21T11:59:55):
    [v5,1/3] MAINTAINERS: Add entry for Synquacer SPI driver
    [v5,2/3] dt-bindings: spi: Add DT bindings for Synquacer
    [v5,3/3] spi: Add spi driver for Socionext Synquacer platform


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
