Return-Path: <linux-spi+bounces-2100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 356EC891371
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 06:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7280BB22EDE
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 05:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CEA3D0A4;
	Fri, 29 Mar 2024 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iipI3i3y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D73C6BA
	for <linux-spi@vger.kernel.org>; Fri, 29 Mar 2024 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691794; cv=none; b=DdV0CHz3C4qv/wI2VgMOYopP9RGV/hymRqLxDIDZJddiAP0n1RGxRB2rMFlHO47S530CyrYFUVQDNRVMcckzczMe8yKayhkKa97/XnPiwl/qUPSzrZnDtMz3lVLUQ5w7psOnegETLqjposdjLE+HCDtMYF2ekXp1K69/DjYrTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691794; c=relaxed/simple;
	bh=75oinFKC8FE9a8OJZ1EcB3SjfK9gRvXmGExeP40EpPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kTgYLFJZcNnndjhetdvuNH+V5be3xC1CnsiU9GdQVbuw+AeJVCJ/BgRKYnivMkaolO3S0US2+b0Mv6prcHod8h/6SGvdqH9W0DxSXD5AxoKrQSmXsSbGvfts1OPrFBOOfDvhrCEuPLsKbwHgR0aX7j3KmEmXAtrUS127XbkF1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iipI3i3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 379F5C433C7;
	Fri, 29 Mar 2024 05:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711691794;
	bh=75oinFKC8FE9a8OJZ1EcB3SjfK9gRvXmGExeP40EpPQ=;
	h=Subject:From:Date:To:From;
	b=iipI3i3yBqH7bF3xPzw3fBa7IdnjmHdXeqhkbH/T1yHy9WMCO5gbLEElTVVBEIGTi
	 jVlPe+Q48c5kpCBkvNlK2oxkzminKt8mUir+1PRlRsMz9aeO0dJuY07Dyrjbg0+kZo
	 7NHaiwqH6QOUWxNoAqfUV1AvCW90wCgHXOP+rPUvW1NCBbm87ixahMfl1EcVIxSVJL
	 log8modbuva33hchctOD4fsta9AZ1jyBAI3kI4OIjS5J1j4E5+Yhok54B0EqhCFDW5
	 zcvY7eWeeaoA7dAJmEftXWsuorg985UaPjnptDtJ9OuY+s9bmxH7gM4BAkyasYwOQh
	 09CeLgvqnCOQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29A9DD2D0EB;
	Fri, 29 Mar 2024 05:56:34 +0000 (UTC)
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
 <171169179416.12869.17388312510505899903.git-patchwork-housekeeping@kernel.org>
Date: Fri, 29 Mar 2024 05:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dt-bindings: add Siflower Quad SPI controller (2024-03-29T05:46:56)
  Superseding: [v1] spi: dt-bindings: add Siflower Quad SPI controller (2024-03-29T01:51:46):
    [RFC,1/2] spi: dt-bindings: add Siflower Quad SPI controller
    [RFC,2/2] spi: add Siflower Quad SPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


