Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4CB3BBBA9
	for <lists+linux-spi@lfdr.de>; Mon,  5 Jul 2021 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhGEK7R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Jul 2021 06:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhGEK7R (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Jul 2021 06:59:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AD401613BA;
        Mon,  5 Jul 2021 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625482600;
        bh=0h0yy1AENY0HDB+nv2Y7iRnAro8OMbfv9Kx3h2sznn8=;
        h=Subject:From:Date:To:From;
        b=qT3cDMVONC6pgYOfvQqLaYKwk09sjqsD/WpckMvHsfSbpRzakOEvW7Ilb9OiBdX4L
         oG6jHOfRHrnBGnHJAAq709DB9ZPBM0er8pBgi7R3oVh6KSb3oMoCnPKFgYHBzY+hcJ
         kTo3/iNXQss/S3nAdbS61TfIOBxu7PBQulIgE4YsbEkU6fr9ayxN9CTIeq96RWUaKe
         /xVS6XVPWtRn59R9wGexJWVMHxMieSaZnS8hfsF8GWfozdcPLjsjiVxXFY/JgRTrkS
         42pli4nnhbJ1XbN6Z9T9tHdAd/Sxy9qiO/bloK+757eQ3hjaCSpPOEwUd4jdPCPAp6
         LxKRu5GTAaWtg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 96A0260A48;
        Mon,  5 Jul 2021 10:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162548260055.14229.16807257283191447761.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 05 Jul 2021 10:56:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC (2021-07-05T10:16:41)
  Superseding: [v3] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC (2021-06-29T12:12:10):
    [v3,1/4] fpga: dfl: expose feature revision from struct dfl_device
    [v3,2/4] spi: spi-altera-dfl: support n5010 feature revision
    [v3,3/4] mfd: intel-m10-bmc: add n5010 variant
    [v3,4/4] hwmon: intel-m10-bmc-hwmon: add n5010 sensors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

