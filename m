Return-Path: <linux-spi+bounces-11116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6354BC40018
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 13:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AF23B1FFE
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5342BEC5F;
	Fri,  7 Nov 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnjSKQ6R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AEF433BC
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520259; cv=none; b=e/liN2YWIJBEOLCZWM1ZWpi4Zvj2y036V3DyHnQNg4XawUtYv2EBQVN6t8UA02q9uPgxET/QX0WU0z4OVfEsrrc0bB8u90c91nVmhIh/GVdB9qs05d1zICrbs7yqUJM+Lb2444nixKjRuap8wQF9WNAQXJ9uBJntXfzz7BPe2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520259; c=relaxed/simple;
	bh=cYcEY4G1BVhrPdZVRrfFdZpi0iuvQctcWB4pZQMGc84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tnmKu87RcryhZdLrveDqbvWF1w5EvJ3T3+fQMnRSGJw303v8tiDcw6/Ko4VTHEDXfHju23dz+MWZTtfK0jAmScoOPzv3YNK6PfcCkHrxS5hMVDRx0m9px6q20fA3CQtc6xEmBmrEdbSEQHU+2ezQzkZkBzatJDRrGGRiNbrXCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnjSKQ6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F530C4CEF5;
	Fri,  7 Nov 2025 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762520259;
	bh=cYcEY4G1BVhrPdZVRrfFdZpi0iuvQctcWB4pZQMGc84=;
	h=Subject:From:Date:To:From;
	b=nnjSKQ6RALiZIgsJ1C911+ZrAG35Q3FBQJucz1i6ZWRt70i0MoBGyzhcE67tasY31
	 V0HxFPaYEwswrwOOQszGoz6wn3QRwZU/4le+zwnenBsqa1kxZhB0z+FGFI9ppiEc94
	 /EeAxl1dWxhLku4nLD1pujl9ZXSYkFPV8oTtc9BFzehEF3J/cK7hP5ONWmJmpo3i0F
	 6F0pC7GKBS8qeMsIOmd2KcdEuVMCIMZdanbq6v5rlv/l4KlVOj+t9Bx20cMOclMgem
	 Xf1Qzr5DSMBdYLFJFGgoxbshVLf5Lck8ZfPRfll31RWAJ8u85IHz33To9CbI+AE7jt
	 fvyVR25P2lZTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDB39EFA6E;
	Fri,  7 Nov 2025 12:57:10 +0000 (UTC)
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
 <176252022946.993140.10244758000021386056.git-patchwork-housekeeping@kernel.org>
Date: Fri, 07 Nov 2025 12:57:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add support for Microchip CoreSPI Controller (2025-11-07T12:21:01)
  Superseding: [v2] Add support for Microchip CoreSPI Controller (2025-11-05T15:28:20):
    [v2,1/3] spi: microchip: rename driver file and internal identifiers
    [v2,2/3] spi: dt-binding: document Microchip CoreSPI
    [v2,3/3] spi: add support for microchip "soft" spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


