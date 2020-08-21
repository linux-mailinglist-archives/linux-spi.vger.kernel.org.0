Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7538424DE7D
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgHURcl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgHURck (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 Aug 2020 13:32:40 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598031160;
        bh=XzrO60GhLCNGP96t+olRqbeNetEAoT5OQtzXK7ijsMI=;
        h=Subject:From:Date:To:From;
        b=VvtizxuwCiX5Be81Fc3LKjNCPOlAg00e8XycZWUGuYDb8JVQLzvfBCMJunBhu5oHy
         Uzqo5m5Ve5wmdbIcCbF6UEPUS/FJUDPLjzXLorLUEusOOwQR4HHMQPbDQVX0Wzr2F6
         F8GH/udkxuOrancZnQljrFZsAtFtbTTScxkQYHx4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159803116052.14585.14177502602204537973.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 21 Aug 2020 17:32:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Some fixes for spi-s3c64xx (2020-08-21T16:13:52)
  Superseding: [v1] Some fixes for spi-s3c64xx (2020-08-19T12:32:01):
    [1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and s3c64xx_enable_datapath()
    [2/8] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
    [3/8] spi: spi-s3c64xx: Report more information when errors occur
    [4/8] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_*
    [5/8] spi: spi-s3c64xx: Fix doc comment for struct s3c64xx_spi_driver_data
    [6/8] spi: spi-s3c64xx: Check return values
    [7/8] spi: spi-s3c64xx: Increase transfer timeout
    [8/8] spi: spi-s3c64xx: Turn on interrupts upon resume


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
