Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB131FA9DC
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 09:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgFPHUQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 03:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFPHUQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 03:20:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592292016;
        bh=wU3f9oYGbPoHHHRu0MrXFrJoXfRgpdADvkduJu0FYbw=;
        h=Subject:From:Date:To:From;
        b=CbRnZSKlnKxDnPLnrpiA3ldkr2IpujCa2dExaHT3mwoHlqlaH0QBB35JBgghhM2k5
         xeeaitnmWpNyv7YbOML/HivWdShEAvzHUpQyVVAN/TQ80LcUSVo6uINbIR0s6RycJ0
         Prbr7S44MJF3LmQgXEXoqZOzyg1te3+yMp5SFNoA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159229201627.30553.17062103754571508313.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Jun 2020 07:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: bcm63xx: add BMIPS support (2020-06-16T07:02:19)
  Superseding: [v2] spi: bcm63xx: add BMIPS support (2020-06-15T09:09:39):
    [v2,1/4] spi: bcm63xx-spi: add reset support
    [v2,2/4] spi: bcm63xx-spi: allow building for BMIPS
    [v2,3/4] spi: bcm63xx-hsspi: add reset support
    [v2,4/4] spi: bcm63xx-hsspi: allow building for BMIPS


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
