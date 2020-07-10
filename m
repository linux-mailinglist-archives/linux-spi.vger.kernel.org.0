Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261B121BF22
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 23:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGJVUU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jul 2020 17:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgGJVUU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jul 2020 17:20:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594416020;
        bh=3UyYvgIy5H+iKfnfLG/ORPdVEhbAsGfzsW98aBg8D/8=;
        h=Subject:From:Date:To:From;
        b=tE/yDLLeWo04qfPaKXWIRL8QbscitlzSwRm4OowLMhm5naFZyaEA0UCcecRLWvvIX
         ngDGjXBHasNZ3RIUJk7qy2F8LtZEaQUwHuT3LMdLupp9GmpNzIFttC9nQET/lbnOku
         15bMuDXFjtkGIsngllQN+0AGRkwT130HSwz0Yh20=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159441602004.28026.3786005516559930278.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 10 Jul 2020 21:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-cadence: add support for chip select high (2020-07-10T21:16:55)
  Superseding: [v1] spi: spi-cadence: add support for chip select high (2020-07-10T04:51:40):
    spi: spi-cadence: add support for chip select high


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
