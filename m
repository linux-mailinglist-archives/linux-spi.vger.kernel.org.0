Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2E17200F
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgB0OkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 09:40:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731868AbgB0OkN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 09:40:13 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814413;
        bh=gqCm9/15+a9urRijbuqxLOhjXKTWna1XZW46aZBYS2A=;
        h=Subject:From:Date:To:From;
        b=VG2tYkucF2XyIMZwT61GoeVZeWn/feNN5MBXiOW+094xiNUJb1pdsG2ZR3uBnvTX1
         5g+JEy7WXVy0EyrcGIRws0tZU3DFsw5a+huWuf6P+w9wRFc/KxTnDEuc2+blJ3CaMQ
         j1Ss4Wft5TPcpnRqwErqzAtEhF4KMYVANpJY1+a0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158281441316.20400.7879240571666053913.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 27 Feb 2020 14:40:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-mpc52xx: Use new structure for SPI transfer delays (2020-02-27T14:39:31)
  Superseding: [v1] spi: spi-mpc52xx: Use new structure for SPI transfer delays (2020-02-27T14:21:31):
    spi: spi-mpc52xx: Use new structure for SPI transfer delays


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
