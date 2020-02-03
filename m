Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9579315127A
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2020 23:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCWkK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 17:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgBCWkK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 3 Feb 2020 17:40:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580769610;
        bh=OritR+1oBf/p00QID/rEH51yUaKESz5zu5DsWB5bqa0=;
        h=Subject:From:Date:To:From;
        b=bYMcWBhVhbmuXljGVq+oKmU2h0QJmKmVthG2pJsoQXgY6p2yfZQsv8yYAw8xmxNr2
         ZNA6rHjjeGhu5cB3tcWwFWOq5gsQe5qrDOI3Y26/C43mgB4Odn2z4jjxWo8/5aliT2
         1wh4MrBvi/OxUxTTYBwkjUsx6SA3iwisGlATyvXs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158076961034.21405.10448566176185966890.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 03 Feb 2020 22:40:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Add FSI-attached SPI controller driver (2020-02-03T22:30:03)
  Superseding: [v1] spi: Add FSI-attached SPI controller driver (2020-01-29T20:08:24):
    spi: Add FSI-attached SPI controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
