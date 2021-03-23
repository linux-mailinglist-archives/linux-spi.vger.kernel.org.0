Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB69346C7A
	for <lists+linux-spi@lfdr.de>; Tue, 23 Mar 2021 23:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhCWWWw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Mar 2021 18:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234124AbhCWWUS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Mar 2021 18:20:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 520C061879;
        Tue, 23 Mar 2021 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616538018;
        bh=dPIW5gNOw3Uzhn39MpfOtmerWm473oqPd2cb8dY3Avg=;
        h=Subject:From:Date:To:From;
        b=NxbbGZWVdgbivRXZV8UBmZDAKHeryoYb4RcztZT7gmx9kEMdktGwhqbjbn0Z583De
         2zA8bFfEFniFH0Yj9wYLHnTp+ciiwIOo0vFV51XGh0v6xV4JXWuJhSqfBPNR0G7bGD
         XHxOgOjvu4LU4RoJ81LMv5cN211XcL2iHxzARglfz8BMe1oVfl5MbV5CZ8u0A84ZYR
         Xa6M9SBeJMd5E6BNcMARr+q0P4mqNURASRlhNdYqFywciUxCdlOb4/GBypqb2L92MC
         vlPeQRyI87g3XMj8Faw6d2LUTJ2eBQeN99jSFFcgM+ilr6T7PcwV4QrLsDX3tinBik
         jnxaLupn+hrGg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 438EC60A0E;
        Tue, 23 Mar 2021 22:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161653801821.31023.16624250072540533791.git-patchwork-summary@kernel.org>
Date:   Tue, 23 Mar 2021 22:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: drivers: spi: cadence: set cqspi to the driver_data field of struct device
  Submitter: Li, Meng <Meng.Li@windriver.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=446063
  Lore link: https://lore.kernel.org/r/20210311091220.3615-1-Meng.Li@windriver.com

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


