Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0048B1E9DC8
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 08:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFAGAR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 02:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgFAGAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Jun 2020 02:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590991217;
        bh=mOgwEfZUWXLXjSQgdo+EwcwmO2r3BUgRMSeiqRv2kCs=;
        h=Subject:From:Date:To:From;
        b=j2piRxoPRpBh1rBbD1Tb9VYE4/1VGvz6PER/v1Qf3XMdh7UqEf58GSkZuEVDs1rNn
         kFOUgqmaz7eovBdGqzrX4Ggx0SPEyqVjN+9Fag6b1/iUs/syTjGOXLGSHgGxo95GMD
         dorASLYthITCh3ZH5ZLGmaemyvqD6wXn/MOK3iMA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159099121705.15428.6364728039360833352.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 01 Jun 2020 06:00:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework (2020-06-01T05:47:17)
  Superseding: [v2] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework (2020-05-26T09:35:58):
    [v2,1/6] mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
    [v2,2/6] mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
    [v2,3/6] mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
    [v2,4/6] mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
    [v2,5/6] mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
    [v2,6/6] spi: Move cadence-quadspi driver to drivers/spi/


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
