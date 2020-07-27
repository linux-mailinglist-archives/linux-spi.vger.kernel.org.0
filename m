Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34E22EE25
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgG0OAR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 10:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgG0OAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 10:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858416;
        bh=4WKLbSaVJsV1poEomaq8Rg+P7xIEwcDFB7wQhk+6i00=;
        h=Subject:From:Date:To:From;
        b=FVHEb/v6Cq8kqmGD5ubCjsqHt0Ag6gqDGn2+ZZgRQqW2cvtmm/BqLoZPA5kqsTzVA
         g6CaAYgvwq3vFkE58BfButtTFuFf4bpTUFrtgliLMhguMVUgOd586jwnSNdgpCz89N
         BbrbEHEIS5bQVpdRlFu1QCSqUrEoEGYNoN9u6EOo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159585841674.15036.15703477020189411644.git-patchwork-summary@kernel.org>
Date:   Mon, 27 Jul 2020 14:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: MAINTAINERS: Change Maintainer for some at91 drivers
  Submitter: Nicolas Ferre <nicolas.ferre@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=311909
  Link: <20200702134224.3750-1-nicolas.ferre@microchip.com>

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
