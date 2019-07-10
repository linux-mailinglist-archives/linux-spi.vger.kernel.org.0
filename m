Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A958649D7
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 17:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfGJPkF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jul 2019 11:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfGJPkE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jul 2019 11:40:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562773204;
        bh=fNCkrAiEb2nkfKb9PvCBRlNhmyzKooL+uvNNXRHy/yg=;
        h=Subject:From:Date:References:To:From;
        b=QpkzYmwnJ2AuPXjuXKwCkQWk+xudK+4eLoG96GiEqX9BxA4qbJfIUfOa3rzhNXjmZ
         qIVdNFuRrUBtmWtekMtM3TifBPPp+n1c5j2kR2xUP27wTHDWyng36xgXpIETQ6gT3v
         dby0aX7s//kSRI/+AR8rCEm/7ofLtabmqoE+C2PM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156277320439.24926.3323065471288542631.git-patchwork-summary@kernel.org>
Date:   Wed, 10 Jul 2019 15:40:04 +0000
References: <20190702193959.11150-1-linus.walleij@linaro.org>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: gpio/spi: Fix spi-gpio regression on active high CS
  Submitter: Linus Walleij <linus.walleij@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=141217

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
