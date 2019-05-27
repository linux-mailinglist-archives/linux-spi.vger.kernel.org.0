Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A492B71E
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2019 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfE0OAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 May 2019 10:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfE0OAJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 May 2019 10:00:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558965609;
        bh=GPxsRbrRYEkeQo6PN/IyrMyTQ2FQdkWfCbhFLVAqAvA=;
        h=Subject:From:Date:To:From;
        b=YBaxBvFV9txdCUNA4hX3HV6sraCkmm2iHrqpp7zau0P5fBBFNqVl3SLTRJ6CWEKqs
         /ujGtWHg2nk+rp/mImyJR9YISKB+tlHhlDLoRGajtxdLd0ALFpBbKucmmM54MVXBmC
         ygxISqWftXfAPsx/WY34U48eUmUl5iaj9rUBOwIQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155896560911.27777.9961093105387873950.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 May 2019 14:00:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-meson-spifc: update with SPDX Licence identifier (2019-05-27T13:41:24)
  Superseding: [v1] spi: spi-meson-spifc: update with SPDX Licence identifier (2019-05-20T14:04:52):
    spi: spi-meson-spifc: update with SPDX Licence identifier


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
