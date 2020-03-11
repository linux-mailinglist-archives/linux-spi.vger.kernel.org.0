Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51418216C
	for <lists+linux-spi@lfdr.de>; Wed, 11 Mar 2020 20:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgCKTAH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Mar 2020 15:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbgCKTAH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Mar 2020 15:00:07 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583953207;
        bh=8oX/LLHHztB0TE4GZ5wMoDKqbMHIgFGOxtzsLqR0m34=;
        h=Subject:From:Date:References:To:From;
        b=INiH4QB0VvDULTN0FXhheGGkP2IvZzp85i4SyenHHo2SSZzHP6yYizp6Kgvhwpoqe
         4+kjHuEXM/gMX2T9d9ubiV1p67QiBxLKvNVCanCuHs2i6E3flV0lvLIrUmuaf4c2mu
         fY+/bKVNsEI0d0aYGwZzmQhbuG2EPgnl5CYo5+NA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158395320721.20121.8815309802315685901.git-patchwork-summary@kernel.org>
Date:   Wed, 11 Mar 2020 19:00:07 +0000
References: <20200306085052.28258-1-gch981213@gmail.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: rewrite mtk-quadspi spi-nor driver with spi-mem
  Submitter: Chuanhong Guo <gch981213@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=252289
    Patches: [v3,1/4] spi: make spi-max-frequency optional
             [v3,2/4] spi: add support for mediatek spi-nor controller
             [v3,3/4] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
             [v3,4/4] mtd: spi-nor: remove mtk-quadspi driver

Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
