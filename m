Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9B134C41
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 21:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgAHUAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 15:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgAHUAM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jan 2020 15:00:12 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578513611;
        bh=V2FAg4IEY/Gk7jLJzrCHTZLsA12sa3tQXSrokHjA0qI=;
        h=Subject:From:Date:To:From;
        b=CiO0/r8HkR6vJORhaPr4H9zO8H+zlh70Yv27CuKkSsOVHzKo7Jq5DpR/m5bvNms7N
         p0rA5uyiMu+MHAfkRavTZxNo96oLosx8SyT2w/zQKqis7EZ+cyC/jGUmDX3xpq1wFz
         picj0WZLMiAnYqkdG3vXLU9W1qojcbiYh/qN42HA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157851361191.3832.14831452781432849983.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 08 Jan 2020 20:00:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: sh-msiof: Do not redefine STR while compile testing (2020-01-08T19:43:19)
  Superseding: [v1] spi: sh-msiof: Do not redefine STR while compile testing (2020-01-07T16:56:58):
    spi: sh-msiof: Do not redefine STR while compile testing


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
