Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A562273B1
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 02:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgGUAUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 20:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgGUAUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 20:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595290817;
        bh=nMM77ADzATRP6Ucwf9QKkVId0b/9+o5QCou622nCzqI=;
        h=Subject:From:Date:To:From;
        b=kOa9msIRXfyasKlBE978nq/GiVma3LwUnO/s7dzKRnkT1BjI/e9ShO58PQ8KNmFou
         NZ6C1u9uzugoGfvhrL5ORnAFW2GiiM6mOeDneQaiatPjg66qiyVmcuc4pBKDaHxDsP
         gX4xTcXZPbO5sNcY4lmY4gZygty+vowRxdIEmD4Q=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159529081698.32752.14936867594064397906.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 21 Jul 2020 00:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-cadence: add support for chip select high (2020-07-21T00:08:50)
  Superseding: [v1] spi: spi-cadence: add support for chip select high (2020-07-10T21:16:55):
    spi: spi-cadence: add support for chip select high


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
