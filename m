Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49378DA5E3
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392672AbfJQHAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Oct 2019 03:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392643AbfJQHAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Oct 2019 03:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571295608;
        bh=9nas76KTvrvD1gtsRcfT34Psnyb11QvlSfINQMTtXX0=;
        h=Subject:From:Date:To:From;
        b=YeJp8qPvVVqDANYjRbbhwUk12twGAWhN5ahmkE2IjEXa59uICyT6lpxOaHdBacz+j
         OKcnvoWbj/VDLTmgy03IJJEBWkg7ABk99fhISjvd+wwTij3CyARdCk1ENUIazoDoPs
         AfmmVGzoIzSbrwb4HfMBkMLy8jfpJwFy+1R3cQKI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157129560844.8533.4470601700245454759.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 17 Oct 2019 07:00:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: pxa2xx: Set controller->max_transfer_size in dma mode (2019-10-17T06:44:26)
  Superseding: [v1] spi: pxa2xx: Set controller->max_transfer_size in dma mode (2019-10-16T19:57:21):
    spi: pxa2xx: Set controller->max_transfer_size in dma mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
