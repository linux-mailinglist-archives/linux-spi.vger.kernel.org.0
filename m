Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA252154D3
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGFJkU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 05:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgGFJkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jul 2020 05:40:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594028420;
        bh=4mohpQjrOHd3RRJkMEldyedWWYuwVUvEtBy+YtWgAIw=;
        h=Subject:From:Date:To:From;
        b=gM1jzlHSuJnOxo4TvZaPi9zKE8g4qzMw1+s+5iuJ7PVbOHpzisZi6u3akhAZ4G1d8
         487qhJR5qd31ECdNJMuXhgJZwp0kXM1yNCFtrdAKej+t5nxttTzvxTZZwr6AlAcg7v
         PKu+gXueAlL8XNnN6pI/hQH9B1dGmd9Yc6nuhBLM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159402842030.22133.13785834946393477533.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 06 Jul 2020 09:40:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Add the SPI daisy chain support. (2020-07-06T09:22:43)
  Superseding: [v1] spi: Add the SPI daisy chain support. (2020-07-03T14:12:43):
    [1/2] spi: Add the SPI daisy chain support.
    [2/2] dt-bindings: Add documentation for SPI daisy chain driver.


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
