Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE01D2BB856
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgKTVae (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Nov 2020 16:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgKTVae (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Nov 2020 16:30:34 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605907833;
        bh=O2TInGa93UCt0zpgOzpjDpu8Rk9SS5a7fhhozyw13Ig=;
        h=Subject:From:Date:To:From;
        b=oZ9/eH5d8/9knv1W9jFJ3R2XEAeFgIxuBbhR2Zb7dsMKsdfdv2UX6g6AzX+Kd6dK3
         //g5DfMr9LBxatKEQv9RLauXdOykEQXK6MeDxQe+lPWN9u+r0E0wutGIvyK717Fd4O
         5u7WTfLbz8KYVme7D8O8UaAMliGq5+qr9pw+jc0M=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160590783324.31552.1291608179277855049.git-patchwork-summary@kernel.org>
Date:   Fri, 20 Nov 2020 21:30:33 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [v2,1/3] spi: fix resource leak for drivers without .remove callback
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=387693
  Lore link: https://lore.kernel.org/r/20201119161604.2633521-1-u.kleine-koenig@pengutronix.de
    Patches: [v2,1/3] spi: fix resource leak for drivers without .remove callback
             [v2,2/3] spi: Use bus_type functions for probe, remove and shutdown
             [v2,3/3] spi: Warn when a driver's remove callback returns an error

Total patches: 3

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


