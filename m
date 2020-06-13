Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83C1F84DF
	for <lists+linux-spi@lfdr.de>; Sat, 13 Jun 2020 21:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFMTUQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Jun 2020 15:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgFMTUQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 13 Jun 2020 15:20:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592076016;
        bh=Pax1SIuid11+T1SSmAgnQXbNByXoAA+Z4crH2sNh154=;
        h=Subject:From:Date:To:From;
        b=p1UpxyMy305P/56ySNIk2+gfxqScZBK8qiGcQMlutNK5WV1L3TNi1bJmDfVIpslc9
         YIPXjjmiSTRgifuTL1ztfauNOvKoyA7JJBcd5M/MH5uZfNHeKSPsNfOAgjM0SexelZ
         ElUZTufVofXgKA7/OJcw/FVYYFXAF+XUsSERR/ns=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159207601622.21263.9449785326062240158.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 13 Jun 2020 19:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: add Renesas RPC-IF driver (2020-06-13T19:18:34)
  Superseding: [v3] spi: add Renesas RPC-IF driver (2020-05-08T19:54:10):
    [v3] spi: add Renesas RPC-IF driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
