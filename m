Return-Path: <linux-spi+bounces-3466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF190ECC2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218591C2119C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323E143C4A;
	Wed, 19 Jun 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAnM+MgE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7081422B8
	for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802630; cv=none; b=cpw08jNgwgyixXjhU8bOxIt0bKz5SjDpRfX9F7G4KLCS0jTy+gPFI4Ea12gnPVq1xTePX7A/nlddnWeB1AfD7vPWYl8MoSN4pylr5Z3MJ65MRi/DnNoaE6Dx/gGIhyBrmCpqtfnFRkKl1Goc414hUjhr0ceq8bB1X8HEraWh4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802630; c=relaxed/simple;
	bh=LE2HdC4HDtlmASXHyXsviWKV5c840a4pIKOtzpgFXrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tKE0+aZDxy0oQOHjVPhKhQMNtuScPJgxf9pnCK5gkntN9CRAh+IBCc/KCmo8EFjlqKKYHWYqgfYAPAKZJZfaAPIhPrZ7zT5OtPi4WtsJFPTC6+zfQXSH9iKSg5DCa87Sv8LcxLboQddM++I9/K4x9RCPCNxNpqSss9uPVdpLWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAnM+MgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DFEBC32786;
	Wed, 19 Jun 2024 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718802630;
	bh=LE2HdC4HDtlmASXHyXsviWKV5c840a4pIKOtzpgFXrU=;
	h=Subject:From:Date:To:From;
	b=aAnM+MgEQ1vF2FSTpfSUx/33BV0DfcRo1zzzoz6WxZVnUmFtPOug4Kp0yWKVDA01A
	 93E8NJU2A8znFGE469lWGQWxRzRMzw3FhKJwVGEnkvjkbo6Ldl3N0UdPhPSmANourv
	 HpiANiYTxBcZi0BSBSvrRU8eprIrWwBgGHefwPgY7eSlxvxDNAzv5uOLhsZ7vXxRRc
	 jhry8UuBTib04xaNj7xbNcw0umfklkgdYY6M3h16Hk7RICT4rZ7Deng2cwfxQ2SQAh
	 C0d1pjX90bD5raBaaLH9AxJsHftwK9SREjA8q1sf9Vy2eC7k4x2VT4HVcUbTKK4Cnh
	 g127YZhNCZ2wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CCF0C41621;
	Wed, 19 Jun 2024 13:10:30 +0000 (UTC)
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
 <171880263017.17393.3593594748055849920.git-patchwork-summary@kernel.org>
Date: Wed, 19 Jun 2024 13:10:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: Fix SPI slave probe failure
  Submitter: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=862656
  Lore link: https://lore.kernel.org/r/20240617153052.26636-1-amit.kumar-mahapatra@amd.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



