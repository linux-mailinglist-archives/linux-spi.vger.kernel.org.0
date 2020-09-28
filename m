Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F323927AA0D
	for <lists+linux-spi@lfdr.de>; Mon, 28 Sep 2020 10:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1I53 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Sep 2020 04:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1I53 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Sep 2020 04:57:29 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601283449;
        bh=O/8Wl+7cDhc2Fib7BoMxMciXI2MK0uqa2a1aU2xOgME=;
        h=Subject:From:Date:To:From;
        b=z37m29ZmTn7Q7J6PLvSnRrZlGhSDps1qY97FE6qxOxIWxFlAFzrTQ2xfk0FTIMi3u
         +ldaDpURdOQGF9pSeAl9Osa40qlcaQ/c/wmFYRSRg8z8p1+rMVCW0tVAf1JZd8ZfbC
         mY5iHzicGQCyxZ/f5hmczVa1wc1PfA6lDp0TfTvw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160128344937.7014.238336427169176508.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 28 Sep 2020 08:57:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: fsl-dspi: fix NULL pointer dereference (2020-09-28T08:55:00)
  Superseding: [v1] spi: fsl-dspi: fix NULL pointer dereference (2020-09-27T22:43:36):
    spi: fsl-dspi: fix NULL pointer dereference
  Superseding: [v2] spi: fsl-dspi: fix NULL pointer dereference (2020-09-28T08:32:38):
    [v2] spi: fsl-dspi: fix NULL pointer dereference


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

