Return-Path: <linux-spi+bounces-4227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBCD956B50
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 14:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7972283F3A
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6038516B752;
	Mon, 19 Aug 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGvjhpL+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C070166F0C
	for <linux-spi@vger.kernel.org>; Mon, 19 Aug 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072218; cv=none; b=bNUIVUoQz1j464bfdhWrA9mRfNBF22uu9uHr+d3j5T2m+jwusuoMuB4eN/PXtzkiwpoweMZrHm3K1iRrj5bNguHGXTwyvYby4uipBRcn99dCiS47DRpo65Bf9rT4e/ZVweWdzmFCsBZM8iiHyjUb7+T0nqeXQUXHso0/VQO5pOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072218; c=relaxed/simple;
	bh=vp8to5MC+zSSS6vGPMWleE5YSfEnHRW9JfLhJhX0wDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DSChSy11pfUyqAhPHGQgbv42reRrvgfe/439qY2cWxGn65knDq0weKbgpZXQ+RPzHbW5jh9tOIv24Qk3qqOZ65PL9YvcD2AdsLFv84aMo4QcMVsHtr0lpu3utiS8paqSfMo2kFLTy7tlIopGe+4mfHNZ3eFZ7sXdGhwwK3MVGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGvjhpL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0A5C32782;
	Mon, 19 Aug 2024 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724072217;
	bh=vp8to5MC+zSSS6vGPMWleE5YSfEnHRW9JfLhJhX0wDs=;
	h=Subject:From:Date:To:From;
	b=uGvjhpL+9pNp84Dli4RBeBnZ9CUfPSFpnfN8VdV17MfHxPC6s9Ck1Oyug6Z5XfNbe
	 XdjUz6riVKr/Y+QnwyqVgwGdd3jJpteyWYKDIcKUiYMIhIxv1uOrML/jSaHtcZG90H
	 T1BpKsdToOxfp7RjuPzBdEXnZgtKaBqhoaD23rje7bHnq9FJQ1eAkzHKRsmHu5uACG
	 aLOG4wr9o/GGtA54HoqvK+5rK3/YAszW7dBcvpEEgyR2vPfc2aPhvq+0pulbL6eh9T
	 kdgZPHvsNNazEYWZf9kmGnmhvj8TgZHtJ8OZ7ZXsLmBULEgR7MTbxT0JE6Jcgv5vJv
	 5wPbyYtJzW53A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711103823097;
	Mon, 19 Aug 2024 12:56:58 +0000 (UTC)
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
 <172407221712.527217.1782798135534105497.git-patchwork-housekeeping@kernel.org>
Date: Mon, 19 Aug 2024 12:56:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: bcm63xx: Fix two bugs (2024-08-19T12:33:49)
  Superseding: [v1] spi: bcm63xx: Fix two bugs (2024-08-19T12:31:54):
    [-next,1/2] spi: bcm63xx: Fix module autoloading
    [-next,2/2] spi: bcm63xx: Fix missing pm_runtime_disable()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


