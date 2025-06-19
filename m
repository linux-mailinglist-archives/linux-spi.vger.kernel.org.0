Return-Path: <linux-spi+bounces-8672-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1724AAE0491
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 13:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C94C3A5CAE
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6242512F1;
	Thu, 19 Jun 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USSR0cic"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC32512DE
	for <linux-spi@vger.kernel.org>; Thu, 19 Jun 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334179; cv=none; b=gxMQQ4vwSzolQ5p4RlyUZ8JjU7WyQbaPQOt8UKflGDEzzvM6M8Dw6D57On9ZIzxU/1cq7K7G1tkDcZTOJShToDDIKWjRjfB5gqLJa8AKX/W7E4NQfOQ2a5hT8lT6nYbRQ3nd5He0iVpkG3vh8GFX0XNT9s5uGx5h+nqscpSf1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334179; c=relaxed/simple;
	bh=GH1APGWx65nc7dJTvUraWgG5hkJD5pZBhOUtGO2bIDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DrKdFJa8DT8dMwrYXcbw1YE2rMWWi76fRMU2iqnth9JSVF3gNnPcvnaRrE3jbnG/SmoyeHj+5kYgio0KgCHxNvDEy1hzkrAFKICLSkXleTWne8Eh1Rl1xEZ2zu8N2+QC9oE/2w6PrkWNMI9MmBZpi0h2oiBrHVO/tQUhbqWIBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USSR0cic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60040C4CEEA;
	Thu, 19 Jun 2025 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750334179;
	bh=GH1APGWx65nc7dJTvUraWgG5hkJD5pZBhOUtGO2bIDY=;
	h=Subject:From:Date:To:From;
	b=USSR0cicAiTCSty0hwW1GM6F2jC9uPwAVMNvY3Jk6nm3MpG/K1+BoNuho/3g3PvGW
	 YsfuuI6t/TstQGn4Yv7t/biN+0AyGJVEKahglf43Bmuzo9kJrk0L4ItNJq1iABz4it
	 m83twUp69CGS/DGRvWqgoj4Ly3oN/x0XZgROX9yCwE1wmIvAnexok3Ued0wMjQcQJu
	 quj6bUHWiMK0UT5OZfQKvwCej5DXJM2Ja9wGC67TrlTEVwV3OpbSWV8CqC6dL53Ug6
	 mhLlI5qZhIOwWlMY3OhDR7TJGRJgoMeWUCVx5AJ1JsSAGEihM3Au+OGC4fS0nrZKN7
	 z1H46b3/65dYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC813806649;
	Thu, 19 Jun 2025 11:56:48 +0000 (UTC)
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
 <175033420739.831020.11275610499264196560.git-patchwork-housekeeping@kernel.org>
Date: Thu, 19 Jun 2025 11:56:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] objtool, spi: amd: Fix out-of-bounds stack access in amd_set_spi_freq() (2025-06-19T11:23:30)
  Superseding: [v1] objtool, spi: amd: Fix out-of-bounds stack access in amd_set_spi_freq() (2025-06-19T11:12:19):
    [6.1,1/1] objtool, spi: amd: Fix out-of-bounds stack access in amd_set_spi_freq()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


