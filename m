Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0682847FB
	for <lists+linux-spi@lfdr.de>; Tue,  6 Oct 2020 09:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgJFH5c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Oct 2020 03:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFH5c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 6 Oct 2020 03:57:32 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601971051;
        bh=8cBFwbtxIErkfCDXA3M1/MTvKCeHQetOktMyhbqqWtY=;
        h=Subject:From:Date:To:From;
        b=E7NpOt7X9TRlNdO97NnFDO7Urnvh1GvSQK2CMiAnQxsZkC98c7B6Y3p6apSbEcf69
         EkyW4ptaUHjWtSpWxKkBMdWNsPiENKxF407u9WJYAdyKn12uoMFkhS3RrF9kHhTuNI
         4MCmQNpm4S/ffnOmzZnFPMKnCjhY9CtsioWAwcw4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160197105185.23796.4494248391269247819.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 06 Oct 2020 07:57:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: spi-mtk-nor: Add mt8192 support. (2020-10-06T07:54:01)
  Superseding: [v4] spi: spi-mtk-nor: Add mt8192 support. (2020-09-29T07:37:51):
    [v4,1/4] dt-bindings: spi: add mt8192-nor compatible string
    [v4,2/4] spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
    [v4,3/4] spi: spi-mtk-nor: support 36bit dma addressing
    [v4,4/4] spi: spi-mtk-nor: Add power management support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

