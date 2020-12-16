Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A411A2DC952
	for <lists+linux-spi@lfdr.de>; Wed, 16 Dec 2020 23:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgLPW5e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Dec 2020 17:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbgLPW5d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 16 Dec 2020 17:57:33 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608159413;
        bh=Ui3c4S7mMg7kfdUzjs4c4xTPLFjkjWwH/5HcdzRpfDE=;
        h=Subject:From:Date:To:From;
        b=L0emWwTmNesgx/kb+WY2m1E2Bvet23HJt0l4nd7Cmtl+NcFnhZGdxhmVJFVvpJDHz
         vlQQx02ofCtaCRYoOCcl9PtV/r9AgE1pG4Q+cywzTJyS81VeNSbdZDbTqRZj24BCF8
         8EVPi+riupcF06a/iFfFLvovUPdSIn3k4lx/kAXiUhN6+rCwV6mhcQ2/eRmkzQBJUL
         AYQfNEpIPUQ4418q+Jqwf18Tc0adBJSp8CsFbnPC90dv07q+YY8XLObarsD5jRI34W
         qRjq60iMVHKwidAougF96fjgw0nbgsuBM8lqYUKSqsxQc4nwwZp3VFjLd8dmBMVE2n
         CzXQjhpyAmZhg==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160815941353.16521.5800145711808555793.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 16 Dec 2020 22:56:53 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case (2020-12-16T22:41:49)
  Superseding: [v1] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case (2020-12-15T00:30:18):
    [1/2] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
    [2/2] spi: spi-geni-qcom: Really ensure the previous xfer is done before new one


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

