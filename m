Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94362DFD1B
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 15:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgLUO50 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 09:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgLUO5Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Dec 2020 09:57:25 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608562605;
        bh=3Kvg7Boiq0NLOGgqHe5LnAV5p0WrJWDP7E0gg0CaFh0=;
        h=Subject:From:Date:To:From;
        b=gn7FkyU64n9oeKyA3WRlFYDFBsQN7YfOwe/rw7ZBt40uo5KdX11N3RrWe1V7BZxbQ
         PTj0pqOy7d4xfkA5DU+Z6An2HHRrhvofhdnHpRgeosrEfUVYu3eGU2kbT/o5FwzoqR
         yIYwz8dr1YB+tdQIzxlCW5GvVnGxUg2L0wWE/X3CagrjOjT02zQRTEzLro8tm5T+1f
         uuIi6GONEoJFb5kikEfH4asHkD5cswKQtAMDWCPZ1qVPUjiDtMqnrIqZnmj8t70eQr
         k6/CQrqygl9npZMpL07o+9GU7dw41/0lKpO5i1+Ddj1k65jtBd1M9LGIJbR+RkZi2v
         ++jZ6wBxCqTvw==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160856260506.8456.17901706727834496950.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Dec 2020 14:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: uapi: unify SPI modes into a single spi.h header (2020-12-21T14:19:04)
  Superseding: [v4] spi: uapi: unify SPI modes into a single spi.h header (2020-12-03T14:05:29):
    [v4,1/3] spi: uapi: unify SPI modes into a single spi.h header
    [v4,2/3] spi: Add SPI_NO_TX/RX support
    [v4,3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

