Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816A6D04D4
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2019 02:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfJIAkI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Oct 2019 20:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfJIAkI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Oct 2019 20:40:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570581608;
        bh=ddsbCjE3djJSZh/zrtbym5HAOAVOa+zZHkifO2NWAXo=;
        h=Subject:From:Date:To:From;
        b=j3GixbO/TQeEM0DrnC8+ELYnKe+IasPHYfa8xLGum7zyebOjKy+KrHrYIJL8a8nNS
         S0Xlfk3t5sBRxfqnhf8YYyzskV/aFv4rmK5idGHtlL6FVWBGD/Tg/5ElMc9ybbfEeu
         RQ9tHsfk/Bi95AwT7HVOohBgiJD013ZrDMr4FJYY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157058160819.11931.15856793545863514996.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 09 Oct 2019 00:40:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Remove two set but not used variables (2019-10-09T00:37:15)
  Superseding: [v1] spi: Remove two set but not used variables (2019-10-08T08:31:36):
    [1/2] spi: omap-100k: Remove set but not used variable 'dataH'
    [2/2] spi: npcm: Remove set but not used variable 'val'


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
