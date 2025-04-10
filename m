Return-Path: <linux-spi+bounces-7530-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE37A84773
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 17:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6788A5A45
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40B1E51FA;
	Thu, 10 Apr 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn0LNqHj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862B1E411C
	for <linux-spi@vger.kernel.org>; Thu, 10 Apr 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297796; cv=none; b=Kln6E4QqCh6s8/qcAK26ukOUaXdGvG6jMU73EdxHIIBG/EbcxnSzH4EEfPxmWhy/qkT9bHYhuSyo3nFstgaqTqLBCbQ3jsJVr1H8DlmEi2ykdSr1wnkLtZFebQPe1N8c6LW+MEZu47N4CLDDoyn4PaDmiXwkh8R0c6Gl15eZSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297796; c=relaxed/simple;
	bh=Eh/jiPUptDlXce5Gjgznw+lRTKVgwAWlqTdFkt2JVQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RpsMC6sVEIc9FnCbVwA6ayd1sijtcCYhl9MJSoxLbZB81/xQ8m4MRCiDJ6LWIBZI49KW7SR7KJQFmy8OWak+le8mYIQW7PtuksKl+nPZZt/iuoJr0PyGxfiFH/cyvoMWxI0x//HwybwstnJsAGJLnP7INx4GDFt5CjojvULPWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn0LNqHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D2EC4CEE8;
	Thu, 10 Apr 2025 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744297795;
	bh=Eh/jiPUptDlXce5Gjgznw+lRTKVgwAWlqTdFkt2JVQg=;
	h=Subject:From:Date:To:From;
	b=Vn0LNqHjt7rMqvF9FhtDghca4yUY9vL3zySjZwYQ2hzmGsAqKut06EloiAYmSWR1C
	 7pNg/DHdgnaNGG5/ISoWcFg5Ske9jFvqgzdPgTddve+4PyqevpbJFuetxPK40MmW76
	 mBRam8YcdHCysKLF8P9MJqTbwTElefrXYjWWIPDKfD+gnPRiS5laSYI4b8NQi/08wN
	 GJfuhmoRLT3B/TkJeqMiOaJrYCmc5BB6dB8Pv5JG0nPd7OoeYHySBocwy2gZZ8ax1z
	 Qus7TI8LAyoJNKkMP1upTHjQa3gYudR2fkCMk+Fg1V/jxLIjxAirXcJ8Dac+lsZky/
	 Ha7mrtjHoqweQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39BCF380CEF4;
	Thu, 10 Apr 2025 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174429783265.3709327.1802698686584935663.git-patchwork-summary@kernel.org>
Date: Thu, 10 Apr 2025 15:10:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: fsl-qspi: Fix double cleanup in probe error path
  Submitter: Kevin Hao <haokexin@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=951872
  Lore link: https://lore.kernel.org/r/20250410-spi-v1-0-56e867cc19cf@gmail.com
    Patches: [1/3] spi: fsl-qspi: Fix double cleanup in probe error path
             [2/3] spi: fsl-spi: Remove redundant probe error message
             [3/3] spi: fsl-qspi: Simplify probe error handling using managed API


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



