Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67A410AA7
	for <lists+linux-spi@lfdr.de>; Sun, 19 Sep 2021 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhISH6N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Sep 2021 03:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhISH6N (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 19 Sep 2021 03:58:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3988A60F51;
        Sun, 19 Sep 2021 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632038208;
        bh=ebftCa26V2uE3ho557BCqLACTC1WOHZKB1+K+3yeqhQ=;
        h=Subject:From:Date:To:From;
        b=bZ7nERH1lEDcMnbjC/OS5o2JvrahjdOZ7+dV06OSpCexmtFQQj6KBG75t7hSkeU+3
         85D/hvV03yMW8GJ8sld7EX8YY9zWcXv0ZtVsW3eyzgWzf3Ie3O5L96+mED7cV/Bn2D
         XC9Cdxn72V318G/wpoIV8N+tnCFFxsk8vuK/8HgYfc/qiYTghhgxypU/vGgNRK9/hE
         nZJwKs+IbK+kARD6QsUgadJ5D0aTd3O6rF/DSCGCdcDbtstO9ZpVFVJS4giEfUfr0B
         O50H/tzXzBWJW58KoJZf8BexWncZRVEjc8mYdooPTLoZB1SRX/JQz8ujMs/BEzTnh8
         3+/3tsfbGr92Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 23683609E9;
        Sun, 19 Sep 2021 07:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163203820808.9410.13647544955638590798.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 19 Sep 2021 07:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] add support for Cadence's XSPI controller (2021-09-19T07:38:41)
  Superseding: [v5] add support for Cadence's XSPI controller (2021-09-17T14:29:07):
    [v5,1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
    [v5,2/2] spi: cadence: add support for Cadence XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

