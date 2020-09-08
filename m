Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E817260E8E
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgIHJUS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 05:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgIHJUS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Sep 2020 05:20:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599556818;
        bh=eEyj6/Hqx9He42PsNzJ/E8JpGEPe4Bu+EKluqCn3uRU=;
        h=Subject:From:Date:To:From;
        b=OnENItgcABfdVVOR1nY/6nsDSwBIXGK5fpqw5emDE5/JQx9qwpcUSGvM2s54+4BfL
         T4EnquLq/Lj3AVqof21hUbQBfj1IuFJFtT2Y/lmcgFn3QZANCF4hOk7IoPNN4ifKo0
         FN/OBg5epHpbf2fdbTuVrvkp55GRROM6cwMC6tws=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159955681800.31579.13332824041827985170.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 08 Sep 2020 09:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Fix memory leak on splited transfers (2020-09-08T09:17:36)
  Superseding: [v1] spi: Fix memory leak on splited transfers (2020-09-05T20:14:21):
    spi: Fix memory leak on splited transfers


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
