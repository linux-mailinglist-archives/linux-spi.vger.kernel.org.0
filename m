Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5E14826FF
	for <lists+linux-spi@lfdr.de>; Sat,  1 Jan 2022 08:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiAAH4U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 1 Jan 2022 02:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiAAH4T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 1 Jan 2022 02:56:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC7C061574
        for <linux-spi@vger.kernel.org>; Fri, 31 Dec 2021 23:56:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7432960A6B
        for <linux-spi@vger.kernel.org>; Sat,  1 Jan 2022 07:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE466C36AE9;
        Sat,  1 Jan 2022 07:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641023777;
        bh=xfa0cCrIb7Akct8/XBt3JL/fkQiAJXFkd0AumIUUwxc=;
        h=Subject:From:Date:To:From;
        b=NwZKsuM8ECo1UsakPh91v5nDsbAtn/cSTtX84tSC5CdOvTfN9s7pmmxSU9GOs2NdK
         7XUgJsXc2ASQIosugpRpTBr1Ou71X35w9SPvnBLj0KvElLZ/03M59Xr6w9JAPpIKep
         5JGdwq4akDPkCUSk+mOdgpz1GXhpOWYSHqApT1JVvD5ZYfHxiDeEVo4mXIeEEnwRCt
         zIjJ17E112gR8VyooqNpQipdi8RHmcqSiP7U0ncTCA+CD5BGl8+yCzdlbuIBxvkeVs
         VcfycwzjK1mIkMQ9Zc1pKp18/20QaeA5bgi9VRseLw/AR0yaC2PMY2qH6fj+SSkhnE
         HD8l+WiWLcpsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA921C395DE;
        Sat,  1 Jan 2022 07:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164102377760.24187.15387842138563121611.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 01 Jan 2022 07:56:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] mtd: spinand: Add Octal DTR SPI (8D-8D-8D) mode support (2022-01-01T07:42:34)
  Superseding: [v2] mtd: spinand: Add Octal DTR SPI (8D-8D-8D) mode support (2021-10-11T20:46:05):
    [v2,01/14] spi: spi-mem: Add DTR templates for cmd, address, dummy and data phase
    [v2,02/14] mtd: spinand: Add enum spinand_proto to indicate current SPI IO mode
    [v2,03/14] mtd: spinand: Patch spi_mem_op for the SPI IO protocol using reg_proto
    [v2,04/14] mtd: spinand: Fix odd byte addr and data phase in read and write reg op for Octal DTR mode
    [v2,05/14] mtd: spinand: Add adjust_op() in manufacturer_ops to modify the ops for manufacturer specific changes
    [v2,06/14] mtd: spinand: Add macros for Octal DTR page read and write operations
    [v2,07/14] mtd: spinand: Allow enabling Octal DTR mode in the core
    [v2,08/14] mtd: spinand: winbond: Add support for write volatile configuration register op
    [v2,09/14] mtd: spinand: winbond: Add octal_dtr_enable() for manufacturer_ops
    [v2,10/14] mtd: spinand: Add support for Power-on-Reset (PoR) instruction
    [v2,11/14] mtd: spinand: Perform Power-on-Reset on the flash in mtd_suspend()
    [v2,12/14] mtd: spinand: Add adjust_op() in Winbond manufacturer_ops
    [v2,13/14] mtd: spinand: winbond: Rename cache op_variants struct variable
    [v2,14/14] mtd: spinand: winbond: Add support for Winbond W35N01JW SPI NAND flash


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

