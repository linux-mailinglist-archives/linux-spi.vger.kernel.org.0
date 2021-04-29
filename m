Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5160D36E4A6
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 07:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhD2F5f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 01:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2F5f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Apr 2021 01:57:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 898ED600D4;
        Thu, 29 Apr 2021 05:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619675807;
        bh=4BbeCVuF5CZFoe8IXWCc+ccyOQkd4Oe0kPObn/eh30A=;
        h=Subject:From:Date:To:From;
        b=p7AaIBA5lcDdoQeFp7KNptt77/bR2mcJPpcbNppeAJoDufDI/7FrbrMZZO7kQx48D
         c/rOvyzecQr1/bmzBc7ebidW2l8JG+w+suNTbbMqiia58853McUcE1h7a/hYxDv8ZD
         vnvgpVNirrAm3BDBisf0CHHS7RhThLS6Lk/qT6n/q6ale6Jj5AE0zlMSX1xIHvaoJC
         tJZo3WI0Z5s7fJOCpt1YZRk78C4EoOWlEOR+i4jVlKpyuIqzzSQrsEmTfQSJg5yThv
         q20UMklVVEM8KJ+8Cr7uvu5lH08cCxMnScYsBEbi0s0rtbJ6PkU4NhWqlq2BrmtUuD
         QGUl7S+Iz+c0w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7110D60A36;
        Thu, 29 Apr 2021 05:56:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161967580739.31603.11974305687650664289.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 29 Apr 2021 05:56:47 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-zynq-qspi: Fix stack violation bug (2021-04-29T05:38:01)
  Superseding: [v1] spi: spi-zynq-qspi: Fix stack violation bug (2021-03-18T10:24:44):
    [1/2] spi: spi-zynq-qspi: Fix kernel-doc warning
    [2/2] spi: spi-zynq-qspi: Fix stack violation bug


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

