Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457E7264E8
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfEVNkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 09:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbfEVNkQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 May 2019 09:40:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558532415;
        bh=wdqQFxUB65rzep043nOlMltXSHo+zk4Y544XirVNU+g=;
        h=Subject:From:Date:To:From;
        b=HCWRtcL5wA2t02ph5KmYPzBmn/GGAD+d8xZSsRGxYg2p9rlnfcptrLAw22YPZMvMN
         kXpoAbqx95XUL4vP5CN2isEa24qrwUnP3kfcIDm4HZ1Drnr+G99aiEArZM5nIx+ykb
         H5O0/HtdQ5Rbbf7PD7f4tYmZ+BT4pBCVvtlTJtSY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155853241559.6660.10634526291488014813.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 22 May 2019 13:40:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: pxa2xx: add driver enabling message (2019-04-10T09:47:04)
  Superseding: [v1] spi: pxa2xx: add driver enabling message (2019-04-08T15:22:44):
    [1/1] spi: pxa2xx: add driver enabling message

Latest series: [v2] spi: tegra114: fix PIO transfer (2019-04-05T00:14:14)
  Superseding: [v1] spi: tegra114: fix PIO transfer (2019-03-27T05:56:22):
    [V1,01/26] spi: tegra114: fix PIO transfer
    [V1,02/26] spi: tegra114: clear packed bit for unpacked mode
    [V1,03/26] spi: tegra114: fix for unpacked mode transfers
    [V1,04/26] spi: tegra114: use packed mode for 32 bits per word
    [V1,05/26] spi: tegra114: use unpacked mode for below 4 byte transfers
    [V1,06/26] spi: tegra114: terminate dma and reset on transfer timeout
    [V1,07/26] spi: tegra114: flush fifos
    [V1,08/26] spi: tegra114: configure dma burst size to fifo trig level
    [V1,09/26] spi: tegra114: dump SPI registers during timeout
    [V1,10/26] spi: tegra114: avoid reset call in atomic context
    [V1,11/26] spi: tegra114: reset controller on probe
    [V1,12/26] spi: tegra114: add SPI_LSB_FIRST support
    [V1,13/26] spi: tegra114: add dual mode support
    [V1,14/26] spi: tegra114: add 3 wire transfer mode support
    [V1,15/26] spi: tegra114: set supported bits_per_word
    [V1,16/26] spi: tegra114: set bus number based on id
    [V1,17/26] spi: tegra114: add support for interrupt mask
    [V1,18/26] spi: tegra114: add support for hw based cs
    [V1,19/26] DT bindings: spi: add spi client device properties
    [V1,20/26] spi: tegra114: add support for tuning HW CS timing
    [V1,21/26] DT bindings: spi: add tx/rx clock delay SPI client properties
    [V1,22/26] spi: tegra114: add support for tuning clock delay
    [V1,23/26] spi: tegra114: add support for gpio based cs
    [V1,24/26] spi: tegra114: de-assert CS before SPI mode is reset to its default
    [V1,25/26] spi: expand mode and mode_bits support
    [V1,26/26] spi: tegra114: add support for LSBYTE_FIRST

Latest series: [v3] dt-bindings: spi: Add YAML schemas for the generic SPI options (2019-05-20T14:50:34)
  Superseding: [v1] dt-bindings: spi: Add YAML schemas for the generic SPI options (2019-05-07T13:48:13):
    [1/4] dt-bindings: spi: Add YAML schemas for the generic SPI options
    [2/4] dt-bindings: spi: sun4i: Add YAML schemas
    [3/4] dt-bindings: spi: sun6i: Add YAML schemas
    [4/4] ARM: dts: sun6i: Add default address and size cells for SPI
  Superseding: [v2] dt-bindings: spi: Add YAML schemas for the generic SPI options (2019-05-09T07:26:05):
    [v2,1/4] dt-bindings: spi: Add YAML schemas for the generic SPI options
    [v2,2/4] dt-bindings: spi: sun4i: Add YAML schemas
    [v2,3/4] dt-bindings: spi: sun6i: Add YAML schemas
    [v2,4/4] ARM: dts: sun6i: Add default address and size cells for SPI

Latest series: [v3] spi: spi-mem: Fix build error without CONFIG_SPI_MEM (2019-04-10T11:57:09)
  Superseding: [v2] spi: spi-mem: Fix build error without CONFIG_SPI_MEM (2019-04-10T05:44:45):
    [LINUX,v2] spi: spi-mem: Fix build error without CONFIG_SPI_MEM

Latest series: [v2] spi: pxa2xx: fix SCR (divisor) calculation (2019-04-12T07:32:19)
  Superseding: [v1] spi: pxa2xx: fix SCR (divisor) calculation (2019-04-10T12:51:35):
    [1/2] spi: pxa2xx: fix SCR (divisor) calculation
    [2/2] spi: pxa2xx: use a module softdep for dw_dmac


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
