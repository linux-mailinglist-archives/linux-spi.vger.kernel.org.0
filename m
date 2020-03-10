Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18917FEC9
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCJNkN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 09:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgCJNkN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Mar 2020 09:40:13 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583847612;
        bh=qzVlcK3eXeKrBlWUq28A/E6bEmGqF40WX+6E4J2tjlk=;
        h=Subject:From:Date:To:From;
        b=lciMOmc0t1fxuUhxNHnJhvk/0rKvP2sB8FTft8sbTdcPGSbDjeF8Zrcmfy4ZYbbsC
         JtIcvNq0ow2mNj3h3Rdp0E9z5XrSc0sVET8Wq4MYMN0WZl6WISAqXU63I7VzF+SDS4
         pcgoqrFMnsp86amMjn6eEpIcZjoD+cBDY1K7GB9E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158384761239.18137.4131870549389678753.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 10 Mar 2020 13:40:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] NXP DSPI bugfixes and support for LS1028A (2020-03-10T12:55:42)
  Superseding: [v2] NXP DSPI bugfixes and support for LS1028A (2020-03-09T21:07:49):
    [v2,1/6] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
    [v2,2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
    [v2,3/6] spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
    [v2,4/6] spi: spi-fsl-dspi: Add support for LS1028A
    [v2,5/6] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
    [v2,6/6] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
