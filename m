Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED217C6AC
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 21:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCFUAN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 15:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFUAN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Mar 2020 15:00:13 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583524813;
        bh=9DatuX4muBVaPbuZGUpZ69oIhBmWI0r8aBvhN1GZv0I=;
        h=Subject:From:Date:To:From;
        b=K4P4Fi5mx30ndSTB159t/Edn72+mEB2L/kvb5Mr/PQ+WHgVPj6aNgGopO9cU5HQbq
         wdR1qE/34u8IL5ITc4HUVG08tTuMxtnp+5cxuAa4XDEKtQ/FNASk/8pYcEC9fA0G82
         Lp6usJbKI1yPdLUbcwskxN+iU9RSR+EuCahBdqs4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158352481324.23521.15253034182977772679.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 06 Mar 2020 20:00:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: Add FSI-attached SPI controller driver (2020-03-06T19:41:16)
  Superseding: [v2] spi: Add FSI-attached SPI controller driver (2020-02-03T22:30:03):
    [v2] spi: Add FSI-attached SPI controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
