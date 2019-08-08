Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43D8862F0
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2019 15:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbfHHNUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 09:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732933AbfHHNUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Aug 2019 09:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565270419;
        bh=jRaS7E00bf8MI+InxwCYowKZnlbLHhBQAjqHQAlMSPc=;
        h=Subject:From:Date:To:From;
        b=TU/XcerY8np8qSb65iUBM6bw2StdMjcZdhh8ofNn2wAxURH9ey3bUWuOIJtYcyxfp
         R4YF7yEg/GTiEnNnogxT5Xzcfuu8INX340WApgdGeGsVBYrZaLaR3jr1RgQmA2j1f5
         f1VZEc7X9PWG66CLXhnTZbhKjUlhisNS6w3M4L6o=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156527041938.24597.8931690690014462905.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 08 Aug 2019 13:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: add NPCM FIU controller driver (2019-08-08T13:14:48)
  Superseding: [v1] spi: add NPCM FIU controller driver (2019-08-01T14:04:19):
    [v1,1/2] dt-binding: spi: add NPCM FIU controller
    [v1,2/2] spi: npcm-fiu: add NPCM FIU controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
