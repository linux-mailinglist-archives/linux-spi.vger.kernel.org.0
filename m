Return-Path: <linux-spi+bounces-10821-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61262C06212
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 975054E36AC
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9373C2DA765;
	Fri, 24 Oct 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMqx4Hf7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60D2D97B5
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307038; cv=none; b=lD/udwn4eWnOMllKXRulgt5SXdIPnmRfBg7DuEFuj7n8IjCibnEiSHrKHN5rd4x0NGz3FWPbs79CcDmyJobFcLooAGcOV08itaGcVKunhpqpSz0VP957JLmy4fz+9Ev4ekCBWi1Er+pyeo5/AkzxCMdAIqUkQ5m+w4v4fu/b8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307038; c=relaxed/simple;
	bh=OgU6u13NC0MsTJ7ks5jLUK6DtqLXegRObdoXCALTlNs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iqLih6POR2PyFob8Pr+bK6WU+sTKubM+uLVUtGmqsI5n2reOy7amqjtANfHWhUFO6RDwxFKjnI9Mu4D96B6GjXwdDu7S95TY/cYFip2k5rFni5Pj6AGT7bJIr1AS+2w3G+H+oSq4JlXRvRSp9B677XQhhYGM9Azqere/o9svjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMqx4Hf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16347C4CEF5;
	Fri, 24 Oct 2025 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761307038;
	bh=OgU6u13NC0MsTJ7ks5jLUK6DtqLXegRObdoXCALTlNs=;
	h=Subject:From:Date:To:From;
	b=qMqx4Hf73FAhCENuod1cjify+0dqYzQU1khuIDDsPAlbR2zS1JSRiRZl+3Ty4QGhe
	 cc3d79VNicNTrakpYBKnr5H9HnPAzCmqUNzq8EBEoiWwx6lfQOd7gZQjqpprjIpOTp
	 huGgmw3Moe1LL/vwzmzhE/wed/TwbKfQNYLZPXrFq9iPTLz4pXcbTduhhGxrY7J+q3
	 7aUl880dwQ1b7uytDSsrUb3VYSkWQp5wifWqYt8IroXIM46F+lhaDqCI2WCKXa06XI
	 a++Yn5bgTHO6sklO/HCWoVMSgISoipyMjtJLPQyDO/qMbxoD/xxVwPDLI92wlPVRiq
	 RZtzh3wfDirKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340EA3809A88;
	Fri, 24 Oct 2025 11:56:59 +0000 (UTC)
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
 <176130701795.3861434.11787768101468625332.git-patchwork-housekeeping@kernel.org>
Date: Fri, 24 Oct 2025 11:56:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: imx: add 16/32 bits per word support for target mode (2025-10-24T11:31:07)
  Superseding: [v1] spi: imx: add 16/32 bits per word support for target mode (2025-10-24T05:49:52):
    spi: imx: add 16/32 bits per word support for target mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


