Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91239F5E0E
	for <lists+linux-spi@lfdr.de>; Sat,  9 Nov 2019 09:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfKIIUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 Nov 2019 03:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfKIIUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 9 Nov 2019 03:20:19 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573287619;
        bh=4Hs2y5llkTMAoIFY08QzGXn6wlbowKwNT6+irhpLKFQ=;
        h=Subject:From:Date:To:From;
        b=OIHhi6KytqtqcH1Rn3tvNiQJBKmT8Y5AYTHhwHcxCWKyVgW+AG8zgAl6MM78U8nXp
         dEUgV0l7WgPtLMcDYtBRzC8seyg360j3wJI2tL2orGJsphaU4xPKSLPj0v80aNhfwQ
         ZCRM5bxgcrmuyqyQVRZe17Yt3qI51eJyJwj0eFx0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157328761916.17861.4732048814548320033.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 09 Nov 2019 08:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: pxa2xx: Add missed security checks (2019-11-09T08:09:43)
  Superseding: [v1] spi: pxa2xx: Add missed security checks (2019-10-17T02:50:58):
    spi: pxa2xx: Add missed security checks


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
