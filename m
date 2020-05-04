Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6520D1C393C
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgEDMUN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 08:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgEDMUN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 08:20:13 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588594813;
        bh=FEuBfP0+rClej64OL9sKKdOJ6/AB981YuQ1+JR6cnd0=;
        h=Subject:From:Date:To:From;
        b=clRGfSsRBTRFSv4MgTApHinmGrKhH/WdwWyNyDMl3AC6ZBM0mn2/07EaquxBQyTFT
         XEHthaWhZLjYncqDW09UZfMD1SE13Q4wKngbpMpVEseULA1rC7RM9xQi9sHQjrWSwo
         Jj0eIWdOa1CC/F11mRBkjrgCMSODIFN/RaaCNk1g=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158859481317.27763.17812806607749969275.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 May 2020 12:20:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: dw: Add support for Intel Keem Bay SPI (2020-05-04T12:11:44)
  Superseding: [v2] spi: dw: Add support for Intel Keem Bay SPI (2020-04-22T14:11:35):
    [v2,1/7] spi: dw: Fix typo in few registers name
    [v2,2/7] spi: dw: Add update_cr0() callback to update CTRLR0
    [v2,3/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema
    [v2,4/7] dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
    [v2,5/7] spi: dw: Add support for DesignWare DWC_ssi
    [v2,6/7] dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
    [v2,7/7] spi: dw: Add support for Intel Keem Bay SPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
