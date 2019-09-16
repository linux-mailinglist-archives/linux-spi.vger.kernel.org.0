Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE8B3573
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfIPHUU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 03:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfIPHUU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Sep 2019 03:20:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568618420;
        bh=jaMjGO/Xh6s332v7o6kjOaOVnTtGaxKGEO7hwHuii+s=;
        h=Subject:From:Date:To:From;
        b=OMyJezmI/suL2FdMKQNG/EPu75ZjnEFr0I27Rd/tU29zJMVB+QlI4IWFQIxRD4gQr
         lGi5Rf0Q3CIP8GnNZ7XhwQhVLeuK1BrFx+rrCvkev2wv5spq1Hb1EShgBEC40MV6P+
         B070kbZVn7jrZWqtC8XRMyzjLyZhu/nubbz4oMAo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156861842000.14978.3371269637370175570.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 16 Sep 2019 07:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: introduce `struct spi_delay` data-type (2019-09-16T07:10:21)
  Superseding: [v2] spi: introduce `struct spi_delay` data-type (2019-09-13T11:55:46):
    [v2,1/4] spi: move `cs_change_delay` backwards compat logic outside switch
    [v2,2/4] spi: introduce spi_delay struct as "value + unit" & spi_delay_exec()
    [v2,3/4] spi: make `cs_change_delay` the first user of the `spi_delay` logic
    [v2,4/4] iio: imu: adis: convert cs_change_delay to spi_delay struct


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
