Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46C42741B2
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 14:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIVMAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 08:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgIVMAQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 08:00:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600776016;
        bh=lLC0HDLil8ma0MDd2QHmZ3uHNj2n8vXhjtFJv8LxjhE=;
        h=Subject:From:Date:To:From;
        b=iWz7bf0Q0oZKpV+PKZD2F5GLAZ+MANjm8pZ5Apcd3IwhCxy3WCcHnCemcKwHMbqyQ
         UdyTaapCrT5RkFVmc8rKDnCiDOENDfpXRn3KnLj6B1/OyLg0+AerqC2b9Vxm1FmJEE
         DI/BFE9aYWgBFpU6QL/QfFmsDI+pe+8OFz71/H5w=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <160077601640.22287.1783954829605625462.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 22 Sep 2020 12:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mtk-nor: fix timeout calculation overflow (2020-09-22T11:49:02)
  Superseding: [v1] spi: spi-mtk-nor: fix timeout calculation overflow (2020-09-22T11:42:59):
    spi: spi-mtk-nor: fix timeout calculation overflow


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
