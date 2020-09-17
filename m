Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF526DD79
	for <lists+linux-spi@lfdr.de>; Thu, 17 Sep 2020 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgIQOGO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Sep 2020 10:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgIQOAJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Sep 2020 10:00:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600351209;
        bh=EXzCloE/HXTSYUlL5OGTnXjej961xJhZsh1D64e1nVI=;
        h=Subject:From:Date:To:From;
        b=yRSE5CFsAbKsr69Csjf8+6VAv0CI2ngHhJgaqzcodHAwn1KYiHnZD7HmAddWVC49Q
         r2BiibruMId9hNWas8eNuinjkwc9BNE8KW1nG4IAFLKFmQw5l8xj3vOupWCtg5UOgU
         1zKcsqaKzPOBHd0e66KoPLR5ooa5qNV4RSZryJz0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <160035120914.1836.1588939803108852305.git-patchwork-summary@kernel.org>
Date:   Thu, 17 Sep 2020 14:00:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: bcm2835: mark polling_limit_us as static
  Submitter: Marc Kleine-Budde <mkl@pengutronix.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=349449
  Link: <20200915132311.1112865-1-mkl@pengutronix.de>

Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
