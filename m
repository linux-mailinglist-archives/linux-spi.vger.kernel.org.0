Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCCCA030A
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2019 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfH1NUJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Aug 2019 09:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1NUJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Aug 2019 09:20:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566998409;
        bh=8rVzM+hSGT24vLxm8hxa/XFKBVh87W++3GxXNSqbmtE=;
        h=Subject:From:Date:References:To:From;
        b=HCDU/lbvMLxk0gaj3SM1YSl5MXMQDg5eAitW5rWe5F0fFOqPxQCGf8r6PjKJ17ho0
         oZUay6J9eCagMFnsevpzutr6//sMG/pEN7LoJEFLVYz/kYJfd9Y+mUoMQNuE/xKC4R
         o5LKkPea4Fado+irl1HpBkexvISEnC4j74oN6iC4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156699840932.26202.14310996872339148557.git-patchwork-summary@kernel.org>
Date:   Wed, 28 Aug 2019 13:20:09 +0000
References: <20190816165000.32334-1-andreas@kemnade.info>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: gpio: of: fix Freescale SPI CS quirk handling
  Submitter: Andreas Kemnade <andreas@kemnade.info>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=160963

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
