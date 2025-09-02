Return-Path: <linux-spi+bounces-9864-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1DBB401D0
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD8416D07B
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4EF2DE6EF;
	Tue,  2 Sep 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvtRkqFM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74422D94B4
	for <linux-spi@vger.kernel.org>; Tue,  2 Sep 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817820; cv=none; b=ijzVhDGO3do4be0waJkm1FTPoJsucqCmq9/9tIXuXbguHi9BRBrnmOMX3UA61UQ435w09JMEl45074eHVuiC2hGEuKOAEAUaIe2xlIjIlrywQo52/PUDBABJe3eoBPQiLb7dS/IyOxQtkjbwNDA3aHGbz791DiqgGLaUEQ8GaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817820; c=relaxed/simple;
	bh=Um3OjUkzq9WkF/btC2CUIISemUmnusJPEFBMXbdx5pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Bci83iyA0/b00ZNAT22E5orV1LN4BtN2Bcxq9Dat7O0q/Vztlx6bcviCVQ2GQrASwQdEWTa4Owxx+fEl1pCXOXsJ4TJMeQOUzR3kAJAN3rKnoHrJM15XKbCcPC4GqYDrYBxNumNh4DN83zz5Y40fuF1OMtVsncCR6Eo2pmU/lUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvtRkqFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F9FC4CEED;
	Tue,  2 Sep 2025 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817820;
	bh=Um3OjUkzq9WkF/btC2CUIISemUmnusJPEFBMXbdx5pg=;
	h=Subject:From:Date:To:From;
	b=IvtRkqFMNHLJUla32pCIl5jFxZhITvvXmtnNrVCya7TE+A8crF+86QLD08UIXcJDu
	 RxEoMW/GpgYX/DAu9H4mPjZxBZhrGAoikEKtes67n6QYCimbo1YXm38nIAeKD5jCo6
	 AVE0ESjdvXN0CXVS1o2UhHtXtlN8ZgWXNRUsUkh9xz+oHONioukQO+3P7rz780rjNI
	 OI0ts4AfAYiXZjoxPmqYlOGTBJu5tQhMqYUcQ8giVJ5BKkFen3KY40jsoAQE4qYnxC
	 +pL6+uRncdS6Pg1LKU6bAraaKFYLOOkxX3DM90mUJI7NOFnROOn1CkjYXnsayE9WAE
	 q+oIfGQFJKyXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1A6383BF75;
	Tue,  2 Sep 2025 12:57:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175681782549.282539.16842246440094845374.git-patchwork-housekeeping@kernel.org>
Date: Tue, 02 Sep 2025 12:57:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: spi-fsl-dspi: Target mode improvements (2025-09-02T12:44:53)
  Superseding: [v5] spi: spi-fsl-dspi: Target mode improvements (2025-08-29T11:46:42):
    [v5,1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
    [v5,2/7] spi: fsl-dspi: Store status directly in cur_msg->status
    [v5,3/7] spi: spi-fsl-dspi: Stub out DMA functions
    [v5,4/7] spi: spi-fsl-dspi: Use non-coherent memory for DMA
    [v5,5/7] spi: spi-fsl-dspi: Use whole page for DMA buffers
    [v5,6/7] spi: spi-fsl-dspi: Increase target mode DMA buffer size
    [v5,7/7] spi: spi-fsl-dspi: Report FIFO overflows as errors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


