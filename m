Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC94483E85
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 09:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiADI4P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jan 2022 03:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiADI4P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 03:56:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE362C061761
        for <linux-spi@vger.kernel.org>; Tue,  4 Jan 2022 00:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40096612ED
        for <linux-spi@vger.kernel.org>; Tue,  4 Jan 2022 08:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7148C36B02;
        Tue,  4 Jan 2022 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641286573;
        bh=5wIs4SdVI68B2qGSRT+7Y8s7V0NPrf5AjmLXK6JLnXY=;
        h=Subject:From:Date:To:From;
        b=g7SKLrStYBl5er5GfIhSB5SWXo/eSkxPW9xn5Gl3mCFG/Rm5+fed6VuLQtDC5JDpa
         zk9mSiSjlWuWAOk0nM0/eSvoQDNqQK8AQrQlcayrPtpr3WrWLG7IDb+HSRF2wtpsWN
         NipFZQvIkz6QG22CkeOqBsITtik0gEElprgGUX4K9m/3oXvSKDiitLP7M2mWKTEYKp
         QpHWsPSpgVhKHWZ1xv1LUOZ9b4lz7uhWbQoOV0zn8woLc/pF0IINrUTft2ji++69fw
         UjSPOWERczhy0tXLShZ8yTpaAyrbY9wlOEVk3qCvJiJKVKPn+utYVeFU17gTdoM6yQ
         aErCP7b4JK3hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 861A4F79400;
        Tue,  4 Jan 2022 08:56:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164128657347.30352.7149026242439097521.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 04 Jan 2022 08:56:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] External ECC engines & Macronix support (2022-01-04T08:36:18)
  Superseding: [v8] External ECC engines & Macronix support (2021-12-21T17:48:30):
    [v8,01/14] spi: spi-mem: reject partial cycle transfers in
    [v8,02/14] spi: spi-mem: Introduce a capability structure
    [v8,03/14] spi: spi-mem: Check the controller extra capabilities
    [v8,04/14] spi: cadence-quadspi: Provide a capability structure
    [v8,05/14] spi: mxic: Provide a capability structure
    [v8,06/14] spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
    [v8,07/14] spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
    [v8,08/14] mtd: spinand: Delay a little bit the dirmap creation
    [v8,09/14] mtd: spinand: Create direct mapping descriptors for ECC operations
    [v8,10/14] spi: mxic: Fix the transmit path
    [v8,11/14] spi: mxic: Create a helper to configure the controller before an operation
    [v8,12/14] spi: mxic: Create a helper to ease the start of an operation
    [v8,13/14] spi: mxic: Add support for direct mapping
    [v8,14/14] spi: mxic: Add support for pipelined ECC operations


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

