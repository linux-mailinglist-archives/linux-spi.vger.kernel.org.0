Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339A02EB692
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 00:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAEX51 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 18:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbhAEX51 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Jan 2021 18:57:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id ADCCE2071A;
        Tue,  5 Jan 2021 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609891006;
        bh=On/ipnAGh4TQOpvVE9tTx53DE9woMeq7b8tgmxFQLW8=;
        h=Subject:From:Date:To:From;
        b=WUzM3TPF+eSCunABNzeUBaumsRg/30at3iMQ0ryanc7Z9CQaOJnqsixTAl4FLAYKL
         jYWgcwmV7d/iJcq6Oah/L52LzSNxC/9RhRo+PoCybKousRHpG5WZM3apPAoWM+t9a+
         fG3kWwVL9JMZgXgaYeEZ6PUksPShpIQXY7h15aKyfZksNcYBeavx6TlT+oYjMmS4aB
         cbpzQI2nMEhCpTPOiZ53UBcZxXJjtzqHnLvrNuHFh0SD3jZ/vZYw8krTI8RgMmyqI/
         WOsIWYiWlggxjb7iBX9DBqmTRkSSeG0gUBk0vGpJb+EW9DxZ9TCWrBOFLZMZoSHduR
         szO0gcb+vUpRg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id A0CBF6012A;
        Tue,  5 Jan 2021 23:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160989100665.19241.2385723553836121050.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 05 Jan 2021 23:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: Add support for Realtek RTL838x/RTL839x SoC SPI (2021-01-05T23:28:14)
  Superseding: [v3] spi: Add support for Realtek RTL838x/RTL839x SoC SPI (2021-01-01T13:24:30):
    [v3,1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI controller
    [v3,2/2] spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SoC SPI controllers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

