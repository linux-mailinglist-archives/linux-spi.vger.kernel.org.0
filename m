Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88268104F75
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2019 10:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKUJkL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Nov 2019 04:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfKUJkL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 Nov 2019 04:40:11 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574329211;
        bh=T8+k+H5Sy4XnYKugoDndNGW/QRqVjl6EydKQCphtFJQ=;
        h=Subject:From:Date:To:From;
        b=f7BNxnOPWPkpB98Lkdvf/ecePYR81owj/ykLAM84u4HZteSlcikVkackVPo1v3YLL
         Kg3UHDiHEbQrl8L/bALL1UwfktKjC2U5SaPX2yFkMkJIPA8XMrEGlWVKAPJmTr7lCO
         w9e5AVY/066DIxk39kcdZECeXZmW37OTo6CS5Igs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157432921094.6545.1761580028634076883.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 21 Nov 2019 09:40:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: pic32: Retire dma_request_slave_channel_compat() (2019-11-21T09:27:03)
  Superseding: [v2] spi: pic32: Retire dma_request_slave_channel_compat() (2019-11-21T09:14:05):
    [v2] spi: pic32: Retire dma_request_slave_channel_compat()


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
