Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83D113A9E2
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgANNAL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 08:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANNAK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jan 2020 08:00:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579006809;
        bh=KcG43Om+mNTJJAewNzgezf9fJ5TI5zHAOyatupgVti0=;
        h=Subject:From:Date:To:From;
        b=rV9/Z9DLGvAus3U9ZJ7FGJKtPGsX5qt6VCslOM0YElp9H0/MkM+ULF/4ZZ5tVKX6c
         Ufmtmm2oDw8h1N1hmMsvR8opfMGDbG0unCxcsNUqYCCiAVVnJiLDXtpR6B48Pjixwc
         rUwz/NpwhewBfQ6O0H5E/QxI7VCfxDoSWuys9Py4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157900680992.30563.18176270881554904282.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 14 Jan 2020 13:00:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-ti-qspi: Support large NOR SPI flash (2020-01-14T12:41:23)
  Superseding: [v1] spi: spi-ti-qspi: Support large NOR SPI flash (2019-12-11T19:39:51):
    [1/3] spi: spi-ti-qspi: Remove unused macro for fclk frequency
    [2/3] spi: spi-ti-qspi: support large flash devices
    [3/3] spi: spi-ti-qspi: optimize byte-transfers


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
