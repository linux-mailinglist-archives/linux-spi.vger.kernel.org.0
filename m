Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF9172FF2
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 05:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgB1EkM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 23:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbgB1EkM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 23:40:12 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582864812;
        bh=OKa8OgBD5l9L8VQgRgGCAifgPdCrtuLL2eaH1h5ahSM=;
        h=Subject:From:Date:To:From;
        b=g1UzaSm6SioBZLesOzs/VsO7ivFS21KVMyrdRIijJh/EHG3X8+/UL8O1PFY8iMMHX
         ZBHvoTYqZpdVaEZ6fUfC8RcGs9Ex0lD+4OjSMvbLIkEZ+BGmtzKlH8I8dL3ZIPVUiR
         68CzyfiOei/vRY+xM2T/fEUQ/xAN0I3WwfQ56y+U=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158286481200.8192.12675004334355042939.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 28 Feb 2020 04:40:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] rewrite mtk-quadspi spi-nor driver with spi-mem (2020-02-28T04:36:32)
  Superseding: [v1] rewrite mtk-quadspi spi-nor driver with spi-mem (2020-02-15T06:58:24):
    [1/2] spi: add support for mediatek spi-nor controller
    [2/2] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
