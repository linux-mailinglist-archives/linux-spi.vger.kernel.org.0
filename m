Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1808CCE323
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2019 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfJGNUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Oct 2019 09:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfJGNUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Oct 2019 09:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570454418;
        bh=cT6PpfkS5QQ45uxAl6qmBijP8XHE2wZwa+Yt+E6hjS8=;
        h=Subject:From:Date:References:To:From;
        b=rMnBtkULk1+VQiWle3jirbl2JjeB2uhVWjrF2YId3wqNQn+c+zPZB3JYHs8Sa676+
         M22zf4kBgERV9UDHtO5mdUMx/ZItI59ZXk9vp6mILpaxNf/3QX2nco+TDyX4tgcN5M
         /T/McvGNmo7EmnRT8816KRscqoL+V1w0C+xpxezA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157045441882.19701.5488976246352142645.git-patchwork-summary@kernel.org>
Date:   Mon, 07 Oct 2019 13:20:18 +0000
References: <c031340840daba810bb2a612c35eea7fab307e56.1568995874.git.hns@goldelico.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v2] DTS: ARM: gta04: introduce legacy spi-cs-high to make display work again
  Submitter: H. Nikolaus Schaller <hns@goldelico.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=176869

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
