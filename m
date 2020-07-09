Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192232198F2
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 09:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGIHAV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 03:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgGIHAV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 03:00:21 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594278020;
        bh=lSsh3w1xs4QQ9kttBSeaMU/Er+3thWPgpHhykBayJTM=;
        h=Subject:From:Date:To:From;
        b=KI8bFWPRrAJshq8Vg1gguI+s+XT95ZHOGwJ32YenNK/IGsbX8fAfr2yXKc5WibdJY
         pQ0RGB9qWSdBObXjYdfr93nln0ambTBTRB5UhNwTTzdlXq2bihJED1GJ7gpDloAWNU
         usZV+nEVCDF+c3EVsrdxNOwF7AE3oU6r4Mt7Zgoc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159427802072.4965.2192294467222409243.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 09 Jul 2020 07:00:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: use kthread_create_worker() helper (2020-07-09T06:50:07)
  Superseding: [v2] spi: use kthread_create_worker() helper (2020-07-08T12:33:49):
    [v2] spi: use kthread_create_worker() helper


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
