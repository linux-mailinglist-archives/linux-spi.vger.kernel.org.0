Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAE22F6D8
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgG0RkU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 13:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgG0RkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 13:40:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595871620;
        bh=oDqmWZV9Ha4Yhux/RDXfhx6t/+zVWLMsmr3RPjplxIk=;
        h=Subject:From:Date:To:From;
        b=TlfM28TklCEbrQFKnwwtCx3REFirkLfoTcp9vp8Dyzgx28rOvjtkQG1UW/Qg85hLU
         gl0prKYAQry02+i1fLN63UWiDeDpbHRk0goaA7J5vHge3n4qBU47GHOEGFZH5Ix5Av
         KvMXrUKP6cJwGtpupr6PXGv6QM0K/pYL1vMXmDRs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159587161998.16585.12791863222830457785.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Jul 2020 17:40:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-topcliff-pch: drop call to wakeup-disable (2020-07-27T17:29:37)
  Superseding: [v2] spi: spi-topcliff-pch: drop call to wakeup-disable (2020-07-27T13:17:43):
    [v2] spi: spi-topcliff-pch: drop call to wakeup-disable


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
