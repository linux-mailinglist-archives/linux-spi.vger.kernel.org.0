Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A1F16FB0A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 10:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBZJkN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 04:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgBZJkN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Feb 2020 04:40:13 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582710013;
        bh=WwotJY0sZIYghCjgI6HNFAUusE+Ll2QcqNUX0TWi+Oc=;
        h=Subject:From:Date:To:From;
        b=Knb+cLCiZKM5swPITgvJie1RFSpAvfRx0GW8VKiXeRPMgHoNx0lIS5xc0PQftrTWE
         ZR8gJ7OK6TJBlvtcNJzC16OdAWhVDSe+nGgJ2Zhc3Hkn8gL+v7Zr7MTnpiKAP6hq5Z
         GKWjPlODCbByEqeMK+wNtVY1w8zsbjXnp0QJ/JSM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158271001327.9204.651132668663659038.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 26 Feb 2020 09:40:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] mtd: spi-nor: add xSPI Octal DTR support (2020-02-26T09:36:52)
  Superseding: [v1] mtd: spi-nor: add xSPI Octal DTR support (2020-02-11T13:33:40):
    [1/9] spi: spi-mem: allow specifying whether an op is DTR or not
    [2/9] spi: spi-mem: allow specifying a command's extension
    [3/9] spi: cadence-quadspi: Add support for octal DTR flashes
    [4/9] mtd: spi-nor: add support for DTR protocol
    [5/9] mtd: spi-nor: get command opcode extension type from BFPT
    [6/9] mtd: spi-nor: parse xSPI Profile 1.0 table
    [7/9] mtd: spi-nor: use dummy cycle and address width info from SFDP
    [8/9] mtd: spi-nor: enable octal DTR mode when possible
    [9/9] mtd: spi-nor: add support for Cypress Semper flash


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
