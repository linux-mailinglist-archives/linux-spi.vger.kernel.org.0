Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D96BF0AF
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfIZLAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 07:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfIZLAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Sep 2019 07:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569495608;
        bh=YX+1/CTJUxw5Kyr6/muDI+fvz7PGwNBmRLlxLeDOoSM=;
        h=Subject:From:Date:To:From;
        b=AwVI0/jwjN1gTvauzHCotx+KMmtWxf1BFoa1SkVqhkIsIU/ZJC3WJHv6CGAKUQWEP
         0eZWUlMsuDn58TJPEEJNQK4OQGLoqDlG0ZdOY7zTODa1BFMvgQQsS0086htWvpbt4I
         lpJcO7WNuJ+qPt4bAQQ1CWc/PSFZZ5w4q2AxjFTs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156949560823.21236.1856938876951365916.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 26 Sep 2019 11:00:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: introduce `struct spi_delay` data-type (2019-09-26T10:51:28)
  Superseding: [v3] spi: introduce `struct spi_delay` data-type (2019-09-16T07:10:21):
    [v3,1/3] spi: move `cs_change_delay` backwards compat logic outside switch
    [v3,2/3] spi: introduce spi_delay struct as "value + unit" & spi_delay_exec()
    [v3,3/3] spi: make `cs_change_delay` the first user of the `spi_delay` logic


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
