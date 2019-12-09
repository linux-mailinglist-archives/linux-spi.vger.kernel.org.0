Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0801116EDB
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfLIOUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 09:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfLIOUL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 09:20:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575901210;
        bh=9HGBYWS+v1TWYoET5N3NOhrzcbiUZCFIPfCKMKO/JtU=;
        h=Subject:From:Date:To:From;
        b=A7nzTNndZz7SD9CkuS6Z85FZQuotcQD/ccCx4WNokYKDy9XpUMf1Utysp8BbyEe0B
         eORIVIxloUfrwHBusBE5a+w2E4/AaEHn6CfeZeROP9fwdKz49pb1mJGyO5Q/gaGSjq
         DDZKwL/WKU+bkxRpBmuZD/GztS6QxErH1P2RdrR4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157590121057.1937.15056720220363328476.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 09 Dec 2019 14:20:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] HiSilicon v3xx SFC driver (2019-12-09T14:08:07)
  Superseding: [v1] HiSilicon v3xx SFC driver (2019-11-04T16:51:35):
    [1/3] mtd: spi-nor: hisi-sfc: Try to provide some clarity on which SFC we are
    [2/3] spi: Add HiSilicon v3xx SPI NOR flash controller driver
    [3/3] MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
