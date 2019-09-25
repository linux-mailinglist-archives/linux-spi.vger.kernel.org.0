Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27970BDAD3
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2019 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfIYJUQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Sep 2019 05:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfIYJUI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Sep 2019 05:20:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569403207;
        bh=frMRC6c95Wowb/69GqthVSInrWmK71QXNLV3D4cMld0=;
        h=Subject:From:Date:To:From;
        b=dqBURPjEPPlKBSfDmEBlVePx3faZ1losf/6Nzq2hrkKgMSxUF9DT04+Gj3pVaD9KP
         AzzIOE2E/EtLoB//RMBCecU1iokOjALFz+QRXRron2Lt/J0CEoTiGQa1hoH+GKDZsX
         n8aCkjKev8/mqd4cRvXkczE3wQAwhKEUOnR8NlwU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156940320786.4602.16702237155303945268.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 25 Sep 2019 09:20:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Fix problem with interrupted slave transmission (2019-09-25T09:11:41)
  Superseding: [v1] spi: Fix problem with interrupted slave transmission (2019-09-24T11:05:45):
    [1/2] spi: Add call to spi_slave_abort() function when spidev driver is released
    [2/2] spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
