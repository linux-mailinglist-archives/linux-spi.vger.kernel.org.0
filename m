Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F31CD12C
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 07:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgEKFAP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 01:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgEKFAP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 01:00:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589173215;
        bh=8Mc7TRiuk3lUpRylZkQ+9OdzwL3wvky41yACgMitiGA=;
        h=Subject:From:Date:To:From;
        b=UFURUKESEizeDUg93/oKxmpVeGI6N71TT35CPlPW61ueWcThmGxA1AHnLliRxbF7D
         ZQ6PVhP6X0ZzH8oYFA3vsQgMSFkhMUu3L2Zu0/MCg/NfyjUJBa5/kvToTeCftfhw6m
         M6CKs/6ptJL9ZrJFFh9C+tMNa4qHYSF5nljD+KEo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158917321502.2170.8287153817065410654.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 11 May 2020 05:00:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: sun6i: Add support for GPIO chip select lines (2020-05-11T04:53:30)
  Superseding: [v1] spi: sun6i: Add support for GPIO chip select lines (2020-05-06T01:41:35):
    spi: sun6i: Add support for GPIO chip select lines


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
