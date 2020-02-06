Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9EF1540C6
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 10:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgBFJAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 04:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgBFJAM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 Feb 2020 04:00:12 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580979611;
        bh=x57IMdvdE2yVMe42veo4Vzh5A/pO28MSojca0XbztCQ=;
        h=Subject:From:Date:To:From;
        b=U2R5uArTwn43PhTlVGcl3yqDWJ6MshU4wCk/XCsuXfqmH1mMqRBDnAFIp1PSI81bE
         e+Wu3mCBWjb1D9WIxiPVLiPJeP+mVeriM0PVOWzM2H36ZO3TGmPpIBmamhPWPtVVkf
         3XeF+ehm1U4N9VS60s7AxF39XY8pZf+tLPutZXHs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158097961190.11724.17867124537335581922.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 06 Feb 2020 09:00:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: add driver for ar934x spi controller (2020-02-06T08:44:41)
  Superseding: [v1] spi: add driver for ar934x spi controller (2020-02-06T08:38:20):
    [1/2] spi: add driver for ar934x spi controller
    [2/2] dt-binding: spi: add bindings for spi-ar934x


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
