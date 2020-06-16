Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6D1FB543
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 17:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFPPAR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 11:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgFPPAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 11:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592319617;
        bh=uy9o0tpO/3ToaJ2igtc1YktsaYx5ySBbhojlkJhewt4=;
        h=Subject:From:Date:To:From;
        b=Szj1a3QrvItsa50pCU+Pyvp5RgGM2FuzAjlVU7xaOeS6fTiGcVJMh8JQ9bhqMCrPI
         jyXQVOD2ijkpHTs32NG5miPVefXuru0F3MhZgkGV25fqIbb54oivvIeejZdnpZaFPu
         u6gb/uWdB3g7VxInsby/H/mINeN+Fp9L5gfcy4Hw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159231961719.16270.10592831984013058210.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Jun 2020 15:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] introduce fallback to pio in spi core (2020-06-16T22:42:07)
  Superseding: [v1] introduce fallback to pio in spi core (2020-06-11T12:58:28):
    [v1,RFC,1/2] spi: introduce fallback to pio
    [v1,RFC,2/2] spi: spi-imx: add fallback feature


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
