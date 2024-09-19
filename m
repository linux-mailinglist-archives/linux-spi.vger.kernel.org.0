Return-Path: <linux-spi+bounces-4891-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A43A97CD5B
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFE11F23D11
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923201A0B0F;
	Thu, 19 Sep 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR4E64uE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49E1A0B08
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768605; cv=none; b=HEiYa/b13eQpynOHKQIZmW/DZUjPnxAaH12KQU9mgnSiOFLSJo1m/7tXvHLkrj2TCAdWTLZs/hPjjHu/6uLZE/x7cx2b7EpOuOL9pv1gdS4Y9OgLVnhWYRbvjVXNZyw6iLTCIoQZQmH89DNQEGyVMzXl8dk6Du860BywTjZrDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768605; c=relaxed/simple;
	bh=FPfsi7UByG6mcohR5YcnZIPqYqK6wdrJYMlF+PuL3k0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HAEuXQ7vH4TxxwNQIwh+xjtdd47JmCEngGI3a1OiamvbYT3BnyC+QVd/+Uo6pUypnWM5i46ZGViyCDS28vC4lKooLcRH21UcQcdmxcIiog2zn+Nmwv2s3NbrKUHmGiSEJT7tLUok2lFCpDb4onY1hIF7/edNthpSIDE80xTbMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR4E64uE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAB5C4CEC4;
	Thu, 19 Sep 2024 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726768605;
	bh=FPfsi7UByG6mcohR5YcnZIPqYqK6wdrJYMlF+PuL3k0=;
	h=Subject:From:Date:To:From;
	b=ZR4E64uEIc2N7u9AAt/hWyAy+rQyUisAo7RyMUM0Q+3SL4C8pfyuqCkQhp9pH5GhS
	 2bGSaZe4Z4uaBJxTEkTFoZlMB+QAeojJmLB5oelZJT8f0pEUuD57g0tkzue7vg7g34
	 /OiVOOSeV8uXFEOpoZU6prdM0S1rR7USqVgMzgm0mMnVR5eEwcrVeRkJRqeTwuTn6e
	 BbUz8ejz0FPmXKcfbB1qCVkkNQ6UpNROTgWx1cBsTBa8c5Jtyb+d2mmWvatNZ7ACEX
	 B0+m5zrm4h9KXJJF9SmEvGaaQsQXmVZgqT/eQzIn5sPnsQpz27mwQMxa2d4l1nx8OF
	 kd7ZakYsGvXHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF4BC3809A80;
	Thu, 19 Sep 2024 17:56:47 +0000 (UTC)
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
 <172676860689.1637018.12405886557826723621.git-patchwork-housekeeping@kernel.org>
Date: Thu, 19 Sep 2024 17:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: airoha: Fix errors reported by mtd_test kernel modules (2024-09-19T16:57:15)
  Superseding: [v1] spi: airoha: Fix errors reported by mtd_test kernel modules (2024-09-13T21:07:12):
    [1/4] spi: airoha: fix dirmap_{read,write} operations
    [2/4] spi: airoha: fix airoha_snand_{write,read}_data data_len estimation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


