Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2799265BC7
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 10:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKIkS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 04:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKIkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 04:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599813616;
        bh=oaCZc4njmLTXFpFHe+1oVsoxKo9lzxtBgyX/XdFn9Ao=;
        h=Subject:From:Date:To:From;
        b=D48SB39JmlMfNfs8MR6hSahKNpFdkYzeO42AZjCEg84X8zgUrD0OUhzvJTLZ3ZMcc
         omKJ5oGbThusmbhEZReOHK0wtuYHwECQoHyEPSmU1aLkdisvFqYWJ6dFk7tEhIN7ig
         blAugl8R64QguSQbQh/T5ZG5o46xcTw5boh4t9Iw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159981361688.27782.5740331790212121359.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 11 Sep 2020 08:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-nxp-fspi: Add ACPI support (2020-09-11T08:28:06)
  Superseding: [v1] spi: spi-nxp-fspi: Add ACPI support (2020-09-08T06:02:27):
    [v1] spi: spi-nxp-fspi: Add ACPI support


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
